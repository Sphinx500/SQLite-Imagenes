import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testimage2/crud_operations.dart';
import 'students.dart';
import 'crud_operations.dart';
import 'dart:io';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'converter.dart';

class insert extends StatefulWidget {
  @override
  _Insertar createState() => new _Insertar();
}

class _Insertar extends State<insert> {
  //Variables referentes al manejo de la bd
  Future<List<Student>> Studentss;
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController controller7 = TextEditingController();
  String name;
  String photoName;
  String surname;
  String ap;
  String mat;
  String mail;
  String num;
  String imagen;
  Future<File> imgFile;
  int currentUserId;
  var bdHelper;
  bool isUpdating;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final formkey = new GlobalKey<FormState>();
  List<Student> imagenes;

  @override
  void initState() {
    super.initState();
    bdHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  void refreshList() {
    setState(() {
      Studentss = bdHelper.getStudents();
    });
  }



  void cleanData() {
    controller1.text = "";
    controller2.text = "";
    controller3.text = "";
    controller4.text = "";
    controller5.text = "";
    controller6.text = "";
    controller7.text = "";
  }

  void dataValidate() async {
    if (formkey.currentState.validate()) {
            formkey.currentState.save();
            if (isUpdating) {
              Student stu = Student(
                  currentUserId, imagen , name, surname, ap, mat, mail, num);
              bdHelper.update(stu);
                setState(() {
                  isUpdating = false;
        });
      } else {
        Student stu =
        Student(null, imagen, name, surname, ap, mat, mail, num);
        //VALIDACION MATRICULA
        var validation = await bdHelper.validateInsert(stu);
        print(validation);
        if (validation) {
          bdHelper.insert(stu);
          final snackbar = SnackBar(
            content: new Text("DATOS INGRESADOS!"),
            backgroundColor: Colors.deepPurple,
          );
          _scaffoldkey.currentState.showSnackBar(snackbar);
        } else {
          final snackbar = SnackBar(
            content: new Text("LA MATRICULA YA FUE REGISTRADA!"),
            backgroundColor: Colors.deepPurple,
          );
          _scaffoldkey.currentState.showSnackBar(snackbar);
        }
      }
      cleanData();
      refreshList();
    }
  }

  pickImagefromGallery(BuildContext context){
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile){
      String  imgString = Convertir.base64String(imgFile.readAsBytesSync());
      imagen = imgString;
      Navigator.of(context).pop();
      controller7.text ="Campo lleno";
      return imagen;
    });
  }

  pickImagefromCamera(BuildContext context){
    ImagePicker.pickImage(source: ImageSource.camera).then((imgFile){
      String  imgString = Convertir.base64String(imgFile.readAsBytesSync());
      imagen = imgString;
      Navigator.of(context).pop();
      controller7.text ="Campo lleno";
      return imagen;
    });
  }
  Future<void> _agregafoto(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Selecciona una opcion", textAlign: TextAlign.center,),
              backgroundColor: Colors.purple,
              content: SingleChildScrollView(
                child: ListBody(children: <Widget>[
                  GestureDetector(
                    child: Text("Galeria"),
                    onTap: () {
                      pickImagefromGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10.0),),
                  GestureDetector(
                    child: Text("Camara",),
                    onTap: () {
                      pickImagefromCamera(context);
                    },
                  )
                ]),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: new AppBar(
        title: Text("Insertar Datos "),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                TextFormField(
                  controller: controller1,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: "Student ID"),
                  validator: (val) =>
                  val.length < 10 ? 'Enter student id' : null,
                  onSaved: (val) => mat = val,
                ),
                TextFormField(
                  controller: controller7,
                  decoration: InputDecoration(
                      labelText: "Photo",
                      suffixIcon: RaisedButton(
                        color: Colors.deepPurple[200],
                        onPressed: () {
                          _agregafoto(context);
                        },
                        child: Text("Select image", textAlign: TextAlign.center,),
                      )),
                  validator: (val) => val.length == 0
                      ? 'Debes subir una imagen'
                      : controller7.text == "Campo lleno"
                      ? null
                      : "Solo imagenes",
                ),
                TextFormField(
                  controller: controller2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Student Name"),
                  validator: (val) => val.length == 0 ? 'Enter name' : null,
                  onSaved: (val) => name = val,
                ),
                TextFormField(
                  controller: controller3,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Paternal Surname"),
                  validator: (val) =>
                  val.length == 0 ? 'Enter paternal surname' : null,
                  onSaved: (val) => surname = val,
                ),
                TextFormField(
                  controller: controller4,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Maternal Surname"),
                  validator: (val) =>
                  val.length == 0 ? 'Enter maternal surname' : null,
                  onSaved: (val) => ap = val,
                ),
                TextFormField(
                  controller: controller5,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Student Mail"),
                  validator: (val) => !val.contains('@') ? 'Enter mail' : null,
                  onSaved: (val) => mail = val,
                ),
                TextFormField(
                  controller: controller6,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: "Student phone"),
                  validator: (val) =>
                  val.length < 10 ? 'Enter phone number' : null,
                  onSaved: (val) => num = val,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.deepPurple)),
                      onPressed: dataValidate,
                      child: Text(isUpdating ? 'Update' : 'Add Data'),
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.deepPurple)),
                      onPressed: () {
                        setState(() {
                          isUpdating = false;
                        });
                        cleanData();
                      },
                      child: Text('Cancel'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.deepPurpleAccent[100],
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: Icon(Icons.camera),
            label: "Tomar Foto",
            labelBackgroundColor: Colors.black,
            backgroundColor: Colors.deepPurpleAccent,
            onTap: () {
              pickImagefromCamera(context);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.photo),
            label: "Subir Imagen",
            labelBackgroundColor: Colors.black,
            backgroundColor: Colors.deepPurple,
            onTap: () {
              pickImagefromGallery(context);
            },
          )
        ],
      ),
    );
  }
}
