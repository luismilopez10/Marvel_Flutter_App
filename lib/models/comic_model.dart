// To parse this JSON data, do
//
//     final comicsResponse = comicsResponseFromMap(jsonString);

import 'dart:convert';

ComicsResponse comicsResponseFromMap(String str) => ComicsResponse.fromMap(json.decode(str));

String comicsResponseToMap(ComicsResponse data) => json.encode(data.toMap());

class ComicsResponse {
    ComicsResponse({
        required this.code,
        required this.status,
        required this.copyright,
        required this.attributionText,
        required this.attributionHtml,
        required this.etag,
        required this.data,
    });

    int code;
    String status;
    String copyright;
    String attributionText;
    String attributionHtml;
    String etag;
    Data data;

    factory ComicsResponse.fromMap(Map<String, dynamic> json) => ComicsResponse(
        code: json["code"],
        status: json["status"],
        copyright: json["copyright"],
        attributionText: json["attributionText"],
        attributionHtml: json["attributionHTML"],
        etag: json["etag"],
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "status": status,
        "copyright": copyright,
        "attributionText": attributionText,
        "attributionHTML": attributionHtml,
        "etag": etag,
        "data": data.toMap(),
    };
}

class Data {
    Data({
        required this.offset,
        required this.limit,
        required this.total,
        required this.count,
        required this.results,
    });

    int offset;
    int limit;
    int total;
    int count;
    List<Comic> results;

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
        count: json["count"],
        results: List<Comic>.from(json["results"].map((x) => Comic.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "offset": offset,
        "limit": limit,
        "total": total,
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
    };
}

class Comic {
    Comic({
        this.firebase_id,
        this.user,
        required this.id,
        this.digitalId,
        required this.title,
        this.issueNumber,
        this.variantDescription,
        this.description,
        this.modified,
        this.isbn,
        this.upc,
        this.diamondCode,
        this.ean,
        this.issn,
        this.format,
        required this.pageCount,
        this.textObjects,
        this.resourceUri,
        required this.urls,
        this.series,
        this.variants,
        this.collections,
        this.collectedIssues,
        required this.dates,
        required this.prices,
        required this.thumbnail,
        required this.images,
        this.creators,
        this.characters,
        this.stories,
        this.events,
    });

    String? firebase_id;
    String? user;
    int id;
    int? digitalId;
    String title;
    int? issueNumber;
    String? variantDescription;
    String? description;
    String? modified;
    String? isbn;
    String? upc;
    DiamondCode? diamondCode;
    Ean? ean;
    String? issn;
    Format? format;
    int pageCount;
    List<TextObject>? textObjects;
    String? resourceUri;
    List<Url> urls;
    Series? series;
    List<Series>? variants;
    List<Series>? collections;
    List<Series>? collectedIssues;
    List<Date> dates;
    List<Price> prices;
    Thumbnail thumbnail;
    List<Thumbnail> images;
    Creators? creators;
    Characters? characters;
    Stories? stories;
    Characters? events;

    factory Comic.fromMap(Map<String, dynamic> json) => Comic(
        user: json["user"],
        id: json["id"],
        digitalId: json["digitalId"],
        title: json["title"],
        issueNumber: json["issueNumber"],
        variantDescription: json["variantDescription"],
        description: json["description"],
        modified: json["modified"],
        isbn: json["isbn"],
        upc: json["upc"],
        diamondCode: diamondCodeValues.map[json["diamondCode"]],
        ean: eanValues.map[json["ean"]],
        issn: json["issn"],
        format: formatValues.map[json["format"]],
        pageCount: json["pageCount"],
        textObjects: json["textObjects"] == null ? [] : List<TextObject>.from(json["textObjects"]!.map((x) => TextObject.fromMap(x))),
        resourceUri: json["resourceURI"],
        urls: List<Url>.from(json["urls"].map((x) => Url.fromMap(x))),
        series: json["series"] == null ? null : Series.fromMap(json["series"]),
        variants: json["variants"] == null ? [] : List<Series>.from(json["variants"]!.map((x) => Series.fromMap(x))),
        collections: json["collections"] == null ? [] : List<Series>.from(json["collections"]!.map((x) => Series.fromMap(x))),
        collectedIssues: json["collectedIssues"] == null ? [] : List<Series>.from(json["collectedIssues"]!.map((x) => Series.fromMap(x))),
        dates: List<Date>.from(json["dates"].map((x) => Date.fromMap(x))),
        prices: List<Price>.from(json["prices"].map((x) => Price.fromMap(x))),
        thumbnail: Thumbnail.fromMap(json["thumbnail"]),
        images: List<Thumbnail>.from(json["images"].map((x) => Thumbnail.fromMap(x))),
        creators: json["creators"] == null ? null : Creators.fromMap(json["creators"]),
        characters: json["characters"] == null ? null : Characters.fromMap(json["characters"]),
        stories: json["stories"] == null ? null : Stories.fromMap(json["stories"]),
        events: json["events"] == null ? null : Characters.fromMap(json["events"]),
    );

