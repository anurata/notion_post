import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'webview_provider.g.dart';
part 'webview_provider.freezed.dart';

@freezed
class WebViewState with _$WebViewState {
  const factory WebViewState({
    required bool isOpen,
    required bool isLoading,
    required bool isError,
    required String errorText,
  }) = _WebViewState;
}

@riverpod
class WebView extends _$WebView {
  @override
  WebViewState build() {
    return const WebViewState(
        isOpen: false, isLoading: false, isError: false, errorText: '');
  }

  void show() => state = state.copyWith(isOpen: true);
  void hide() => state = state.copyWith(isOpen: false);
  void loading() => state = state.copyWith(isLoading: true);
  void loaded() => state = state.copyWith(isLoading: false);
  void error(String msg) {
    state = state.copyWith(isError: true);
    state = state.copyWith(errorText: msg);
  }

  void clearError() {
    state = state.copyWith(isError: false);
    state = state.copyWith(errorText: '');
  }
}
