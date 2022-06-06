import 'package:flutter/material.dart';
import 'package:food_line_livreur/models/commande_menu.dart';
import 'package:food_line_livreur/services/station_repo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:food_line_livreur/widgets/full_screen_widget.dart';
import 'package:food_line_livreur/widgets/my_widget_button.dart';

class DetailCommandScreen extends StatefulWidget {
  final String idCmd;
  const DetailCommandScreen({required this.idCmd, Key? key}) : super(key: key);

  @override
  State<DetailCommandScreen> createState() => _DetailCommandScreenState();
}

class _DetailCommandScreenState extends State<DetailCommandScreen> {
  StationNotifier stationNotifier = StationNotifier();
  bool done = false;
  bool? result;
  late CommandeMenu commandeMenu;
  getDetailCommand() async {
    var response = await stationNotifier.getDetailCommand(widget.idCmd);
    setState(() {
      done = true;
      result = response['result'];
    });
    if (response['result']) {
      commandeMenu = response['data'];
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.idCmd);
    getDetailCommand();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mygrey,
        body: !done
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  const FullScreenForStackWidget(),
                  Positioned(
                    top: 44.h,
                    left: 128.w,
                    child: Text(
                      'Détails Commande',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  ListView.builder(
                      padding: EdgeInsets.only(top: 120.h),
                      itemCount: commandeMenu
                          .detailsCommande?.listeMenusCommande?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Text(
                                'x${commandeMenu.detailsCommande!.listeMenusCommande?[index].quantite}',
                              ),
                              trailing: Image.network(commandeMenu
                                      .detailsCommande!
                                      .listeMenusCommande?[index]
                                      .linkedMenu?[0]
                                      .image ??
                                  ''),
                              subtitle: Text(
                                commandeMenu
                                        .detailsCommande!
                                        .listeMenusCommande?[index]
                                        .linkedMenu?[0]
                                        .description ??
                                    '',
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              title: Text(commandeMenu
                                      .detailsCommande!
                                      .listeMenusCommande?[index]
                                      .linkedMenu?[0]
                                      .titre ??
                                  ''),
                              /*  leading: Image.network(
                             '',
                            height: 50.h,
                            width: 50.w,
                      ), */
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                          ],
                        );
                      }),
                  Positioned(
                    top: 36.h,
                    left: 36.w,
                    child: MyWidgetButton(
                        widget: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
      ),
    );
  }
}
