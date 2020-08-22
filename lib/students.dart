class Student{
  int controlum;
  String photoName;
  String name;
  String surname;
  String mail;
  String num;
  String am;
  String matricula;
  Student(this.controlum, this.photoName, this.name, this.surname, this.am,this.matricula, this.mail, this.num);
  Map<String,dynamic>toMap(){
    var map = <String,dynamic>{
      'controlum':controlum,
      'photoName': photoName,
      'name':name,
      'surname':surname,
      'am':am,
      'matricula':matricula,
      'mail':mail,
      'num':num


    };
    return map;
  }
  Student.fromMap(Map<String,dynamic> map){
    controlum=map['controlum'];
    photoName = map['photoName'];
    name=map['name'];
    surname=map['surname'];
    am=map['am'];
    matricula=map['matricula'];
    mail=map['mail'];
    num=map['num'];


  }
}