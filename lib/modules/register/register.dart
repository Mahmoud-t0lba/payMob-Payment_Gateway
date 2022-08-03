import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/modules/payment/cubit/pay_ment_cubit.dart';
import 'package:payment/modules/payment/cubit/pay_ment_state.dart';
import 'package:payment/modules/payment/toggle.dart';
import 'package:payment/shared/components/components.dart';
import 'package:payment/shared/components/constants.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    return BlocProvider(
      create: (context) => PayMentCubit(),
      child: BlocConsumer<PayMentCubit, PayMentStates>(
        listener: (context, state) {
          if (state is PayMentRefCodeSuccessState) {
            navigateAndFinish(context, const ToggleScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: payColor,
              elevation: 0,
              title: const Text('PayMent integration'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 30,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: defaultFormField(
                          controller: firstNameController,
                          label: 'First Name',
                          type: TextInputType.name,
                          validate: 'Please Enter your first name',
                          prefix: Icons.person,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        child: defaultFormField(
                          controller: lastNameController,
                          label: 'Last Name',
                          type: TextInputType.name,
                          validate: 'Please Enter your last name',
                          prefix: Icons.person,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        child: defaultFormField(
                          controller: emailController,
                          label: 'Email',
                          type: TextInputType.emailAddress,
                          validate: 'Please Enter your email address',
                          prefix: Icons.email,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        child: defaultFormField(
                          controller: phoneController,
                          label: 'phone number',
                          type: TextInputType.name,
                          validate: 'Please Enter your phone number',
                          prefix: Icons.phone,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        child: defaultFormField(
                          controller: priceController,
                          label: 'Price',
                          type: TextInputType.name,
                          validate: 'Please Enter your price',
                          prefix: Icons.price_check,
                        ),
                      ),
                      const SizedBox(height: 20),
                      defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            PayMentCubit.get(context).getFirstToken(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              price: priceController.text,
                            );
                          }
                        },
                        text: 'Go To Pay',
                        radius: 20,
                        width: 300,
                        background: payColor,
                      ),
                    ],
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
