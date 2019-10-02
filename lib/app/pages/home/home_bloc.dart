import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttergym/app/pages/home/models/alimento_model.dart';
import 'package:fluttergym/app/pages/home/services/alimentos_repository.dart';
import 'package:trotter/trotter.dart';

class HomeBloc extends BlocBase {
  //dispose will be called automatically by closing its streams
  final _respositorio = AlimentosRepository();
  final List<String> combosAlim = List<String>();
 
  
  Stream<List<Alimentos>> getAlim() async*{
    try{
      List<Alimentos>  alim = await _respositorio.getAlimentos();
      yield alim;
    }catch(e){
      throw Exception("error ${e.toString()}");
    }
  }

  Stream<List<Map<String,Alimentos>>> getCombos(int call) async*{
    List<Map<String,Alimentos>> listCombo = List<Map<String,Alimentos>>();
    List<Alimentos>  alim = await _respositorio.getAlimentos();
    try{
      var combos = Combinations(3, alim);
      for (var combo in combos()) { // combos is iterable
        List<Alimentos> cb = combo.cast<Alimentos>();
        int calc = cb[0].calorias + cb[1].calorias + cb[2].calorias;
        if(calc <= call){
          Map<String,Alimentos> map = Map<String,Alimentos>();
          map["A"] = cb[0];
          map["B"] = cb[1];
          map["C"] = cb[2];
          listCombo.add(map); 
        }
         
      }
      yield listCombo;
    }catch(e){
      throw Exception("error ${e.toString()}");
    }

  }
  
  @override
  void dispose() {
    super.dispose();
  }


}
