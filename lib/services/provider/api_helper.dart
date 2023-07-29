import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pingolearn/services/provider/exception.dart';
class ApiHelper{
  Future<dynamic>getApi({required url})async{
    late var jsonResponse;
    try{
      var response = await http.get(Uri.parse(url));
      jsonResponse = checkREsponse(response);
    } on SocketException{
      throw FetchDataException("No internet");
    }
    return jsonResponse;

  }

  dynamic checkREsponse(http.Response response){
    if(response.statusCode==200){
      var data = jsonDecode(response.body.toString());
      return data;
    }else if(response.statusCode ==400){
      return BadRequestException(response.body.toString());
    }else{
      return FetchDataException("Error Occured while communicate the server with status code: ${response.statusCode}");
    }
  }
}