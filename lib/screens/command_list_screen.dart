import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_line_livreur/models/command_list.dart';
import 'package:food_line_livreur/screens/detail_command.dart';
import 'package:food_line_livreur/services/station_repo.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:food_line_livreur/utils/functions.dart';
import 'package:food_line_livreur/widgets/full_screen_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line_livreur/widgets/mission_widget.dart';
import 'package:food_line_livreur/widgets/my_home_appbar.dart';

import 'profile/profile_repo.dart';

final stationProvider = ChangeNotifierProvider<StationNotifier>(
  (ref) => StationNotifier(),
);
final profileProvider = ChangeNotifierProvider<ProfileLivreurNotifier>(
  (ref) => ProfileLivreurNotifier(),
);

class CommandListScreen extends ConsumerStatefulWidget {
  final String? idTrajet, idStation, title;

  const CommandListScreen({
    this.idStation,
    this.idTrajet,
    this.title,
    Key? key,
  }) : super(key: key);

  @override
  _CommandListScreenState createState() => _CommandListScreenState();
}

class _CommandListScreenState extends ConsumerState<CommandListScreen> {
  CommandList commandList = CommandList();
  bool done = false;
  bool getProf = false;
  int index = 1;
  getProfile() async {
    final viewModel = ref.read(profileProvider);
    await viewModel.getProfileLivreur();
    setState(() {
      getProf = true;
    });
  }

