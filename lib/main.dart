import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:test_app/slide_menu_item.dart';
import 'package:test_app/utils/rive_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  RiveAsset selectedBottomNav = slideItems[0];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Container(
        width: 288,
        height: double.infinity,
        color: Color(0xff17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(CupertinoIcons.person, color: Colors.white),
                ),
                title: Text(
                  "Mahmoud",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  "Developer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 16,bottom: 5),
                child: Text(
                  "browse".toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ...slideItems.map((item) => SlideMenuItem(
                    riveAsset: item,
                    isActive: selectedBottomNav == item,
                    riveOnInit: (artboard) {
                      StateMachineController controller = RiveUtils.getRiveController(artboard, stateMachineName: item.stateMachineName);
                      item.input = controller.findSMI("active") as SMIBool;
                    },
                    press: () {
                      setState(() {
                        item.input?.change(true);
                      });
                      if (item != selectedBottomNav) {
                        setState(() {
                          selectedBottomNav = item;
                        });
                      }
                      Future.delayed(const Duration(seconds: 1), () {
                        item.input?.change(false);
                      });
                    },
                  )),
              const SizedBox(height: 36,),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 16,bottom: 5),
                child: Text(
                  "history".toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ...slideMenu2.map((item) => SlideMenuItem(
                riveAsset: item,
                isActive: selectedBottomNav == item,
                riveOnInit: (artboard) {
                  StateMachineController controller = RiveUtils.getRiveController(artboard, stateMachineName: item.stateMachineName);
                  item.input = controller.findSMI("active") as SMIBool;
                },
                press: () {
                  setState(() {
                    item.input?.change(true);
                  });
                  if (item != selectedBottomNav) {
                    setState(() {
                      selectedBottomNav = item;
                    });
                  }
                  Future.delayed(const Duration(seconds: 1), () {
                    item.input?.change(false);
                  });
                },
              )),
            ],
          ),
        ),
      ),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       SizedBox(
      //           width: 100,
      //           height: 100,
      //           child: RiveAnimation.asset(
      //             "assets/RiveAssets/animated_icon.riv",
      //             artboard: "CHAT",
      //           )),
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //       const SizedBox(height: 36),
      //       Container(
      //         width: size.width * 0.9,
      //         padding: const EdgeInsets.all(8),
      //         decoration: const BoxDecoration(
      //           color: Colors.black54,
      //           borderRadius: BorderRadius.all(Radius.circular(28.0)),
      //         ),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: List.generate(bottomNavs.length, (index) => GestureDetector(
      //             onTap: (){
      //               bottomNavs[index].input?.change(true);
      //               if(bottomNavs[index] != selectedBottomNav){
      //                 setState(() {
      //                   selectedBottomNav = bottomNavs[index];
      //                 });
      //               }
      //               Future.delayed(const Duration(seconds: 1), (){
      //                 bottomNavs[index].input?.change(false);
      //               });
      //             },
      //             child: SizedBox(width: 36.0, height: 36.0, child: RiveAnimation.asset(
      //                 bottomNavs[index].src,
      //               artboard: bottomNavs[index].artboard,
      //               onInit: (artboard){
      //                   StateMachineController controller = RiveUtils.getRiveController(artboard,
      //                       stateMachineName: bottomNavs[index].stateMachineName);
      //                   bottomNavs[index].input = controller.findSMI("active") as SMIBool;
      //                   },
      //             ),),
      //           )),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RiveAsset {
  final String src, title, stateMachineName, artboard;
  late SMIBool? input;

  RiveAsset(
    this.src, {
    required this.title,
    required this.artboard,
    required this.stateMachineName,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset("assets/RiveAssets/animated_icon.riv",
      title: "HOME", artboard: "HOME", stateMachineName: "HOME_interactivity"),
  RiveAsset("assets/RiveAssets/animated_icon.riv",
      title: "SEARCH",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity"),
  RiveAsset("assets/RiveAssets/animated_icon.riv",
      title: "BELL", artboard: "BELL", stateMachineName: "BELL_Interactivity"),
  RiveAsset("assets/RiveAssets/animated_icon.riv",
      title: "CHAT", artboard: "CHAT", stateMachineName: "CHAT_Interactivity"),
  RiveAsset("assets/RiveAssets/animated_icon.riv",
      title: "USER", artboard: "USER", stateMachineName: "USER_Interactivity"),
];
