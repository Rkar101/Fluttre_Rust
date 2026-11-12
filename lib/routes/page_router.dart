import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rust_flutter/features/auth/presentation/posloading_page.dart';
import 'package:rust_flutter/src/view/shop_page/shop_detail.dart';
import 'package:rust_flutter/src/view/shop_page/inventory/shop_inventory.dart';
import '../core/database/secure_const.dart';
import '../core/database/secure_db.dart';
import '../features/auth/presentation/login.dart';
import '../features/products/data/product_data.dart';
import '../features/products/model/product_model.dart';
import '../features/shopdata/model/shopdata_model.dart';
import '../src/main_page/home_page.dart';
import '../src/view/emp_view/order_cart.dart';
import '../src/view/emp_view/product_order/product_order_detail.dart';
import '../src/view/emp_view/products_list.dart';
import '../src/view/product_page/product_detail.dart';
import '../src/view/shop_page/inventory/inventory_add_page.dart';

// true = logged in, false = logged out
final ValueNotifier<bool> globalAuthNotifier = ValueNotifier<bool>(false);

final GoRouter router = GoRouter(
  debugLogDiagnostics: false,
  // navigatorKey: ChuckerFlutter.navigatorKey, // Bind Chucker here
  refreshListenable: globalAuthNotifier,
  redirect: (context, state) async {
    globalAuthNotifier.value = await SecureStorage.secureBoolRead(
      SecureConst.loginFlag,
    );
    final isLoggedIn = globalAuthNotifier.value == true;
    final path = state.uri.path;
    final isAuthPage = path == PageRouter.authPage;

    // If the user is NOT logged in, force them to the login page
    if (!isLoggedIn) {
      return isAuthPage ? null : PageRouter.authPage;
    }

    // If the user IS logged in but sitting on the login page, push them home
    if (isLoggedIn && isAuthPage) {
      return PageRouter.posLoading;
    }

    // Otherwise, allow navigation to proceed normally (like /shopDetail)
    null;
    return null;
  },
  initialLocation: PageRouter.authPage,
  routes: [
    GoRoute(
      path: PageRouter.authPage,
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: PageRouter.posLoading,
      builder: (context, state) => const PosLoadingPage(),
    ),
    GoRoute(
      path: PageRouter.homePage,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: HomePage(), // Your home page
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: PageRouter.shopDetailPage,
      pageBuilder: (context, state) {
        final shopData = state.extra as ResponseShopData?;
        logger.i("Router received shopData: ${shopData?.shopName}");
        return CustomTransitionPage(
          key: state.pageKey,
          child: ShopDetail(shopData: shopData),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: PageRouter.shopInventory,
      pageBuilder: (context, state) {
        final shopData = state.extra as ResponseShopData;
        return CustomTransitionPage(
          key: state.pageKey,
          child: ShopInventory(shopData: shopData),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: PageRouter.shopInventory,
      pageBuilder: (context, state) {
        final shopData = state.extra as ResponseShopData;
        return CustomTransitionPage(
          key: state.pageKey,
          child: ShopInventory(shopData: shopData),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: PageRouter.addShopInventory,

      pageBuilder: (context, state) {
        final shopId = state.extra as int;

        return CustomTransitionPage(
          key: state.pageKey,
          child: InventoryStorePage(shopId: shopId),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
      },
    ),
    //EmployeeProductList
    GoRoute(
      path: PageRouter.productDetail,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: ProductDetail(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: PageRouter.empProducts,
      pageBuilder: (context, state) {
        final shopData = state.extra as ResponseShopData?;
        logger.i("Router received shopData: ${shopData?.shopName}");
        return CustomTransitionPage(
          key: state.pageKey,
          child: EmployeeProductList(shopData: shopData),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
      },
    ),

    GoRoute(
      path: PageRouter.empProductOrder,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final invProData = extra['productData'] as InventoryViewData;
        final heroTag = extra['imageKey'] as String;

        return CustomTransitionPage(
          key: state.pageKey,
          child: ProductOrderDetail(invProData: invProData, heroTag: heroTag),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: PageRouter.empProductCart,
      pageBuilder: (context, state) {
        // final extra = state.extra as Map<String, dynamic>;
        // final invProData = extra['productData'] as InventoryViewData;
        // final heroTag = extra['imageKey'] as String;

        return CustomTransitionPage(
          key: state.pageKey,
          child: OrderCart(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

class PageRouter {
  static const homePage = "/home";

  static const authPage = "/login";

  static const posLoading = "/posloading";

  static const shopDetailPage = "/shop-detail";

  static const shopProducts = "/shop_Products";

  static const productDetail = "/product_detail";

  static const shopInventory = "/shopInventory";

  static const addShopInventory = "/shopInventory/add";

  static const empProducts = "/emp_products";

  static const empProductOrder = "/emp_products/order";

  static const empProductCart = "/emp_products/OrderCart";
}
