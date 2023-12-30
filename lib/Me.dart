import 'package:alarm_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:alarm_app/models/Methods.dart';

class Myinfopro extends StatefulWidget {
  const Myinfopro({Key? key}) : super(key: key);

  @override
  State<Myinfopro> createState() => _MyinfoproState();
}

class _MyinfoproState extends State<Myinfopro> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "رجوع",
            textAlign: TextAlign.end,
            style: TextStyle(color: Color.fromARGB(255, 238, 191, 39)),
          ),
          backgroundColor: kCardColor,
          elevation: 0,
        ),
        backgroundColor: kCardColor,
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                  top: 15, bottom: size.height >= 550 ? 35 : 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Color.fromARGB(255, 239, 186, 8),
                        width: 1,
                        style: BorderStyle.solid)),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: ExactAssetImage("assets/images/Himo1.png"),
                  radius: size.height >= 550 ? 80 : 50, //
                ),
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Card(
                  title: "تطوير :",
                  subtitle: "حفيد تك",
                  icon: Icons.developer_board,
                  perss: () {}),
              Card(
                  title: "فيس بوك :",
                  subtitle: "www.facebook.com",
                  icon: Icons.facebook,
                  perss: () {
                    launchURLApp;
                  }),
              Card(
                  title: "وتس أب :",
                  subtitle: "967711055612+",
                  icon: Icons.whatsapp,
                  perss: () {
                    launchURLApp;
                  }),
              Card(
                  title: "تلجرام :",
                  subtitle: "Haved7@",
                  icon: Icons.telegram,
                  perss: () {
                    launchURLApp;
                  }),
            ],
          )),
        ]),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.perss,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final IconData icon;
  final perss;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 50, vertical: size.height >= 550 ? 10 : 2),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
          size: size.height >= 550 ? 25 : 20,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            ),
            side: BorderSide(
              color: Color.fromARGB(255, 154, 122, 16).withOpacity(0.9),
              width: 1,
            )),
        title: Text(
          title,
          textDirection: TextDirection.rtl,
          style: TextStyle(
              color: Color.fromARGB(255, 239, 186, 8),
              fontSize: 10 * 1.5,
              fontWeight: FontWeight.w300),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            subtitle,
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: size.height >= 550 ? 18 : 12,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                height: 2),
          ),
        ),
        onTap: () {
          if (title == "فيس بوك :")
            launchURLApp(
                "https://www.facebook.com/profile.php?id=100065901841341&mibextid=ZbWKwL");
          else if (title == "وتس أب :")
            launchURLApp(
                //"whatsapp://send?phone=+967711055612&text=${Uri.encodeFull('السلام عليكم هل يمكن مساعدتي في.. ')}"
                "https://wa.me/+967711055612?text=السلام عليكم هل يمكن مساعدتي في.. ");
          else if (title == "تلجرام :") launchURLApp("https://t.me/Haved7");
        },
      ),
    );
  }
}
