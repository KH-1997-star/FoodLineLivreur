import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line_livreur/models/command_list.dart';
import 'package:food_line_livreur/screens/location_screen.dart';
import 'package:food_line_livreur/services/station_repo.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:food_line_livreur/utils/functions.dart';
import 'package:food_line_livreur/widgets/full_screen_widget.dart';
import 'package:food_line_livreur/widgets/my_title_button_widget.dart';
import 'package:food_line_livreur/widgets/side_mission_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StationWidget extends StatelessWidget {
  final String? stationName, heure;
  final int? commandNumber;
  final double? stationDistance;
  final List? position;
  final VoidCallback? onPresse;
  final VoidCallback? onTap;
  final String? idStation;
  final String? idCamion;
  final String? etat;

  const StationWidget({
    this.stationName,
    this.heure,
    this.commandNumber,
    this.stationDistance,
    this.position,
    this.onPresse,
    this.onTap,
    this.idCamion,
    this.idStation,
    this.etat,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StationNotifier stationNotifier = StationNotifier();
    print('IDDDDCOMAAND');
    print(idCamion);
    print(idStation);
    print(etat);

    String distance = stationDistance!.toStringAsFixed(1);
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: Container(
        height: 115.h,
        width: 328.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(-2, 2), // Shadow position
            ),
          ],
        ),
        child: Stack(
          children: [
            const FullScreenForStackWidget(),
            InkWell(
              onTap: () => onTap!(),
              child: Padding(
                padding: EdgeInsets.only(left: 12.w, top: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 260.w,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              width: 170.w,
                              child: Text('$stationName',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: SizedBox(
                              width: 60.w,
                              child: Text(
                                '(faite à ${heure}h)',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xff717171),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        'Nombre de commandes : $commandNumber',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'icons/location_icon.svg',
                            width: 12.3.w,
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'A $distance km',
                            style: TextStyle(
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SideMissionWidget(
                  color: const Color(0xff5B8A01),
                  opacity: 0.21,
                  myWidget: const Icon(
                    Icons.location_on_outlined,
                    color: myGreen,
                  ),
                  top: true,
                  onTap: () async {
                    CommandList commandList = await stationNotifier.getCommands(
                        idStation ?? '', idCamion ?? '');
                    print('Type BTN');
                    print(commandList.typeBtn);
                    commandList.typeBtn == 'false'
                        ? showToast(erreurUlterieur)
                        : commandList.typeBtn == 'isGone'
                            ? showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: const Text(
                                      'Cette station c\'est déjà livrée'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('fermer'),
                                    )
                                  ],
                                ),
                              )
                            : Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LocationScreen(
                                    lat: position?[0] ?? 0,
                                    lng: position?[1] ?? 0,
                                    idStation: idStation,
                                    idTrajetCamion: idCamion,
                                    etat: commandList.typeBtn,
                                  ),
                                ),
                              );
                  }),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SideMissionWidget(
                color: const Color(0xff44656B),
                opacity: 0.13,
                myWidget: const Icon(
                  Icons.menu_sharp,
                  color: Color(0xff44656B),
                ),
                onTap: () => onPresse!(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  myAlert(context) => showDialog(
        context: context,
        builder: (context) => Dialog(
          insetAnimationDuration: const Duration(seconds: 1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0.r))),
          child: Container(
            height: 257.h,
            width: 295.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 23.h, left: 26.w),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'icons/close_icon.svg',
                      width: 16.w,
                      height: 16.5.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 52.5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50.w, right: 52.w),
                  child: Text(
                    'Etes Vous Sure De Vouloir Refuser La Commande ?',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 46.h,
                ),
                Center(
                  child: MyTitleButton(
                    width: 165.w,
                    onTap: () {},
                    title: 'Oui',
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
