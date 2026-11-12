import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Product {
  final int productId;
  final String name;
  final int categoryId;
  final String createdAt;

  Product({
    required this.productId,
    required this.name,
    required this.categoryId,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

// --- Create Product Model ---
@JsonSerializable(fieldRename: FieldRename.snake)
class CreateProduct {
  final String name;
  final int categoryId;

  CreateProduct({required this.categoryId, required this.name});

  factory CreateProduct.fromJson(Map<String, dynamic> json) =>
      _$CreateProductFromJson(json);

  Map<String, dynamic> toJson() => _$CreateProductToJson(this);
}

// --- Bulk Product Request Model ---
@JsonSerializable(fieldRename: FieldRename.snake)
class BulkProductRequest {
  final List<CreateProduct> products;

  BulkProductRequest({required this.products});

  factory BulkProductRequest.fromJson(Map<String, dynamic> json) =>
      _$BulkProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BulkProductRequestToJson(this);
}

// --- Response Status Model ---
@JsonSerializable(fieldRename: FieldRename.snake)
class ResponseStatus {
  final int status;
  final bool state;
  final String msg;

  ResponseStatus({
    required this.status,
    required this.state,
    required this.msg,
  });

  factory ResponseStatus.fromJson(Map<String, dynamic> json) =>
      _$ResponseStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseStatusToJson(this);
}

// --- Response Product List Status Model ---
@JsonSerializable(fieldRename: FieldRename.snake)
class ResponseProductListStatus {
  final int status;
  final bool state;
  final String msg;
  final ProductListResponse productList;

  ResponseProductListStatus({
    required this.status,
    required this.state,
    required this.msg,
    required this.productList,
  });

  factory ResponseProductListStatus.fromJson(Map<String, dynamic> json) =>
      _$ResponseProductListStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseProductListStatusToJson(this);
}

// --- Product List Response Model ---
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductListResponse {
  final List<Product> data;
  final Pagination pagination;

  ProductListResponse({required this.data, required this.pagination});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProductListResponseToJson(this);
}

// --- Patch Product Model ---
@JsonSerializable(fieldRename: FieldRename.snake)
class PatchProduct {
  final String? name;
  final int? price;
  final int? stock;

  PatchProduct({this.name, this.price, this.stock});

  factory PatchProduct.fromJson(Map<String, dynamic> json) =>
      _$PatchProductFromJson(json);

  Map<String, dynamic> toJson() => _$PatchProductToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductQuery {
  final int? page;
  final int? limit;
  final String? name;
  final String? sort;
  final String? order;
  final int? minPrice;
  final int? maxPrice;

  ProductQuery({
    required this.page,
    required this.limit,
    required this.name,
    required this.sort,
    required this.order,
    required this.minPrice,
    required this.maxPrice,
  });

  factory ProductQuery.fromJson(Map<String, dynamic> json) =>
      _$ProductQueryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductQueryToJson(this);
}

// --- Placeholder for Pagination Model ---
// Make sure to match your actual pagination structure in Flutter
@JsonSerializable(fieldRename: FieldRename.snake)
class Pagination {
  final int page;
  final int totalPages;
  final int totalItems;
  final int limit;

  Pagination({
    required this.page,
    required this.totalPages,
    required this.totalItems,
    required this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Category {
  final int categoryId;
  final String name;

  Category(this.categoryId, this.name);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ResponseCategory {
  final int status;
  final bool state;
  final String msg;
  final List<Category> data;

  ResponseCategory(this.status, this.state, this.msg, this.data);

  factory ResponseCategory.fromJson(Map<String, dynamic> json) =>
      _$ResponseCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCategoryToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class InventoryData {
  final int? id;
  final int shopId;
  final int productId;
  final int price;
  final int quantity;
  final DateTime? updatedAt;

  InventoryData(
    this.id,
    this.shopId,
    this.productId,
    this.price,
    this.quantity,
    this.updatedAt,
  );

  factory InventoryData.fromJson(Map<String, dynamic> json) =>
      _$InventoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class InventoryViewData {
  final int? id;
  final int shopId;
  final int productId;
  final String productName;
  final int price;
  final int quantity;
  final String? imagePath;
  final String? imageUrl;
  final DateTime? updatedAt;

  InventoryViewData(
    this.id,
    this.shopId,
    this.productId,
    this.price,
    this.quantity,
    this.updatedAt,
    this.imagePath,
    this.imageUrl,
    this.productName,
  );

  factory InventoryViewData.fromJson(Map<String, dynamic> json) =>
      _$InventoryViewDataFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryViewDataToJson(this);
}

@JsonSerializable()
class OrderItem {
  int id;
  int count;
  int price;
  String? orderName;
  String? orderNote;
  OrderItem({
    required this.id,
    required this.count,
    required this.price,
    required this.orderName,
    required this.orderNote,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
