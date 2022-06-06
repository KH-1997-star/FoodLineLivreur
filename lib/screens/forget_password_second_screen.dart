import 'package:food_line_livreur/services/forget_password.dart';
import 'package:food_line_livreur/utils/colors.dart';
import 'package:food_line_livreur/widgets/my_widget_button.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pin_put/pin_put.dart';

final signUpModelSignUp = ChangeNotifierProvider<ForgetPasswordViewModel>(
  (ref) => ForgetPasswordViewModel(),
);

class ForgetPwdTwoScreen extends ConsumerStatefulWidget {
  final String? email;
  const ForgetPwdTwoScreen({Key? key, this.email}) : super(key: key);

  @override
  _ForgetPwdTwoScreenState createState() => _ForgetPwdTwoScreenState();
}

class _ForgetPwdTwoScreenState extends ConsumerState<ForgetPwdTwoScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController adresseController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  String typee = "email";
  bool _showPassword = false;
  bool enablpwd = false;
  bool enablemail = false;
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNodepwd = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      color: mywhitegrey,
      border: Border.all(color: mywhitegrey),
      borderRadius: BorderRadius.circular(10.0.r),
    );
  }

  BoxDecoration get _selectedpinPutDecoration {
    return BoxDecoration(
      color: mywhitegrey,
      border: Border.all(color: mywhitegrey),
      borderRadius: BorderRadius.circular(10.0.r),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewModel = ref.read(signUpModelSignUp);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
            color: myblack,
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                Positioned(
                  top: 36.h,
                  left: 36.w,
                  child: MyWidgetButton(
                    widget: Container(
                      child: SvgPicture.asset(
                        'images/arrowback.svg',
                        height: 3.h,
                        width: 3.w,
                        fit: BoxFit.none,
                      ),
                    ),
                    color: mywhite,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                Positioned(
                  top: 75.h,
                  right: 131.w,
                  child: SvgPicture.asset(
                    'images/logo_food.svg',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    top: 276.h,
                    right: 36.w,
                    left: 36.w,
                    child: const Text(
                      "Entrez le code reçu dans votre boite mail",
                      style: TextStyle(
                          color: mywhite,
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )),
                Positioned(
                  top: 315.h,
                  right: 36.w,
                  left: 36.w,
                  child: PinPut(
                    eachFieldHeight: 58.h,
                    eachFieldWidth: 58.w,
                    fieldsCount: 4,
                    onSubmit: (String pin) => _showSnackBar(pin, context),
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),
                    selectedFieldDecoration: _selectedpinPutDecoration,
                    followingFieldDecoration: _pinPutDecoration.copyWith(
                      borderRadius: BorderRadius.circular(10.0.r),
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 400.h,
                  left: 36.w,
                  child: MyWidgetButton(
                      width: 303,
                      height: 50,
                      color: myGreen,
                      widget: Center(
                        child: Text('Continuer',
                            style: TextStyle(
                                color: mywhite,
                                fontFamily: "Robot",
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp)),
                      ),
                      onTap: () {
                        if (_pinPutController.text != null) {
                          viewModel.forgetPasswordTwo(
                              context, _pinPutController.text, widget.email);
                        } else {
                          Toast.show("Veuillez entrez votre code.", context,
                              backgroundColor: Colors.red,
                              duration: 2,
                              gravity: 3);
                        }

                        // viewModel.onChangeData(
                        //     email: emailController.text,
                        //     password: pwdController.text);
                        // viewModel.signInWithEmailAndPassword(context);
                      }),
                ),
                Positioned(
                    top: 475.h,
                    left: 79.w,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Vous n'avez pas reçu de code?",
                            style: TextStyle(
                                color: mywhite,
                                fontFamily: 'Roboto',
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          InkWell(
                              child: Container(
                                height: 20.h,
                                child: Text(
                                  "Cliquez ici",
                                  style: TextStyle(
                                      color: myGreen,
                                      fontFamily: 'Roboto',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onTap: () {
                                viewModel.resendCode(context, widget.email);
                              }),
                        ],
                      ),
                    ))
              ],
            )),
      ),
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
