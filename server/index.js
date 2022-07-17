require('dotenv').config();
const express = require('express');
const http = require('http');
const mongoose = require('mongoose');
const Room = require('./models/room');
const Player = require('./models/player');

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
      socketio.to(socket.id).emit('roomCreationResolution', null);
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
