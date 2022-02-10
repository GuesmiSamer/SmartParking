// @dart=2.9
class UserModel {
  String uid;
  String email;
  String firstName;
  String secondName;
  String profileImage;
  String mat;
   

  UserModel({this.uid, this.email, this.firstName, this.secondName, this.profileImage,this.mat});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      profileImage: map['profileImage'],
      mat: map['mat'],
      
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'profileImage': profileImage,
      'mat': mat,
      
    };
  }
}

