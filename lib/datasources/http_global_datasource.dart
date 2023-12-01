import 'package:dio/dio.dart';
import '../constants/common_variable.dart';
import '../models/pack_model.dart';
import '../models/service.dart';

class HttpGlobalDatasource {
  Dio dio = Dio(
    BaseOptions(baseUrl: NetworkVariable.apiBaseUrl, headers: {
       'Accept': 'application/json',
       'Content-Type': 'application/json',
    }),
  );

  //? Login user >> Connexion de l'utilisateur
  Future connexion({
   required String email,
   required  String password,
   String? ip,
   String? user_agent
  }) async {
    try {
      Response response = await dio.post("auth/login", data: {
        "email": email,
        "password": password,
        "ip": ip,
        "user_agent": user_agent
      });
      print("Connexion >>>>>>>> $response ");
      return response.data;
    } catch (error, stacktrace) {
      print("ERROR connexion >>>>>>>>> $stacktrace");
    }
  }


  //? signup user ——this function will be call in signup user screen
  Future signupUser(
      {
      required var phone,
      required String email,
      required String firstname,
      required String lastname,
      required String password,
      required String country,
      required String city,
      String? code_sponsor,
     }) async {
    try {

      FormData formData = FormData.fromMap( {
        "phone": phone,
        "email": email,
        "first_name": firstname,
        "last_name": lastname,
        "city": city,
        "password": password,
        "country": country,
        "code_sponsor": code_sponsor,
   
      });

      Response response = await dio.post('auth/register', data: formData,
    
      );
      return response.data;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  } 


   //? fetch all service 
  Future<List<Services>> serviceList() async {
    try {
      Response response = await dio.post("service/list");
         return (response.data['result'] as List)
          .map((x) => Services.fromJson(x))
          .toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }  
  
  //? retrieve service details by passing uuid parameter
  Future<List<Packs>> serviceDetail({required String? uiid}) async {
    try {
      Response response = await dio.post("service/detail/$uiid",);
      print("service Detail >>>>>>>> $response ");
         return (response.data['result']['packages'] as List).map((x) => Packs.fromJson(x)).toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
 }
