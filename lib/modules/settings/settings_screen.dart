import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/bloc/shop_cubit/shop_cubit.dart';
import 'package:shop/shared/components/components.dart';

import '../../shared/bloc/shop_cubit/shop_states.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is GetUserProfileSuccessState){
          ShopCubit.get(context).userProfileNameController.text=state.loginModel!.data!.name!;
          ShopCubit.get(context).userProfileEmailController.text=state.loginModel!.data!.email!;
          ShopCubit.get(context).userProfilePhoneController.text=state.loginModel!.data!.phone!;
        }
      },
      builder: (context,state){
        var model=ShopCubit.get(context).profileModel;
        ShopCubit.get(context).userProfileNameController.text=model!.data!.name!;
        ShopCubit.get(context).userProfileEmailController.text=model.data!.email!;
        ShopCubit.get(context).userProfilePhoneController.text=model.data!.phone!;
        return Scaffold(
            appBar: AppBar(),
            body: ShopCubit.get(context).profileModel==null?
            const Center(child: CircularProgressIndicator(),)
                :Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: ShopCubit.get(context).formKey,
                child: Column(
                  children: [
                    if(state is UpdateUserProfileLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 20,),
                    textFormFieldCustom(
                      controller: ShopCubit.get(context).userProfileNameController,
                        label: 'Name',
                        prefix: Icons.person,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Name Can\'t be Empty';
                          }
                        }
                    ),
                    const SizedBox(height: 20,),
                    textFormFieldCustom(
                      controller: ShopCubit.get(context).userProfileEmailController,
                        label: 'Email',
                        prefix: Icons.email,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Email Can\'t be Empty';}
                        }
                    ),
                    const SizedBox(height: 20,),
                    textFormFieldCustom(
                      controller:ShopCubit.get(context).userProfilePhoneController,
                        label: 'Phone',
                        prefix: Icons.phone,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Phone Can\'t be Empty';}
                        }
                    ),
                  const SizedBox(height: 20,),
                    buildingElevatedButton(onPressed:(){
                      if(ShopCubit.get(context).formKey.currentState!.validate()){
                        ShopCubit.get(context).updateUserProfile(
                            name:ShopCubit.get(context).userProfileNameController.text,
                            phone:ShopCubit.get(context).userProfilePhoneController.text,
                            email:ShopCubit.get(context).userProfileEmailController.text);
                      }
                    },buttonLabel: 'Update'),
                    const SizedBox(height:10,),
                    buildingElevatedButton(onPressed:(){
                      signOut(context);
                    },buttonLabel: 'Log out'),
                  ],
                ),
              ),
            )
        );
      },

    );
  }
}