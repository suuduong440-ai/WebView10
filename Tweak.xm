#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <Foundation/Foundation.h>

static BOOL IsGoogleURL(NSURL *url) {
    NSString *host = url.host.lowercaseString ?: @"";
    return [host hasSuffix:@"google.com"] ||
           [host hasSuffix:@"google.com.vn"];
}

%hook WKWebView

- (void)didMoveToWindow {
    %orig;

    if (!IsGoogleURL(self.URL))
        return;

    NSString *js =
    @"(function(){"
    "var s=document.createElement('style');"
    "s.textContent='"
    "body{font-size:18px!important;line-height:1.5!important;}"
    "a,h3{font-size:18px!important;}"
    "button,input{font-size:17px!important;}"
    "';"
    "document.documentElement.appendChild(s);"
    "})();";

    WKUserScript *script =
    [[WKUserScript alloc] initWithSource:js
                           injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                        forMainFrameOnly:YES];

    [self.configuration.userContentController addUserScript:script];
}

%end
