import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String uid;
  final String? email;

  const AuthModel({
    required this.uid,
    this.email,
  });

  static const empty = AuthModel(uid: '');

  bool get isEmpty => this == AuthModel.empty;
  bool get isNotEmpty => this != AuthModel.empty;

  @override
  List<Object?> get props => [uid, email];
}
