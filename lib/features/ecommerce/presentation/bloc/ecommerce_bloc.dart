import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskcart/features/ecommerce/domain/usecase/get_home_data_uc.dart';

part 'ecommerce_event.dart';
part 'ecommerce_state.dart';

class EcommerceBloc extends Bloc<EcommerceEvent, EcommerceState> {
  final GetHomeDataUsecase getHomeDataUsecase;

  EcommerceBloc({required this.getHomeDataUsecase}) : super(EcommerceInitial()) {
    on<LoadHomeDataEvent>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(LoadHomeDataEvent event, Emitter<EcommerceState> emit) async {
    emit(EcommerceLoading());
    final result = await getHomeDataUsecase.call(NoParams());
    result.fold(
          (failure) => emit(EcommerceFailure(message: failure.message)),
          (success) => emit(EcommerceSuccess(data: success)),
    );
  }
}