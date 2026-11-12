import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rust_flutter/core/extension/context_extension.dart';
import 'package:rust_flutter/core/extension/text_style.dart';
import 'package:rust_flutter/routes/page_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../providers/admin_provider.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  AdminProvider get _adminPvd =>
      Provider.of<AdminProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _adminPvd.getAdminDashBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminPvd, child) {
        return Scaffold(
          appBar: commonAppBar(color: Colors.white, text: "DashBoard"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(162, 216, 216, 216),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        spacing: 5,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(0, 33, 149, 243),
                              border: Border.all(color: Colors.indigoAccent),
                            ),
                            child: Row(
                              spacing: 5,
                              children: [
                                const Icon(
                                  Icons.storefront_outlined,
                                  color: Colors.indigoAccent,
                                ),
                                Text(
                                  "${adminPvd.adminData?.totalShops ?? 0}",
                                  style: getMediumtext(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Shops",
                            style: getMediumtext(color: Colors.black),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          context.push(PageRouter.productDetail);
                        },
                        child: Column(
                          spacing: 10,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(0, 33, 149, 243),
                                border: Border.all(color: Colors.orangeAccent),
                              ),
                              child: Row(
                                spacing: 5,
                                children: [
                                  const Icon(
                                    Icons.inventory_2_outlined,
                                    color: Colors.orangeAccent,
                                  ),
                                  Text(
                                    "${adminPvd.adminData?.totalProducts ?? 0}",
                                    style: getMediumtext(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Products",
                              style: getMediumtext(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        spacing: 10,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(0, 33, 149, 243),
                              border: Border.all(color: Colors.lightBlueAccent),
                            ),
                            child: Row(
                              spacing: 5,
                              children: [
                                const Icon(
                                  Icons.warehouse,
                                  color: Colors.lightBlueAccent,
                                ),
                                Text(
                                  "${adminPvd.adminData?.totalStockQuantity ?? 0}",
                                  style: getMediumtext(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Stock",
                            style: getMediumtext(color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 10,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(0, 33, 149, 243),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Row(
                              spacing: 5,
                              children: [
                                const Icon(
                                  Icons.point_of_sale,
                                  color: Colors.green,
                                ),
                                Text(
                                  "${adminPvd.adminData?.totalSalesCount ?? 0}",
                                  style: getMediumtext(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Sales",
                            style: getMediumtext(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Replaced broken fl_chart with SfCartesianChart to bypass vector_math version conflicts
                SizedBox(
                  height: 250,
                  child: SfCartesianChart(
                    title: ChartTitle(
                      text: "Weekly Dashboard",
                      textStyle: getMediumtext(color: Colors.black),
                    ),
                    primaryXAxis: CategoryAxis(),
                    series: <CartesianSeries<_SalesData, String>>[
                      LineSeries<_SalesData, String>(
                        dataSource: <_SalesData>[
                          _SalesData('Mon', 200),
                          _SalesData('Tue', 170),
                          _SalesData('Wed', 210),
                          _SalesData('Thu', 55),
                          _SalesData('Fri', 89),
                          _SalesData('Sat', 256),
                          _SalesData('Sun', 290),
                        ],
                        xValueMapper: (_SalesData sales, _) => sales.day,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        color: Colors.green,
                        width: 3,
                        markerSettings: const MarkerSettings(isVisible: true),
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: false,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(162, 216, 216, 216),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15,
                    children: [
                      Text(
                        "Monthly Rate (default)",
                        style: getMediumtext(color: Colors.black, fontSize: 16),
                      ),
                      Row(
                        spacing: 15,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_double_arrow_down_sharp,
                                  color: Colors.red,
                                ),
                                Text(
                                  "0.34 %",
                                  style: getMediumtext(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_double_arrow_up_sharp,
                                  color: Colors.green,
                                ),
                                Text(
                                  "2.85 %",
                                  style: getMediumtext(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(162, 216, 216, 216),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15,
                    children: [
                      Text(
                        "Out of Stock (default)",
                        style: getMediumtext(color: Colors.black, fontSize: 16),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(15, 255, 82, 82),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Keyboard 21FS001"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(15, 255, 82, 82),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Coca cola"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SalesData {
  _SalesData(this.day, this.sales);
  final String day;
  final double sales;
}

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
  });
  final String count;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.4,
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(spacing: 5, children: [Text(title), Text(count)]),
      ),
    );
  }
}
