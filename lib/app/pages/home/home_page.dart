import 'package:flutter/material.dart';
import 'package:fluttergym/app/pages/home/home_bloc.dart';
import 'package:fluttergym/app/pages/home/models/alimento_model.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();
  bool search = false;
  int callSend  = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Gym"),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("Digite quantas calorias: ",style: TextStyle(fontSize: 24),),
            Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: TextField(
                      controller: _textEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3))
                        ),
                        hintText: "129cal"
                      ),
              ),
            ),
            MaterialButton(
              child: Text("Combinar",style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                _textEditingController.value.text.isEmpty ? setState(() {
                  search = false;
                }) : setState(() {
                  search = true;
                  callSend = int.parse(_textEditingController.value.text);
                });
              },
              minWidth: MediaQuery.of(context).size.width - 16,
            ),
            search == false ? StreamBuilder<List<Alimentos>>(
              stream: HomeBloc().getAlim(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index){
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.3),width: 1)
                        ),
                        child: Column(
                          children: <Widget>[
                            Text("${snapshot.data[index].nome}"),
                            Text("Calorias: ${snapshot.data[index].calorias} Grupo: [${snapshot.data[index].grupo.nome}]")
                          ],
                        ),
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              }
            ) : StreamBuilder<List<Map<String,Alimentos>>>(
              stream: HomeBloc().getCombos(callSend),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, int index){
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.3),width: 1)
                        ),
                        child: Column(
                          children: <Widget>[
                            Text("${snapshot.data[index]["A"].nome} + ${snapshot.data[index]["B"].nome} + ${snapshot.data[index]["C"].nome}"),
                            Text("Total de ${snapshot.data[index]["A"].calorias + snapshot.data[index]["B"].calorias + snapshot.data[index]["C"].calorias} calorias"),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              }
            )
          ],
        ),
      )
    );
  }
}
