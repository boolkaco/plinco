# Plinco app

## design

[figma](https://www.figma.com/file/0T9U3BVVt7q4sBhQiUx7gA/Plinco?type=design&node-id=0-1&mode=design&t=wwj9u7SWIvOUdPyb-0)
[assets](https://mm.nodeart.app/files/zokjn96j8fgaxbhf779h8apwga/public?h=onwC6wBJJ-U0DDghFE6L6-6hU3hOhNfd_GaphnhxM7g)

## links
- Game site: [plincogame.com](plincogame.com)
- [repo for static assets](https://github.com/NodeArt/plincogame.com/tree/main/static/assets)
- [firebase project](https://console.firebase.google.com/project/plincogame-com)

## description

### env:

```Shell
BUNDLE_ID=com.plincogame.app
APPSFLYER_DEV_KEY=XFQCmN22uYmCWYXxRen4GX
APPSFLYER_DEBUG=false
APPSFLYER_ONE_LINK=https://link.plincogame.com/Iz7C/1zqq58ft
DOMAIN_URL=https://plincogame.com
SEND_ATTRIBUTION_POST=api/
SENTRY_DSN=
APPLE_ID_PREFIX=
```

## Metrics
- size of the resulting app
- amount of external requirements
- passing ios\android review
- app must build and operate on both Android and Ios

## Notes
### Game Engine
Please use [Flame](https://pub.dev/packages/flame) as engine
### Assets
There should be no assets in the resulting package. Please store all assets at CDN, and download them at loading screen when the app launched.
### Linter
Please use [flutter_lints](https://pub.dev/packages/flutter_lints) set of rules
### ATT request
Please add [app_tracking_transparency](https://pub.dev/packages/app_tracking_transparency), the request should be done on app start (even before loading)
### Push Messages
Please use [firebase_messaging](https://pub.dev/packages/firebase_messaging).
### Native splash
Please use [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) to provide loading screen to step BEFORE loading bar.
### Privacy page
Please use [flutter_inappwebview](https://pub.dev/packages/flutter_inappwebview) for webview. Url of privacy page to show: https://plincogame.com/privacy
