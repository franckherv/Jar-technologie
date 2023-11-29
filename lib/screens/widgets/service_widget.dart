// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../models/service.dart';
import '../service/service_detail.dart';

class ServiceWidget extends StatelessWidget {
   Services services;
   ServiceWidget({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.category),
        title: Text(services.name!.fr.toString()),
        trailing: const Icon(Icons.arrow_right),
        onTap: () {
          //? Here I pass the expected uiid argument as a parameter to the serviceDetail function
          Navigator.of(context).pushNamed('/detail-service', arguments: ServiceDetail(pack: services,));
        },
        ),
    );
  }
}