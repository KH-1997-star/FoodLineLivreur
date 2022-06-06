import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_line_livreur/widgets/conexion_form_widget.dart';
import 'package:food_line_livreur/widgets/my_title_button_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 51.h, left: 35.w),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'S\'inscrire ',
                  style: TextStyle(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 52.h,
                ),
                ConexionFormWidget(
                  titleTxt: 'Nom',
                  onWriting: (p0) {},
                  validationStr: 'nom ne peux pas etre vide',
                ),
                SizedBox(
                  height: 23.h,
                ),
                ConexionFormWidget(
                  titleTxt: 'Email',
                  onWriting: (p0) {},
                  validationStr: 'email ne peux pas etre vide',
                ),
                SizedBox(
                  height: 23.h,
                ),
                ConexionFormWidget(
                  titleTxt: 'Numéro De Téléphone',
                  onWriting: (p0) {},
                  isNumber: true,
                  validationStr: 'tel ne peux pas etre vide',
                ),
                SizedBox(
                  height: 23.h,
                ),
                ConexionFormWidget(
                  titleTxt: 'Addresse',
                  onWriting: (p0) {},
                  validationStr: 'adresse ne peux pas etre vide',
                ),
                SizedBox(
                  height: 23.h,
                ),
                ConexionFormWidget(
                  titleTxt: 'Mot De Passe',
                  onWriting: (p0) {},
                  isPassword: true,
                  validationStr: 'mdp ne peux pas etre vide',
                ),
                SizedBox(
                  height: 23.h,
                ),
                ConexionFormWidget(
                  titleTxt: 'Confirmer Mot De Passe',
                  onWriting: (p0) {},
                  isPassword: true,
                  validationStr: 'cmdp ne peux pas etre vide',
                ),
                SizedBox(
                  height: 23.h,
                ),
                MyTitleButton(
                  title: 'S\'inscrire',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      ('form is valprintidate');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
