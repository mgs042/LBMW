import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:trash_dash/model/rive_asset.dart';
import 'package:trash_dash/widgets/side_menu_tile.dart';

import 'package:provider/provider.dart';
import 'package:trash_dash/provider/auth_provider.dart';

import '../utils/rive_utils.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Color(0xff8CEEB3),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Image.network(ap.userModel.profilePic),
                ),
                title: Text(
                  ap.userModel.name.toUpperCase(),
                  style: TextStyle(
                    color: Color(0xff010402),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse",
                  style: TextStyle(
                    color: Color(0xff010402),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...sideMenus.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    StateMachineController? controller =
                        RiveUtils.getRiveController(
                      artboard,
                      stateMachineName: menu.stateMachineName,
                    );
                    if (controller != null) {
                      menu.input = controller.findSMI("active") as SMIBool?;
                    }
                  },
                  press: () {
                    if (menu.input != null) {
                      menu.input!.change(true);
                      Future.delayed(const Duration(seconds: 1), () {
                        menu.input!.change(false);
                      });
                      setState(() {
                        selectedMenu = menu;
                      });
                    }
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
