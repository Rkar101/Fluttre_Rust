import 'package:json_annotation/json_annotation.dart';

part 'dashboard_model.g.dart';

@JsonSerializable()
class ResponseAdminStatus {
  final int status;
  final bool state;
  final String msg;
  final AdminDashboardStats? data;

  ResponseAdminStatus({
    required this.status,
    required this.state,
    required this.msg,
    this.data,
  });

  factory ResponseAdminStatus.fromJson(Map<String, dynamic> json) =>
      _$ResponseAdminStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseAdminStatusToJson(this);
}

@JsonSerializable()
class AdminDashboardStats {
  @JsonKey(name: 'total_employee')
  final int? totalEmployee;

  @JsonKey(name: 'total_shops')
  final int? totalShops;

  @JsonKey(name: 'total_products')
  final int? totalProducts;

  @JsonKey(name: 'total_stock_quantity')
  final int? totalStockQuantity;

  @JsonKey(name: 'total_sales_count')
  final int? totalSalesCount;

  @JsonKey(name: 'total_revenue')
  final int? totalRevenue; // Change to double? if your Rust backend returns a decimal/float

  AdminDashboardStats({
    this.totalEmployee,
    this.totalShops,
    this.totalProducts,
    this.totalStockQuantity,
    this.totalSalesCount,
    this.totalRevenue,
  });

  factory AdminDashboardStats.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardStatsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminDashboardStatsToJson(this);
}
