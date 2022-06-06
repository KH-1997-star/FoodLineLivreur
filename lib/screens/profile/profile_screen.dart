import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line_livreur/screens/conexion_screen.dart';
import 'package:food_line_livreur/screens/profile/profile_repo.dart';
import 'package:food_line_livreur/services/login_repo.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:food_line_livreur/utils/consts.dart';
import 'package:food_line_livreur/utils/functions.dart';
import 'package:food_line_livreur/widgets/identity_profile_widget.dart';
import 'package:food_line_livreur/widgets/my_profile_appbar.dart';
import 'package:food_line_livreur/widgets/my_title_button_widget.dart';

final profileProvider = ChangeNotifierProvider<ProfileLivreurNotifier>(
  (ref) => ProfileLivreurNotifier(),
);

class ProfileScreen extends ConsumerStatefulWidget {
  final bool fromHome;
  const ProfileScreen({this.fromHome = true, Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  bool done = false;
  String nom = '', ville = '', adresse = '', phone = '';

  getProfile() async {
    final viewModel = ref.read(profileProvider);
    await viewModel.getProfileLivreur();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(profileProvider);

    return WillPopScope(
      onWillPop: () async {
        widget.fromHome
            ? Navigator.pushNamed(context, '/home_screen')
            : Navigator.pushNamed(context, '/command_list_screen');
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileAppBar(
                    fromHome: widget.fromHome,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  IdentityProfile(
                    id: viewModel.livreur?.identifiant ?? '',
                    name:
                        '${viewModel.livreur?.nom ?? 'inconnu'} ${viewModel.livreur?.prenom ?? ''}',
                    path: viewModel.livreur?.photoProfil,
                  ),
                  SizedBox(
                    height: 42.8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 31.w, right: 44.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60.h,
                          child: ListTile(
                            title: Text(
                              'Nom',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xff89898A),
                              ),
                            ),
                            subtitle: TextFormField(
                              onChanged: (value) {
                                nom = value;
                              },
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(bottom: 35.h),
                                  child: SizedBox(
                                    height: 18.h,
                                    width: 18.w,
                                    child: SvgPicture.asset(
                                      'icons/edit_icon.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: 0.w,
                                    right: 3.w,
                                    top: 0.h,
                                    bottom: 14.h),
                                errorStyle:
                                    TextStyle(fontSize: 10.sp, height: 0.3),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                                hintText:
                                    '${viewModel.livreur?.nom ?? 'inconnu'} ${viewModel.livreur?.prenom ?? ''}',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                          child: ListTile(
                            title: Text(
                              'Ville',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xff89898A),
                              ),
                            ),
                            subtitle: TextFormField(
                              onChanged: (value) {
                                ville = value;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 0.w,
                                    right: 3.w,
                                    top: 0.h,
                                    bottom: 14.h),
                                errorStyle:
                                    TextStyle(fontSize: 10.sp, height: 0.3),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(bottom: 35.h),
                                  child: SizedBox(
                                    height: 18.h,
                                    width: 18.w,
                                    child: SvgPicture.asset(
                                      'icons/edit_icon.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                hintText: viewModel.livreur?.ville ?? 'inconnu',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                          child: ListTile(
                            title: Text(
                              'Adresse',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xff89898A),
                              ),
                            ),
                            subtitle: TextFormField(
                              onChanged: (value) {
                                adresse = value;
                              },
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(bottom: 35.h),
                                  child: SizedBox(
                                    height: 18.h,
                                    width: 18.w,
                                    child: SvgPicture.asset(
                                      'icons/edit_icon.svg',
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                    left: 0.w,
                                    right: 3.w,
                                    top: 0.h,
                                    bottom: 14.h),
                                errorStyle:
                                    TextStyle(fontSize: 10.sp, height: 0.3),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                                hintText:
                                    '${viewModel.livreur?.addresse ?? 'inconnu'} ',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                          child: ListTile(
                            title: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xff89898A),
                              ),
                            ),
                            subtitle: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 0.w,
                                    right: 3.w,
                                    top: 0.h,
                                    bottom: 14.h),
                                errorStyle:
                                    TextStyle(fontSize: 10.sp, height: 0.3),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                ),
                                hintText: viewModel.livreur?.email ?? 'inconnu',
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Numéro de Téléphone',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xff89898A),
                            ),
                          ),
                          subtitle: TextFormField(
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(bottom: 35.h),
                                child: SizedBox(
                                  height: 18.h,
                                  width: 18.w,
                                  child: SvgPicture.asset(
                                    'icons/edit_icon.svg',
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 0.w,
                                  right: 3.w,
                                  top: 0.h,
                                  bottom: 14.h),
                              errorStyle:
                                  TextStyle(fontSize: 10.sp, height: 0.3),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                              ),
                              hintText: viewModel.livreur?.phone ?? 'inconnu',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /* Padding(
                    padding: EdgeInsets.only(
                      left: 43.w,
                      top: 45.h,
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Missions Réalisées',
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                color: const Color(0xff89898A),
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              '3',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: myGreen,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 131.w,
                        ),
                        SvgPicture.asset(
                          'icons/search.svg',
                          color: Colors.black,
                        )
                      ],
                    ),
                  ), */
                  Padding(
                    padding: EdgeInsets.only(left: 31.w),
                    child: TextButton.icon(
                      onPressed: () async {
                        showLoader(context);
                        bool result = await Login().logOut();
                        hideLoader(context);
                        result
                            ? Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ConexionScreen()),
                                (route) => false,
                              )
                            : showToast(erreurUlterieur);
                      },
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      label: const Text(
                        'se deconecter',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55.h, //35.h/,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 32.w),
                        child: MyTitleButton(
                          titlePadding: 10,
                          onTap: () async {
                            nom.trim() == ''
                                ? nom =
                                    '${viewModel.livreur?.nom} ${viewModel.livreur?.prenom}'
                                : nom;
                            ville.trim() == ''
                                ? ville = viewModel.livreur?.ville ?? ''
                                : ville;
                            adresse.trim() == ''
                                ? adresse = viewModel.livreur?.addresse ?? ''
                                : adresse;
                            phone.trim() == ''
                                ? phone = viewModel.livreur?.phone ?? ''
                                : phone;

                            List<String>? nomPrenom = nom.split(' ');
                            hideKeyborad();
                            showLoader(context);
                            done = await viewModel.updateProfile(
                                nomPrenom[0],
                                nomPrenom.length == 1 ? '' : nomPrenom[1],
                                ville,
                                adresse,
                                viewModel.livreur?.pays,
                                viewModel.livreur?.codePostal,
                                phone);
                            Loader.hide();
                            Navigator.pushNamed(context, '/home_screen');
                            Navigator.pushNamed(context, '/profile_screen');
                          },
                          borderRadius: 9,
                          title: 'Sauvgarder',
                          width: 115.w,
                          height: 49.h,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
