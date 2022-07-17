import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:tictactoe/data/models/player.dart';
import 'package:tictactoe/data/models/room.dart';

class SocketClient {
  late io.Socket socket;
  static SocketClient? _instance;
  final StreamController createRoomStream = StreamController.broadcast();

  SocketClient._internal() {
    socket = io.io('http://192.168.1.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('roomCreationResolution', (data) {
      createRoomStream.sink.add(data);
    });
  }

  static SocketClient? get instance {
    _instance ??= SocketClient._internal();
    return _instance;
  }

  // Emitters
  void createRoom(String username) {
    socket.emit('createRoom', {
      'username': username,
    });
  }

  Future<RoomModel?> roomCreationResolution(Stream source) async {
    await for (dynamic data in source) {
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
