// @dart=2.9
class Reservation {


DateTime Hin;
DateTime Hout;


  Reservation({ this.Hin, this.Hout });


 factory Reservation.fromMap(map) {
    return Reservation(
      Hin: map['Hin'],
      Hout: map['Hout'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'Hin': Hin,
      'Hout': Hout,
    };
  }
}
