import 'package:flutter/material.dart';
import '../models/tcg_card_item.dart';

class CardGridTile extends StatelessWidget {
  final TcgCardItem card;
  final VoidCallback onFavoriteToggle;

  const CardGridTile({
    super.key,
    required this.card,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    // Ambil skema warna dari tema yang aktif
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow, // Mengikut ke tema (Slate 800)
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(7),
                  ),
                  child: Image.network(
                    card.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: colorScheme.surface,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: colorScheme.surface,
                        child: Icon(
                          Icons.broken_image, 
                          size: 32, 
                          color: colorScheme.onSurfaceVariant,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                      onTap: onFavoriteToggle,
                      child: Icon(
                        card.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: card.isFavorite ? Colors.red : colorScheme.onSurfaceVariant,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium, //teks dari tema
                ),
                Text(
                  card.set,
                  style: theme.textTheme.bodySmall, // teks dari tema
                ),
                const SizedBox(height: 2),
                Text(
                  '\$${card.estimatedValue.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: colorScheme.primary, // Mengikut ke warna utama tema
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}