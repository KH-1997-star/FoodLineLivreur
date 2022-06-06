import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_line_livreur/screens/home_screen.dart';
import 'package:food_line_livreur/services/login_repo.dart';
import 'package:food_line_livreur/utils/functions.dart';
import 'package:food_line_livreur/widgets/conexion_form_widget.dart';
import 'package:food_line_livreur/widgets/first_half_conexion_widget.dart';
import 'package:food_line_livreur/widgets/mdp_oublier_widget.dart';
import 'package:food_line_livreur/widgets/my_title_button_widget.dart';
import 'package:page_transition/page_transition.dart';

class ConexionScreen extends StatefulWidget {
  const ConexionScreen({Key? key}) : super(key: key);

  @override
  State<ConexionScreen> createState() => _ConexionScreenState();
}

class _ConexionScreenState extends State<ConexionScreen> {
  String email = '', password = '', message = '';
  Map<String, dynamic>? result;
  Login login = Login();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FirstHalfConexionWidget(),
              SizedBox(
                height: 46.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 50.w),
                child: Text(
                  'Se connecter',
                  style: TextStyle(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 39.w),
                child: ConexionFormWidget(
                  titleTxt: 'Email',
                  validationStr: 'email ne doit pas être vide',
                  onWriting: (p0) {
                    email = p0;
                  },
                ),
              ),
              SizedBox(
                height: 24.w,
              ),
              Padding(
                padding: EdgeInsets.only(left: 39.w),
                child: ConexionFormWidget(
                  titleTxt: 'Mot De Passe',
                  validationStr: 'mots de passe ne doit pas être vide',
                  isPassword: true,
                  onWriting: (p0) {
                    password = p0;
                  },
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              MDPOublierWidget(
                onMdpOublier: () => Navigator.pushNamed(
                    context, '/forget_password_first_screen'),
              ),
              SizedBox(
                height: 40.h,
              ),
              Center(
                child: MyTitleButton(
                  borderRadius: 10,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      hideKeyborad();
                      showLoader(context);
                      result = await login.login(email, password, message);
                      Loader.hide();

                      result?['message'] == 'login success'
                          ? Navigator.push(
                              context,
                              PageTransition(
                                  child: const HomeScreen(),
                                  type: PageTransitionType.fade,
                                  duration: const Duration(seconds: 1)))
                          : Fluttertoast.showToast(msg: result?['message']);
                    }
                  },
                  title: 'Se Connecter',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
