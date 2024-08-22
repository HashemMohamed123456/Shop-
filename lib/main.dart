import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_layout.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/modules/onboarding/onboarding_screen.dart';
import 'package:shop/shared/bloc/bloc_observer/bloc_observer.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/network/local/cache_helper/cache_helper.dart';
import 'package:shop/shared/network/local/shared_keys/shared_keys.dart';
import 'package:shop/shared/network/remote/Dio_Helper/dio_helper.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  //CacheHelper.clearData();
  Widget? widget;
  SharedKeys.token =CacheHelper.getData(key:'token');
  bool? onboarding=CacheHelper.getData(key:'onBoarding');
  if(onboarding!=null){
    if(SharedKeys.token!=null)widget=ShopLayout();
    else widget=LoginScreen();
  }else{
    widget=const OnboardingScreen();
  }
  runApp(MyApp(onboarding: onboarding,startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final bool? onboarding;
  final Widget? startWidget;
  const MyApp({super.key,this.onboarding,this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategories()..getFavouriteProducts()..getUserProfile())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            elevation: 10,
            selectedItemColor:Colors.deepOrange,
            unselectedItemColor: Colors.blueGrey,
            selectedIconTheme:IconThemeData(
              size: 30
            ),
            unselectedIconTheme: IconThemeData(
              size: 20
            ),
            selectedLabelStyle: TextStyle(
              fontSize: 20,
              color: Colors.deepOrange
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.blueGrey,
              fontSize: 20
            )
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            shape: CircleBorder(),
            backgroundColor: Colors.deepOrange
          ),
          fontFamily: 'Jannah',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(
              color: Colors.black
            )
          ),
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,primary: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: startWidget
      ),
    );
  }
}
