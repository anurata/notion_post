import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notion_post/api/notion_oauth_api.dart';
import 'package:notion_post/env/env.dart';
import 'package:notion_post/provider/notion_auth_provider.dart';
import 'package:notion_post/provider/webview_provider.dart';

class NotionLoginWebviewWidget extends ConsumerWidget {
  const NotionLoginWebviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notionOauthApi = ref.read(notionOauthApiProvider);
    InAppWebViewController? webViewController;
    final webViewNotifier = ref.read(webViewProvider.notifier);
    return InAppWebView(
      //initialUrlRequest: URLRequest(url: Uri.parse(Env.notionOauthUrl)),
      initialUrlRequest: URLRequest(url: WebUri(Env.notionOauthUrl)),
      initialSettings: InAppWebViewSettings(
        userAgent: Platform.isIOS
            ? 'Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.1 Mobile/15E148 Safari/604.1'
            : 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36',
        //crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        useOnLoadResource: true,
        clearCache: true,
        //)
        //,
        //android: AndroidInAppWebViewOptions(disableDefaultErrorPage: true)
      ),
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
      onLoadStart: (controller, url) async {
        if (url != null) {
          webViewNotifier.loading();
          webViewNotifier.clearError();
          try {
            if (url.toString().startsWith('notionpost://oauth/callback?code')) {
              await notionOauthApi.authenticate(url.toString());
              webViewNotifier.hide();
              ref.read(notionAuthProvider.notifier).getNotionWorkspace();
            }
          } catch (e) {
            throw Exception(e);
          }
        }
      },
      onLoadStop: (controller, url) async {
        webViewNotifier.loaded();
      },
      onLoadError: (controller, url, code, message) {
        // allow redirect to notionpost://oauth/callback
        if (url.toString().startsWith('notionpost://oauth/callback?code')) {
          return;
        }
        webViewNotifier.error(message);
      },
    );
  }
}
