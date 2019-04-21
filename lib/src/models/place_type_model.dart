class PlaceType {
  bool get isPrice => false;
  String get toRequest => "";
}

class Free extends PlaceType {
  @override
  bool get isPrice => true;

  String get toRequest => "0";
  @override
  String toString() {
    return "Бесплатно";
  }
}

class OneThousand extends PlaceType {
  @override
  bool get isPrice => true;
  
  String get toRequest => "1000";

  @override
  String toString() {
    return "До тысячи";
  }
}

class TwoThousand extends PlaceType {
  @override
  bool get isPrice => true;
  
  String get toRequest => "2000";

  @override
  String toString() {
    return "До двух тысяч";
  }
}

class Caffe extends PlaceType {
  String get toRequest => "Рестораны и кафе";
  @override
  String toString() {
    return "Рестораны и кафе";
  }
}

class Tours extends PlaceType {
  String get toRequest => "";

  @override
  String toString() {
    return "Экскурсии";
  }
}
class Pub extends PlaceType {
  String get toRequest => "Бары и пабы";

  @override
  String toString() {
    return "Пабы и бары";
  }
}
class CultureObject extends PlaceType {
  String get toRequest => "Культурные объекты";

  @override
  String toString() {
    return "Культурные объекты";
  }
}
class Church extends PlaceType {
  String get toRequest => "Соборы и храмы";

  @override
  String toString() {
    return "Соборы и храмы";
  }
}
class Museum extends PlaceType {

  String get toRequest => "Музеи";

  @override
  String toString() {
    return "Музеи";
  }
}
class Parks extends PlaceType {
  String get toRequest => "";

  @override
  String toString() {
    return "Сады и парки";
  }
}
class Unknown extends PlaceType {
  String get toRequest => "";

  @override
  String toString() {
    return "Все";
  }
}