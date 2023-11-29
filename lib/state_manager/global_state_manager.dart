import 'package:flutter/material.dart';
import '../models/panier_model.dart'; 




class GlobalStateManager extends ChangeNotifier{


   List<ProduitPanierModel> produits = [];
   int nbreProduitPanier = 0;

  void setNbreProduitPanier(int nbreProduit) {
    nbreProduitPanier = nbreProduit;
    notifyListeners();
  }

  get getNbreProduitPanier {
    return nbreProduitPanier;
  }

  get getProduitsPanier {
    return produits;
  }


  void setProduitsPanier(List<ProduitPanierModel> produit) {
    produits = produit;
    notifyListeners();
  }

}