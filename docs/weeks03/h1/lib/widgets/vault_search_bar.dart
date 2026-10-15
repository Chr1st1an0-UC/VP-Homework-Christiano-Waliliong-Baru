import 'package:flutter/material.dart';

class VaultSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const VaultSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      onChanged: onChanged,
      style: TextStyle(color: colorScheme.onSurface, fontSize: 13),
      decoration: InputDecoration(
        hintText: 'Cari kartu...',
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 13),
        prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant, size: 20),
        filled: true,
        fillColor: colorScheme.surfaceContainerLow, // Menggunakan warna Search
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}