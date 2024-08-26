import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart'; // Import path_provider
import 'package:dio/dio.dart';
import 'package:rpgl/bases/api/copd.dart'; // Import your API file

class CopdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'COPD',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: PdfViewerScreen(),
    );
  }
}

class PdfViewerScreen extends StatefulWidget {
  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? localFilePath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAndDownloadPdf();
  }

  Future<void> _fetchAndDownloadPdf() async {
    try {
      // Fetch the PDF URL from the API
      CopdAPI copdApi = await CopdAPI.pdflist();
      String pdfUrl = copdApi.copdDoc ?? '';

      if (pdfUrl.isNotEmpty) {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/copd_petition.pdf';
        final dio = Dio();

        await dio.download(pdfUrl, filePath);

        setState(() {
          localFilePath = filePath;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to fetch PDF URL from the API');
      }
    } catch (e) {
      print('Error downloading PDF: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            ))
          : localFilePath != null
              ? PDFView(
                  filePath: localFilePath,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: false,
                  onRender: (pages) {
                    setState(() {
                      _totalPages = pages!;
                    });
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _pdfViewController = pdfViewController;
                  },
                  onPageChanged: (int? page, int? total) {
                    setState(() {
                      _currentPage = page!;
                    });
                  },
                  onError: (error) {
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    print('$page: ${error.toString()}');
                  },
                )
              : Center(child: Text('Failed to load PDF')),
      floatingActionButton: localFilePath != null
          ? FloatingActionButton.extended(
              onPressed: () {
                if (_pdfViewController != null) {
                  _pdfViewController!.setPage(
                      _currentPage == _totalPages - 1 ? 0 : _currentPage + 1);
                }
              },
              label: Text('${_currentPage + 1} / $_totalPages'),
            )
          : null,
    );
  }

  PDFViewController? _pdfViewController;
  int _totalPages = 0;
  int _currentPage = 0;
}
