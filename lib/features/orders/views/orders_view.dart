// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yum_quick/core/helper/app_navigator.dart';
import 'package:yum_quick/core/shared/custom_svg_wrapper.dart';
import 'package:yum_quick/core/utils/app_colors.dart';
import 'package:yum_quick/core/shared/custom_views_style.dart';
import 'package:yum_quick/core/utils/app_font_styles.dart';
import 'package:yum_quick/features/orders/cubits/get_orders/get_orders_cubit.dart';
import 'package:yum_quick/features/orders/cubits/get_orders/get_orders_state.dart';
import 'package:yum_quick/features/orders/data/models/orders_response_model.dart';
import 'package:yum_quick/features/orders/data/repo/orders_repo.dart';
import 'package:yum_quick/features/orders/views/order_details_view.dart';

class OrdersView extends StatelessWidget {
  OrdersView({super.key});

  List<String> orderStatus = ["Active", "Canceled", "Completed"];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetOrdersCubit(OrdersRepo(), orders: OrdersModel())..getOrders(),
      child: CustomViewsStyle(
        header: Padding(
          padding: const EdgeInsets.only(bottom: 20, top: 10),
          child: Text(
            "My Orders",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocBuilder<GetOrdersCubit, GetOrdersState>(
          builder: (context, state) {
            var cubit = GetOrdersCubit.get(context);

            if (state is GetOrdersLoading && cubit.orders.active == null) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetOrdersError && cubit.orders.active == null) {
              return Center(child: Text(state.error));
            }
            if (cubit.orders.active != null ||
                cubit.orders.canceled != null ||
                cubit.orders.completed != null) {
              List<ItemsModel> currentItems = [];
              var orders = cubit.orders;

              if (cubit.currentIndex == 0 && orders.active != null) {
                for (var order in orders.active!) {
                  if (order.items != null) currentItems.addAll(order.items!);
                }
              } else if (cubit.currentIndex == 1 && orders.canceled != null) {
                for (var order in orders.canceled!) {
                  if (order.items != null) currentItems.addAll(order.items!);
                }
              } else if (cubit.currentIndex == 2 && orders.completed != null) {
                for (var order in orders.completed!) {
                  if (order.items != null) currentItems.addAll(order.items!);
                }
              }

              return Column(
                children: [
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          cubit.onOrderTapped(index);
                        },
                        child: Container(
                          height: 30,
                          width: 95,
                          decoration: BoxDecoration(
                            color: cubit.currentIndex == index
                                ? AppColors.orange
                                : AppColors.orange.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              orderStatus[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: cubit.currentIndex == index
                                    ? Colors.white
                                    : AppColors.orange,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 15),
                      itemCount: orderStatus.length,
                    ),
                  ),
                  const Divider(color: AppColors.orange, thickness: 0.5),

                  Expanded(
                    child: Builder(
                      builder: (context) {
                        dynamic currentOrders = [];
                        if (cubit.currentIndex == 0) {
                          currentOrders = cubit.orders.active ?? [];
                        } else if (cubit.currentIndex == 1) {
                          currentOrders = cubit.orders.canceled ?? [];
                        } else if (cubit.currentIndex == 2) {
                          currentOrders = cubit.orders.completed ?? [];
                        }

                        if (currentOrders.isEmpty) {
                          return const Center(child: Text("No orders found"));
                        }

                        return ListView.builder(
                          // padding: const EdgeInsets.symmetric(horizontal: 15),
                          itemCount: currentOrders.length,
                          itemBuilder: (context, index) {
                            var order = currentOrders[index];
                            var firstItem = order.items?.first;

                            return InkWell(
                              onTap: () => MyNavigator.goto(
                                context,
                                OrderDetailsView(order: order),
                              ),
                              child: MenuItemBuilder(
                                image: firstItem?.imagePath ?? '',
                                title: firstItem?.name ?? 'Order #${order.id}',
                                date: order.orderDate ?? 'No Date',
                                price:
                                    order.total?.toStringAsFixed(2) ?? '0.00',
                                itemCount: order.items?.length ?? 0,
                                status: cubit
                                    .currentIndex, // نمرر الحالة عشان نتحكم في ظهور الأزرار
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class MenuItemBuilder extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String price;
  final int itemCount;
  final int status; // 0 for Active, 1 for Canceled, 2 for Completed

  const MenuItemBuilder({
    super.key,
    required this.image,
    required this.title,
    required this.date,
    required this.price,
    required this.itemCount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            // إضافة ظل خفيف جداً ليناسب التصميم العصري
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.20),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  image,
                  height: 120,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 120,
                    width: 100,
                    color: Colors.grey[200],
                    child: const Icon(Icons.fastfood, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D1414), // لون غامق زي الصورة
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          "\$$price",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.orange, // اللون البرتقالي للسعر
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   maxLines: 2,
                        //   date,
                        //   style: TextStyle(
                        //     overflow: TextOverflow.ellipsis,

                        //     fontSize: 14,
                        //     color: Colors.grey[600],
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        Spacer(),
                        Text(
                          "$itemCount items",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    if (status == 0)
                      Row(
                        children: [
                          // زر Cancel Order
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Text(
                                  "Cancel Order",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // زر Track Driver
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFFFFEBE3,
                                ), // لون برتقالي فاتح جداً
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Text(
                                  "Track Driver",
                                  style: TextStyle(
                                    color: AppColors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (status == 1)
                      Row(
                        children: [
                          CustomSvgWrapper(
                            path: "assets/icons/cancelled_icon.svg",
                          ),
                          Text(
                            " Order Cancelled",
                            style: TextStyle(
                              color: AppColors.orange,
                              fontWeight: AppFontWeight.extraLight,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    if (status == 2)
                      Row(
                        children: [
                          CustomSvgWrapper(
                            path: "assets/icons/right_check_icon.svg",
                          ),
                          Text(
                            " Order delivered",
                            style: TextStyle(
                              color: AppColors.orange,
                              fontWeight: AppFontWeight.extraLight,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Divider(color: AppColors.primary.withValues(alpha: 0.5)),
        SizedBox(height: 10),
      ],
    );
  }
}

class RatingBadge extends StatelessWidget {
  final double rating;

  const RatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, size: 12, color: Colors.white),
          // استبدلت CustomSvgWrapper بـ Icon عادي للتأكد انه هيشتغل معاك بدون مشاكل
          // لو حابب ترجعها للـ Svg بتاعك مفيش مشكلة:
          // const CustomSvgWrapper(path: "assets/icons/star_icon.svg", width: 12),
        ],
      ),
    );
  }
}
