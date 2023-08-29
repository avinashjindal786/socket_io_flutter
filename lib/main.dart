import 'package:flutter/material.dart';
import 'package:flutter_socket_io/providers/login.dart';
import 'package:flutter_socket_io/screens/login.dart';
import 'package:flutter_socket_io/screens/payment_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = 'pk_test_51NGyQySJrQdmVhzxdsl417gXBeM8LKtWJDd5O72Wy40j9u90jnfTwwyFAIxupw6Ykhcd23rmt0jcJ2R6YU3NRw1S00dr0x1o0Q';

  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Socket.IO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: HomeScreen(),
      ),
    );
  }
}
