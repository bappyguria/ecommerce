
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/screens/auth/login/bloc/login_bloc.dart';
import 'features/screens/auth/pin/bloc/pin_bloc.dart';
import 'features/screens/auth/signup/bloc/signup_bloc.dart';
import 'features/screens/home/categories/bloc/category_bloc.dart';
import 'features/screens/home/categories/bloc/category_event.dart';
import 'features/screens/home/home_screen.dart';
import 'features/screens/home/product_list/bloc/product_list_bloc.dart';
import 'features/screens/home/slider/bloc/slider_bloc.dart';
import 'features/screens/home/slider/bloc/slider_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox('authBox'); // 🔐 auth data
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
        BlocProvider<PinVerificationBloc>(
          create: (context) => PinVerificationBloc(),
        ),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<SliderBloc>(
          create: (context) => SliderBloc()..add(LoadSliderEvent()),
        ),
        BlocProvider<CategoryBloc>(create: (context) => CategoryBloc()),
        BlocProvider(
          create: (_) => CategoryBloc()..add(LoadCategories()),
          child: HomeScreen(),
        ),
        BlocProvider<ProductListBloc>(create: (context) => ProductListBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce App',
        theme: appTheme(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
