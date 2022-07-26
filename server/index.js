require('dotenv').config();
const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
const Room = require('./models/room');

const app = express();
const port = process.env.PORT || 3000;
const server = http.createServer(app);

// Middleware
app.use(express.json());

const DB = `mongodb+srv://${process.env.MONGODB}@cluster0.scyid.mongodb.net/?retryWrites=true&w=majority`;
const socketio = require('socket.io')(server);

socketio.on('connection', (socket) => {
  socket.on('createRoom', async ({ username }) => {
    let player = {
      socketID: socket.id,
      username,
      playerType: 'X',
    };
    let room = new Room();
    room.players.push(player);
    room.turn = player;
    try {
      room = await room.save();
      const roomId = room._id.toString();
      socket.join(roomId);
      socketio.to(roomId).emit('roomCreationResolution', room);
    } catch (error) {
      socket.emit('errorOccured', 'Room creation failed');
    }
  });
  socket.on('joinRoom', async ({ roomId, username }) => {
    try {
      if (!roomId.match(/^[0-9a-fA-F]{24}/)) {
        socket.emit('errorOccured', 'Please enter a valid room ID');
        return;
      }
      let room = await Room.findById(roomId);

      if (room.isAvailable) {
        let player = {
          socketID: socket.id,
          username,
          playerType: 'O',
        };
        socket.join(roomId);
        room.players.push(player);
        room = await room.save();
        socketio.to(roomId).emit('playerJoinedRoom', room);
        socketio.to(roomId).emit('gameStart', room);
      } else {
        socket.emit('errorOccured', 'Room is full');
      }
    } catch (error) {
      console.log(error);
    }
  });
});

mongoose
  .connect(DB)
  .then(() => {
    console.log('database is connected!');
  })
  .catch((err) => {
    console.log(err);
  });

server.listen(port, '0.0.0.0', () => {
  console.log('listening on port ' + port);
});
