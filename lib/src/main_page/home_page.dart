import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/src/providers/admin_provider.dart';

import '../../routes/page_router.dart';
import '../providers/order_provider.dart';
import '../providers/product_provider.dart';
import '../enums/emp_role.dart';
import '../view/admin_view/admin_dashboard.dart';
import '../view/admin_view/admin_users.dart';
import '../view/emp_view/sales_list.dart';
import '../view/owner_view/owner_dashboard.dart';
import '../view/profile_view.dart';
import '../view/receipt_history/history_tab.dart';
import '../view/shop_page/shop_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductProvider get productPvd =>
      Provider.of<ProductProvider>(context, listen: false);

  AdminProvider get adminPvd =>
      Provider.of<AdminProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await adminPvd.getData();
      await productPvd.getProductList();
    });
  }

  // Helper method to keep tabs clean and apply AnimatedScale uniformly
  Tab _buildAnimatedTab(IconData icon, String text, int tabIndex) {
    return Tab(
      icon: AnimatedScale(
        scale: adminPvd.indexTab == tabIndex ? 1.35 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Icon(icon),
      ),
      text: text,
    );
  }

  List<Tab> get tabs {
    switch (adminPvd.empRole) {
      case AuthRole.admin:
        return [
          _buildAnimatedTab(Icons.dashboard, 'Dashboard', 0),
          _buildAnimatedTab(Icons.store, 'Shops', 1),
          _buildAnimatedTab(Icons.people, 'Users', 2),
          _buildAnimatedTab(Icons.receipt_long_sharp, 'History', 3),
          _buildAnimatedTab(Icons.person, 'Profile', 4),
        ];

      case AuthRole.owner:
        return [
          _buildAnimatedTab(Icons.dashboard, 'Dashboard', 0),
          _buildAnimatedTab(Icons.store, 'Shops', 1),
          _buildAnimatedTab(Icons.people, 'Users', 2),
          _buildAnimatedTab(Icons.receipt_long_sharp, 'History', 3),
          _buildAnimatedTab(Icons.person, 'Profile', 4),
        ];

      case AuthRole.employee:
        return [
          _buildAnimatedTab(Icons.inventory, 'Products', 0),
          _buildAnimatedTab(Icons.point_of_sale, 'Sales', 1),
          _buildAnimatedTab(Icons.receipt_long, 'History', 2),
          _buildAnimatedTab(Icons.person, 'Profile', 3),
        ];
    }
  }

  List<Widget> get pages {
    switch (adminPvd.empRole) {
      case AuthRole.admin:
        return const [
          AdminDashboardView(),
          ShopListView(),
          AdminUsersView(),
          ReceiptHistoryView(),
          ProfileView(),
        ];

      case AuthRole.owner:
        return const [
          OwnerDashboardView(),
          ShopListView(),
          AdminUsersView(),
          ReceiptHistoryView(),
          ProfileView(),
        ];

      case AuthRole.employee:
        return const [
          ShopListView(),
          SalesList(),
          ReceiptHistoryView(),
          ProfileView(),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AdminProvider>();
    final roleTabs = tabs;
    final rolePages = pages;

    return DefaultTabController(
      length: roleTabs.length,
      child: Scaffold(
        body: SafeArea(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: rolePages,
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 254, 254, 255),
            border: Border(top: BorderSide(color: Colors.white12, width: 0.5)),
          ),
          child: TabBar(
            onTap: (value) {
              adminPvd.updateInDexTab(value);
            },
            labelPadding: const EdgeInsets.all(4),
            labelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.transparent,
              fontSize: 12,
            ),
            indicatorColor: Colors.indigoAccent,
            labelColor: Colors.indigoAccent,
            unselectedLabelColor: Colors.grey,
            tabs: roleTabs,
          ),
        ),
        floatingActionButton: Selector<OrderProvider, bool>(
          builder: (_, haveOrderItems, _) {
            return haveOrderItems
                ? FloatingActionButton(
                  heroTag: "bag",
                  backgroundColor: Colors.white,
                  onPressed: () {
                    context.push(PageRouter.empProductCart);
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      Image.asset(width: 45, "assets/icons/bags.png"),
                    ],
                  ),
                )
                : const SizedBox.shrink();
          },
          selector: (_, pvd) => pvd.totalCount > 0,
        ),
      ),
    );
  }
}
