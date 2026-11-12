// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseAdminStatus _$ResponseAdminStatusFromJson(Map<String, dynamic> json) =>
    ResponseAdminStatus(
      status: (json['status'] as num).toInt(),
      state: json['state'] as bool,
      msg: json['msg'] as String,
      data:
          json['data'] == null
              ? null
              : AdminDashboardStats.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$ResponseAdminStatusToJson(
  ResponseAdminStatus instance,
) => <String, dynamic>{
  'status': instance.status,
  'state': instance.state,
  'msg': instance.msg,
  'data': instance.data,
};

AdminDashboardStats _$AdminDashboardStatsFromJson(Map<String, dynamic> json) =>
    AdminDashboardStats(
      totalEmployee: (json['total_employee'] as num?)?.toInt(),
      totalShops: (json['total_shops'] as num?)?.toInt(),
      totalProducts: (json['total_products'] as num?)?.toInt(),
      totalStockQuantity: (json['total_stock_quantity'] as num?)?.toInt(),
      totalSalesCount: (json['total_sales_count'] as num?)?.toInt(),
      totalRevenue: (json['total_revenue'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AdminDashboardStatsToJson(
  AdminDashboardStats instance,
) => <String, dynamic>{
  'total_employee': instance.totalEmployee,
  'total_shops': instance.totalShops,
  'total_products': instance.totalProducts,
  'total_stock_quantity': instance.totalStockQuantity,
  'total_sales_count': instance.totalSalesCount,
  'total_revenue': instance.totalRevenue,
};
