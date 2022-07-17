class PlayerModel {
  final String id;
  final String username;
  final String socketId;
  final String playerType;

  PlayerModel({
    required this.id,
    required this.username,
    required this.socketId,
    required this.playerType,
  });

  factory PlayerModel.fromMap(
    Map<String, dynamic> player,
  ) {
    String id = player['_id'];
    String username = player['username'];
    String socketId = player['socketID'];
    String playerType = player['playerType'];

    return PlayerModel(
      id: id,
      username: username,
      socketId: socketId,
      playerType: playerType,
    );
  }
}
