import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;
  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input});
  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> sideMenus = [
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    artboard: "HOME",
    stateMachineName: "HOME_interactivity",
    title: "Home",
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "Profile",
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    artboard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
    title: "History",
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    artboard: "LIKE/STAR",
    stateMachineName: "STAR_Interactivity",
    title: "Rewards",
  ),
];
