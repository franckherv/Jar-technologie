
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jartech_app/models/pack_model.dart';
import 'package:jartech_app/screens/widgets/manage_product.dart';

//import 'manage_number_and_price_widget.dart';

class DisplayPacksItemWidget extends StatefulWidget {
  Packs produit;
  bool isOnShoppingCart;

   DisplayPacksItemWidget(
      {required this.produit, required this.isOnShoppingCart});

  @override
  _DisplayPacksItemWidgetState createState() =>
      _DisplayPacksItemWidgetState();
}

class _DisplayPacksItemWidgetState extends State<DisplayPacksItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: SizedBox(
          height: 170.h,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Row(
              children: [
              Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Colors.black12)
                      ),
                      height: 100,
                      width: 100,
                      //  color: AppColors.appThemeColor,
                      child: Icon(Icons.coffee, size: 70.h, color: Colors.grey,),
                    ),
                  ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 5.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              widget.produit.name.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ManageNumberAndPriceWidget(
                              produit: widget.produit,
                              isOnShoppingCart: widget.isOnShoppingCart,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
      },
    );
  }
}