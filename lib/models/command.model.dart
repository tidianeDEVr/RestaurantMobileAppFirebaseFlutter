import 'package:food_ui_kit/models/menu.model.dart';

class CommandModel {
  String clientId;
  DateTime commandedAt;
  List<MenuModel> menus;
  CommandModel(
      {required this.clientId, required this.commandedAt, required this.menus});
  Map<String, dynamic> toMap() {
    return {
      'clientId': this.clientId,
      'commandedAt': this.commandedAt,
      'menus': this.menus
    };
  }
}
