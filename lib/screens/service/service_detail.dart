// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jartech_app/models/pack_model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:jartech_app/screens/widgets/display_detail_pack_widget.dart';
import '../../datasources/http_global_datasource.dart';
import '../../models/service.dart';
import '../../utils/appbar.dart';
import '../../utils/loading/loading_spinner.dart';
import 'package:provider/provider.dart';

import '../../models/panier_model.dart';
import '../../state_manager/global_state_manager.dart';

class ServiceDetail extends StatefulWidget {
  Services pack;

  ServiceDetail({super.key, required this.pack});

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  HttpGlobalDatasource httpGlobalDatasource = HttpGlobalDatasource();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  String loadingMessage = "Patientez svp";
  //? create list variable to stock ServiceDetail liste
  List<Packs> _packs = [];

//
  PanierModel panierModel = PanierModel();
  ProduitPanierModel? produiPanier;
  final Packs produits = Packs(
      uuid: "",
      name: "",
      price: 0,
      currency: "",
      priceUnit: "",
      priceDuration: 0);

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

  @override
  void initState() {
    // TODO: implement initState
    // call all ServiceDetails fonction
    Future.delayed(const Duration(milliseconds: 0), () {
      getAllServiceDetail();
    });
    // Initialisation des packs
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
        appBar:
            appBarmenu(context: context, title: 'Liste des Packs', action: [
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
        ]),
        body: ListView.builder(
          itemCount: _packs.length,
          itemBuilder: (cxt, i) {
            return DisplayPacksItemWidget(
              produit: _packs[i],
              isOnShoppingCart: true,
            );
          },
        ));
  }

  getAllServiceDetail() async {
    LoadingSpinner.showLoadingDialog(context, _keyLoader, loadingMessage);
    await httpGlobalDatasource
        .serviceDetail(uiid: widget.pack.uuid)
        .then((data) {
      Navigator.of(context).pop();
      setState(() {
        _packs = data;
      });
      print(">>>>>>>>>>> ${_packs.length}");
    }).catchError((err) {
      Navigator.of(context).pop();
      print("**err**$err********");
    });
  }
}
