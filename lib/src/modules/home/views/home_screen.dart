import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall/src/components/list_tiles/product_tile.dart';
import 'package:mall/src/modules/home/blocs/item/product_item_cubit.dart';

import 'package:mall/src/modules/home/blocs/product_list_bloc.dart';
import 'package:mall/src/modules/home/services/prouct_items_handler.dart';

import '../../../components/search_textfield.dart';
import '../model/dummyModel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final GlobalKey<AnimatedListState> _listKeyChecked =
      GlobalKey<AnimatedListState>();

  bool isHistoryVisible = false;

  final TextEditingController addItemController = TextEditingController();
  final FocusNode addItemFocusNode = FocusNode();
  List<MyProductItem> products = [];
  List<MyProductItem> completedProducts = [];
  // region ITEMS

  // void addItem() {
  //   if (addItemController.text.isEmpty) {
  //     addItemFocusNode.unfocus();
  //     return;
  //   }
  //   print(addItemController.text);
  //   _productItems.insert(
  //       0,
  //       MyProductItem.empty.copyWith(
  //           id: (_productItems.length + 1).toString(),
  //           name: addItemController.text));
  //   addItemController.clear();
  //   addItemFocusNode.requestFocus();
  //   setState(() {});
  // }

  void uncheckItem(
    MyProductItem product,
  ) {
    context.read<ProductItemCubit>().uncheckItem(product);
  }

  void checkItem(MyProductItem product) {
    context.read<ProductItemCubit>().checkItem(product);
    // print(_listKey.toString());
    // _listKey.currentState?.removeItem(
    //     i,
    //     (context, animation) => SizeTransition(
    //         sizeFactor: animation,
    //         child: KProductTile(
    //           isLoading: false,
    //           product: product,
    //           onFavoriteTapped: () {},
    //           onCheckTapped: () {},
    //         )),
    //     duration: Duration(milliseconds: 200));
    // print(_listKey.toString());
    // _listKey.currentState?.insertItem(
    //   0,
    //   duration: Duration(milliseconds: 200),
    // );
  }

  // endregion

  void showHistory() {
    isHistoryVisible = !isHistoryVisible;
    setState(() {});
  }

  void loadAllProducts() {
    context.read<ProductListBloc>().add(LoadAllProductsEvent());
  }

  @override
  void initState() {
    loadAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ProductListBloc, ProductListState>(
      listener: (context, state) {
        if (state is ProductListLoaded) {
          context.read<ProductItemCubit>().setAllProducts(state.allProducts);
        }
        ;
      },
      builder: (context, state) {
        print('build');
        if (state is ProductListLoaded) {
          return BlocBuilder<ProductItemCubit, ProductItemState>(
            builder: (context, productItemState) {
              completedProducts = productItemState.completedProducts;
              products = productItemState.products;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text('Home'),
                    actions: [
                      IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Icon(Icons.refresh))
                    ],
                  ),

                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: products.length, (context, i) {
                    MyProductItem product = products[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: KProductTile(
                        isLoading: false,
                        product: product,
                        onFavoriteTapped: () {},
                        onCheckTapped: () {
                          checkItem(product);
                        },
                      ),
                    );
                  })),
                  // region toggle button
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {
                        showHistory();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Show checked',
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: Theme.of(context).colorScheme.secondary,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // endregion
                  isHistoryVisible
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: completedProducts.length,
                              (context, i) {
                          MyProductItem product = completedProducts[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            child: KProductTile(
                              isLoading: false,
                              product: product,
                              onFavoriteTapped: () {},
                              onCheckTapped: () {
                                uncheckItem(product);
                              },
                            ),
                          );
                        }))
                      : SliverToBoxAdapter(
                          child: SizedBox(
                            height: 100,
                          ),
                        ),
                  // SliverToBoxAdapter(
                  //   child: CustomSearchTextField(
                  //     focusNode: addItemFocusNode,
                  //     controller: addItemController,
                  //     onChange: () {},
                  //     onClear: () {},
                  //     onSubmitted: () {},
                  //   ),
                  // )
                ],
              );
            },
          );
        } else if (state is ProductListLoading) {
          return Center(
            child: SizedBox(
                height: 60, width: 60, child: CircularProgressIndicator()),
          );
        } else {
          return Text('Error');
        }
      },
    ));
  }
}
