import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:fluttergym/app/pages/home/models/alimento_model.dart';

class AlimentosRepository extends Disposable {
  //dispose will be called automatically by closing its streams

  Future<List<Alimentos>> getAlimentos() async{
   final response = await http.get('https://dod-ps.herokuapp.com/alimentos');
   if(response.statusCode == 200){
     final alimentos = alimentosFromJson(response.body);
     return alimentos;
   }
   throw Exception('Error: ${response.statusCode}');
  }

  @override
  void dispose() {}
}
