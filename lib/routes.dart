import 'package:flutter/material.dart';
import 'package:tictactoe/view/screens/game_screen.dart';
import 'package:tictactoe/view/screens/menu_screen.dart';
import 'package:tictactoe/view/screens/settings_screen.dart';

class Routes {
  Routes._();

  static const String menu = '/menu';
  static const String login = '/login';
  static const String join = '/join';
  static const String create = '/create';
  static const String game = '/game';
  static const String settings = '/settings';

  static final routes = <String, WidgetBuilder>{
    menu: (BuildContext context) => const MenuScreen(),
    game: (BuildContext context) => const GameScreen(),
    settings: (BuildContext context) => const SettingsScreen(),
  };
}