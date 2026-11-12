import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/src/helpers/database_repo/database_impl.dart';
import 'package:rust_flutter/src/helpers/database_repo/database_repo.dart';
import 'package:rust_flutter/src/providers/admin_provider.dart';
import 'package:rust_flutter/features/admin/repository/admin_impl.dart';
import 'package:rust_flutter/features/admin/repository/admin_repo.dart';
import 'package:rust_flutter/src/providers/order_provider.dart';
import 'package:rust_flutter/src/providers/owner_provider.dart';
import 'package:rust_flutter/src/providers/product_provider.dart';
import 'package:rust_flutter/features/shopdata/repositories/shopdata_impl.dart';
import 'package:trusted_time/trusted_time.dart';
import 'core/database/app_db.dart';
import 'core/system/date_time.dart';
import 'features/admin/data/admin_data.dart';
import 'features/products/repositories/product_impl.dart';
import 'features/products/repositories/product_repo.dart';
import 'src/providers/shop_provider.dart';
import 'features/shopdata/repositories/shopdata_repo.dart';
import 'routes/page_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppDatabase appDatabase = AppDatabase.instance;
  AppDatabaseRepository dbRepo = AppDatabaseImpl(appDatabase);
  ProductRepository productRepository = ProductRepoImpl();
  ShopdataRepo shopdataRepo = ShopdataImpl();
  AdminRepo adminRepo = AdminRepositoryImpl();
  await TrustedTime.initialize(
    config: const TrustedTimeConfig(
      refreshInterval: Duration(hours: 1),
      persistState: true,
    ),
  );
  final trustedTimeService = TrustedTimeService();
  trustedTimeService.startMonitoring(
    onIntegrityLost: (reason) {
      logger.i('Integrity lost: $reason');
    },
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AdminProvider(repository: adminRepo),
        ),
        ChangeNotifierProvider(
          create: (_) => OwnerProvider(repository: adminRepo),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(repository: productRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ShopProvider(shopdataRepo: shopdataRepo),
        ),

        ChangeNotifierProvider(create: (_) => OrderProvider(dbRepo)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      // Provide Chucker's navigatorObserver or let router handle it
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.indigoAccent,
          foregroundColor: Colors.white,
        ),
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      routerConfig:
          router, // ONLY use routerConfig when using MaterialApp.router
    );
  }
}
