part of 'ecommerce_bloc.dart';

sealed class EcommerceEvent extends Equatable {
  const EcommerceEvent();
}

class LoadHomeDataEvent extends EcommerceEvent {
  @override
  List<Object?> get props => [];
}