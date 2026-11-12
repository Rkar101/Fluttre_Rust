import '../../../features/products/model/product_model.dart';

abstract class AppDatabaseRepository {
  Future<List<OrderItem>> getDataList();

  Future<void> deleteData();

  Future<void> deleteByKey(int id);

  Future<void> modifyData(OrderItem data);
}
