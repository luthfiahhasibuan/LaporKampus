import 'package:flutter/material.dart';

void main() {
  runApp(const LaporBuDekanApp());
}

class LaporBuDekanApp extends StatelessWidget {
  const LaporBuDekanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lapor Pak Rektor',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF455B8A)),
      ),
      home: const HomePage(),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  static const Color primaryColor = Color(0xFF4E693E);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color backgroundColor = Color(0xFFF7F7F2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // BODY
      body: SafeArea(
        child: Column(
          children: [
            // HEADER

            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // WELCOME CARD
                      _buildWelcomeCard(),

                      const SizedBox(height: 25),

                      // STATISTICS
                      _buildStatistics(),

                      const SizedBox(height: 30),

                      // TULIS LAPORAN BARU
                      _buildMenuCard(
                        icon: Icons.edit_square,
                        title: 'Tulis Laporan Baru',
                        subtitle: 'Sampaikan keluhan dan aspirasi anda',
                        onTap: () {
                          _showMessage('Membuka halaman laporan baru');
                        },
                      ),

                      const SizedBox(height: 20),

                      // LIHAT LAPORAN SAYA
                      _buildMenuCard(
                        icon: Icons.format_list_bulleted,
                        title: 'Lihat Laporan Saya',
                        subtitle: 'Pantau status semua laporan anda',
                        onTap: () {
                          _showMessage('Membuka laporan saya');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: _buildBottomNavigation(),

      // FLOATING BUTTON
      floatingActionButton: SizedBox(
        width: 58,
        height: 58,
        child: FloatingActionButton(
          onPressed: () {
            _showMessage('Tulis laporan baru');
          },
          backgroundColor: const Color(0xff4E693E),
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // HEADER

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(80, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Judul
          const Text(
            'LAPOR KAMPUS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff252A1C),
            ),
          ),

          // Avatar
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE5EAF2),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Text('👨🏻‍💼', style: TextStyle(fontSize: 25)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selamat datang..',
            style: TextStyle(color: Color(0xff6B705C), fontSize: 16),
          ),

          const SizedBox(height: 4),

          const Text(
            'Halo, Luthfi!',
            style: TextStyle(
              color: Color(0xff2D4030),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Sampaikan laporan atau aspirasi kamu\n'
            'kepada pihak Konoha University',
            style: TextStyle(
              color: Color(0xff6B705C),
              fontSize: 16,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Row(
      children: [
        // TOTAL
        Expanded(
          child: _buildStatisticCard(
            icon: Icons.folder,
            number: '0',
            label: 'Total',
          ),
        ),

        const SizedBox(width: 40),

        // TERKIRIM
        Expanded(
          child: _buildStatisticCard(
            icon: Icons.send,
            number: '0',
            label: 'Terkirim',
          ),
        ),

        const SizedBox(width: 40),

        // DITANGGAPI
        Expanded(
          child: _buildStatisticCard(
            icon: Icons.check_circle,
            number: '0',
            label: 'Ditanggapi',
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticCard({
    required IconData icon,
    required String number,
    required String label,
  }) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Color(0xff4E693E), size: 21),

          const SizedBox(height: 4),

          Text(
            number,
            style: const TextStyle(
              color: Color(0xff252A1C),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 1),

          Text(
            label,
            style: const TextStyle(color: Color(0xff6B705C), fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // ICON

            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: Color(0xff4E693E), size: 27),
            ),

            const SizedBox(width: 12),

            // TEXT
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BOTTOM NAVIGATION

  Widget _buildBottomNavigation() {
    return Container(
      height: 64,
      decoration: const BoxDecoration(color: primaryColor),
      child: Row(
        children: [
          // -------------------------
          // BERANDA
          // -------------------------
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              child: _buildBottomItem(
                icon: Icons.home,
                label: 'Beranda',
                selected: selectedIndex == 0,
              ),
            ),
          ),

          // SPACE UNTUK FAB
          const SizedBox(width: 70),

          // LAPORAN
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              child: _buildBottomItem(
                icon: Icons.description,
                label: 'Laporan',
                selected: selectedIndex == 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomItem({
    required IconData icon,
    required String label,
    required bool selected,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 21, color: selected ? whiteColor : Colors.white70),

        const SizedBox(height: 2),

        Text(
          label,
          style: TextStyle(
            color: selected ? whiteColor : Colors.white70,
            fontSize: 7,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // SNACKBAR

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
    );
  }
}
