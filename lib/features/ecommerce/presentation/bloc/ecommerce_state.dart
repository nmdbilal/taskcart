part of 'ecommerce_bloc.dart';

sealed class EcommerceState extends Equatable {
  const EcommerceState();
}

final class EcommerceInitial extends EcommerceState {
  @override
  List<Object?> get props => [];
}

final class EcommerceLoading extends EcommerceState {
  @override
  List<Object?> get props => [];
}

final class EcommerceSuccess extends EcommerceState {
  final HomeData data;
  const EcommerceSuccess({required this.data});
  @override
  List<Object?> get props => [data];
}

final class EcommerceFailure extends EcommerceState {
  final String message;
  const EcommerceFailure({required this.message});
  @override
  List<Object?> get props => [message];
}