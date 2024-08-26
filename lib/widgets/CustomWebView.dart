import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {
  final String initialUrl;
  final NavigationDelegate? navigationDelegate;

  const CustomWebView({
    Key? key,
    required this.initialUrl,
    this.navigationDelegate,
  }) : super(key: key);

  @override
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  late WebViewController _webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(widget.initialUrl))
      ..setNavigationDelegate(widget.navigationDelegate ??
          NavigationDelegate(
            onPageStarted: (String url) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                isLoading = false;
              });
            },
            onHttpError: (HttpResponseError error) {
              // Handle HTTP errors
            },
            onWebResourceError: (WebResourceError error) {
              // Handle web resource errors
            },
          ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _webViewController),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          ),
      ],
    );
  }
}
