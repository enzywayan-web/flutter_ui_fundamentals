
import 'favorites_page.dart';
import 'value_notifier_demo.dart';
import 'course_state_demo.dart';
import 'course_provider_demo.dart';
import 'course_model_demo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/course_provider.dart' as app_provider;

const String studentName = 'Ni Wayan Enzy Ariantini';
const String studentId = '2415051070';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => app_provider.CourseProvider(),
      child: const CourseExplorerApp(),
    ),
  );
}

// =====================================================
// APP
// =====================================================

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/favorites-experiment': (context) => const FavoritesPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const ResponsiveShell(),
    );
  }
}

// =====================================================
// DATA COURSE
// =====================================================

final List<Map<String, dynamic>> courses = [
  {
    'name': 'Pemrograman Mobile',
    'code': 'TIK19505',
    'sks': 3,
    'status': 'Sedang Dipelajari',
  },
  {
    'name': 'Manajemen dan Kepemimpinan',
    'code': 'TIK19506',
    'sks': 2,
    'status': 'Sedang Dipelajari',
  },
  {
    'name': 'Pengolahan Citra Digital',
    'code': 'TIK19504',
    'sks': 3,
    'status': 'Sedang Dipelajari',
  },
  {
    'name': 'Pemrograman Berbasis Web',
    'code': 'TIK19507',
    'sks': 3,
    'status': 'Sedang Dipelajari',
  },
  {
    'name': 'Kecerdasan Buatan',
    'code': 'TIK19508',
    'sks': 3,
    'status': 'Belum Selesai',
  },
  {
    'name': 'Jaringan Komputer',
    'code': 'TIK19509',
    'sks': 3,
    'status': 'Selesai',
  },
];

// =====================================================
// RESPONSIVE SHELL
// =====================================================

class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    CoursesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool expanded = constraints.maxWidth >= 840;

        if (expanded) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.menu_book_outlined),
                      selectedIcon: Icon(Icons.menu_book),
                      label: Text('Courses'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outlined),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Column(
                    children: [
                      AppBar(
                        title: const Text('Course Explorer'),
                      ),
                      Expanded(
                        child: pages[selectedIndex],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Course Explorer'),
          ),
          body: pages[selectedIndex],
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                selectedIcon: Icon(Icons.menu_book),
                label: 'Courses',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outlined),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}

// =====================================================
// REUSABLE IDENTITY CARD
// =====================================================

class IdentityCard extends StatelessWidget {
  const IdentityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              child: Icon(Icons.person),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studentName,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text('NIM: $studentId'),
                  const SizedBox(height: 4),
                  const Text('Pendidikan Teknik Informatika'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// HOME PAGE - LOCAL STATE
// =====================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // LOCAL STATE: hanya digunakan pada halaman Home.
  bool showDetail = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IdentityCard(),
          const SizedBox(height: 20),
          Text(
            'Selamat Datang 👋',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Course Explorer digunakan untuk melihat daftar course '
            'dan informasi pembelajaran secara responsif.',
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.devices, size: 42),
                  const SizedBox(height: 12),
                  Text(
                    'Responsive Layout',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tampilan akan menyesuaikan ukuran layar. '
                    'Pada layar kecil menggunakan NavigationBar, '
                    'sedangkan layar lebar menggunakan NavigationRail.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // TOMBOL UNTUK MENGUBAH LOCAL STATE
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contoh Local State',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tekan tombol untuk menampilkan atau '
                    'menyembunyikan detail.',
                  ),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: () {
                      setState(() {
                        showDetail = !showDetail;
                      });
                    },
                    icon: Icon(
                      showDetail
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    label: Text(
                      showDetail
                          ? 'Sembunyikan Detail'
                          : 'Lihat Detail',
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Eksperimen ValueNotifier, CourseState, CourseProvider, dan CourseModel Demo
                  const ValueNotifierDemoCard(),
                  const SizedBox(height: 16),
                  const CourseStateDemo(),
                  const SizedBox(height: 16),
                  const CourseProviderDemo(),
                  const SizedBox(height: 16),
                  const CourseModelDemo(),
                  const SizedBox(height: 16),

                  FilledButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/favorites-experiment',
                      );
                    },
                    icon: const Icon(Icons.favorite),
                    label: const Text('Eksperimen Prop Drilling'),
                  ),
                  if (showDetail) ...[
                    const SizedBox(height: 12),
                    const Divider(),
                    const Text(
                      'Detail Course Explorer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Aplikasi ini menampilkan daftar mata kuliah, '
                      'informasi course, status favorit, dan profil '
                      'mahasiswa. Nilai showDetail hanya mengatur '
                      'tampilan detail pada halaman Home.',
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ),
              );
            },
            icon: const Icon(Icons.info_outline),
            label: const Text('Lihat Informasi'),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// COURSES PAGE
