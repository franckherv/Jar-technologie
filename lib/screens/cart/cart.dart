import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jartech_app/screens/widgets/display_detail_pack_widget.dart';
import 'package:jartech_app/state_manager/global_state_manager.dart';
import 'package:jartech_app/utils/appbar.dart';

import 'package:provider/provider.dart';

import '../../datasources/DbLocal.dart';
import '../../models/panier_model.dart';
import '../../utils/rounded_raised_button.dart';



class CartScreen extends StatefulWidget {

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  //List<ProduitModel> _produitProduit = [];

  PanierModel panierModel = PanierModel();
  ProduitPanierModel? produiPanier;

  List<ProduitPanierModel> savedProduits = [];

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

  num prixTotalArticle = 0;
  num nbreTotalArticle = 0;

  @override
  void initState() {

    //_produitProduit = api.getProduitsList(fake:true);

    getProduitLocalPanier().then((value) {});

    panierModel.initState();
   // openBox();
    super.initState();
  }


  Box? box1;

 

  void openBox() async {
    box1 = await Hive.openBox('logindata');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    if (Provider.of<GlobalStateManager>(context).getProduitsPanier != null) {
      setState(() {
        savedProduits = Provider.of<GlobalStateManager>(context).getProduitsPanier;
        prixTotalArticle = savedProduits.fold(0, (sum, item) => sum + (item.produits.price * item.qte));
        nbreTotalArticle = savedProduits.fold(0, (sum, item) => sum + (item.qte));
      });
    }


    return Scaffold(
      appBar: appBarmenu(context: context, title: "Mon panier"),
      
      body: Stack(
        children: [

          Align(
            alignment: Alignment.topCenter,
            child: ListView.separated(
              //physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[200],
                thickness: 2.0,
              ),
              itemCount: savedProduits.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {

                return DisplayPacksItemWidget(
                  produit: savedProduits[index].produits,
                  isOnShoppingCart: true,
                );
              },
            ),
          ),

          if(prixTotalArticle > 0 && nbreTotalArticle > 0)
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:   [

                     const  Padding(
                        padding: EdgeInsets.only(top: 60.0),
                        child: Text(
                          "TOTAL",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              //foreground: Paint()..shader = AppColors.linearGradient,
                              ),
                          //overflow: TextOverflow.visible,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Text(
                          "$prixTotalArticle FCFA",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.redAccent,
                              ),
                          //overflow: TextOverflow.visible,
                        ),
                      ),

                    ],
                  ),
                ),

                if(prixTotalArticle > 0 && nbreTotalArticle > 0)
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 30.0, left: 20.0, right: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: ElevateButton(
                        label: "Valider",
                        btnColor: Colors.black,
                        onPressAction: () {
                        
                          if(box1?.get(DBLocale.isLogged, defaultValue: false) != null){

                            Navigator.of(context).pushNamed(
                              '/livraison',
                            );

                          }else{

                            Navigator.of(context).pushNamed(
                              '/login-screen',
                              
                            );

                          }
                        }),
                  ),
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}