class SrcModel {
  String? landscape;
  String? large;
  String? large2x;
  String? medium;
  String? original;
  String? portrait;
  String? small;
  String? tiny;

  SrcModel({
    required this.landscape,
    required this.large,
    required this.large2x,
    required this.medium,
    required this.original,
    required this.portrait,
    required this.small,
    required this.tiny,
  });

  factory SrcModel.fromJson(Map<String, dynamic> json) {
    return SrcModel(
      landscape: json['landscape'],
      large: json['large'],
      large2x: json['large2x'],
      medium: json['medium'],
      original: json['original'],
      portrait: json['portrait'],
      small: json['small'],
      tiny: json['tiny'],
    );
  }
}

class WallpaperModel {
  String? alt;
  String? avg_color;
  num? height;
  int? id;
  bool? liked;
  String? photographer;
  int? photographer_id;
  String? photographer_url;
  String? url;
  num? width;
  SrcModel? src;

  WallpaperModel({
    required this.alt,
    required this.avg_color,
    required this.height,
    required this.id,
    required this.liked,
    required this.photographer,
    required this.photographer_id,
    required this.photographer_url,
    required this.url,
    required this.width,
    required this.src,
  });

  factory WallpaperModel.fromJson(Map<String, dynamic> json) =>
      WallpaperModel(
        alt: json['alt'],
        avg_color: json['avg_color'],
        height: json['height'],
        id: json['id'],
        liked: json['liked'],
        photographer: json['photographer'],
        photographer_id: json['photographer_id'],
        photographer_url: json['photographer_url'],
        url: json['url'],
        width: json['width'],
        src: SrcModel.fromJson(json['src']),
      );
}

class WallpaperDataModel {
  String? next_page;
  int? page;
  int? per_page;
  int? total_results;
  List<WallpaperModel>? photos;

  WallpaperDataModel({
    required this.next_page,
    required this.page,
    required this.per_page,
    required this.total_results,
    required this.photos,
  });

  factory WallpaperDataModel.fromJson(Map<String, dynamic> json){
    List<WallpaperModel> mWallpaper = [];

    for(Map<String, dynamic> eachWall in json['photos']){
      mWallpaper.add(WallpaperModel.fromJson(eachWall));
    }

    return WallpaperDataModel(
        next_page: json['next_page'],
        page: json['page'],
        per_page: json['per_page'],
        total_results: json['total_results'],
        photos: mWallpaper);
  }
}