    Map<String, dynamic> toMap() => {
        "user": user,
        "id": id,
        "digitalId": digitalId,
        "title": title,
        "issueNumber": issueNumber,
        "variantDescription": variantDescription,
        "description": description,
        "modified": modified,
        "isbn": isbn,
        "upc": upc,
        "diamondCode": diamondCodeValues.reverse[diamondCode],
        "ean": eanValues.reverse[ean],
        "issn": issn,
        "format": formatValues.reverse[format],
        "pageCount": pageCount,
        "textObjects": textObjects == null ? [] : List<dynamic>.from(textObjects!.map((x) => x.toMap())),
        "resourceURI": resourceUri,
        "urls": List<dynamic>.from(urls.map((x) => x.toMap())),
        "series": series?.toMap(),
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x.toMap())),
        "collections": collections == null ? [] : List<dynamic>.from(collections!.map((x) => x.toMap())),
        "collectedIssues": collectedIssues == null ? [] : List<dynamic>.from(collectedIssues!.map((x) => x.toMap())),
        "dates": List<dynamic>.from(dates.map((x) => x.toMap())),
        "prices": List<dynamic>.from(prices.map((x) => x.toMap())),
        "thumbnail": thumbnail.toMap(),
        "images": List<dynamic>.from(images.map((x) => x.toMap())),
        "creators": creators?.toMap(),
        "characters": characters?.toMap(),
        "stories": stories?.toMap(),
        "events": events?.toMap(),
    };
}

class Characters {
    Characters({
        required this.available,
        required this.collectionUri,
        required this.items,
        required this.returned,
    });

    int available;
    String collectionUri;
    List<Series> items;
    int returned;

