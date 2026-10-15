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
}