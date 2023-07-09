import 'package:rive/rive.dart';

class RiveUtils {
  static StateMachineController? getRiveController(Artboard artboard,
      {String stateMachineName = "State Machine 1"}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    if (controller != null) {
      artboard.addController(controller);
    }
    return controller;
  }
}
