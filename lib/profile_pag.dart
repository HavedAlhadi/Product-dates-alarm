import 'package:alarm_app/constants.dart';
import 'package:alarm_app/main.dart';
import 'package:alarm_app/models/Methods.dart';
import 'package:flutter/material.dart';

class ButtonsInfo {
  String title;
  IconData icon;
  ButtonsInfo({required this.title, required this.icon});
}

int _currentIndex = 1;

List<ButtonsInfo> _buttonNames = [
  ButtonsInfo(title: "الرئيسية", icon: Icons.home),
  ButtonsInfo(title: "قائمة الأصناف", icon: Icons.list_alt),
  // ButtonsInfo(title: "تصدير نسخة", icon: Icons.list_alt),
  // ButtonsInfo(title: "إستيراد نسخة", icon: Icons.list_alt),
  ButtonsInfo(title: "حفيد تك", icon: Icons.developer_board),
];

class DrawerPage extends StatefulWidget {
  final int i;
  const DrawerPage({Key? key, required this.i}) : super(key: key);
  @override
  _DrawerPageState createState() => _DrawerPageState(this.i);
}

class _DrawerPageState extends State<DrawerPage> {
  _DrawerPageState(int i) {
    _currentIndex = i;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: Color.fromARGB(163, 0, 0, 0),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10 * 2),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10 * 2),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30, top: 10),
                      child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 80,
                          child: Image.asset("assets/images/LogoP.jpg.png")),
                    ),
                  ],
                ),
              ),
              //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
              // buttuns Forms
              ...List.generate(
                _buttonNames.length,
                (index) => Column(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: Duration(milliseconds: 300),
                            height: 49,
                            width: index == _currentIndex ? (259.0) : 0,
                            right: 0,
                            child: Container(
                              decoration: index == _currentIndex
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        colors: [
                                          red.withOpacity(0.9),
                                          blue.withOpacity(0.9),
                                        ],
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          ListTile(
                            trailing: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Icon(
                                index == _currentIndex
                                    ? Icons.circle_rounded
                                    : Icons.circle_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              _buttonNames[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            leading: Padding(
                              padding: const EdgeInsets.all(10 - 5),
                              child: Icon(
                                _buttonNames[index].icon,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (index == 0) controllers.jumpToPage(0);
                                if (index == 1) controllers.jumpToPage(1);
                                if (index == 2) {
                                  Navigator.pop(context);
                                  Navigator.of(context).pushNamed("Me");
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.02,
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, top: 20, left: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("إيقاف الإشعارات",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                        Switch(
                          value: IsNotNoti,
                          onChanged: (val) {
                            setState(() {
                              IsNotNoti = val;
                              setboolNoti(val);
                            });
                          },
                          inactiveTrackColor:
                              Color.fromARGB(255, 142, 153, 154),
                          activeColor: Color.fromARGB(255, 122, 19, 12),
                        )
                      ]),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                color: Colors.white,
                thickness: 0.3,
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    child: TextButton(
                      onPressed: () {
                        launchURLApp("https://t.me/Haved7");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.telegram,
                          ),
                          Text(
                            ' فريق التطوير',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
