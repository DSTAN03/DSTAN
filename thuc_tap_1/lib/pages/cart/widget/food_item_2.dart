import 'package:flutter/material.dart';
import '../../../components/app_rating_bar.dart';
import '../../../models/food_model.dart';
import '../../../components/app_box_shadow.dart';
import '../../../components/app_shimmer.dart';

class FoodItem2 extends StatelessWidget {
  const FoodItem2(
    this.food, {
    super.key,
    this.onAdd,
    this.onRemove,
    this.onDelete,
  });

  final Function()? onAdd;
  final Function()? onRemove;
  final Function()? onDelete;
  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: AppBoxShadow.boxShadow,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            child: Image.asset(
              food.imageStr ?? '',
              width: 120.0,
              height: 120.0,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const AppShimmer(
                width: 120.0,
                height: 120.0,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  food.name ?? '-:-',
                  style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  food.description ?? '-:-',
                  style: const TextStyle(color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      food.price?.toStringAsFixed(2) ?? '-:-',
                      style: const TextStyle(fontSize: 16.8),
                    ),
                    const Text(
                      '\$',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.8,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 46.0,
                      child: TextButton(
                        onPressed: onAdd,
                        child: const Text(
                          '+',
                          style:
                              TextStyle(color: Colors.orange, fontSize: 24.0),
                        ),
                      ),
                    ),
                    Text(
                      '${food.quantity ?? 0}',
                      style: const TextStyle(color: Colors.red, fontSize: 16.8),
                    ),
                    SizedBox(
                      width: 46.0,
                      child: TextButton(
                        onPressed: onRemove,
                        child: const Text(
                          '-',
                          style:
                              TextStyle(color: Colors.orange, fontSize: 24.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    AppRatingBar(
                      onRatingUpdate: (value) {},
                      rating: food.rating ?? 0.0,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onDelete,
                      behavior: HitTestBehavior.translucent,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0).copyWith(right: 8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.8),
                          radius: 12.6,
                          child: const Icon(
                            Icons.delete,
                            size: 14.6,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
