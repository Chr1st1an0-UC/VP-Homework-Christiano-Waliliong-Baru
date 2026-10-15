// Enum untuk kategori kartu TCG
enum TcgCategory {
  all,
  pokemon,
  mtg,
  yugioh,
}

class TcgCardItem {
  final String id;
  final String name;
  final String set;
  final double estimatedValue;
  final String imageUrl;
  final TcgCategory category;
  final bool isFavorite;

  const TcgCardItem({
    required this.id,
    required this.name,
    required this.set,
    required this.estimatedValue,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
  });

  TcgCardItem copyWith({
    String? id,
    String? name,
    String? set,
    double? estimatedValue,
    String? imageUrl,
    TcgCategory? category,
    bool? isFavorite,
  }) {
    return TcgCardItem(
      id: id ?? this.id,
      name: name ?? this.name,
      set: set ?? this.set,
      estimatedValue: estimatedValue ?? this.estimatedValue,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // Sample data awal
  static List<TcgCardItem> get sampleCards => const [
        TcgCardItem(
          id: '1',
          name: 'Charizard Base Set',
          set: '1st Ed Limited Shadowless Collector Edition',
          estimatedValue: 4200.0,
          imageUrl: 'https://images.unsplash.com/photo-1613771404784-3a5686aa2be3?w=500',
          category: TcgCategory.pokemon,
          isFavorite: true,
        ),
        TcgCardItem(
          id: '2',
          name: 'Black Lotus',
          set: 'Alpha Rare Mint',
          estimatedValue: 15000.0,
          imageUrl: 'https://images.unsplash.com/photo-1541963463532-d68292c34b19?w=500',
          category: TcgCategory.mtg,
        ),
        TcgCardItem(
          id: '3',
          name: 'Blue-Eyes White Dragon',
          set: 'LOB-001 Legend of Blue Eyes White Dragon 1st Edition Ultra Rare Edition',
          estimatedValue: 1800.0,
          imageUrl: 'https://images.unsplash.com/photo-1563089145-599997674d42?w=500',
          category: TcgCategory.yugioh,
        ),
      ];

  // Sampel item dengan nama 200 karakter untuk pengujian long text
  static TcgCardItem get longTextCard => TcgCardItem(
        id: 'long_1',
        name: 'Ultra Extremely Rare Special Edition Holographic Shiny Animated Charizard Dragon Master Card With Over Two Hundred Character Long Descriptive Title Name For Testing Overflow Robustness Across Devices',
        set: 'Special Anniversary Limited Edition Box Set Release 2026',
        estimatedValue: 99999.99,
        imageUrl: 'https://images.unsplash.com/photo-1613771404784-3a5686aa2be3?w=500',
        category: TcgCategory.pokemon,
      );

  // Generates 500 items for long list testing without shrinkWrap
  static List<TcgCardItem> generate500Items() {
    final categories = [TcgCategory.pokemon, TcgCategory.mtg, TcgCategory.yugioh];
    return List.generate(500, (index) {
      final category = categories[index % categories.length];
      return TcgCardItem(
        id: 'item_$index',
        name: '${category.name.toUpperCase()} Card #${index + 1} - High Grade Collectible Specimen',
        set: 'Series ${index ~/ 10 + 1} Set Edition',
        estimatedValue: (index + 1) * 12.5,
        imageUrl: 'https://images.unsplash.com/photo-1613771404784-3a5686aa2be3?w=500',
        category: category,
        isFavorite: index % 5 == 0,
      );
    });
  }
}
