import 'students.dart';
import 'package:flutter/material.dart';
import 'converter.dart';


class DetailPage extends StatelessWidget{

  final Student student;
  DetailPage(this.student);
  int opcion;
  final formkey = new GlobalKey<FormState>();
  String photoName;
  int currentUserId;
  var bdHelper;
  String imagen;

  String name;
  String surname;
  String ap;
  String mat;
  String mail;
  String num;
  String valor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        appBar: AppBar(
          title: Text(student.name.toString().toUpperCase()),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.5,
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 19,
              left: 10.0,
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.10,
              child: Container(
                child: SingleChildScrollView(
                  child: Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        //FOTOGRAFIA
                        CircleAvatar(
                          minRadius: 80.0,
                          maxRadius:  80.0,
                          backgroundColor: Colors.white,
                          backgroundImage: Convertir.imageFromBase64String(student.photoName).image,

                        ),
                        /* new RaisedButton( color: Colors.deepPurple[200],
                          onPressed: () {
                            _selectfoto(context);
                          },
                          child: Text("Update image", textAlign: TextAlign.center,),),*/
                        new Padding(padding: EdgeInsets.all(10.0),),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //NOMBRE
                            Text(
                              student.name.toString().toUpperCase(),
                              style: TextStyle(
                                fontSize: 25.0,
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                            //APELLIDO PATERNO
                            Text(
                              student.surname.toString().toUpperCase(),
                              style: TextStyle(
                                fontSize: 25.0,
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                            //APELLIDO MATERNO
                          ],
                        ),
                        //MATRICULA
                        new Padding(padding: EdgeInsets.all(10.0),),
                        Text("Matricula: ${student.matricula}",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.yellow
                          ),
                        ),
                        //EMAIL
                        new Padding(padding: EdgeInsets.all(15.0),),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Email: ${student.mail}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        new Padding(padding: EdgeInsets.all(10.0),),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Telefono: ${student.num}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}