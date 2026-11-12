import 'package:json_annotation/json_annotation.dart';

import '../../products/model/product_model.dart';

part 'shopdata_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ShopdataModel {
  final String? shopName;
  final String? contact;
  final String? address;
  final String? contactLink;
  final bool? active;

  ShopdataModel(
    this.shopName,
    this.contact,
    this.address,
    this.contactLink,
    this.active,
  );

  factory ShopdataModel.fromJson(Map<String, dynamic> json) =>
      _$ShopdataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopdataModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ResponseShopListStatus {
  final int? status;
  final bool? state;
  final String? msg;
  final List<ResponseShopData>? shopList;

  ResponseShopListStatus({
    required this.status,
    required this.state,
    required this.msg,
    required this.shopList,
  });

  factory ResponseShopListStatus.fromJson(Map<String, dynamic> json) =>
      _$ResponseShopListStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseShopListStatusToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ResponseShopData {
  final int? shopId;
  final String? shopName;
  final String? contact;
  final String? address;
  final String? contactLink;
  final bool? active;

  ResponseShopData(
    this.shopId,
    this.shopName,
    this.contact,
    this.address,
    this.contactLink,
    this.active,
  );

  factory ResponseShopData.fromJson(Map<String, dynamic> json) =>
      _$ResponseShopDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseShopDataToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ResponseShopProducts {
  final int status;
  final bool state;
  final String msg;
  final ProductListResponse productList;

  ResponseShopProducts(this.status, this.state, this.msg, this.productList);

  factory ResponseShopProducts.fromJson(Map<String, dynamic> json) =>
      _$ResponseShopProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseShopProductsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductListResponse {
  final List<Product> data;
  final Pagination pagination;

  ProductListResponse(this.data, this.pagination);

  factory ProductListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Pagination {
  final int page;
  final int limit;
  final int totalItems;
  final int totalPages;

  Pagination(this.page, this.limit, this.totalItems, this.totalPages);

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ResponseShopInventory {
  final int status;
  final bool state;
  final String msg;
  final List<InventoryViewData>? dataList;

  ResponseShopInventory(this.status, this.state, this.msg, this.dataList);

  factory ResponseShopInventory.fromJson(Map<String, dynamic> json) =>
      _$ResponseShopInventoryFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseShopInventoryToJson(this);
}
