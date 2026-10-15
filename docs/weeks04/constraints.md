# H2 — Constraint Diagnosis: 3 Jenis Error Overflow dan Cara Perbaikannya

Dokumen ini berisi diagnosis lengkap dari 3 jenis *layout overflow error* yang umum terjadi pada Flutter beserta aturan *constraint* yang dilanggar dan cara mengatasinya.

---

## 1. Row Horizontal Overflow (`RenderFlex overflowed by X pixels` secara Horizontal)

### Pelanggaran Constraint
Widget anak (*child*) di dalam `Row` memiliki total lebar yang melebihi batas maksimum *horizontal constraints* yang diberikan oleh induknya tanpa dibungkus komponen fleksibel.

### Cara Perbaikan
Membungkus widget teks atau anak yang panjang dengan `Expanded` atau `Flexible` agar ukuran lebarnya menyesuaikan sisa ruang di dalam `Row`.

```dart
// ❌ KODE DENGAN ERROR
Row(
  children: [
    const Text("Teks sangat panjang tanpa pembungkus yang menabrak batas layar kanan"),
    IconButton(icon: Icon(Icons.star), onPressed: () {}),
  ],
)

// ✅ KODE SETELAH DIPERBAIKI
Row(
  children: [
    const Expanded(
      child: Text(
        "Teks aman karena dibungkus Expanded dan terpotong rapi dengan ellipsis",
        overflow: TextOverflow.ellipsis,
      ),
    ),
    IconButton(icon: Icon(Icons.star), onPressed: () {}),
  ],
)
```

---

## 2. Column Vertical Overflow (`RenderFlex overflowed by X pixels` secara Vertikal)

### Pelanggaran Constraint
Total tinggi komponen di dalam `Column` tanpa *scrolling* melebihi batas maksimum *vertical constraints* dari tinggi layar fisik perangkat.

### Cara Perbaikan
Membungkus `Column` dengan `SingleChildScrollView` (atau menggunakan `ListView` / `Sliver` untuk list dinamis) agar konten dapat digulir.

```dart
// ❌ KODE DENGAN ERROR (Tinggi komponen melebihi container/layar)
Container(
  height: 120,
  child: Column(
    children: const [
      Text('Baris 1'), Text('Baris 2'), Text('Baris 3'),
      Text('Baris 4'), Text('Baris 5'), Text('Baris 6 yang meluber keluar!'),
    ],
  ),
)

// ✅ KODE SETELAH DIPERBAIKI
SingleChildScrollView(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text('Baris 1 aman'),
      Text('Baris 2 aman tanpa tinggi tetap kaku'),
    ],
  ),
)
```

---

## 3. Container / SizedBox Fixed Dimension Overflow

### Pelanggaran Constraint
Komponen anak merender diri melebihi batas ukuran statis (`width` dan `height`) yang dipatok secara kaku (*hardcoded*) pada `Container` atau `SizedBox` induknya.

### Cara Perbaikan
Menggunakan `ConstrainedBox` dengan batasan `BoxConstraints` fleksibel atau membungkus konten menggunakan `FittedBox`.

```dart
// ❌ KODE DENGAN ERROR (Container kaku terlalu kecil untuk teks)
Container(
  width: 120,
  height: 30,
  child: const Text("Kotak Container Kaku Terlalu Kecil Untuk Teks Panjang Ini"),
)

// ✅ KODE SETELAH DIPERBAIKI
ConstrainedBox(
  constraints: const BoxConstraints(minWidth: 120, minHeight: 40),
  child: Container(
    padding: const EdgeInsets.all(6),
    child: const FittedBox(
      fit: BoxFit.scaleDown,
      child: Text("Kotak Aman dengan FittedBox"),
    ),
  ),
)
```
