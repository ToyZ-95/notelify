// To parse this JSON data, do
//
//     final unsplashWallpaperModel = unsplashWallpaperModelFromJson(jsonString);

import 'dart:convert';

UnsplashWallpaperModel unsplashWallpaperModelFromJson(String str) =>
    UnsplashWallpaperModel.fromJson(json.decode(str));

String unsplashWallpaperModelToJson(UnsplashWallpaperModel data) =>
    json.encode(data.toJson());

class UnsplashWallpaperModel {
  UnsplashWallpaperModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.categories,
    this.likes,
    this.exif,
    this.location,
    this.views,
    this.downloads,
  });

  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? promotedAt;
  int? width;
  int? height;
  String? color;
  String? description;
  String? altDescription;
  Urls? urls;
  UnsplashWallpaperModelLinks? links;
  List<dynamic>? categories;
  int? likes;

  Exif? exif;
  Location? location;
  int? views;
  int? downloads;

  factory UnsplashWallpaperModel.fromJson(Map<String, dynamic> json) =>
      UnsplashWallpaperModel(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        promotedAt: json["promoted_at"] == null
            ? null
            : DateTime.parse(json["promoted_at"]),
        width: json["width"],
        height: json["height"],
        color: json["color"],
        description: json["description"],
        altDescription: json["alt_description"],
        urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
        links: json["links"] == null
            ? null
            : UnsplashWallpaperModelLinks.fromJson(json["links"]),
        categories: json["categories"] == null
            ? null
            : List<dynamic>.from(json["categories"].map((x) => x)),
        likes: json["likes"],
        exif: json["exif"] == null ? null : Exif.fromJson(json["exif"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        views: json["views"],
        downloads: json["downloads"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "promoted_at":
            promotedAt == null ? null : promotedAt!.toIso8601String(),
        "width": width,
        "height": height,
        "color": color,
        "description": description,
        "alt_description": altDescription,
        "urls": urls == null ? null : urls!.toJson(),
        "links": links == null ? null : links!.toJson(),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x)),
        "likes": likes,
        "exif": exif == null ? null : exif!.toJson(),
        "location": location == null ? null : location!.toJson(),
        "views": views,
        "downloads": downloads,
      };
}

class Exif {
  Exif({
    this.make,
    this.model,
    this.name,
    this.exposureTime,
    this.aperture,
    this.focalLength,
    this.iso,
  });

  String? make;
  String? model;
  String? name;
  String? exposureTime;
  String? aperture;
  String? focalLength;
  int? iso;

  factory Exif.fromJson(Map<String, dynamic> json) => Exif(
        make: json["make"],
        model: json["model"],
        name: json["name"],
        exposureTime: json["exposure_time"],
        aperture: json["aperture"],
        focalLength: json["focal_length"],
        iso: json["iso"],
      );

  Map<String, dynamic> toJson() => {
        "make": make,
        "model": model,
        "name": name,
        "exposure_time": exposureTime,
        "aperture": aperture,
        "focal_length": focalLength,
        "iso": iso,
      };
}

class UnsplashWallpaperModelLinks {
  UnsplashWallpaperModelLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  String? self;
  String? html;
  String? download;
  String? downloadLocation;

  factory UnsplashWallpaperModelLinks.fromJson(Map<String, dynamic> json) =>
      UnsplashWallpaperModelLinks(
        self: json["self"],
        html: json["html"],
        download: json["download"],
        downloadLocation: json["download_location"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "download": download,
        "download_location": downloadLocation,
      };
}

class Location {
  Location({
    this.title,
    this.name,
    this.city,
    this.country,
    this.position,
  });

  String? title;
  String? name;
  String? city;
  String? country;
  Coordinates? position;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        title: json["title"],
        name: json["name"],
        city: json["city"],
        country: json["country"],
        position: json["position"] == null
            ? null
            : Coordinates.fromJson(json["position"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "name": name,
        "city": city,
        "country": country,
        "position": position == null ? null : position!.toJson(),
      };
}

class Coordinates {
  Coordinates({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Urls {
  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smallS3,
  });

  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        raw: json["raw"],
        full: json["full"],
        regular: json["regular"],
        small: json["small"],
        thumb: json["thumb"],
        smallS3: json["small_s3"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "full": full,
        "regular": regular,
        "small": small,
        "thumb": thumb,
        "small_s3": smallS3,
      };
}
