import 'package:flutter/material.dart';

const String studentName = 'Ni Wayan Enzy Ariantini';
const String studentId = '2415051070';

void main() {
  runApp(const CourseExplorerApp());
}

class CourseExplorerApp extends StatelessWidget {
  const CourseExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

// =========================
// RESPONSIVE SHELL
// =========================

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

  final List<String> titles = const [
    'Course Explorer',
    'Courses',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Expanded → NavigationRail
        if (constraints.maxWidth >= 840) {
          return Scaffold(
            appBar: AppBar(
              title: Text(titles[selectedIndex]),
            ),
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
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: pages[selectedIndex],
                ),
              ],
            ),
          );
        }

        // Compact / Medium → NavigationBar
        return Scaffold(
          appBar: AppBar(
            title: Text(titles[selectedIndex]),
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
                icon: Icon(Icons.person_outline),
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

// =========================
// HOME PAGE
// =========================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IdentityCard(),

          const SizedBox(height: 20),

          const Text(
            'Selamat Datang 👋',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Course Explorer merupakan aplikasi sederhana '
            'untuk melihat daftar course dan informasi detailnya.',
            style: TextStyle(fontSize: 16),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  const Icon(
                    Icons.school,
                    size: 45,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Course Explorer',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Belajar dan menjelajahi berbagai course.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================
// IDENTITY WIDGET
// =========================

class IdentityCard extends StatelessWidget {
  const IdentityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Identitas Mahasiswa',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Nama: $studentName'),
            Text('NIM: $studentId'),
          ],
        ),
      ),
    );
  }
}

// =========================
// DATA COURSE
// =========================

final List<Map<String, dynamic>> courses = [
  {
    'name': 'Pemrograman Mobile',
    'code': 'TIK20504',
    'sks': 3,
    'description': 'Mempelajari pengembangan aplikasi mobile.',
  },
  {
    'name': 'Pengolahan Citra Digital',
    'code': 'TIK19504',
    'sks': 3,
    'description': 'Mempelajari pengolahan dan analisis citra digital.',
  },
  {
    'name': 'Manajemen dan Kepemimpinan',
    'code': 'MKK204',
    'sks': 2,
    'description': 'Mempelajari dasar manajemen dan kepemimpinan.',
  },
  {
    'name': 'Pemrograman Berbasis Web',
    'code': 'TIK20404',
    'sks': 3,
    'description': 'Mempelajari pengembangan aplikasi berbasis web.',
  },
  {
    'name': 'Jaringan Komputer',
    'code': 'TIK20304',
    'sks': 3,
    'description': 'Mempelajari konsep dasar jaringan komputer.',
  },
  {
    'name': 'Kecerdasan Buatan',
    'code': 'TIK20604',
    'sks': 3,
    'description': 'Mempelajari konsep dan penerapan kecerdasan buatan.',
  },
];

// =========================
// COURSES PAGE
// =========================

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final Map<int, bool> favoriteStatus = {};

  void toggleFavorite(int index) {
    setState(() {
      favoriteStatus[index] =
          !(favoriteStatus[index] ?? false);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          favoriteStatus[index] == true
              ? 'Course ditambahkan ke favorite'
              : 'Course dihapus dari favorite',
        ),
      ),
    );
  }

  void openDetail(Map<String, dynamic> course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CourseDetailPage(course: course),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact =
            constraints.maxWidth < 600;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IdentityCard(),

              const SizedBox(height: 20),

              const Text(
                'Daftar Course',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // Compact → List
              if (isCompact)
                ListView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return CourseCard(
                      course: courses[index],
                      isFavorite:
                          favoriteStatus[index] ?? false,
                      onTap: () =>
                          openDetail(courses[index]),
                      onFavorite: () =>
                          toggleFavorite(index),
                    );
                  },
                )

              // Medium / Expanded → Grid
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        constraints.maxWidth >= 840
                            ? 3
                            : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.35,
                  ),
                  itemBuilder: (context, index) {
                    return CourseCard(
                      course: courses[index],
                      isFavorite:
                          favoriteStatus[index] ?? false,
                      onTap: () =>
                          openDetail(courses[index]),
                      onFavorite: () =>
                          toggleFavorite(index),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

// =========================
// COURSE CARD WIDGET
// =========================

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const CourseCard({
    super.key,
    required this.course,
    required this.isFavorite,
    required this.onTap,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(course['name']),
                content: Text(
                  course['description'],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.book),
                  const Spacer(),
                  IconButton(
                    onPressed: onFavorite,
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                  ),
                ],
              ),

              Text(
                course['name'],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Text('Kode: ${course['code']}'),
              Text('SKS: ${course['sks']}'),

              const SizedBox(height: 8),

              const Text(
                'Tekan untuk melihat detail',
                style: TextStyle(
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

// =========================
// COURSE DETAIL
// =========================

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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const IdentityCard(),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      course['name'],
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'Kode: ${course['code']}',
                    ),

                    Text(
                      'SKS: ${course['sks']}',
                    ),

                    const SizedBox(height: 15),

                    Text(
                      course['description'],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Course berhasil dipilih!',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.check),
              label: const Text('Pilih Course'),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// PROFILE + FEEDBACK
// =========================

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() =>
      _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();

  final namaController =
      TextEditingController(text: studentName);

  final nimController =
      TextEditingController(text: studentId);

  final komentarController =
      TextEditingController();

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
          title: const Text('Konfirmasi'),
          content: const Text(
            'Apakah feedback ingin disimpan?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Feedback berhasil disimpan',
                    ),
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
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const IdentityCard(),

            const SizedBox(height: 20),

            const Text(
              'Feedback',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Nama wajib diisi';
                }
                return null;
              },
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'NIM wajib diisi';
                }
                return null;
              },
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: komentarController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Komentar',
                hintText:
                    'Minimal 5 karakter',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Komentar wajib diisi';
                }

                if (value.trim().length < 5) {
                  return 'Minimal 5 karakter';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: submitFeedback,
                icon: const Icon(Icons.send),
                label: const Text(
                  'Kirim Feedback',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}