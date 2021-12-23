part of 'network_bloc.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

enum ConnectionType { Wifi, Mobile }

class NetworkInitial extends NetworkState {}

class NetworkSucess extends NetworkState {
  final ConnectionType connectionType;

  const NetworkSucess({required this.connectionType});

  @override 
  List<Object> get props => [connectionType];
}

class NetworkFailure extends NetworkState {}

class NetworkDisconnected extends NetworkState {}
