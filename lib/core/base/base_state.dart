import 'package:bloc_pattern/core/enums/enums.dart';
import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  final StateStatus stateStatus;

  const BaseState(this.stateStatus);

  @override
  List<Object?> get props => [stateStatus];
}
