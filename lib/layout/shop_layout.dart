import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/search/search_screen.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_states.dart';
import 'package:shop/shared/components/components.dart';
class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed:(){
                navigateTo(context,const SearchScreen());
              }, icon:const Icon(Icons.search))
            ],
            title: const Text('Salla'),
          ),
          bottomNavigationBar:BottomNavigationBar(
            currentIndex:ShopCubit.get(context).currentIndex,
            onTap: (index){
              ShopCubit.get(context).changeBottomNavBarIndex(index);
            },
            items:const [
               BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Home'),
              BottomNavigationBarItem(icon:Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon:Icon(Icons.favorite),label: 'Favourites'),
              BottomNavigationBarItem(icon:Icon(Icons.settings),label: 'Settings'),
            ],
          ),
          body:ShopCubit.get(context).bottomNavBarScreens[ShopCubit.get(context).currentIndex]
        );
      },
    );
  }
}
