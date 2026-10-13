import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';
import 'statistics_screen.dart';
import 'wallet_screen.dart';
import 'add_transaction_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    StatisticsScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  final List<String> _titles = const [
    'Home',
    'Statistics',
    'Wallet',
    'Profile',
  ];

  Future<void> _openAddTransaction() async {
    await Navigator.push(
        context, 
        MaterialPageRoute(
            builder: (context) => const AddTransactionScreen(),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              // print("Grid icon clicked");
            },
          icon: const Icon(Icons.grid_view_rounded),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
          )
        ],
      ),
      body: _screens[_selectedIndex],

      floatingActionButton: FloatingActionButton(
          onPressed: _openAddTransaction,
          backgroundColor: const Color(0xFF8138F5),
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 32)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, 'Home', 0),
              _navItem(Icons.bar_chart_rounded, 'Statistics', 1),
              const SizedBox(width: 48),
              _navItem(Icons.account_balance_wallet, 'Wallet', 2),
              _navItem(Icons.person_rounded, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }
  Widget _navItem(IconData icon, String label,int index) {
    final selected = _selectedIndex == index;
    final color = selected ? const Color(0xFF8138F5) : Colors.grey;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



