import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermoneymanagementapp/constants/color_constant.dart';
import 'package:fluttermoneymanagementapp/models/card_model.dart';
import 'package:fluttermoneymanagementapp/models/operation_model.dart';
import 'package:fluttermoneymanagementapp/models/transaction_model.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current_index = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
              margin: EdgeInsets.all(10),
              child: ListView(physics: ClampingScrollPhysics(), children: [
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset('assets/svg/drawer_icon.svg'),
                        Container(
                            height: 59,
                            width: 59,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/user_image.png"))))
                      ]),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Good Morning",
                            style: GoogleFonts.inder(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                        Text("Wahbi Baklouti",
                            style: GoogleFonts.inter(
                                fontSize: 18, fontWeight: FontWeight.w700))
                      ]),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 200,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 0, right: 8),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(right: 8),
                          height: 199,
                          width: 340,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Color(cards[index].cardBackground),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                  // bottom:150,
                                  child: SvgPicture.asset(
                                      cards[index].cardElementTop)),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: SvgPicture.asset(
                                      cards[index].cardElementBottom)),
                              Positioned(
                                  top: 49,
                                  left: 30,
                                  child: Text("Card Number",
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ))),
                              Positioned(
                                top: 70,
                                left: 30,
                                child: Text(cards[index].cardNumber,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    )),
                              ),
                              Positioned(
                                  bottom: 45,
                                  left: 30,
                                  child: Text("Card HolderName",
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ))),
                              Positioned(
                                bottom: 25,
                                left: 30,
                                child: Text(cards[index].user,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    )),
                              ),
                              Positioned(
                                  top: 31,
                                  right: 40,
                                  child: Image.asset(cards[index].cardType,
                                      height: 29, width: 29)),
                              Positioned(
                                  bottom: 45,
                                  right: 54,
                                  child: Text("Expired Date",
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ))),
                              Positioned(
                                bottom: 25,
                                right: 30,
                                child: Text(cards[index].cardExpired,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    )),
                              ),
                            ],
                          ));
                    },
                    itemCount: cards.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 0, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Operations",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                          )),
                      Row(
                          children: map<Widget>(datas, (index, selected) {
                        return Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: current_index == index
                                  ? kBlueColor
                                  : kTwentyBlueColor,
                            ));
                      }))
                    ],
                  ),
                ),
                Container(
                    height: 125,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(left: 8),
                        scrollDirection: Axis.horizontal,
                        itemCount: datas.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  current_index = index;
                                });
                              },
                              child: OperationCard(
                                operation: datas[index].name,
                                selectedIcon: datas[index].selectedIcon,
                                unselectedIcon: datas[index].unselectedIcon,
                                isSelected: current_index == index,
                              ),
                            ))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 0, 16),
                  child: Text("Transaction Histories",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                      )),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    return Container(
                        height: 69,
                        padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: kTenBlackColor,
                              blurRadius: 10,
                              offset: Offset(8, 8),
                            )
                          ],
                        ),
                        child: Row(children: [
                          Image.asset(transactions[index].photo),
                          SizedBox(width: 24),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(transactions[index].name,
                                    style: GoogleFonts.inter(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900)),
                                Text(transactions[index].date,
                                    style: GoogleFonts.inter(
                                        fontSize: 11, color: Colors.grey))
                              ]),
                          Spacer(),
                          Text(transactions[index].amount,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight:FontWeight.w400,
                                color: transactions[index].amount.startsWith("+")?Colors.green:Colors.red,
                              ))
                        ]));
                  },
                )
              ])),
        ));
  }
}

class OperationCard extends StatefulWidget {
  final String operation;
  final String selectedIcon;
  final String unselectedIcon;
  final bool isSelected;

  OperationCard(
      {this.isSelected,
      this.selectedIcon,
      this.unselectedIcon,
      this.operation});

  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 10),
        height: 125,
        width: 125,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kTenBlackColor,
              blurRadius: 10,
              offset: Offset(8, 8),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          color: widget.isSelected ? kBlueColor : kWhiteColor,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(
              widget.isSelected ? widget.selectedIcon : widget.unselectedIcon),
          Text(widget.operation,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: widget.isSelected ? kWhiteColor : kBlackColor,
              ),
              textAlign: TextAlign.center)
        ]));
  }
}
