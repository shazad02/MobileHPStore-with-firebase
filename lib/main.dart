import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starcell/navigator/navigator_screen.dart';
import 'package:starcell/providers/category_provider.dart';
import 'package:starcell/providers/cekout_provider.dart';
import 'package:starcell/providers/product_provider.dart';
import 'package:starcell/views/screen/cart/cart_screen.dart';
import 'package:starcell/views/screen/cart/selesai_upload.dart';
import 'package:starcell/views/screen/dashboard/dashboard_screen.dart';
import 'package:starcell/views/screen/fav/favorit_screen.dart';
import 'package:starcell/views/screen/intro/intro_screen.dart';
import 'package:starcell/views/screen/login/login_screen.dart';
import 'package:starcell/views/screen/profile/edit_profile.dart';
import 'package:starcell/views/screen/regis2/regis_screen2.dart';
import 'package:starcell/views/screen/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (contex) => ProductProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (contex) => CategoryProvider(),
        ),
        ChangeNotifierProvider<CekProvider>(
          create: (contex) => CekProvider(),
        ),
        // Provider lainnya jika ada
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Apps',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisFullScreen(),
          '/home': (context) => const DashboardScreen(),
          '/favorite': (context) => const FavoritScreen(),
          '/edit': (context) => const EditProfile(),
          '/cart': (context) => const CartScreen(),
          '/navigator': (context) => const NavigatorScreen(),
          '/selesai': (context) => const SelesaiUpload(),
        },
        home: StreamBuilder<User?>(
          stream: authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final user = snapshot.data;
              if (user == null) {
                return const SplashScrren();
              } else {
                return const IntroScreen();
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
