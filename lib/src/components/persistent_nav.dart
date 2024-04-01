import 'package:mall/src/modules/home/blocs/item/product_item_cubit.dart';

import '../modules/auth/blocs/authentication_bloc/authentication_bloc.dart';
import '../modules/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import '../modules/home/blocs/product_list_bloc.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/profile/blocs/update_user_bloc/update_user_bloc.dart';
import '../modules/profile/views/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class PersistentTabScreen extends StatefulWidget {
  const PersistentTabScreen({super.key});

  @override
  State<PersistentTabScreen> createState() => _PersistentTabScreenState();
}

class _PersistentTabScreenState extends State<PersistentTabScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductListBloc(),
          ),
          BlocProvider(
            create: (context) => ProductItemCubit(),
          ),
        ],
        child: HomeScreen(),
      ),
      MultiBlocProvider(
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
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      _persistentBottomNavBarItem(const Icon(CupertinoIcons.home), "Hem"),
      _persistentBottomNavBarItem(const Icon(CupertinoIcons.person), "Profil"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      backgroundColor: Theme.of(context).colorScheme.background,

      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }

  PersistentBottomNavBarItem _persistentBottomNavBarItem(
          Icon icon, String title) =>
      PersistentBottomNavBarItem(
        activeColorPrimary: Theme.of(context).colorScheme.primary,
        // activeColorSecondary: Theme.of(context).colorScheme.secondary,
        inactiveColorPrimary:
            Theme.of(context).colorScheme.primary.withOpacity(0.5),
        icon: icon,
        title: title,
      );
}
