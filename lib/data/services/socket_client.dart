import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  late io.Socket socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = io.io('http://192.168.1.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();
  }

  static SocketClient? get instance {
    _instance ??= SocketClient._internal();
    return _instance;
  }

  // Emitters
  void createRoom(String username) {
    if (username.isNotEmpty) {
      socket.emit('createRoom', {
        'username': username,
      });
    }
  }

  // Listeners
  Stream roomSuccessfullyCreated() async* {
    socket.on('createRoomSuccess', (data) async* {
      print(data);
      yield data;
    });
  }
}
