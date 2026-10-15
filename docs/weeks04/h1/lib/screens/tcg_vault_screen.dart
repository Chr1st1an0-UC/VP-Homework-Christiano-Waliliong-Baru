import 'package:flutter/material.dart';
import '../main.dart';
import '../models/tcg_card_item.dart';
import '../widgets/vault_header_card.dart';
import '../widgets/vault_search_bar.dart';
import '../widgets/category_filter_chips.dart';
import '../widgets/card_grid_tile.dart';
import '../widgets/empty_state_view.dart';

class TcgVaultScreen extends StatefulWidget {
  const TcgVaultScreen({super.key});

  @override
  State<TcgVaultScreen> createState() => _TcgVaultScreenState();
}

class _TcgVaultScreenState extends State<TcgVaultScreen> {
  String _searchQuery = '';
  TcgCategory _selectedCategory = TcgCategory.all;
  bool _use500Items = false;
  bool _useLongTextItem = false;

  late List<TcgCardItem> _cards;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  void _loadCards() {
    if (_use500Items) {
      _cards = TcgCardItem.generate500Items();
    } else {
      _cards = List.from(TcgCardItem.sampleCards);
      if (_useLongTextItem) {
        _cards.add(TcgCardItem.longTextCard);
      }
    }
  }

  void _resetFilters() {
    setState(() {
      _searchQuery = '';
      _selectedCategory = TcgCategory.all;
    });
  }

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

  double get _totalValue {
    return _cards.fold(0, (sum, item) => sum + item.estimatedValue);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final myApp = MyApp.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('TCG Vault'),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: 'Toggle 500 Items Mode',
            icon: Icon(_use500Items ? Icons.filter_5_rounded : Icons.filter_3_rounded),
            onPressed: () {
              setState(() {
                _use500Items = !_use500Items;
                _loadCards();
              });
            },
          ),
          IconButton(
            tooltip: 'Toggle 200-Char Long Text',
            icon: Icon(_useLongTextItem ? Icons.text_fields_rounded : Icons.short_text_rounded),
            onPressed: () {
              setState(() {
                _useLongTextItem = !_useLongTextItem;
                _loadCards();
              });
            },
          ),
          IconButton(
            tooltip: 'Toggle Theme',
            icon: Icon(
              myApp?.isDarkMode ?? true
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
            onPressed: () {
              myApp?.toggleTheme();
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isTabletOrWide = width >= 720;

          if (isTabletOrWide) {
            // Structural Breakpoint >= 720dp (Tablet / Wide Landscape): Split layout
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Sticky Sidebar (Header, Search, Filters)
                  SizedBox(
                    width: 300,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VaultHeaderCard(
                            totalValue: _totalValue,
                            totalCards: _cards.length,
                          ),
                          const SizedBox(height: 16),
                          VaultSearchBar(
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          CategoryFilterChips(
                            selectedCategory: _selectedCategory,
                            onCategorySelected: (category) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Right Main Grid Content Area
                  Expanded(
                    child: _filteredCards.isEmpty
                        ? EmptyStateView(onActionPressed: _resetFilters)
                        : GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: width >= 1000 ? 4 : 3,
                              childAspectRatio: 0.72,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: _filteredCards.length,
                            itemBuilder: (context, index) {
                              final card = _filteredCards[index];
                              return CardGridTile(
                                card: card,
                                onFavoriteToggle: () {
                                  setState(() {
                                    _cards[index] = card.copyWith(
                                      isFavorite: !card.isFavorite,
                                    );
                                  });
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          }

          // Mobile / Narrow Phone Layout (< 720dp)
          final crossAxisCount = width < 360 ? 2 : (width < 500 ? 2 : 3);
          final padding = width < 360 ? 10.0 : 16.0;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
                    child: VaultHeaderCard(
                      totalValue: _totalValue,
                      totalCards: _cards.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: VaultSearchBar(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  Padding(
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
                  
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _filteredCards.length,
                    itemBuilder: (context, index) {
                      final card = _filteredCards[index];
                      return CardGridTile(
                        card: card,
                        onFavoriteToggle: () {
                          setState(() {
                            _cards[index] = card.copyWith(
                              isFavorite: !card.isFavorite,
                            );
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
