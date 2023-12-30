import 'package:alarm_app/Screen/EditPag.dart';
import 'package:alarm_app/Screen/home_screen.dart';
import 'package:alarm_app/constants.dart';
import 'package:alarm_app/db_helper/ProductSer.dart';
import 'package:alarm_app/models/Methods.dart';
import 'package:alarm_app/models/ProductModel.dart';
import 'package:alarm_app/Widget/SnakBar_Widget.dart';
import 'package:flutter/material.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({Key? key, required this.index, required this.list})
      : super(key: key);
  final int index;
  final list;
  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  String TextBut = "إضافة";
  TextEditingController txteditTitle = TextEditingController();
  TextEditingController txteditDate = TextEditingController();
  var _prodService = ProductService();

  void initState() {
    if (widget.index == -1) {
      setState(() {
        TextBut = "إضافة";
        txteditTitle.text = "";
        txteditDate.text = "mm/dd/yy";
      });
    } else {
      TextBut = "تعديل";
      txteditTitle.text = widget.list[widget.index].name;
      txteditDate.text = widget.list[widget.index].Expier;
    }
    super.initState();
  }

  //Function Chick to find Product
  ChickRecName(String Title, String d) {
    for (int i = 0; i < recentProducts.length; i++) {
      if (Title == recentProducts[i].name && d == recentProducts[i].Expier) {
        return i;
      }
    }
    return -1;
  }

  //Function work Filter Product For  Reports
  void runFilterReports() {
    Healthy = [];
    good = [];
    bad = [];
    for (int i = 0; i < recentProducts.length; i++) {
      Product Product1 = recentProducts[i];
      DateTime d = DateTime.parse(Product1.Expier.toString());
      int daysLeft = DateTime.now().difference(d).inDays;
      daysLeft = daysLeft < 0 ? -daysLeft : 0;
      setState(() {
        if (daysLeft < 60 && daysLeft > 1) {
          good.add(Product1);
          //print(daysLeft.toString());
        } else if (daysLeft == 0) {
          bad.add(Product1);
        } else {
          Healthy.add(Product1);
        }
      });
    }
  }

  //Function Add Product
  AddProductNow() async {
    if (txteditTitle.text != "") {
      if (txteditDate.text != "" && txteditDate.text != "mm/dd/yy") {
        var ProdNew = Product();
        ProdNew.name = txteditTitle.text;
        ProdNew.Expier = txteditDate.text;
        var result = await _prodService.SaveProduct(ProdNew);
        recentProducts.add(ProdNew);
        ProductsListFound = recentProducts;
        ProductsListFound = ProductsListFound.reversed.toList();
        ShowMySnakbar(
          context,
          "تمت الإضافة بنجاح",
          Color.fromARGB(205, 6, 240, 60),
        );
        //Navigator.pop(context);
        setState(() {
          txteditDate.text = "mm/dd/yy";
          txteditTitle.text = "";
          ProductsListFound = recentProducts;
          ProductsListFound = ProductsListFound.reversed.toList();
          runFilterReports();
          try {
            Scoll2.animateTo(Scoll2.position.maxScrollExtent,
                duration: Duration(milliseconds: 100),
                curve: Curves.easeInOutCubic);
          } catch (es) {}
        });
      } else {
        ShowMySnakbar(context, "يجب إدخل صلاحية المنتج!",
            Color.fromARGB(174, 198, 26, 32));
      }
    } else {
      ShowMySnakbar(
          context, "يجب إدخل إسم المنتج!", Color.fromARGB(174, 198, 26, 32));
    }
  }

//Function Refrash End Product
  void runFilterEndProd() {
    ListEndProd = [];
    List<Product> results = [];
    for (int i = 0; i < recentProducts.length; i++) {
      Product Product1 = recentProducts[i];
      int daysLeft =
          DateTime.now().difference(DateTime.parse(Product1.Expier!)).inDays;
      daysLeft = daysLeft < 0 ? -daysLeft : 0;
      if (daysLeft < 60) {
        results.add(Product1);
        //print(daysLeft.toString());
      }
    }
    setState(() {
      ListEndProd = results;
      ListEndProd.sort((a, b) {
        var adate = DateTime.parse(a.Expier.toString());
        var bdate = DateTime.parse(b.Expier.toString());
        return adate.compareTo(bdate);
      });
    });
  }

