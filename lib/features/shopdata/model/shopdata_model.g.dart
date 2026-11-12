// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopdata_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopdataModel _$ShopdataModelFromJson(Map<String, dynamic> json) =>
    ShopdataModel(
      json['shop_name'] as String?,
      json['contact'] as String?,
      json['address'] as String?,
      json['contact_link'] as String?,
      json['active'] as bool?,
    );

Map<String, dynamic> _$ShopdataModelToJson(ShopdataModel instance) =>
    <String, dynamic>{
      'shop_name': instance.shopName,
      'contact': instance.contact,
      'address': instance.address,
      'contact_link': instance.contactLink,
      'active': instance.active,
    };

ResponseShopListStatus _$ResponseShopListStatusFromJson(
  Map<String, dynamic> json,
) => ResponseShopListStatus(
  status: (json['status'] as num?)?.toInt(),
  state: json['state'] as bool?,
  msg: json['msg'] as String?,
  shopList:
      (json['shop_list'] as List<dynamic>?)
          ?.map((e) => ResponseShopData.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ResponseShopListStatusToJson(
  ResponseShopListStatus instance,
) => <String, dynamic>{
  'status': instance.status,
  'state': instance.state,
  'msg': instance.msg,
  'shop_list': instance.shopList,
};

ResponseShopData _$ResponseShopDataFromJson(Map<String, dynamic> json) =>
    ResponseShopData(
      (json['shop_id'] as num?)?.toInt(),
      json['shop_name'] as String?,
      json['contact'] as String?,
      json['address'] as String?,
      json['contact_link'] as String?,
      json['active'] as bool?,
    );

Map<String, dynamic> _$ResponseShopDataToJson(ResponseShopData instance) =>
    <String, dynamic>{
      'shop_id': instance.shopId,
      'shop_name': instance.shopName,
      'contact': instance.contact,
      'address': instance.address,
      'contact_link': instance.contactLink,
      'active': instance.active,
    };

ResponseShopProducts _$ResponseShopProductsFromJson(
  Map<String, dynamic> json,
) => ResponseShopProducts(
  (json['status'] as num).toInt(),
  json['state'] as bool,
  json['msg'] as String,
  ProductListResponse.fromJson(json['product_list'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ResponseShopProductsToJson(
  ResponseShopProducts instance,
) => <String, dynamic>{
  'status': instance.status,
  'state': instance.state,
  'msg': instance.msg,
  'product_list': instance.productList,
};

ProductListResponse _$ProductListResponseFromJson(Map<String, dynamic> json) =>
    ProductListResponse(
      (json['data'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductListResponseToJson(
  ProductListResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'pagination': instance.pagination,
};

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  (json['page'] as num).toInt(),
  (json['limit'] as num).toInt(),
  (json['total_items'] as num).toInt(),
  (json['total_pages'] as num).toInt(),
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
    };

ResponseShopInventory _$ResponseShopInventoryFromJson(
  Map<String, dynamic> json,
) => ResponseShopInventory(
  (json['status'] as num).toInt(),
  json['state'] as bool,
  json['msg'] as String,
  (json['data_list'] as List<dynamic>?)
      ?.map((e) => InventoryViewData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ResponseShopInventoryToJson(
  ResponseShopInventory instance,
) => <String, dynamic>{
  'status': instance.status,
  'state': instance.state,
  'msg': instance.msg,
  'data_list': instance.dataList,
};
