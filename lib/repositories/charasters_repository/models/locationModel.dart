class LocationModel {
  const LocationModel({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };

  LocationModel.empty()
      : name = '',
        url = '';

}
