import 'dart:convert';
import 'package:jartech_app/models/pack_model.dart';
import 'package:jartech_app/models/preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class PanierModel {

  late List<ProduitPanierModel> produits;

  Future initState() async {
    await getDataProduit();
  }

//add pack
  addProduit(ProduitPanierModel? produit) {
    produits.add(produit!);
    _saveProduit();
  }
  
//update element in lists
  updateProduit(ProduitPanierModel produit) {
    produits.indexWhere((element) => element.id == produit.id);

    _saveProduit();
  }

 //remove pack
  removeProduit(ProduitPanierModel produit) {
    produits.removeWhere((element) => element.id == produit.id);
    _saveProduit();
  }

 //save pack
  _saveProduit() {
    var obj = json.encode(produits.map((e) => e.toJson()).toList());
    return SharedPrefs.instance!.setString('produits', obj);
  }


  Future<List<ProduitPanierModel>> getDataProduit() async {
    return produits = (json.decode(SharedPrefs.instance!.getString('produits', defaultValue: "[]").getValue()) as List).map((event) => ProduitPanierModel.fromJson(event)).toList();
  }
}

class ProduitPanierModel {

  int id;
  int qte;
  Packs produits;

  ProduitPanierModel( this.id,  this.produits,  this.qte);

  ProduitPanierModel.fromJson(Map json): 
         id = json['id'],
         qte = json['qte'],
        produits =  Packs.fromJson(json['produits']);
         

  Map toJson() {
    return {
      'id': id,
      'qte': qte,
      'produits': produits.toJson(),
    };
  }

  factory ProduitPanierModel.fromPrefs() {
    Preference<String> encodedUser =
    SharedPrefs.instance!.getString("produits", defaultValue: '');
    String val = encodedUser.getValue();
    return  ProduitPanierModel.fromJson(jsonDecode(val));
  }
}

