import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line_livreur/screens/profile/profile_screen.dart';
import 'package:food_line_livreur/screens/qr_code_screen.dart';
import 'package:food_line_livreur/services/station_repo.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:food_line_livreur/utils/functions.dart';
import 'package:food_line_livreur/widgets/home_colored_widget.dart';
import 'package:page_transition/page_transition.dart';

class MyHomeAppBar extends StatefulWidget {
  final String? idTrajet, idStation, title;
  final int? delivered, waiting, canceled;
  final Function(int)? chosenTable;
  final bool dispo, arret;
  final Widget? titre;
  final double leftPadding;
  const MyHomeAppBar({
    this.idStation,
    this.idTrajet,
    this.title,
    this.chosenTable,
    this.canceled,
    this.delivered,
    this.waiting,
    this.arret = true,
    this.titre,
    this.leftPadding = 37,
    required this.dispo,
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomeAppBar> createState() => _MyHomeAppBarState();
}

class _MyHomeAppBarState extends State<MyHomeAppBar> {
  List<bool> boolList = [false, true, false];
  bool dispo = true;

  @override
  void initState() {
    super.initState();

    setState(() {
      dispo = widget.dispo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 332.h,
      width: getWidth(context),
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: 49.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: getWidth(context),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: widget.leftPadding.w,
                          ),
                          child: widget.titre,
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'icons/notif_icon.svg',
                            width: 17.w,
                            height: 20.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13.w,
                      ),
                      Expanded(
                        flex: 0,
                        child: InkWell(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: ProfileScreen(
                                fromHome: widget.arret,
                              ),
                              type: PageTransitionType.fade,
                              duration: const Duration(milliseconds: 750),
                              reverseDuration:
                                  const Duration(milliseconds: 750),
                            ),
                          ),
                          child: SvgPicture.asset(
                            'icons/profile_icon.svg',
                            height: 19.69.h,
                            width: 14.81.w,
                          ),
                        ),
                      ),
                      SizedBox(width: 30.h),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: widget.arret ? 230.w : 180.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      widget.arret
                          ? const SizedBox()
                          : InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScanScreen(
                                    idStation: widget.idStation,
                                    idTrajet: widget.idTrajet,
                                    title: widget.title,
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                'icons/scan.png',
                                height: 45.h,
                                width: 45.w,
                              ),
                            ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Disponible',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: dispo ? myGreen : Colors.grey[350],
                        ),
                      ),
                      buildSwitch(),
                    ],
                  ),
                ),
                SizedBox(height: 42.h),
                Padding(
                  padding: EdgeInsets.only(left: 19.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HomeColoredWidget(
                        onTap: widget.arret
                            ? () {}
                            : () {
                                setState(() {
                                  boolList[0] = true;
                                  boolList[1] = false;
                                  boolList[2] = false;
                                });
                                widget.chosenTable!(0);
                              },
                        arret: widget.arret,
                        clicked: boolList[0],
                        color: const Color(0xff3EC1F3),
                        number: '${widget.delivered}',
                        titre: 'Livrées',
                      ),
                      SizedBox(
                        width: 26.w,
                      ),
                      HomeColoredWidget(
                        onTap: widget.arret
                            ? () {}
                            : () {
                                setState(() {
                                  boolList[0] = false;
                                  boolList[1] = true;
                                  boolList[2] = false;
                                });
                                widget.chosenTable!(1);
                              },
                        arret: widget.arret,
                        clicked: boolList[1],
                        color: const Color(0xff606060),
                        number: '${widget.waiting}',
                        titre: 'En attentes',
                        isBlack: true,
                      ),
                      SizedBox(
                        width: 26.w,
                      ),
                      HomeColoredWidget(
                        onTap: widget.arret
                            ? () {}
                            : () {
                                setState(() {
                                  boolList[0] = false;
                                  boolList[1] = false;
                                  boolList[2] = true;
                                });
                                widget.chosenTable!(2);
                              },
                        arret: widget.arret,
                        clicked: boolList[2],
                        color: const Color(0xffFF0000),
                        number: '${widget.canceled}',
                        titre: 'Annulées',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 19.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSwitch() {
    return Switch.adaptive(
      activeColor: myGreen,
      value: dispo,
      onChanged: (v) async {
        showLoader(context);

        bool result = await StationNotifier().updateLivreurDispo(v);
        Loader.hide();
        if (result) {
          setState(
            () {
              dispo = v;
            },
          );
        } else {
          showToast(erreurUlterieur);
        }
      },
    );
  }
}
