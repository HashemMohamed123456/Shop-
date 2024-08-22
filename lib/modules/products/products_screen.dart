import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/home_builder.dart';
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is AddProductOrDeleteToFavoritesSuccessState){
          if(!state.model.status!){
            showToast(message: state.model.message!, state:ToastStates.error);
          }else{
            showToast(message: state.model.message!, state:ToastStates.success);
          }
        }
      },
      builder: (context,state){
        return ShopCubit.get(context).homeModel==null?
        const Center(child: CircularProgressIndicator()):
        HomeBuilder(homeModel:ShopCubit.get(context).homeModel,categoriesModel: ShopCubit.get(context).categoriesModel);
      }
      );
  }
}
