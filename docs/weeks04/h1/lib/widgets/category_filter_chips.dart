import 'package:flutter/material.dart';
import '../models/tcg_card_item.dart';

class CategoryFilterChips extends StatelessWidget {
  final TcgCategory selectedCategory;
  final ValueChanged<TcgCategory> onCategorySelected;

  const CategoryFilterChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: TcgCategory.values.map((category) {
          final isSelected = selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(
                category.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? colorScheme.onSurface : colorScheme.onSurfaceVariant,
                ),
              ),
              selected: isSelected,
              selectedColor: colorScheme.primary.withValues(alpha: 0.3),
              backgroundColor: colorScheme.surfaceContainerHigh, // Warna Chip
              side: BorderSide(
                color: isSelected ? colorScheme.primary : colorScheme.outline,
              ),
              onSelected: (_) => onCategorySelected(category),
            ),
          );
        }).toList(),
      ),
    );
  }
}