#PDFJSTest

A test project to display PDFs within the PDF Viewer using the PDF.js library, in iOS. Ideally, we'd like to run PDF.js within the iOS app, instead of having the library run from a remote server. We found a workaround that makes this possible. The solution is explained in this issue:

https://github.com/mozilla/pdf.js/issues/8663

There are two apps that you can run from this project: the iOS app and the web app.

To run the iOS app, open the PDFJSTest.xcodeproj in Xcode and run like usual.

To run the web app:

1) Go to the directory PDFJSTest/pdf.js-dist in a terminal window

2) Start a local web server in the terminal window. I use the Python SimpleHTTPServer program.

At the command prompt, type:
python -m SimpleHTTPServer

For more details, go to: https://developer.mozilla.org/en-US/docs/Learn/Common_questions/set_up_a_local_testing_server

3) In a Safari browser (you must use Safari as that comes closest to simulating WebKit in iOS), type:
localhost:8000

The PDF Viewer and a default PDF loaded in the Viewer, should appear in the browser.

For additional information about PDF.js, check out these links:
https://github.com/mozilla/pdf.js/wiki/Frequently-Asked-Questions#faq-xhr
https://mozilla.github.io/pdf.js/getting_started/

The cross domain request question in FAQs will explain why we need to run a local web server to access a local PDF in the web app, as will the "Trying the Viewer" section on the Getting Started page.

https://github.com/mozilla/pdf.js/wiki/Viewer-options
This is helpful to understand different ways to work with the Viewer
