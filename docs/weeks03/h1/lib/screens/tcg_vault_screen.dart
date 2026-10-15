import 'package:flutter/material.dart';
import '../models/tcg_card_item.dart';
import '../widgets/vault_header_card.dart';
import '../widgets/vault_search_bar.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/card_grid_tile.dart';

class TcgVaultScreen extends StatefulWidget {
  const TcgVaultScreen({super.key});

  @override
  State<TcgVaultScreen> createState() => _TcgVaultScreenState();
}

class _TcgVaultScreenState extends State<TcgVaultScreen> {
  String _searchQuery = '';
  TcgCategory _selectedCategory = TcgCategory.all;

  // Data Dummy Kartu TCG
  final List<TcgCardItem> _cards = const [
    TcgCardItem(
      id: '1',
      name: 'Charizard Base Set',
      set: '1st Ed',
      estimatedValue: 4200.0,
      imageUrl: 'https://images.unsplash.com/photo-1613771404784-3a5686aa2be3?w=500',
      category: TcgCategory.pokemon,
      isFavorite: true,
    ),
    TcgCardItem(
      id: '2',
      name: 'Black Lotus',
      set: 'Alpha',
      estimatedValue: 15000.0,
      imageUrl: 'https://images.unsplash.com/photo-1541963463532-d68292c34b19?w=500',
      category: TcgCategory.mtg,
    ),
    TcgCardItem(
      id: '3',
      name: 'Blue-Eyes Dragon',
      set: 'LOB-001',
      estimatedValue: 1800.0,
      imageUrl: 'https://images.unsplash.com/photo-1563089145-599997674d42?w=500',
      category: TcgCategory.yugioh,
    ),
  ];

  // Getter untuk menyaring kartu berdasarkan pencarian & tag/kategori
  List<TcgCardItem> get _filteredCards {
    return _cards.where((card) {
      final matchesSearch = card.name
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == TcgCategory.all ||
          card.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  // Menghitung total nilai koleksi
  double get _totalValue {
    return _cards.fold(0, (sum, item) => sum + item.estimatedValue);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // Menggunakan warna latar belakang dari tema aktif
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('TCG Vault'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          slivers: [
            // 1. Vault Header Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: VaultHeaderCard(
                  totalValue: _totalValue,
                  totalCards: _cards.length,
                ),
              ),
            ),

            // 2. Search Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: VaultSearchBar(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
            ),

            // 3. Category Filter Chips
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CategoryFilterChips(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
              ),
            ),

            // 4. Card Grid Tiles
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final card = _filteredCards[index];
                  return CardGridTile(
                    card: card,
                    onFavoriteToggle: () {
                      setState(() {
                        // Logika toggle favorit
                      });
                    },
                  );
                },
                childCount: _filteredCards.length,
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }
}