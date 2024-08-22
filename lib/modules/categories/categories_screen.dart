import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_states.dart';
import 'package:shop/shared/components/components.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=>categoryScreenItem(model: ShopCubit.get(context).categoriesModel?.data?.data?[index]),
            separatorBuilder:(context,index)=>Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(height: 2,width: double.infinity,color:Colors.grey,),
        ), itemCount:ShopCubit.get(context).categoriesModel?.data?.data?.length??0);
      },
    );
  }
}