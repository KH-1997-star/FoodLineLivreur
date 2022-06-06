import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_line_livreur/models/station.dart';
import 'package:food_line_livreur/screens/command_list_screen.dart';
import 'package:food_line_livreur/services/station_repo.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line_livreur/utils/functions.dart';
import 'package:food_line_livreur/widgets/station_widget.dart';
import 'package:food_line_livreur/widgets/full_screen_widget.dart';
import 'package:food_line_livreur/widgets/my_home_appbar.dart';
import 'profile/profile_repo.dart';

final stationProvider = ChangeNotifierProvider<StationNotifier>(
  (ref) => StationNotifier(),
);
final profileProvider = ChangeNotifierProvider<ProfileLivreurNotifier>(
  (ref) => ProfileLivreurNotifier(),
);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  StationNotifier stationNotifier = StationNotifier();
  StreamController? controller;
  List<Station> stations = [];
  bool done = false;
  bool result = true;
  Timer? timer;
  getCommands() async {
    final viewModel = ref.read(stationProvider);
  }

  getStation() async {
    final viewModel = ref.read(stationProvider);
    result = await viewModel.getStation();
    if (result) {
      result = await viewModel.getAllCommandStatus();
    }
    if (mounted) {
      setState(() {});
    }
  }

  checkChanges() async {
    final viewModel = ref.read(stationProvider);
    await viewModel.getStation().then((value) {
      controller?.add(value);
      (value);
    });
    /* if (result) {
      result = await viewModel.getAllCommandStatus();
    }
    setState(() {}); */
  }

  getProfile() async {
    final viewModel = ref.read(profileProvider);
    await viewModel.getProfileLivreur();
    setState(() {
      done = true;
    });
  }

  @override
  void initState() {
    super.initState();

    getStation();
    getProfile();
    timer = Timer.periodic(const Duration(milliseconds: 1500), (v) {
      getStation();
      ('heelo');
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  /* void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivated');
    timer?.cancel();
  } */

  @override
  Widget build(BuildContext context) {
    final viewProfileModel = ref.read(profileProvider);
    final viewModel = ref.read(stationProvider);
    bool isDispo = viewProfileModel.livreur?.disponible == '1';

    return SafeArea(
      child: Scaffold(
        backgroundColor: mygrey,
        body: !result
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  const FullScreenForStackWidget(),
                  !done
                      ? const Center(child: CircularProgressIndicator())
                      : MyHomeAppBar(
                          titre: Text(
                            'Mes Arrêts',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          delivered:
                              viewModel.commandStatus?.nbreCommandesdelivered ??
                                  0,
                          waiting:
                              viewModel.commandStatus?.nbreCommandeEnAttente ??
                                  0,
                          canceled:
                              viewModel.commandStatus?.nbreCommandesAnnule ?? 0,
                          dispo: isDispo,
                        ),
                  Positioned(
                    top: 320.h,
                    left: 23.5.w,
                    right: 23.5.w,
                    child: SizedBox(
                      height: 500,
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 0, bottom: 160.h),
                        itemBuilder: (context, i) => StationWidget(
                          etat: viewModel.commandList?.typeBtn,
                          heure: viewModel.staions[i].heureArrive,
                          idCamion: viewModel.staions[i].idTrajetCamion ?? '',
                          idStation: viewModel.staions[i].idStation ?? '',
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommandListScreen(
                                idStation: viewModel.staions[i].idStation ?? '',
                                idTrajet:
                                    viewModel.staions[i].idTrajetCamion ?? '',
                                title: viewModel.staions[i].name,
                              ),
                            ),
                          ),
                          onPresse: () {
                            /*  viewModel.getCommands(
                              viewModel.staions[i].idStation ?? '',
                              viewModel.staions[i].idTrajetCamion ?? ''); */
                            print(viewModel.staions[i].idStation);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommandListScreen(
                                  idStation:
                                      viewModel.staions[i].idStation ?? '',
                                  idTrajet:
                                      viewModel.staions[i].idTrajetCamion ?? '',
                                  title: viewModel.staions[i].name,
                                ),
                              ),
                            );
                          },
                          stationName: viewModel.staions[i].name ?? '',
                          commandNumber: viewModel.staions[i].nbreCmd ?? 0,
                          stationDistance: viewModel.staions[i].distance ?? 0,
                          position: viewModel.staions[i].position ?? [0, 0],
                        ),
                        itemCount: viewModel.staions.length,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      height: 100.h,
                      width: getWidth(context),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
