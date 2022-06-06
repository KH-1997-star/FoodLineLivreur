import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line_livreur/models/command_list.dart';
import 'package:food_line_livreur/services/location_tracking_repo.dart';
import 'package:food_line_livreur/services/station_repo.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:food_line_livreur/utils/functions.dart';
import 'package:food_line_livreur/widgets/bottom_location_widget.dart';
import 'package:food_line_livreur/widgets/full_screen_widget.dart';
import 'package:food_line_livreur/widgets/go_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget {
  final double lat, lng;

  final String? idStation, idTrajetCamion, etat;
  const LocationScreen({
    this.lat = 49.409393,
    this.lng = 1.084645,
    this.idStation,
    this.idTrajetCamion,
    this.etat,
    Key? key,
  }) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool onWorking = false;
  getLoc() async {
    onWorking = true;
    print('H1');
    showLoader(context);
    bool result = await getCurrentLocation();
    print('H2');
    if (result) {
      Loader.hide();
      print('H3');
    } else {
      Loader.hide();
      showToast(erreurUlterieur);
      print('H4');
    }
    onWorking = false;
  }

  StationNotifier stationNotifier = StationNotifier();
  String titre = 'GO';
  bool partiClicked = false;
  StreamSubscription? _streamSubscription;
  LocationTracking locationTracking = LocationTracking();
  Marker marker = const Marker(
    markerId: MarkerId('home'),
    position: LatLng(49.409393, 1.084645),
  );
  late Marker destinationMarker;

  late Polyline polyline =
      const Polyline(polylineId: PolylineId('polyline'), points: [
    LatLng(49.409393, 1.084645),
    LatLng(49.409393, 1.084645),
  ]);
  final Location _location = Location();
  Circle circle = Circle(
    circleId: const CircleId('car'),
    zIndex: 1,
    radius: 60,
    strokeColor: Colors.blue,
    center: const LatLng(37.4219983, -122.084),
    fillColor: Colors.blue.withAlpha(70),
  );

  bool gone = false;
  late Widget myWidget;
  List<Widget> bottomWidget = [
    Align(
      key: const ValueKey('0'),
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        child: Text(
          'Vous êtes hors ligne',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    Align(
      key: const ValueKey('1'),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Vous êtes ',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'connecté',
            style: TextStyle(
              fontSize: 20.sp,
              color: myGreen,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    )
  ];
  int index = 0;
  final String a = '';
  GoogleMapController? _controller;
  late CameraPosition _kGooglePlex;
  @override
  void initState() {
    super.initState();
    titre = widget.etat!;
    if (titre == 'jysuis') {
      setState(() {
        titre = 'j\'y suis';
      });
    }

    _kGooglePlex = CameraPosition(
      target: LatLng(widget.lat, widget.lng),
      zoom: 13,
    );
    titre == 'go' ? myWidget = bottomWidget[0] : myWidget = bottomWidget[1];
    destinationMarker = Marker(
      markerId: const MarkerId('destination'),
      position: LatLng(widget.lat, widget.lng),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('TYPE BTN INSIDE LOCATION : ${widget.etat}');
    return WillPopScope(
      onWillPop: () async {
        if (!onWorking) {
          await _streamSubscription?.cancel();
          _controller!.dispose();

          Navigator.pushNamed(
            context,
            '/home_screen',
          );
        }

        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            const FullScreenForStackWidget(),
            GoogleMap(
              markers: {marker, destinationMarker},
              circles: {circle},
              polylines: {polyline},
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (controller) async {
                _controller = controller;
                if (titre != 'go') {
                  await getLoc();
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 121.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: gone ? 0 : 1,
                  child: GOWidget(
                    title: titre,
                    onTap: () async {
                      print('tapped');

                      if (titre == 'go') {
                        await getLoc();
                        print('11111111111111111');
                        print('go');
                        showLoader(context);
                        var result = await stationNotifier.changeEtatCommande(
                          'deliveryInTheTransit',
                          widget.idStation ?? '',
                          widget.idTrajetCamion ?? '',
                        );
                        CommandList commandList =
                            await stationNotifier.getCommands(
                                widget.idStation ?? '',
                                widget.idTrajetCamion ?? '');
                        hideLoader(context);
                        if (result['result'] && mounted) {
                          setState(() {
                            titre = commandList.typeBtn ?? '';
                            print('1111111111111111');
                            titre == 'jysuis' ? titre = 'j\'y suis' : '';
                            print(titre);
                            myWidget = bottomWidget[1];
                          });
                        } else {
                          showToast(result['message']);
                        }
                      } else if (titre == 'j\'y suis') {
                        print('22222222222222222');
                        print('atThePlace');
                        showLoader(context);
                        var result = await stationNotifier.changeEtatCommande(
                          'atThePlace',
                          widget.idStation ?? '',
                          widget.idTrajetCamion ?? '',
                        );
                        print(result);
                        CommandList commandList =
                            await stationNotifier.getCommands(
                                widget.idStation ?? '',
                                widget.idTrajetCamion ?? '');
                        print(commandList.typeBtn);
                        hideLoader(context);
                        if (result['result']) {
                          setState(() {
                            titre = commandList.typeBtn ?? '';
                          });
                        } else {
                          showToast(result['message']);
                        }
                      } else if (titre == 'parti') {
                        print('333333333333333333');
                        print('isGone');
                        var result = await stationNotifier.changeEtatCommande(
                          'isGone',
                          widget.idStation ?? '',
                          widget.idTrajetCamion ?? '',
                        );

                        if (result['result'] && mounted) {
                          if (!onWorking) {
                            Navigator.pushNamed(
                              context,
                              '/home_screen',
                            );
                          }
                        } else {
                          showToast(result['message']);
                        }
                      } else {
                        print('hereeeee');
                        print(titre);
                      }
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomLocationWidget(
                bottomWidget: AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  child: myWidget,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load(
      'images/car.jpg',
    );
    return byteData.buffer.asUint8List();
  }

  upadateMarkerAndCicle(LocationData? locationData, Uint8List imageData) {
    LatLng latLng =
        LatLng(locationData!.latitude ?? 0, locationData.longitude ?? 0);
    if (mounted) {
      setState(() {
        marker = Marker(
          markerId: const MarkerId('home'),
          position: latLng,
          rotation: locationData.heading ?? 0,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData),
        );
        circle = Circle(
          circleId: const CircleId('car'),
          radius: locationData.accuracy ?? 0,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latLng,
          fillColor: Colors.blue.withAlpha(70),
        );
      });
    }
  }

  Future<bool> getCurrentLocation() async {
    bool result = false;
    try {
      Uint8List imageData = await getMarker();
      var location = await _location.getLocation();
      if (mounted) {
        setState(() {
          polyline = Polyline(
            polylineId: const PolylineId('poly'),
            points: [
              LatLng(location.latitude ?? 0, location.longitude ?? 0),
              LatLng(widget.lat, widget.lng),
            ],
            color: myGreen,
          );
        });
        await locationTracking.changeLivreurLocation(
            lat: location.latitude ?? 0, lng: location.longitude ?? 0);

        upadateMarkerAndCicle(location, imageData);
        _streamSubscription =
            _location.onLocationChanged.listen((newLoc) async {
          _controller!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  tilt: 0,
                  zoom: 13,
                  target: LatLng(newLoc.latitude ?? 0, newLoc.longitude ?? 0),
                  bearing: 192.8334901395799),
            ),
          );
          upadateMarkerAndCicle(newLoc, imageData);
          if (mounted) {
            setState(() {
              polyline = Polyline(
                polylineId: const PolylineId('poly'),
                points: [
                  LatLng(newLoc.latitude ?? 0, newLoc.longitude ?? 0),
                  LatLng(widget.lat, widget.lng),
                ],
                color: myGreen,
              );
            });
          }

          await locationTracking.changeLivreurLocation(
              lat: newLoc.latitude ?? 0, lng: newLoc.longitude ?? 0);
        });
        result = true;
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        (e.code);
        result = false;
      } else {
        result = false;
      }
    }
    return result;
  }

  @override
  void dispose() {
    print('disposed');
    super.dispose();
    _streamSubscription?.cancel();
    _controller!.dispose();
  }
}
