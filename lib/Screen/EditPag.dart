import 'package:alarm_app/Widget/Alarte_Add_Ui.dart';
import 'package:alarm_app/Widget/Card.dart';
import 'package:alarm_app/Widget/MyHeader.dart';
import 'package:alarm_app/Widget/Reports.dart';
import 'package:alarm_app/constants.dart';
import 'package:alarm_app/models/Methods.dart';
import 'package:alarm_app/models/ProductModel.dart';
import 'package:alarm_app/profile_pag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

ScrollController Scoll2 = ScrollController();

class EditPag extends StatefulWidget {
  @override
  _EditPagState createState() => _EditPagState();
}

class _EditPagState extends State<EditPag> with SingleTickerProviderStateMixin {
  bool online = true;
  TextEditingController txtSearch = TextEditingController();
  GlobalKey<ScaffoldState> scaffolKey2 = GlobalKey<ScaffoldState>();

  void runFilter(String enteredKeyword) {
    List<Product> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all Prods
      results = recentProducts;
    } else {
      results = recentProducts
          .where((Prod) =>
              Prod.name!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    // Refresh the UI
    setState(() {
      ProductsListFound = results;
      ProductsListFound = ProductsListFound.reversed.toList();
    });
  }

  @override
  void initState() {
    getAllProdDetails();
    setState(() {
      try {
        Scoll2.animateTo(Scoll2.position.maxScrollExtent,
            duration: Duration(milliseconds: 4000),
            curve: Curves.easeInOutCubic);
      } catch (es) {}
    });
    super.initState();
    ProductsListFound = recentProducts;
    ProductsListFound = ProductsListFound.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffolKey2,
        drawer: DrawerPage(i: 1),
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            size.height >= 550 ? size.height / 2.3 : size.height / 2.25,
          ),
          //Container Photo list Product Pag..
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: <Widget>[
                    MyHeader(
                      image: "assets/images/Edite.png",
                      textTop: "وراء كل نجاح",
                      textBottom: "خطوات كثيرة من التعب",
                      offset: 10.0,
                    ),
                    Positioned(
                        top: 30,
                        right: 7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              "assets/icons/menushort.svg",
                              width: 25.0,
                              color: White,
                            ),
                            onPressed: () {
                              scaffolKey2.currentState!.openDrawer();
                            },
                          ),
                        )),
                    Positioned(
                        bottom: 0,
                        child: Container(
                            height: 40,
                            child: SizedBox(
                              height: 60,
                              child: TitelPart(
                                  "قائمة المنتجات", Icons.ac_unit_rounded),
                            ))),
                    Positioned(
                        bottom: 5,
                        left: 16,
                        child: Icon(
                          Icons.list_rounded,
                          color: blue,
                          size: 30,
                        )),
                  ],
                ),
              ),
              //part Search Abote Product
              Padding(
                padding: size.height >= 550
                    ? EdgeInsets.all(8.0)
                    : EdgeInsets.all(4.0),
                child: Container(
                  margin: EdgeInsets.only(top: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.search_rounded,
                          size: 30,
                          color: White,
                        ),
                        decoration: BoxDecoration(
                          color: blue.withOpacity(.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        width: size.width * .78,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: TextField(
                              decoration: InputDecoration(
                                hintText: ' بحث عن منتج... ',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              controller: txtSearch,
                              onChanged: (value) => runFilter(value),
                            )),
                            InkWell(
                              child: txtSearch.text == ""
                                  ? Icon(
                                      Icons.mic,
                                      color: Colors.black54.withOpacity(.6),
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.black54.withOpacity(.6),
                                    ),
                              onTap: () {
                                if (txtSearch.text != "") {
                                  setState(() {
                                    txtSearch.text = "";
                                    runFilter("");
                                  });
                                }
                                ;
                              },
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: blue.withOpacity(.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            //margin: EdgeInsets.only(bottom: 39),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height - (size.height / 2.1),
                  child: ProductsListFound.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(right: 20.0, top: 0),
                          scrollDirection: Axis.vertical,
                          itemCount: ProductsListFound.length,
                          itemBuilder: (context, index) => RecentsProducts(
                                index: index,
                                list: ProductsListFound,
                              ))
                      : SizedBox(
                          child: Padding(
                          padding: EdgeInsets.all(size.height >= 550 ? 80 : 50),
                          child: Center(
                              child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "assets/icons/doodle.svg",
                                  width: 100.0,
                                  color: blue.withOpacity(0.9),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("لا توجد نتائج !"),
                              ),
                            ],
                          )),
                        )),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black45,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              side: BorderSide(color: White)),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimtLoded(
                    indexPro: -1,
                    list: ProductsListFound,
                  );
                });
          },
          child: Icon(
            Icons.add_shopping_cart_sharp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
