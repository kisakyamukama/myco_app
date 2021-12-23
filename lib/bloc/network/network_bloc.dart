import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final Connectivity connectivity;
  NetworkBloc({required this.connectivity}) : super(NetworkInitial()) {
    on<NetworkEvent>(_mapEventToState);
  }

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  Future<void> _mapEventToState(
      NetworkEvent event, Emitter<NetworkState> emit) async {
    debugPrint('$event');
    if (event is ConnnectionListen) {
      _connectivitySubscription =
          connectivity.onConnectivityChanged.listen((connectivityResult) {
        add(ConnectionChanged(connectivityResult == ConnectivityResult.none
            ? NetworkDisconnected()
            : NetworkSucess(
                connectionType: connectivityResult == ConnectivityResult.mobile
                    ? ConnectionType.Mobile
                    : ConnectionType.Wifi)));
      });
    }

    if (event is ConnectionChanged) {
      debugPrint('$event');
      emit(event.connection);
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
