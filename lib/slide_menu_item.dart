import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:test_app/main.dart';

class SlideMenuItem extends StatelessWidget {
  const SlideMenuItem(
      {Key? key,
      required this.riveAsset,
      required this.isActive,
      required this.riveOnInit,
      required this.press})
      : super(key: key);
  final RiveAsset riveAsset;
  final bool isActive;
  final ValueChanged<Artboard> riveOnInit;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              height: 50,
              width: isActive?288:0,
              left: 0,
              child: Container(
              decoration: const BoxDecoration(
                  color: Color(0XFF6792FF),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
            ),),
            ListTile(
              onTap: press,
              leading: SizedBox(
                width: 34,
                height: 34,
                child: RiveAnimation.asset(
                  riveAsset.src,
                  artboard: riveAsset.artboard,
                  onInit: riveOnInit,
                ),
              ),
              title: Text(
                riveAsset.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

List<RiveAsset> slideItems = [
  RiveAsset("assets/RiveAssets/animated_icon.riv",
      title: "Home", artboard: "HOME", stateMachineName: "HOME_interactivity"),
  RiveAsset("assets/RiveAssets/animated_icon.riv",
      title: "Search", artboard: "SEARCH", stateMachineName: "SEARCH_Interactivity"),
  RiveAsset("assets/RiveAssets/animated_icon.riv",
      title: "Chat", artboard: "CHAT", stateMachineName: "CHAT_Interactivity"),
  RiveAsset("assets/RiveAssets/animated_icon.riv",
      title: "Favorites", artboard: "LIKE/STAR", stateMachineName: "STAR_Interactivity"),
  RiveAsset("assets/RiveAssets/animated_icon.riv",
      title: "User", artboard: "USER", stateMachineName: "USER_Interactivity"),
];

List<RiveAsset> slideMenu2 = [
  RiveAsset("assets/RiveAssets/animated_icon.riv",
      title: "Timer", artboard: "TIMER", stateMachineName: "TIMER_Interactivity"),
  RiveAsset("assets/RiveAssets/animated_icon.riv",
      title: "Notifications", artboard: "BELL", stateMachineName: "BELL_Interactivity"),
];
