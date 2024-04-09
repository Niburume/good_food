import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mall/constants/sizes.dart';
import 'package:mall/src/extensions/build_context.dart';
import 'package:mall/src/modules/home/model/dummyModel.dart';
import 'package:mall/src/utils/enums/enums.dart';

import '../../modules/home/model/product_item_view_model.dart';

class KProductTile extends StatelessWidget {
  final MyProductItemViewModel productViewModel;
  final bool isLoading;
  final bool isFavoriteAnimates;
  final VoidCallback onFavoriteTapped;
  final VoidCallback onCheckTapped;
  final VoidCallback? onDeleteTapped;

  final bool isReorderAbleView;

  const KProductTile(
      {super.key,
      this.isLoading = false,
      this.isFavoriteAnimates = false,
      this.isReorderAbleView = false,
      this.onDeleteTapped,
      required this.productViewModel,
      required this.onFavoriteTapped,
      required this.onCheckTapped});

  @override
  Widget build(BuildContext context) {
    var product = productViewModel.productItem;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      child: Slidable(
        enabled: isReorderAbleView ? false : true,
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(10),
              // An action can be bigger than the others.
              flex: 2,
              onPressed: (_) => onDeleteTapped?.call(),
              backgroundColor: context.onError.withOpacity(0.5),
              foregroundColor: context.onBackground,
              icon: Icons.archive,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          height: kProductTileSize,
          decoration: BoxDecoration(
              border: Border.all(color: context.tertiary.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(15)),
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        product.isChecked
                            ? onCheckTapped()
                            : onFavoriteTapped();
                      },
                      icon: product.isFavorite
                          ? isFavoriteAnimates
                              ? Animate(
                                      child: Icon(
                                  Icons.star,
                                  size: kProductTileSize * 0.5,
                                ))
                                  .animate(delay: 200.ms)
                                  .scale()
                                  .rotate()
                                  .shimmer(delay: 300.ms)
                              : Icon(
                                  Icons.star,
                                  size: kProductTileSize * 0.5,
                                )
                          : Icon(
                              product.isChecked
                                  ? Icons.not_interested
                                  : Icons.star_border,
                              size: kProductTileSize * 0.4,
                            ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(product.name),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text('product.category'),
                        ),
                      ],
                    ),
                  ],
                ),
                isReorderAbleView
                    ? IconButton(
                        onPressed: () {},
                        icon: Animate(child: Icon(Icons.list))
                            .animate()
                            .fadeIn()
                            .slideX(begin: -5, end: 0, curve: Curves.easeIn)
                            .then()
                            .rotate(),
                      )
                    : Row(
                        children: [
                          AnimatedContainer(
                              width: isLoading ? 10 : 0,
                              duration: Duration(milliseconds: 300),
                              child: LinearProgressIndicator()),
                          Animate(
                            child: IconButton(
                              onPressed: () {
                                onCheckTapped();
                              },
                              icon: product.isChecked
                                  ? Icon(Icons.check_box_outlined)
                                  : Icon(Icons.check_box_outline_blank),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
