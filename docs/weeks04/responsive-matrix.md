# H1 — Responsive Matrix Pass Report

**App Screen Audited**: `TCG Vault Screen` (`TcgVaultScreen`)  
**Directory**: `weeks04/h1`  
**Test Suite**: `test/responsive_test.dart` (9/9 tests passed)

---

## 📊 Responsive Test Matrix

| Screen | Test | Status | How Tested / Verification | Fixes / Implementations Applied |
| :--- | :--- | :---: | :--- | :--- |
| **TCG Vault Screen** | **Small phone** | `PASS` | Emulator / View at 320 dp width | Used `LayoutBuilder` with 2 compact columns, adjusted horizontal padding (10dp), and wrapped `VaultHeaderCard` values in `FittedBox` / `maxLines`. |
| **TCG Vault Screen** | **Large phone** | `PASS` | Emulator / View at 430 dp width | Applied responsive 2-3 column grid with 16dp outer padding and balanced aspect ratios (`childAspectRatio: 0.7`). |
| **TCG Vault Screen** | **Tablet** | `PASS` | Emulator / View at 800 dp width | **Structural Breakpoint Change**: Responsive layout shifts from 1-column flow to a dual-pane split layout with a sticky 300dp sidebar (Header, Search, Filters) and a 4-column card grid. |
| **TCG Vault Screen** | **Landscape** | `PASS` | Rotated screen at 800×400 & 640×320 dp | Used `CustomScrollView` and scrollable sidebars to allow smooth vertical scrolling without bottom overflow warnings. |
| **TCG Vault Screen** | **Long text** | `PASS` | Item name with 200 characters | Enforced `maxLines: 2` with `overflow: TextOverflow.ellipsis` on card titles, `maxLines: 1` on set names, and `maxLines: 1` on prices. |
| **TCG Vault Screen** | **Empty state** | `PASS` | Query yielding 0 items | Created `EmptyStateView` containing a search icon, descriptive message ("No Cards Found"), and an action button ("Reset Filters"). |
| **TCG Vault Screen** | **Long list** | `PASS` | 500 items dataset rendered | Implemented high-performance lazy loading via `SliverGrid` and `GridView.builder` with `SliverChildBuilderDelegate`. **Zero usage of `shrinkWrap: true`**. |
| **TCG Vault Screen** | **Keyboard** | `PASS` | Search textfield focused on short screen (400dp height) | Search bar is hosted inside `CustomScrollView` / scrollable viewport with native `resizeToAvoidBottomInset`, maintaining focused textfield visibility. |
| **TCG Vault Screen** | **Dark mode** | `PASS` | Switched between Light and Dark themes | Configured full Material 3 `darkColorScheme` and `lightColorScheme` in `AppTheme`, ensuring high text contrast (`onSurface`, `onSurfaceVariant`) in both modes. |

---
