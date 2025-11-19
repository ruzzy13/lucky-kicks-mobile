// To parse this JSON data, do
//
//     final produchEntry = produchEntryFromJson(jsonString);

import 'dart:convert';

List<ProduchEntry> produchEntryFromJson(String str) => List<ProduchEntry>.from(json.decode(str).map((x) => ProduchEntry.fromJson(x)));

String produchEntryToJson(List<ProduchEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProduchEntry {
    String id;
    String title;
    String content;
    Category category;
    String thumbnail;
    int views;
    int price;
    int stock;
    bool isFeatured;
    int userId;

    ProduchEntry({
        required this.id,
        required this.title,
        required this.content,
        required this.category,
        required this.thumbnail,
        required this.views,
        required this.price,
        required this.stock,
        required this.isFeatured,
        required this.userId,
    });

    factory ProduchEntry.fromJson(Map<String, dynamic> json) => ProduchEntry(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        category: categoryValues.map[json["category"]]!,
        thumbnail: json["thumbnail"],
        views: json["views"],
        price: json["price"],
        stock: json["stock"],
        isFeatured: json["is_featured"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "category": categoryValues.reverse[category],
        "thumbnail": thumbnail,
        "views": views,
        "price": price,
        "stock": stock,
        "is_featured": isFeatured,
        "user_id": userId,
    };
}

enum Category {
    ACCESSORIES,
    APPAREL,
    SHOES
}

final categoryValues = EnumValues({
    "accessories": Category.ACCESSORIES,
    "apparel": Category.APPAREL,
    "shoes": Category.SHOES
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