  getCommands() async {
    final viewModel = ref.read(stationProvider);
    commandList = await viewModel.getCommands(
        widget.idStation ?? '', widget.idTrajet ?? '');
    setState(() {
      done = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getCommands();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final viewProfileModel = ref.read(profileProvider);
    final viewModel = ref.read(stationProvider);
    bool isDispo = viewProfileModel.livreur?.disponible == '1';

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/home_screen');
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: mygrey,
          body: !done || !getProf
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    const FullScreenForStackWidget(),
                    MyHomeAppBar(
                      idStation: widget.idStation,
                      idTrajet: widget.idTrajet,
                      title: widget.title,
                      chosenTable: (p0) {
                        setState(() {
                          index = p0;
                        });
                      },
                      arret: false,
                      leftPadding: 0,
                      dispo: isDispo,
                      titre: Row(
                        children: [
                          IconButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/home_screen'),
                            icon: const Icon(Icons.arrow_back),
                          ),
                          Text(
                            'Mes Missions',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      delivered: viewModel.commandList?.delivered?.length ?? 0,
                      canceled: viewModel.commandList?.annule?.length ?? 0,
                      waiting: viewModel.commandList?.enAttente?.length ?? 0,
                    ),
                    Positioned(
                      top: 320.h,
                      left: 23.5.w,
                      right: 23.5.w,
                      child: SizedBox(
                        height: 500,
                        child: index == 1
                            ? ListView.builder(
                                padding: EdgeInsets.only(top: 0, bottom: 160.h),
                                itemBuilder: (context, i) => MissionWidget(
                                  onPresse: () {},
                                  onConfirm: (p0) async {
                                    showLoader(context);

                                    bool result =
                                        await viewModel.changeStatutCommande(
                                      p0,
                                      viewModel.commandList?.enAttente?[i]
                                          .idCommande,
                                      context,
                                      widget.idStation,
                                      widget.idTrajet,
                                      widget.title,
                                    );
                                    Loader.hide();
                                    if (!result) {
                                      showToast(erreurUlterieur);
                                    }
                                  },
                                  onDelete: (p0) async {
                                    showLoader(context);
                                    bool result =
                                        await viewModel.changeStatutCommande(
                                      p0,
                                      viewModel.commandList?.enAttente?[i]
                                          .idCommande,
                                      context,
                                      widget.idStation,
                                      widget.idTrajet,
                                      widget.title,
                                    );
                                    Loader.hide();
                                    if (!result) {
                                      showToast(erreurUlterieur);
                                    }
                                  },
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailCommandScreen(
                                        idCmd: viewModel.commandList
                                                ?.enAttente?[i].idCommande ??
                                            '',
                                      ),
                                    ),
                                  ),
                                  commandNumber: viewModel.commandList
                                          ?.enAttente?[i].numeroCommande ??
                                      0,
                                  date: viewModel
                                          .commandList?.enAttente?[i].date ??
                                      '',
                                  prix: viewModel
                                          .commandList?.enAttente?[i].totalTtc
                                          .toString() ??
                                      '',
                                  quantity: viewModel.commandList?.enAttente?[i]
                                          .quantite ??
                                      0,
                                ),
                                itemCount:
                                    viewModel.commandList?.enAttente?.length ??
                                        0,
                              )
                            : ListView.builder(
                                padding: EdgeInsets.only(top: 0, bottom: 160.h),
                                itemBuilder: (context, i) => MissionWidget(
                                  cardColor: index == 2
                                      ? const Color(0xffFF0000)
                                          .withOpacity(0.50)
                                      : const Color(0xff3EC1F3)
                                          .withOpacity(0.50),
                                  enAttente: false,
                                  onPresse: () {},
                                  onConfirm: (p0) async {
                                    showLoader(context);

                                    bool result = index == 0
                                        ? await viewModel.changeStatutCommande(
                                            p0,
                                            viewModel.commandList?.delivered?[i]
                                                .idCommande,
                                            context,
                                            widget.idStation,
                                            widget.idTrajet,
                                            widget.title,
                                          )
                                        : await viewModel.changeStatutCommande(
                                            p0,
                                            viewModel.commandList?.annule?[i]
                                                .idCommande,
                                            context,
                                            widget.idStation,
                                            widget.idTrajet,
                                            widget.title,
                                          );
                                    Loader.hide();
                                    if (!result) {
                                      showToast(erreurUlterieur);
                                    }
                                  },
                                  onDelete: (p0) async {
                                    showLoader(context);
                                    bool result =
                                        await viewModel.changeStatutCommande(
                                      p0,
                                      viewModel.commandList?.delivered?[i]
                                          .idCommande,
                                      context,
                                      widget.idStation,
                                      widget.idTrajet,
                                      widget.title,
                                    );
                                    Loader.hide();
                                    if (!result) {
                                      showToast(erreurUlterieur);
                                    }
                                  },
                                  onTap: () => index == 2
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailCommandScreen(
                                              idCmd: viewModel.commandList
                                                      ?.annule?[i].idCommande ??
                                                  '',
                                            ),
                                          ),
                                        )
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailCommandScreen(
                                              idCmd: viewModel
                                                      .commandList
                                                      ?.delivered?[i]
                                                      .idCommande ??
                                                  '',
                                            ),
                                          ),
                                        ),
                                  commandNumber: index == 0
                                      ? viewModel.commandList?.delivered![i]
                                              .numeroCommande ??
                                          0
                                      : viewModel.commandList?.annule![i]
                                              .numeroCommande ??
                                          0,
                                  date: index == 0
                                      ? viewModel.commandList?.delivered![i]
                                              .date ??
                                          ''
                                      : viewModel
                                              .commandList?.annule?[i].date ??
                                          '',
                                  prix: index == 0
                                      ? viewModel.commandList?.delivered![i]
                                              .totalTtc
                                              .toString() ??
                                          ''
                                      : viewModel
                                              .commandList?.annule?[i].totalTtc
                                              .toString() ??
                                          '',
                                  quantity: index == 0
                                      ? viewModel.commandList?.delivered![i]
                                              .quantite ??
                                          0
                                      : viewModel.commandList?.annule?[i]
                                              .quantite ??
                                          0,
                                ),
                                itemCount: index == 0
                                    ? viewModel
                                            .commandList?.delivered?.length ??
                                        0
                                    : viewModel.commandList?.annule?.length ??
                                        0,
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
      ),
    );
  }
}
