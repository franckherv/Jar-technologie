// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jartech_app/models/panier_model.dart';
import 'package:jartech_app/state_manager/global_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../datasources/http_global_datasource.dart';
import '../../utils/appbar.dart';
import '../../utils/rounded_raised_button.dart';
import '../../utils/rounded_text_input_field.dart';
import 'package:badges/badges.dart' as badges;


class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  // Controller
  final TextEditingController deliveryPlaceCtl = TextEditingController();

  HttpGlobalDatasource httpGlobalDatasource = HttpGlobalDatasource();
  String loadingMessage = "Ajout de lieu en cours ...";

   PanierModel panierModel = PanierModel();

  List<ProduitPanierModel> savedProduits = [];

  SharedPreferences? prefs;
    num nbreProduitPanier = 0;


  initPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

 
  Future getProduitLocalPanier() async {
    await panierModel.initState();
    setState(() {
      savedProduits = panierModel.produits;
      num nbreProduit = savedProduits.fold(0, (sum, item) => sum + (item.qte));
      context.read<GlobalStateManager>().setNbreProduitPanier(nbreProduit.toInt());
      //context.read<GlobalStateManager>().setNbreProduitPanier(savedProduits.length);
      context.read<GlobalStateManager>().setProduitsPanier(savedProduits);

    });
  }


  @override
  void initState() {
      initPreferences();

    getProduitLocalPanier().then((value) {});

    panierModel.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
       if (Provider.of<GlobalStateManager>(context).getProduitsPanier != null) {
      setState(() {
        nbreProduitPanier = Provider.of<GlobalStateManager>(context).getNbreProduitPanier;
      });
    }

    return Scaffold(
      appBar: appBarmenu(
        context: context,
        title: "Ajout de lieu de livraison",
        action: [
            if (nbreProduitPanier > 0)
            Padding(
              padding: EdgeInsets.all(12.h),
              child: InkWell(
                onTap: () {
                    Navigator.of(context).pushNamed(
                      '/ecran-panier',
                    );
                  
                },
                child: badges.Badge(
                  badgeContent: Text(
                    "$nbreProduitPanier",
                    style: const TextStyle(color: Colors.white),
                  ),
                  child: const Icon(Icons.shopping_cart),
                ),
              ),
            ),
        ]
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    SizedBox(
                      height: 8.h,
                    ),
                    leftAlign("Indiquer le lieu de livraison"),
                    RoundedTextInputField(
                      imputCtrl: deliveryPlaceCtl,
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
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
                        label: "Valider",
                        onPressAction: () {
                          const snack = SnackBar(
                            content: Text('Commande crée avec succes'),
                            backgroundColor: Colors.green,
                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(5),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                          prefs?.remove("produits");

                          context
                              .read<GlobalStateManager>()
                              .setNbreProduitPanier(0);
                          Navigator.of(context).pushNamed("/home-screen");
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
    );
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
