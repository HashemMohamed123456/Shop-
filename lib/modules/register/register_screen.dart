import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/bloc/register_cubit/register_cubit.dart';
import 'package:shop/shared/bloc/register_cubit/register_states.dart';
import 'package:shop/shared/network/local/shared_keys/shared_keys.dart';
import '../../layout/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper/cache_helper.dart';
import '../login/login_screen.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterSuccessState){
            if(state.registerModel?.status==true){
              showToast(message:state.registerModel?.message??'', state:ToastStates.success);
              CacheHelper.setData(key: 'token', value:state.registerModel?.data?.token)?.then((value){
                SharedKeys.token=state.registerModel?.data?.token;
                navigateToAndFinish(context,const ShopLayout());
              });

            }else{
              showToast(message:state.registerModel?.message??'', state:ToastStates.error);
            }
          }

        },
        builder: (context,state){
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: RegisterCubit.get(context).formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('REGISTER',style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),),Text('Register Now To Browse Our Hot Offers',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),),
                          const SizedBox(height: 40,),
                          textFormFieldCustom(
                              controller: RegisterCubit.get(context).nameController,
                              label: 'Name',
                              keyboardType: TextInputType.name,
                              prefix:Icons.person,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Name Can\'t be Empty';
                                }
                                return null;
                              }),
                          const SizedBox(height: 20,),
                          textFormFieldCustom(
                              controller: RegisterCubit.get(context).phoneController,
                              label: 'Phone',
                              keyboardType: TextInputType.phone,
                              prefix:Icons.email_outlined,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Phone Number Can\'t be Empty';
                                }
                                return null;
                              }),
                          const SizedBox(height: 20,),
                          textFormFieldCustom(
                              controller: RegisterCubit.get(context).emailController,
                              label: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              prefix:Icons.email_outlined,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Email Can\'t be Empty';
                                }
                                return null;
                              }),
                          const SizedBox(height: 20,),
                          textFormFieldCustom(
                              obscureText:RegisterCubit.get(context).isPassword,
                              onFieldSubmitted: (value){
                                if(RegisterCubit.get(context).formKey.currentState!.validate()){
                                  RegisterCubit.get(context).userRegister(
                                      email:RegisterCubit.get(context).emailController.text,
                                      password:RegisterCubit.get(context).passwordController.text,
                                      name:RegisterCubit.get(context).nameController.text,
                                      phone:RegisterCubit.get(context).phoneController.text
                                  );
                                }
                              },
                              controller:RegisterCubit.get(context).passwordController,
                              label: 'Password',
                              keyboardType: TextInputType.visiblePassword,
                              suffix:RegisterCubit.get(context).passwordSuffix,
                              prefix: Icons.lock_outline_rounded,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Password Can\'t be Empty';
                                }
                                return null;
                              },
                              onSuffixPressed: (){
                                RegisterCubit.get(context).changePasswordSuffixIcon();
                              }),
                          const SizedBox(height: 30,),
                          (state is RegisterLoadingState)?
                          const Center(child: CircularProgressIndicator(color: Colors.deepOrange,),):
                          buildingElevatedButton(onPressed:(){
                            if(RegisterCubit.get(context).formKey.currentState!.validate()){
                              RegisterCubit.get(context).userRegister
                                (name: RegisterCubit.get(context).nameController.text,
                                  phone: RegisterCubit.get(context).phoneController.text,
                                  email:RegisterCubit.get(context).emailController.text,
                                  password:RegisterCubit.get(context).passwordController.text);
                            }
                          },buttonLabel: 'Register'),
                          const SizedBox(height: 20,),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(' Have an Account?',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ) ,),
                              TextButton(onPressed:(){
                                navigateTo(context,const LoginScreen());
                              }, child:const Text('Login',style: TextStyle(color: Colors.deepOrange),))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          );
        },
      ),
    );
  }
}