//Function Update Product
  UpdateProduct() async {
    if (txteditTitle != "") {
      if (txteditDate.text != "" && txteditDate.text != "mm/dd/yy") {
        String t = widget.list[widget.index].name;
        String d = widget.list[widget.index].Expier;
        int indo = ChickRecName(t, d);
        recentProducts[indo].name = txteditTitle.text;
        recentProducts[indo].Expier = txteditDate.text;
        Product p = recentProducts[indo];
        recentProducts.removeAt(indo);
        recentProducts.add(p);
        runFilterEndProd();
        runFilterReports();
        var result = await _prodService.UpdateProduct(p);
        ShowMySnakbar(
          context,
          "تمت التعديل بنجاح",
          Color.fromARGB(205, 6, 240, 60),
        );
        Navigator.pop(context);
        setState(() {
          txteditDate.text = "mm/dd/yy";
          txteditTitle.text = "";
          ProductsListFound = recentProducts;
          ProductsListFound = ProductsListFound.reversed.toList();
          runFilterReports();
        });
      } else {
        ShowMySnakbar(context, "يجب إدخل صلاحية المنتج!",
            Color.fromARGB(174, 198, 26, 32));
      }
    } else {
      ShowMySnakbar(
          context, "يجب إدخل إسم المنتج!", Color.fromARGB(174, 198, 26, 32));
    }
  }

  //Function Delet Product
  DeleteProduct() async {
    String t = widget.list[widget.index].name;
    String d = widget.list[widget.index].Expier;
    int indo = ChickRecName(t, d);
    if (indo != -1) {
      var result = await _prodService.deleteProduct(recentProducts[indo].id);
      recentProducts.removeAt(indo);
      widget.list.removeAt(widget.index);
      ShowMySnakbar(
        context,
        "تمت الحذف بنجاح",
        Color.fromARGB(205, 6, 240, 60),
      );
      Navigator.pop(context);
      runFilterReports();
      runFilterEndProd();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Wrap(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.only(bottom: 16),
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      TextBut + " منتج",
                      style: TextStyle(color: White, fontSize: 20),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: White, width: 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: White, width: 1),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    color: Colors.transparent,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: size.height >= 550 ? 10 : 3),
                      child: TextField(
                        controller: txteditTitle,
                        autofocus: true,
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                        style: TextStyle(color: White, fontSize: 17),
                        decoration: InputDecoration(
                          hintText: "",
                          hintStyle: TextStyle(color: White, fontSize: 20),
                          hintTextDirection: TextDirection.rtl,
                          border: InputBorder.none,
                          fillColor: White,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: Text(" :إسم المنتج",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 5, 198, 246),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          ),
                          prefixIcon: Icon(
                            Icons.add_to_photos_outlined,
                            color: Color.fromARGB(255, 5, 198, 246),
                          ),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    DateTime? resdate = await showDatePicker(
                        context: context,
                        textDirection: TextDirection.rtl,
                        initialDate: new DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2050));
                    if (resdate == null) {
                      setState(() {
                        txteditDate.text = getDateNow(DateTime.now());
                      });
                    } else {
                      setState(() {
                        txteditDate.text = getDateNow(resdate);
                      });
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.height >= 550 ? 10 : 3),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: White, width: 1),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 11),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Color.fromARGB(255, 5, 198, 246),
                                size: 25,
                              ),
                              Text(
                                txteditDate.text,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: White,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "صلاحية المنتج:",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 5, 198, 246),
                                    fontSize: 10 * 1.5,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.index != -1
                          ? InkWell(
                              child: Card(
                                color: Colors.redAccent,
                                elevation: 4,
                                shadowColor: blue,
                                borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: White),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 9),
                                  child: Text(" حذف  ",
                                      style: TextStyle(
                                          color: White, fontSize: 20)),
                                ),
                              ),
                              onTap: () {
                                ShowAlertdialog(
                                    context, DeleteProduct, "المنتج");
                              })
                          : SizedBox(
                              width: 0,
                            ),
                      InkWell(
                        child: Card(
                          color: Colors.blueAccent,
                          elevation: 4,
                          shadowColor: blue,
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: White),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: Text(TextBut,
                                style: TextStyle(color: White, fontSize: 20)),
                          ),
                        ),
                        onTap: () {
                          if (TextBut == "إضافة") {
                            AddProductNow();
                          } else {
                            UpdateProduct();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
