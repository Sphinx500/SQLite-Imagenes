import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testimage2/tarjetas.dart';
import 'search.dart';
import 'update.dart';
import 'students.dart';
import 'crud_operations.dart';
import 'dart:async';
import 'formulario.dart';
import 'converter.dart';

class lista extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<lista> {

  //ELEMENTOS PARA BUSCAR
  String searchString = "";
  bool _isSearching = false;

  Future<List<Student>> Studentss;
  var bdHelper;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bdHelper = DBHelper();
    _isSearching = false;
    refreshList();
  }

  void refreshList() {
    setState(() {
      Studentss = bdHelper.Busqueda(searchController.text);
    });
  }

  void cleanData() {
    searchController.text = "";
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
        title: _isSearching ? TextField(
          decoration: InputDecoration(
              hintText: "Buscando..."),
          onChanged: (value) {
            setState(() {
              searchString = value;
            });
          },
          controller: searchController,
        )
            :Text("Consultar registros",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        actions: <Widget>[
          !_isSearching ? IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                searchString = "";
                this._isSearching = !this._isSearching;
              });
            },
          )
              :IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                this._isSearching = !this._isSearching;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: FutureBuilder(
            future: Studentss,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Cargando información..."),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return snapshot.data[index].matricula.contains(searchController.text)
                        ? ListTile(
                      leading: CircleAvatar(
                        minRadius: 30.0,
                        maxRadius:  30.0,
                        backgroundColor: Colors.white,
                        backgroundImage: Convertir.imageFromBase64String(snapshot.data[index].photoName).image,),
                      title: new Text(
                        snapshot.data[index].name.toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: new Text(
                        snapshot.data[index].matricula.toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context)=> DetailPage(snapshot.data[index])));
                      },
                    )
                        : Container();
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}