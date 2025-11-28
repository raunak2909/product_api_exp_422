class ReviewModel {
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;
  num rating;

  ReviewModel({
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      comment: json['comment'],
      date: json['date'],
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
      rating: json['rating'],
    );
  }
}

class MetaModel {
  String barcode;
  String createdAt;
  String qrCode;
  String updatedAt;

  MetaModel({
    required this.barcode,
    required this.createdAt,
    required this.qrCode,
    required this.updatedAt,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      barcode: json['barcode'],
      createdAt: json['createdAt'],
      qrCode: json['qrCode'],
      updatedAt: json['updatedAt'],
    );
  }
}

class DimensionModel {
  num depth;
  num height;
  num width;

  DimensionModel({
    required this.depth,
    required this.height,
    required this.width,
  });

  factory DimensionModel.fromJson(Map<String, dynamic> json) {
    return DimensionModel(
      depth: json['depth'],
      height: json['height'],
      width: json['width'],
    );
  }
}

class ProductModel {
  String? availabilityStatus;
  String? brand;
  String category;
  String description;
  num discountPercentage;
  int id;
  int minimumOrderQuantity;
  num price;
  num rating;
  String returnPolicy;
  String shippingInformation;
  String sku;
  int stock;
  String thumbnail;
  String title;
  String warrantyInformation;
  num weight;
  DimensionModel dimensions;
  List<dynamic> images;
  MetaModel meta;
  List<ReviewModel>? reviews;
  List<dynamic> tags;

  ProductModel({
    required this.availabilityStatus,
    required this.brand,
    required this.category,
    required this.description,
    required this.discountPercentage,
    required this.id,
    required this.minimumOrderQuantity,
    required this.price,
    required this.rating,
    required this.returnPolicy,
    required this.shippingInformation,
    required this.sku,
    required this.stock,
    required this.thumbnail,
    required this.title,
    required this.warrantyInformation,
    required this.weight,
    required this.dimensions,
    required this.images,
    required this.meta,
    required this.reviews,
    required this.tags,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<ReviewModel> mReview = [];

    for (Map<String, dynamic> eachReview in json['reviews']) {
      mReview.add(ReviewModel.fromJson(eachReview));
    }

    return ProductModel(
      availabilityStatus: json['availabilityStatus'],
      brand: json['brand'],
      category: json['category'],
      description: json['description'],
      discountPercentage: json['discountPercentage'],
      id: json['id'],
      minimumOrderQuantity: json['minimumOrderQuantity'],
      price: json['price'],
      rating: json['rating'],
      returnPolicy: json['returnPolicy'],
      shippingInformation: json['shippingInformation'],
      sku: json['sku'],
      stock: json['stock'],
      thumbnail: json['thumbnail'],
      title: json['title'],
      warrantyInformation: json['warrantyInformation'],
      weight: json['weight'],
      dimensions: DimensionModel.fromJson(json['dimensions']),
      images: json['images'],
      meta: MetaModel.fromJson(json['meta']),
      reviews: mReview,
      tags: json['tags'],
    );
  }
}

class ProductDataModel {
  int limit;
  int skip;
  int total;
  List<ProductModel> products;

  ProductDataModel({
    required this.limit,
    required this.skip,
    required this.total,
    required this.products,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json){

    List<ProductModel> mProducts = [];

    for(Map<String, dynamic> eachProduct in json['products']){
      mProducts.add(ProductModel.fromJson(eachProduct));
    }

    return ProductDataModel(
        limit: json['limit'],
        skip: json['skip'],
        total: json['total'],
        products: mProducts
    );
  }
}
