import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall/src/modules/home/model/dummyModel.dart';

class KProductTile extends StatelessWidget {
  final MyProductItem product;
  final bool isLoading;
  final VoidCallback onFavoriteTapped;
  final VoidCallback onCheckTapped;
  const KProductTile(
      {super.key,
      required this.isLoading,
      required this.product,
      required this.onFavoriteTapped,
      required this.onCheckTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), border: Border.all()),
      child: ListTile(
        leading: Animate(
            child: IconButton(
                onPressed: onFavoriteTapped,
                icon: Animate(
                    child: product.isFavorite
                        ? Icon(
                            Icons.star,
                            size: 30,
                            color: Theme.of(context).colorScheme.secondary,
                          )
                            .animate()
                            .rotate(duration: 400.ms)
                            .scale(duration: 300.ms)
                            .then()
                            .shimmer(delay: 200.ms, duration: 1000.ms)
                        : const Icon(
                            Icons.star_border,
                            size: 20,
                          )))),
        title: Text(product.name),
        subtitle: product.category != '' ? Text(product.category) : null,
        trailing: Animate(
            child: IconButton(
                onPressed: onCheckTapped,
                icon: Animate(
                    child: product.isChecked
                        ? Icon(
                            Icons.check_box_outlined,
                            size: 30,
                            color: Theme.of(context).colorScheme.secondary,
                          )
                        : const Icon(
                            Icons.check_box_outline_blank,
                            size: 20,
                          )
                            .animate()
                            .rotate(duration: 400.ms)
                            .scale(duration: 300.ms)
                            .then()
                            .shimmer(delay: 200.ms, duration: 1000.ms)))),
      ),
    );
  }
}
