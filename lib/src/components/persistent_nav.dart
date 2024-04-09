import 'package:mall/src/extensions/build_context.dart';
import 'package:mall/src/modules/add_item_bar/bloc/add_item_bar_cubit.dart';
import 'package:mall/src/modules/home/blocs/item/product_item_cubit.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../modules/auth/blocs/authentication_bloc/authentication_bloc.dart';
import '../modules/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

import '../modules/home/views/home_screen.dart';
import '../modules/profile/blocs/update_user_bloc/update_user_bloc.dart';
import '../modules/profile/views/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersistentTabScreen extends StatefulWidget {
  const PersistentTabScreen({super.key});

  @override
  State<PersistentTabScreen> createState() => _PersistentTabScreenState();
}

class _PersistentTabScreenState extends State<PersistentTabScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    print(_controller.index);
    return PersistentTabView(
      backgroundColor: context.backgroud,
      controller: _controller,
      navBarOverlap: NavBarOverlap.none(),
      tabs: [
        PersistentTabConfig(
          screen: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProductListCubit()..setAllProducts(),
              ),
              BlocProvider(create: (context) => AddItemBarCubit())
            ],
            child: HomeScreen(),
          ),
          item: ItemConfig(
              icon: Icon(Icons.list),
              title: "List",
              activeForegroundColor: context.secondary,
              inactiveBackgroundColor: context.backgroud),
        ),
        PersistentTabConfig(
          screen: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SignInBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository),
              ),
              BlocProvider(
                create: (context) => UpdateUserBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository),
              ),
            ],
            child: const ProfileScreen(),
          ),
          item: ItemConfig(
              icon: Icon(Icons.person_outline),
              title: "Settings",
              activeForegroundColor: context.secondary,
              inactiveBackgroundColor: context.backgroud),
        ),
        // PersistentTabConfig(
        //   screen: YourThirdScreen(),
        //   item: ItemConfig(
        //     icon: Icon(Icons.settings),
        //     title: "Settings",
        //   ),
        // ),
      ],
      navBarBuilder: (navBarConfig) => Style2BottomNavBar(
        navBarDecoration: NavBarDecoration(color: context.backgroud),
        navBarConfig: navBarConfig,
      ),
    );
  }

  ItemConfig _tabBarItem(String title, IconData iconData, bool isSelected) {
    return ItemConfig(
      icon: IconTheme(
        data: IconThemeData(
            size: 30, color: isSelected ? context.primary : context.secondary),
        child: Icon(iconData),
      ),
      title: title,
    );
  }
}
