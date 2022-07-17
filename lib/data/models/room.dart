import 'package:tictactoe/data/models/player.dart';

class RoomModel {
  final String id;
  final int occupancy;
  final int maxRounds;
  final int currentRound;
  final bool isAvailable;
  List<PlayerModel> players;
  PlayerModel? turn;

  RoomModel({
    required this.id,
    required this.occupancy,
    required this.maxRounds,
    required this.currentRound,
    required this.isAvailable,
    this.players = const [],
    this.turn,
  });

  get roomId {
    return id;
  }

  factory RoomModel.fromMap(
    Map<String, dynamic> data,
    List<PlayerModel> players,
    PlayerModel player,
  ) {
    String id = data['_id'];
    int occupancy = data['occupancy'];
    int maxRounds = data['maxRounds'];
    int currentRound = data['currentRound'];
    bool isAvailable = data['isAvailable'];

    return RoomModel(
      id: id,
      occupancy: occupancy,
      maxRounds: maxRounds,
      currentRound: currentRound,
      isAvailable: isAvailable,
      players: players,
      turn: player,
    );
  }
}
