
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jartech_app/models/pack_model.dart';
import 'package:jartech_app/models/panier_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_colors.dart';
import '../../state_manager/global_state_manager.dart';
import '../../utils/rounded_raised_button.dart';



class ManageNumberAndPriceWidget extends StatefulWidget {

  Packs produit;
  bool isOnShoppingCart;

  ManageNumberAndPriceWidget({required this.produit, required this.isOnShoppingCart});

  @override
  _ManageNumberAndPriceWidgetState createState() => _ManageNumberAndPriceWidgetState();
}

class _ManageNumberAndPriceWidgetState extends State<ManageNumberAndPriceWidget> {



  PanierModel panierModel = PanierModel();
  ProduitPanierModel? produiPanier;
  final Packs produits = Packs(uuid: "", name: "", price: 0);

  List<ProduitPanierModel> savedProduits = [];

  num prixTotalArticle = 0;
  num nbreTotalArticle = 0;

  num nbreProduitPanier = 0;

  // int produitTotalPanier = 0;

  Future getProduitLocalPanier() async {
    await panierModel.initState();
    setState(() {
      savedProduits = panierModel.produits;
      int nbreProduit = savedProduits.fold(0, (sum, item) => sum + (item.qte));
      context.read<GlobalStateManager>().setNbreProduitPanier(nbreProduit);
      // context.read<GlobalStateManager>().setNbreProduitPanier(savedProduits.length);
      context.read<GlobalStateManager>().setProduitsPanier(savedProduits);
    });
  }
  final now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Initialisation des packs
      panierModel.initState();
    getProduitLocalPanier().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
      if (Provider.of<GlobalStateManager>(context).getProduitsPanier != null) {
      setState(() {
        nbreProduitPanier =
            Provider.of<GlobalStateManager>(context).getNbreProduitPanier;
        prixTotalArticle =
            savedProduits.fold(0, (sum, item) => sum + (item.produits.price ?? 0));
        nbreTotalArticle =
            savedProduits.fold(0, (sum, item) => sum + (item.qte));
      });
    }

    var produit = savedProduits.indexWhere((produitSave) => produitSave.produits.uuid == widget.produit.uuid && produitSave.produits.name == widget.produit.name && produitSave.produits.uuid == widget.produit.uuid,);
    if(produit < 0){
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.produit.name.toString(),
              style: const TextStyle(
                  fontSize: 13,
                  
                  color: Colors.black54
              ),),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "${produit >= 0 ? widget.produit.price * savedProduits[produit].qte : widget.produit.price} CFA",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13.0,
                
                color: Colors.redAccent,
              ),
            ),
          ),

          Padding(
            padding:  EdgeInsets.only(left: 20.0, right: 20.0, top: 3.h),
            child: SizedBox(
              width: double.infinity,
              height: 25.0.h,
              child: ElevateButton(
                label: "Ajouter",
                btnColor: AppColors.appThemeColor,
                onPressAction: () {

                  setState(() {
                    addProduit(widget.produit);
                  });

                  getProduitLocalPanier().then((value) {});

                },
              ),
            ),
          ),

        ],
      );
    }else{
      return widget.isOnShoppingCart ? Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.produit.name.toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54
              ),),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "${produit >= 0 ? widget.produit.price * savedProduits[produit].qte : widget.produit.price} CFA",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13.0,
                color: Colors.redAccent,
              ),
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Container(
              height: 30.0,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[


                  FloatingActionButton(
                    elevation: 0.0,
                    child:   Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 16.0,
                    ),
                    backgroundColor: AppColors.appThemeColor,
                    heroTag: null,
                    onPressed: (){

                      setState(() {

                        setState(() {

                          if(savedProduits[produit].qte == 1){
                              showAlertDialog(context, savedProduits[produit], );
                         
                          }{
                            try{
                              if(savedProduits[produit].qte > 1){
                                savedProduits[produit].qte--;
                                panierModel.updateProduit(savedProduits[produit]);
                                getProduitLocalPanier().then((value) {});
                              }
                            }catch (e){

                            }


                          }

                        });


                      });

                    },
                  ),

                  Text(
                    "${savedProduits[produit].qte}",
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.black54,
                    ),
                  ),

                  FloatingActionButton(
                    child:  const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18.0,
                    ),
                    backgroundColor: AppColors.appThemeColor,
                    elevation: 0.0,
                    heroTag: null,
                    onPressed: (){

                      setState(() {

                        savedProduits[produit].qte++;
                        panierModel.updateProduit(savedProduits[produit]);
                        getProduitLocalPanier().then((value) {});

                      });

                    },
                  ),
         
                ],
              ),
            ),
          ),

        ],
      ) : Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.produit.name.toString(),
              style: const TextStyle(
                  fontSize: 13,
                  
                  color: Colors.black54
              ),),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "${produit >= 0 ? widget.produit.price * savedProduits[produit].qte : widget.produit.price} CFA",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13.0,
                
                color: Colors.redAccent,
              ),
            ),
          ),

          Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                height: 30.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[


                    FloatingActionButton(
                      elevation: 0.0,
                      child:  const Icon(
Icons.remove,                        color: Colors.white,
                        size: 16.0,
                      ),
                      backgroundColor: AppColors.appThemeColor,
                      heroTag: null,
                      onPressed: (){

                        setState(() {

                          setState(() {

                            if(savedProduits[produit].qte == 1){
                              showAlertDialog(context, savedProduits[produit], );
                              //panierModel.removeProduit(savedProduits[index]);
                              //getReservation().then((value) {});
                            }{
                              try{
                                if(savedProduits[produit].qte > 1){
                                  savedProduits[produit].qte--;
                                  panierModel.updateProduit(savedProduits[produit]);
                                  getProduitLocalPanier().then((value) {});
                                }
                              }catch (e){

                              } 


                            }

                          });


                        });

                      },
                    ),

                    Text(
                      "${savedProduits[produit].qte}",
                      style: const TextStyle(
                        fontSize: 15.0,
                          color: Colors.black54,
                      ),
                    ),

                    FloatingActionButton(
                      child:   Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 18.0,
                      ),
                      backgroundColor: AppColors.appThemeColor,
                      elevation: 0.0,
                      heroTag: null,
                      onPressed: (){

                        setState(() {

                          savedProduits[produit].qte++;
                          panierModel.updateProduit(savedProduits[produit]);
                          getProduitLocalPanier().then((value) {});

                        });

                      },
                    ),

                  ],
                ),
              ),
            ),

        ],
      );
    }

  }



  addProduit(Packs produit) async {

    await SharedPreferences.getInstance();
    setState(() {
      int id = savedProduits.length + 1;

      produiPanier = ProduitPanierModel(
        id,
        produit,
        1,
      );

      panierModel.addProduit(produiPanier);

    });

  }


  showAlertDialog(BuildContext context, ProduitPanierModel produit) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Non"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Oui"),
    onPressed:  () {
       //  panierModel.removeProduit(savedProduits);
             panierModel.removeProduit(produit);
              getProduitLocalPanier().then((value) {});
              Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Attention!"),
    content: Text("Voulez-vous vraiment rétiré cet article du panier ?.",
),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


}

