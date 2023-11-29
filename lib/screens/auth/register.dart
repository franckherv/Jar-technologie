// ignore_for_file: invalid_use_of_visible_for_testing_member, unnecessary_null_comparison

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../datasources/DbLocal.dart';
import '../../datasources/http_global_datasource.dart';
import '../../utils/appbar.dart';
import '../../utils/loading/loading_spinner.dart';
import '../../utils/rounded_raised_button.dart';
import '../../utils/rounded_text_input_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameCtl = TextEditingController();
  final TextEditingController lastNameCtl = TextEditingController();
  final TextEditingController cityNameCtl = TextEditingController();
  final TextEditingController phoneNumberCtl = TextEditingController();
  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController codeSponsorCtl = TextEditingController();
  final TextEditingController pwdCtl = TextEditingController();

  //
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

// Keep user data in localStorage
  Box? box1;
  HttpGlobalDatasource httpGlobalDatasource = HttpGlobalDatasource();
  String loadingMessage = "Connexion en cours ...";

  String countryName = "";
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
        title: "Inscription",

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
                      leftAlign("Nom"),
                      RoundedTextInputField(
                        imputCtrl: firstNameCtl,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      leftAlign("Prenom"),
                      RoundedTextInputField(
                        imputCtrl: lastNameCtl,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        autofocus: false,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      leftAlign("Pays"),
                      Center(
                        child: ElevatedButton(
                          
                          onPressed: () {
                            showCountryPicker(
                              context: context,
                              //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                              exclude: <String>['KN', 'MF'],
                              favorite: <String>['SE'],
                              //Optional. Shows phone code before the country name.
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                print('Select country: ${country.displayName}');
                                setState(() {
                                  countryName = country.displayName;
                                });
                              },
                              // Optional. Sets the theme for the country list picker.
                              countryListTheme: CountryListThemeData(
                                // Optional. Sets the border radius for the bottomsheet.
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0),
                                ),
                                // Optional. Styles the search field.
                                inputDecoration: InputDecoration(
                                  labelText: 'Search',
                                  hintText: 'Start typing to search',
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: const Color(0xFF8C98A8)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                // Optional. Styles the text in the search field
                                searchTextStyle: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          },
                          child: countryName != null
                              ? Text(countryName)
                              : const Text("Choisir le pays"),
                        ),
                      ),
                      leftAlign("Ville"),
                      RoundedTextInputField(
                        imputCtrl: cityNameCtl,
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        autofocus: false,
                      ),
                      leftAlign("Phone"),
                      RoundedTextInputField(
                        imputCtrl: phoneNumberCtl,
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        autofocus: false,
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
                      leftAlign("Code sponsor(facultatif)"),
                      RoundedTextInputField(
                        imputCtrl: codeSponsorCtl,
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
                          label: "Inscription",
                          // labelColor: AppColors.whiteColor,
                          onPressAction: () {
                            signup();
                          },
                        ),
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

  signup() async {
    LoadingSpinner.showLoadingDialog(context, _keyLoader, loadingMessage);
    await httpGlobalDatasource
        .signupUser(
            password: pwdCtl.text,
            email: emailCtl.text,
            phone: phoneNumberCtl.text,
            firstname: firstNameCtl.text,
            lastname: lastNameCtl.text,
            country: countryName,
            city: cityNameCtl.text,
            code_sponsor:
            codeSponsorCtl.text.isNotEmpty ? codeSponsorCtl.text : "")
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