// =====================================================

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  // Single source of truth: status favorit disimpan di parent.
  final Set<String> favorites = <String>{};

  void toggleFavorite(String courseName) {
    setState(() {
      if (favorites.contains(courseName)) {
        favorites.remove(courseName);
      } else {
        favorites.add(courseName);
      }
    });
  }

  void openCourseDetail(Map<String, dynamic> course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetailPage(course: course),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Widget pertama membaca state dari parent.
        Card(
          margin: const EdgeInsets.all(16),
          child: ListTile(
            leading: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            title: const Text('Ringkasan Favorit'),
            subtitle: Text(
              'Jumlah course favorit: ${favorites.length}',
            ),
            trailing: Text('${favorites.length}/${courses.length}'),
          ),
        ),

        // Widget kedua menerima state yang sama melalui constructor.
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isCompact = constraints.maxWidth < 600;

              if (isCompact) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    final String courseName =
                        course['name'].toString();

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CourseCard(
                        course: course,
                        isFavorite: favorites.contains(courseName),
                        onFavorite: () {
                          toggleFavorite(courseName);
                        },
                        onTap: () {
                          openCourseDetail(course);
                        },
                      ),
                    );
                  },
                );
              }

              final int columnCount =
                  constraints.maxWidth >= 840 ? 3 : 2;

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: courses.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columnCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.45,
                ),
                itemBuilder: (context, index) {
                  final course = courses[index];
                  final String courseName =
                      course['name'].toString();

                  return CourseCard(
                    course: course,
                    isFavorite: favorites.contains(courseName),
                    onFavorite: () {
                      toggleFavorite(courseName);
                    },
                    onTap: () {
                      openCourseDetail(course);
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// =====================================================
// REUSABLE COURSE CARD
// =====================================================

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Informasi Course'),
                content: Text(
                  '${course['name']}\n'
                  'Kode: ${course['code']}\n'
                  'SKS: ${course['sks']}',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Tutup'),
                  ),
                ],
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.book),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onFavorite,
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                course['name'].toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text('Kode: ${course['code']}'),
              Text('SKS: ${course['sks']}'),
              Text('Status: ${course['status']}'),
              const Spacer(),
              Text(
                isFavorite ? 'Sudah difavoritkan' : 'Belum difavoritkan',
                style: TextStyle(
                  color: isFavorite ? Colors.red : null,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// COURSE DETAIL PAGE
// =====================================================

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IdentityCard(),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.menu_book, size: 50),
                    const SizedBox(height: 16),
                    Text(
                      course['name'].toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text('Kode Course: ${course['code']}'),
                    const SizedBox(height: 8),
                    Text('Jumlah SKS: ${course['sks']}'),
                    const SizedBox(height: 8),
                    Text('Status: ${course['status']}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Course berhasil dipilih!'),
                  ),
                );
              },
              icon: const Icon(Icons.check),
              label: const Text('Pilih Course'),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// PROFILE + FORM VALIDATION
// =====================================================

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController namaController;
  late final TextEditingController nimController;
  final TextEditingController komentarController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    namaController = TextEditingController(text: studentName);
    nimController = TextEditingController(text: studentId);
  }

  @override
  void dispose() {
    namaController.dispose();
    nimController.dispose();
    komentarController.dispose();
    super.dispose();
  }

  void submitFeedback() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Feedback'),
          content: const Text(
            'Apakah data feedback sudah benar?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Feedback berhasil disimpan'),
                  ),
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IdentityCard(),
          const SizedBox(height: 20),
          Text(
            'Feedback',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: nimController,
                  decoration: const InputDecoration(
                    labelText: 'NIM',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'NIM wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: komentarController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Komentar',
                    hintText: 'Masukkan komentar minimal 5 karakter',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Komentar wajib diisi';
                    }

                    if (value.trim().length < 5) {
                      return 'Komentar minimal 5 karakter';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: submitFeedback,
                    icon: const Icon(Icons.send),
                    label: const Text('Kirim Feedback'),
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

// =====================================================
// ABOUT PAGE
// =====================================================

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const IdentityCard(),
            const SizedBox(height: 20),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.devices, size: 60),
                    SizedBox(height: 16),
                    Text(
                      'Responsive Course Explorer',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Aplikasi ini dibuat untuk menerapkan '
                      'responsive layout, navigation, interaction, '
                      'form validation, dan feedback pada Flutter.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}