import 'package:flutter/material.dart';
import 'package:shop_app/screens/favorite_product_screen.dart';
import 'package:shop_app/widgets/drawer/custom_list_tile.dart';
import 'package:shop_app/widgets/drawer/header.dart';

import '../../screens/order_screen.dart';
import '../../screens/user_products_screen.dart';
import 'bottom_user_info.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),
        width: _isCollapsed ? 300 : 70,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Color.fromRGBO(20, 20, 20, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDrawerHeader(isColapsed: _isCollapsed),
              const Divider(
                color: Colors.grey,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
                child: CustomListTile(
                  isCollapsed: _isCollapsed,
                  icon: Icons.shop_rounded,
                  title: 'All Products',
                  infoCount: 0,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(FavoriteProductScreen.routeName);
                },
                child: CustomListTile(
                  isCollapsed: _isCollapsed,
                  icon: Icons.favorite,
                  title: 'Favorite',
                  infoCount: 0,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(OrdersScreen.routeName);
                  // .pushReplacementNamed(OrdersScreenNewFutureBuilder.routeName);
                },
                child: CustomListTile(
                  isCollapsed: _isCollapsed,
                  icon: Icons.payment_outlined,
                  title: 'Your orders',
                  infoCount: 0,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(UserProductsScreen.routeName);
                },
                child: CustomListTile(
                  isCollapsed: _isCollapsed,
                  icon: Icons.edit_rounded,
                  title: 'Add/Mannage products',
                  infoCount: 0,
                ),
              ),
              const Divider(color: Colors.grey),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.location_on_rounded,
                title: 'Address',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.credit_card,
                title: 'Saved Cards & Wallet',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.headphones_rounded,
                title: 'Help center',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              const Divider(color: Colors.grey),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.help_rounded,
                title: 'HELP',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.info_rounded,
                title: 'ABOUT US',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.quiz_rounded,
                title: 'TERMS, POLICIES AND POLICY',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              const Divider(color: Colors.grey),
              const Spacer(),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.notifications,
                title: 'Notifications',
                infoCount: 2,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.settings,
                title: 'Settings',
                infoCount: 0,
              ),
              const SizedBox(height: 10),
              BottomUserInfo(isCollapsed: _isCollapsed),
              Align(
                alignment: _isCollapsed
                    ? Alignment.bottomRight
                    : Alignment.bottomCenter,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    _isCollapsed
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      _isCollapsed = !_isCollapsed;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
