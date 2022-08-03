abstract class PayMentStates {}

class PayMentInitialState extends PayMentStates {}

class PayMentSuccessState extends PayMentStates {}

class PayMentErrorState extends PayMentStates {
  final String error;

  PayMentErrorState(this.error);
}

class PayMentOrderIDSuccessState extends PayMentStates {}

class PayMentOrderIDErrorState extends PayMentStates {
  final String error;

  PayMentOrderIDErrorState(this.error);
}

class PayMentRequestTokenSuccessState extends PayMentStates {}

class PayMentRequestTokenErrorState extends PayMentStates {
  final String error;

  PayMentRequestTokenErrorState(this.error);
}

class PayMentRequestKioskSuccessState extends PayMentStates {}

class PayMentRequestKioskErrorState extends PayMentStates {
  final String error;

  PayMentRequestKioskErrorState(this.error);
}

class PayMentRefCodeSuccessState extends PayMentStates {}

class PayMentRefCodeErrorState extends PayMentStates {
  final String error;

  PayMentRefCodeErrorState(this.error);
}
