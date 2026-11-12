// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  productId: (json['product_id'] as num).toInt(),
  name: json['name'] as String,
  categoryId: (json['category_id'] as num).toInt(),
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'product_id': instance.productId,
  'name': instance.name,
  'category_id': instance.categoryId,
  'created_at': instance.createdAt,
};

CreateProduct _$CreateProductFromJson(Map<String, dynamic> json) =>
    CreateProduct(
      categoryId: (json['category_id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$CreateProductToJson(CreateProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'category_id': instance.categoryId,
    };

BulkProductRequest _$BulkProductRequestFromJson(Map<String, dynamic> json) =>
    BulkProductRequest(
      products:
          (json['products'] as List<dynamic>)
              .map((e) => CreateProduct.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$BulkProductRequestToJson(BulkProductRequest instance) =>
    <String, dynamic>{'products': instance.products};

ResponseStatus _$ResponseStatusFromJson(Map<String, dynamic> json) =>
    ResponseStatus(
      status: (json['status'] as num).toInt(),
      state: json['state'] as bool,
      msg: json['msg'] as String,
    );

Map<String, dynamic> _$ResponseStatusToJson(ResponseStatus instance) =>
    <String, dynamic>{
      'status': instance.status,
      'state': instance.state,
      'msg': instance.msg,
    };

ResponseProductListStatus _$ResponseProductListStatusFromJson(
  Map<String, dynamic> json,
) => ResponseProductListStatus(
  status: (json['status'] as num).toInt(),
  state: json['state'] as bool,
  msg: json['msg'] as String,
  productList: ProductListResponse.fromJson(
    json['product_list'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ResponseProductListStatusToJson(
  ResponseProductListStatus instance,
) => <String, dynamic>{
  'status': instance.status,
  'state': instance.state,
  'msg': instance.msg,
  'product_list': instance.productList,
};

ProductListResponse _$ProductListResponseFromJson(Map<String, dynamic> json) =>
    ProductListResponse(
      data:
          (json['data'] as List<dynamic>)
              .map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList(),
      pagination: Pagination.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ProductListResponseToJson(
  ProductListResponse instance,
) => <String, dynamic>{
  'data': instance.data,
  'pagination': instance.pagination,
};

PatchProduct _$PatchProductFromJson(Map<String, dynamic> json) => PatchProduct(
  name: json['name'] as String?,
  price: (json['price'] as num?)?.toInt(),
  stock: (json['stock'] as num?)?.toInt(),
);

Map<String, dynamic> _$PatchProductToJson(PatchProduct instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'stock': instance.stock,
    };

ProductQuery _$ProductQueryFromJson(Map<String, dynamic> json) => ProductQuery(
  page: (json['page'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  name: json['name'] as String?,
  sort: json['sort'] as String?,
  order: json['order'] as String?,
  minPrice: (json['min_price'] as num?)?.toInt(),
  maxPrice: (json['max_price'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProductQueryToJson(ProductQuery instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
      'name': instance.name,
      'sort': instance.sort,
      'order': instance.order,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  page: (json['page'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
  totalItems: (json['total_items'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_pages': instance.totalPages,
      'total_items': instance.totalItems,
      'limit': instance.limit,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) =>
    Category((json['category_id'] as num).toInt(), json['name'] as String);

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'category_id': instance.categoryId,
  'name': instance.name,
};

ResponseCategory _$ResponseCategoryFromJson(Map<String, dynamic> json) =>
    ResponseCategory(
      (json['status'] as num).toInt(),
      json['state'] as bool,
      json['msg'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseCategoryToJson(ResponseCategory instance) =>
    <String, dynamic>{
      'status': instance.status,
      'state': instance.state,
      'msg': instance.msg,
      'data': instance.data,
    };

InventoryData _$InventoryDataFromJson(Map<String, dynamic> json) =>
    InventoryData(
      (json['id'] as num?)?.toInt(),
      (json['shop_id'] as num).toInt(),
      (json['product_id'] as num).toInt(),
      (json['price'] as num).toInt(),
      (json['quantity'] as num).toInt(),
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$InventoryDataToJson(InventoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop_id': instance.shopId,
      'product_id': instance.productId,
      'price': instance.price,
      'quantity': instance.quantity,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

InventoryViewData _$InventoryViewDataFromJson(Map<String, dynamic> json) =>
    InventoryViewData(
      (json['id'] as num?)?.toInt(),
      (json['shop_id'] as num).toInt(),
      (json['product_id'] as num).toInt(),
      (json['price'] as num).toInt(),
      (json['quantity'] as num).toInt(),
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      json['image_path'] as String?,
      json['image_url'] as String?,
      json['product_name'] as String,
    );

Map<String, dynamic> _$InventoryViewDataToJson(InventoryViewData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop_id': instance.shopId,
      'product_id': instance.productId,
      'product_name': instance.productName,
      'price': instance.price,
      'quantity': instance.quantity,
      'image_path': instance.imagePath,
      'image_url': instance.imageUrl,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
  id: (json['id'] as num).toInt(),
  count: (json['count'] as num).toInt(),
  price: (json['price'] as num).toInt(),
  orderName: json['orderName'] as String?,
  orderNote: json['orderNote'] as String?,
);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'id': instance.id,
  'count': instance.count,
  'price': instance.price,
  'orderName': instance.orderName,
  'orderNote': instance.orderNote,
};
