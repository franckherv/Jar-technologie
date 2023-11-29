// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import '../../datasources/DbLocal.dart';
import '../../datasources/http_global_datasource.dart';
import '../../utils/appbar.dart';
import '../../utils/loading/loading_spinner.dart';
import '../../utils/rounded_raised_button.dart';
import '../../utils/rounded_text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller
  final TextEditingController pwdCtl = TextEditingController();
  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController ipCtl = TextEditingController();
  final TextEditingController userAgentCtl = TextEditingController();

  //
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

// Keep user data in localStorage
  Box? box1;

  bool hidePassword = true;

  HttpGlobalDatasource httpGlobalDatasource = HttpGlobalDatasource();

  String loadingMessage = "Connexion en cours ...";

  @override
  void initState() {
    // TODO: implement initState
    createBox();
    super.initState();
  }

// initialisation du box sur cette page
  void createBox() async {
    box1 = await Hive.openBox('logindata');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarmenu(
        context: context,
        title: "Connexion",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      leftAlign("Email"),
                      RoundedTextInputField(
                        imputCtrl: emailCtl,
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        autofocus: false,
                      ),
                      leftAlign("Mot de passe"),
                      RoundedTextInputField(
                        imputCtrl: pwdCtl,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        autofocus: false,
                      ),
                      leftAlign("Code Ip(facultatif)"),
                      RoundedTextInputField(
                        imputCtrl: ipCtl,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        autofocus: false,
                      ),
                      leftAlign("User Agent (facultatif)"),
                      RoundedTextInputField(
                        imputCtrl: userAgentCtl,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(10),
                            bottom: ScreenUtil().setHeight(20)),
                        child: ElevateButton(
                          label: "Connexion",
                          onPressAction: () {
                            if (pwdCtl.text.isNotEmpty &&
                                emailCtl.text.isNotEmpty) {
                              login();
                            }
                          },
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          const TextSpan(
                            text: 'Pas de compte? ',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          TextSpan(
                              text: 'Créer un compte ',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/sing-up-screen',
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    LoadingSpinner.showLoadingDialog(context, _keyLoader, loadingMessage);
    await httpGlobalDatasource
        .connexion(
      password: pwdCtl.text,
      email: emailCtl.text,
      ip: ipCtl.text.isNotEmpty ? ipCtl.text : "",
      user_agent: userAgentCtl.text.isNotEmpty ? userAgentCtl.text : "",
    )
        .then((response) {
      debugPrint(">>>>> RESPONSE ${response["success"]}");
      if (response["success"] == true) {
        box1!.put(DBLocale.name, response["results"]['first_name']);
        box1!.put(DBLocale.email, response["results"]['email']);
        box1!.put(DBLocale.lastname, response["results"]['last_name']);

        box1!.put(DBLocale.isLogged, true);

        Navigator.of(context).pushNamed(
          '/livraison',
        );
      }
    }).catchError((err) {
      print("====Nos===ERREUR=${err}=========");

      Navigator.of(context).pop();
    });
  }
}

Padding leftAlign(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5, top: 5),
    child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(fontSize: 17),
        )),
  );
}
