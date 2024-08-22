import 'package:shop/model/register_model/register_model.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  RegisterModel? registerModel;
  RegisterSuccessState({this.registerModel});
}
class RegisterErrorState extends RegisterStates{}
class ChangePasswordSuffixIconState extends RegisterStates{}