import 'package:flutter/material.dart';

import '../../datasources/http_global_datasource.dart';
import '../../models/service.dart';
import '../../utils/loading/loading_spinner.dart';
import '../widgets/service_widget.dart';

class Service extends StatefulWidget {
  const Service({super.key});

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
   HttpGlobalDatasource httpGlobalDatasource = HttpGlobalDatasource();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
    String loadingMessage = "Patientez svp";
    //? create list variable to stock service liste
    List<Services> _service = [];



    @override
  void initState() {
    // TODO: implement initState
    // call all services fonction
     Future.delayed(const Duration(milliseconds: 0), () {
      getAllservice();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des services", style: TextStyle(color: Colors.white),),
        centerTitle: true,
          automaticallyImplyLeading: false,

        ),
      body: ListView.builder(
        itemCount: _service.length,
        itemBuilder: (cxt, i){
           return ServiceWidget(services: _service[i],);
        },
        )
    );
  }

    getAllservice() async {
    LoadingSpinner.showLoadingDialog(context, _keyLoader, loadingMessage);
    await httpGlobalDatasource.serviceList().then((data) {
      Navigator.of(context).pop();
      setState(() {
        _service = data;
      });
      print(">>>>>>>>>>> ${_service.length}");
    }).catchError((err) {
      Navigator.of(context).pop();
      print("**err**$err********");
    });
  }
}