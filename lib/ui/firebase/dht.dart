class DHT {
  final double temp;
  final double humidity;
  final double heatIndex;

  DHT({this.temp = 0, this.humidity = 0, this.heatIndex = 0});

  factory DHT.fromJson(Map<dynamic, dynamic> json) {
    double parser(dynamic source) {
      try {
        return double.parse(source.toString());
      } on FormatException {
        return -1;
      }
    }

    return DHT(
        temp: parser(json['temp']),
        humidity: parser(json['hum']),
        heatIndex: parser(json['ht']));
  }
}