    factory Characters.fromMap(Map<String, dynamic> json) => Characters(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: json["items"] == null ? [] : List<Series>.from(json["items"]!.map((x) => Series.fromMap(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toMap() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "returned": returned,
    };
}

class Series {
    Series({
        required this.resourceUri,
        required this.name,
    });

    String resourceUri;
    String name;

    factory Series.fromMap(Map<String, dynamic> json) => Series(
        resourceUri: json["resourceURI"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "resourceURI": resourceUri,
        "name": name,
    };
}

class Creators {
    Creators({
        required this.available,
        required this.collectionUri,
        required this.items,
        required this.returned,
    });

    int available;
    String collectionUri;
    List<CreatorsItem> items;
    int returned;

    factory Creators.fromMap(Map<String, dynamic> json) => Creators(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: json["items"] == null ? [] : List<CreatorsItem>.from(json["items"]!.map((x) => CreatorsItem.fromMap(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toMap() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "returned": returned,
    };
}

class CreatorsItem {
    CreatorsItem({
        required this.resourceUri,
        required this.name,
        required this.role,
    });

    String resourceUri;
    String name;
    Role role;

    factory CreatorsItem.fromMap(Map<String, dynamic> json) => CreatorsItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
        role: roleValues.map[json["role"]]!,
    );

    Map<String, dynamic> toMap() => {
        "resourceURI": resourceUri,
        "name": name,
        "role": roleValues.reverse[role],
    };
}

enum Role { EDITOR, PENCILLER_COVER, WRITER, OTHER, COLORIST, INKER, LETTERER, PENCILLER, PENCILER, ARTIST }

final roleValues = EnumValues({
    "artist": Role.ARTIST,
    "colorist": Role.COLORIST,
    "editor": Role.EDITOR,
    "inker": Role.INKER,
    "letterer": Role.LETTERER,
    "other": Role.OTHER,
    "penciler": Role.PENCILER,
    "penciller": Role.PENCILLER,
    "penciller (cover)": Role.PENCILLER_COVER,
    "writer": Role.WRITER
});

class Date {
    Date({
        required this.type,
        required this.date,
    });

    DateType type;
    String date;

    factory Date.fromMap(Map<String, dynamic> json) => Date(
        type: dateTypeValues.map[json["type"]]!,
        date: json["date"],
    );

    Map<String, dynamic> toMap() => {
        "type": dateTypeValues.reverse[type],
        "date": date,
    };
}

enum DateType { ONSALE_DATE, FOC_DATE, UNLIMITED_DATE, DIGITAL_PURCHASE_DATE }

final dateTypeValues = EnumValues({
    "digitalPurchaseDate": DateType.DIGITAL_PURCHASE_DATE,
    "focDate": DateType.FOC_DATE,
    "onsaleDate": DateType.ONSALE_DATE,
    "unlimitedDate": DateType.UNLIMITED_DATE
});

enum DiamondCode { EMPTY, JUL190068, SEP090507, DEC090577, AUG082435, OCT090594 }

final diamondCodeValues = EnumValues({
    "AUG082435": DiamondCode.AUG082435,
    "DEC090577": DiamondCode.DEC090577,
    "": DiamondCode.EMPTY,
    "JUL190068": DiamondCode.JUL190068,
    "OCT090594": DiamondCode.OCT090594,
    "SEP090507": DiamondCode.SEP090507
});

enum Ean { EMPTY, THE_978078513621752499, THE_978078512508252499, THE_978078512178753999, THE_978078513704752499 }

final eanValues = EnumValues({
    "": Ean.EMPTY,
    "9780785 121787 53999": Ean.THE_978078512178753999,
    "9780785 125082 52499": Ean.THE_978078512508252499,
    "9780785 136217 52499": Ean.THE_978078513621752499,
    "9780785 137047 52499": Ean.THE_978078513704752499
});

enum Format { EMPTY, COMIC, HARDCOVER, DIGITAL_COMIC, TRADE_PAPERBACK, DIGEST }

final formatValues = EnumValues({
    "Comic": Format.COMIC,
    "Digest": Format.DIGEST,
    "Digital Comic": Format.DIGITAL_COMIC,
    "": Format.EMPTY,
    "Hardcover": Format.HARDCOVER,
    "Trade Paperback": Format.TRADE_PAPERBACK
});

class Thumbnail {
    Thumbnail({
        required this.path,
        required this.extension,
    });

    String path;
    Extension extension;

    factory Thumbnail.fromMap(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extension: extensionValues.map[json["extension"]]!,
    );

    Map<String, dynamic> toMap() => {
        "path": path,
        "extension": extensionValues.reverse[extension],
    };
}

enum Extension { JPG }

final extensionValues = EnumValues({
    "jpg": Extension.JPG
});

class Price {
    Price({
        required this.type,
        required this.price,
    });

    PriceType type;
    double price;

    factory Price.fromMap(Map<String, dynamic> json) => Price(
        type: priceTypeValues.map[json["type"]]!,
        price: json["price"]?.toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "type": priceTypeValues.reverse[type],
        "price": price,
    };
}

enum PriceType { PRINT_PRICE, DIGITAL_PURCHASE_PRICE }

final priceTypeValues = EnumValues({
    "digitalPurchasePrice": PriceType.DIGITAL_PURCHASE_PRICE,
    "printPrice": PriceType.PRINT_PRICE
});

class Stories {
    Stories({
        required this.available,
        required this.collectionUri,
        required this.items,
        required this.returned,
    });

    int available;
    String collectionUri;
    List<StoriesItem> items;
    int returned;

    factory Stories.fromMap(Map<String, dynamic> json) => Stories(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<StoriesItem>.from(json["items"].map((x) => StoriesItem.fromMap(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toMap() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "returned": returned,
    };
}

class StoriesItem {
    StoriesItem({
        required this.resourceUri,
        required this.name,
        required this.type,
    });

    String resourceUri;
    String name;
    ItemType type;

    factory StoriesItem.fromMap(Map<String, dynamic> json) => StoriesItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
        type: itemTypeValues.map[json["type"]]!,
    );

    Map<String, dynamic> toMap() => {
        "resourceURI": resourceUri,
        "name": name,
        "type": itemTypeValues.reverse[type],
    };
}

enum ItemType { COVER, INTERIOR_STORY, EMPTY, RECAP, LETTERS, PROMO }

final itemTypeValues = EnumValues({
    "cover": ItemType.COVER,
    "": ItemType.EMPTY,
    "interiorStory": ItemType.INTERIOR_STORY,
    "letters": ItemType.LETTERS,
    "promo": ItemType.PROMO,
    "recap": ItemType.RECAP
});

class TextObject {
    TextObject({
        required this.type,
        required this.language,
        required this.text,
    });

    TextObjectType type;
    Language language;
    String text;

    factory TextObject.fromMap(Map<String, dynamic> json) => TextObject(
        type: textObjectTypeValues.map[json["type"]]!,
        language: languageValues.map[json["language"]]!,
        text: json["text"],
    );

    Map<String, dynamic> toMap() => {
        "type": textObjectTypeValues.reverse[type],
        "language": languageValues.reverse[language],
        "text": text,
    };
}

enum Language { EN_US }

final languageValues = EnumValues({
    "en-us": Language.EN_US
});

enum TextObjectType { ISSUE_SOLICIT_TEXT, ISSUE_PREVIEW_TEXT }

final textObjectTypeValues = EnumValues({
    "issue_preview_text": TextObjectType.ISSUE_PREVIEW_TEXT,
    "issue_solicit_text": TextObjectType.ISSUE_SOLICIT_TEXT
});

class Url {
    Url({
        required this.type,
        required this.url,
    });

    UrlType type;
    String url;

    factory Url.fromMap(Map<String, dynamic> json) => Url(
        type: urlTypeValues.map[json["type"]]!,
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "type": urlTypeValues.reverse[type],
        "url": url,
    };
}

enum UrlType { DETAIL, PURCHASE, READER, IN_APP_LINK }

final urlTypeValues = EnumValues({
    "detail": UrlType.DETAIL,
    "inAppLink": UrlType.IN_APP_LINK,
    "purchase": UrlType.PURCHASE,
    "reader": UrlType.READER
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
