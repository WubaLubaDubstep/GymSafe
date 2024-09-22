import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsafeflutter/blocs/authentication_bloc/authentication_bloc.dart';
// import 'package:gymsafeflutter/blocs/setup_data_bloc/setup_data_bloc.dart';
import 'package:gymsafeflutter/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:gymsafeflutter/screens/home/views/home_screen.dart';
import 'package:gymsafeflutter/screens/profile/profile_screen.dart';

class PersistentTabScreen extends StatefulWidget {
  const PersistentTabScreen({super.key});

  @override
  State<PersistentTabScreen> createState() => _PersistentTabScreenState();
}

class _PersistentTabScreenState extends State<PersistentTabScreen> {
  int _selectedIndex = 0; // Track the selected tab index.
  late Color dynamicColor;

  // List of screens corresponding to each tab.
  final List<Widget> _screens = [
    const HomeScreen(),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInBloc(
            userRepository: context.read<AuthenticationBloc>().userRepository,
          ),
        ),
        // BlocProvider(
        //   create: (context) => SetupDataBloc(
        //     context.read<AuthenticationBloc>().userRepository,
        //   ),
        // )
      ],
      child: const ProfileScreen(),
    ),
  ];

  @override
  void initState() {
    dynamicColor = const Color(0xFFFe3c72);
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      dynamicColor =
          index == 0 ? Theme.of(context).colorScheme.primary : Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(context.read<AuthenticationBloc>().state.user);
    }
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "../../../../assets/tinder_logo.png",
              scale: 16,
              color: dynamicColor,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person_fill,
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
