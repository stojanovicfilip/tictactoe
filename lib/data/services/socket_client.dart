import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:tictactoe/data/models/player.dart';
import 'package:tictactoe/data/models/room.dart';

class SocketClient {
  late io.Socket socket;
  static SocketClient? _instance;
  final StreamController createRoomController = StreamController.broadcast();
  final StreamController joinRoomController = StreamController.broadcast();
  final StreamController gameStartController = StreamController.broadcast();

  static SocketClient? get instance {
    _instance ??= SocketClient._internal();
    return _instance;
  }

  SocketClient._internal() {
    socket = io.io('http://192.168.1.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    // Listeners
    socket.on('roomCreationResolution', (data) {
      createRoomController.sink.add(data);
    });
    socket.on('playerJoinedRoom', (data) {
      joinRoomController.sink.add(data);
    });
    socket.on('gameStart', (data) {
      gameStartController.sink.add(data);
    });
  }

  // Emitters
  void createRoom(String username) {
    socket.emit('createRoom', {
      'username': username,
    });
  }

  void joinRoom(String roomId, String username) {
    socket.emit('joinRoom', {
      'roomId': roomId,
      'username': username,
    });
  }

  // Adapters
  Future<RoomModel?> roomCreateOrJoinEvent(Stream source) async {
    await for (var data in source) {
      final List<PlayerModel> players = [];
      for (var i = 0; i < data['players'].length; i++) {
        players.add(PlayerModel.fromMap(data['players'][i]));
      }
      final PlayerModel player = PlayerModel.fromMap(data['turn']);
      final RoomModel room = RoomModel.fromMap(data, [], player);
      return room;
    }
    return null;
  }

  // Adapters
  Future<RoomModel?> gameStartEvent(Stream source) async {
    await for (var data in source) {
      final List<PlayerModel> players = [];
      for (var i = 0; i < data['players'].length; i++) {
        players.add(PlayerModel.fromMap(data['players'][i]));
      }
      final PlayerModel player = PlayerModel.fromMap(data['turn']);
      final RoomModel room = RoomModel.fromMap(data, [], player);
      return room;
    }
    return null;
  }
}
