import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_line_livreur/screens/detail_command.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:food_line_livreur/widgets/full_screen_widget.dart';
import 'package:food_line_livreur/widgets/my_title_button_widget.dart';
import 'package:food_line_livreur/widgets/side_mission_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MissionWidget extends StatelessWidget {
  final int? commandNumber, quantity;

  final String? date, prix;
  final double? stationDistance;
  final List? position;
  final bool enAttente;
  final VoidCallback? onPresse, onTap;
  final Color cardColor;
  final Function(String)? onConfirm, onDelete;
  const MissionWidget({
    this.cardColor = mywhite,
    this.enAttente = true,
    this.quantity,
    this.commandNumber,
    this.date,
    this.stationDistance,
    this.position,
    this.onPresse,
    this.onTap,
    this.prix,
    this.onConfirm,
    this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //String distance = stationDistance!.toStringAsFixed(1);
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h),
      child: Container(
        height: 115.h,
        width: 328.w,
        decoration: BoxDecoration(
          color: cardColor,
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
                padding: EdgeInsets.only(left: 12.w, top: 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 239.w,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                'CMD N°$commandNumber',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 35.w,
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Text(
                                '(faite à ${date}h)',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xff717171),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        'prix total : $prix€',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'Quantité total:',
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            '$quantity',
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
            enAttente
                ? Align(
                    alignment: Alignment.topRight,
                    child: SideMissionWidget(
                      height: 57.72,
                      color: const Color(0xff5B8A01),
                      opacity: 0.21,
                      myWidget: const Icon(
                        Icons.done,
                        color: myGreen,
                      ),
                      top: true,
                      onTap: () => myAlert(context, true),
                    ),
                  )
                : const SizedBox(),
            enAttente
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: SideMissionWidget(
                      height: 57.72,
                      color: Colors.red,
                      opacity: 0.13,
                      myWidget: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      onTap: () => myAlert(context, false),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  myAlert(context, bool isValid) => showDialog(
        context: context,
        builder: (context) => Dialog(
          insetAnimationDuration: const Duration(seconds: 1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0.r))),
          child: Stack(
            children: [
              Container(
                height: 257.h,
                width: 295.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.r),
                ),
                child: SingleChildScrollView(
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
                        height: 30.5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50.w, right: 52.w),
                        child: Text(
                          isValid ? valider : refuser,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 15.h,
                left: 70.w,
                child: MyTitleButton(
                  width: 165.w,
                  onTap: () {
                    isValid ? onConfirm!('delivered') : onDelete!('canceled');
                    Navigator.pop(context);
                  },
                  title: 'Oui',
                ),
              ),
            ],
          ),
        ),
      );
}
