import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/modules/payment/cubit/pay_ment_state.dart';
import 'package:payment/shared/components/constants.dart';
import 'package:payment/shared/network/dio.dart';
import 'package:payment/shared/network/end_point.dart';

class PayMentCubit extends Cubit<PayMentStates> {
  PayMentCubit() : super(PayMentInitialState());

  static PayMentCubit get(context) => BlocProvider.of(context);

  /// ========================================================

  Future getFirstToken({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String price,
  }) async {
    DioHelper.postData(
      url: firstToken,
      data: {
        'api_key': payMobApiKey,
      },
    ).then((value) {
      payMobToken = value.data['token'];
      print('first Token <<<< $payMobToken >>>>');
      getOrderId(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        price: price,
      );
      emit(PayMentSuccessState());
    }).catchError(
      (error) {
        emit(PayMentErrorState(error.toString()));
      },
    );
  }

  /// ========================================================

  Future getOrderId({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String price,
  }) async {
    DioHelper.postData(
      url: orderId,
      data: {
        'auth_token': payMobToken,
        'delivery_needed': 'false',
        'amount_cents': price,
        'currency': 'EGP',
        'items': [],
      },
    ).then((value) {
      payMobOrderId = value.data['id'].toString();
      print('Order id <<<< $payMobOrderId >>>>');
      getFinalTokenCard(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        price: price,
      );
      getFinalTokenKiosk(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        price: price,
      );
      emit(PayMentOrderIDSuccessState());
    }).catchError(
      (error) {
        emit(PayMentOrderIDErrorState(error.toString()));
      },
    );
  }

  /// ========================================================

  Future getFinalTokenCard({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String price,
  }) async {
    DioHelper.postData(
      url: finalToken,
      data: {
        'auth_token': payMobToken,
        'amount_cents': price,
        'expiration': 3600,
        'order_id': payMobOrderId,
        'billing_data': {
          'apartment': 'NA',
          'email': email,
          'floor': 'NA',
          'first_name': firstName,
          'street': 'NA',
          'building': 'NA',
          'phone_number': phone,
          'shipping_method': 'NA',
          'postal_code': 'NA',
          'city': 'NA',
          'country': 'NA',
          'last_name': lastName,
          'state': 'NA'
        },
        'currency': 'EGP',
        'integration_id': integrationIdCard,
        'lock_order_when_paid': 'false'
      },
    ).then((value) {
      payMobFinalToken = value.data['token'].toString();
      print('final token card <<<< $payMobFinalToken >>>>');
      emit(PayMentRequestTokenSuccessState());
    }).catchError(
      (error) {
        emit(PayMentRequestTokenErrorState(error.toString()));
      },
    );
  }

  /// ========================================================

  Future getFinalTokenKiosk({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String price,
  }) async {
    DioHelper.postData(
      url: finalToken,
      data: {
        'auth_token': payMobToken,
        'amount_cents': price,
        'expiration': 3600,
        'order_id': payMobOrderId,
        'billing_data': {
          'apartment': 'NA',
          'email': email,
          'floor': 'NA',
          'first_name': firstName,
          'street': 'NA',
          'building': 'NA',
          'phone_number': phone,
          'shipping_method': 'NA',
          'postal_code': 'NA',
          'city': 'NA',
          'country': 'NA',
          'last_name': lastName,
          'state': 'NA'
        },
        'currency': 'EGP',
        'integration_id': integrationIdKiosk,
        'lock_order_when_paid': 'false'
      },
    ).then((value) {
      payMobFinalTokenKiosk = value.data['token'];
      print('final token kiosk <<<< $payMobFinalTokenKiosk >>>>');
      getRefCode();
      emit(PayMentRequestKioskSuccessState());
    }).catchError(
      (error) {
        emit(PayMentRequestKioskErrorState(error.toString()));
      },
    );
  }

  /// ========================================================

  Future getRefCode() async {
    DioHelper.postData(
      url: recCode,
      data: {
        'source': {
          'identifier': 'AGGREGATOR',
          'subtype': 'AGGREGATOR',
        },
        'payment_token': payMobFinalTokenKiosk,
      },
    ).then((value) {
      refCode = value.data['id'].toString();
      print('Ref Code <<<< $refCode >>>>');
      emit(PayMentRefCodeSuccessState());
    }).catchError(
      (error) {
        emit(PayMentRefCodeErrorState(error.toString()));
      },
    );
  }

  /// ========================================================

  /// ========================================================
}
