
export function initializeFb (app) {

  // Initializes FB SDK
  app.ports.initFb.subscribe(function ({appId, sdkVersion}) {
    FB.init({
      appId      : appId,
      cookie     : true,
      xfbml      : false,
      version    : sdkVersion
    });
    FB.AppEvents.logPageView();
    app.ports.fbInitialized.send(null);
  });

  // Checking is the guy logged in.
  app.ports.checkLoginStatus.subscribe(function () {
    FB.getLoginStatus(function(response) {
      console.log('statusChangeCallback');
      console.log(response);

      app.ports.fbLoginStatus.send(response.status);

      // if (response.status === 'connected') {
      //   // Logged into your app and Facebook.
      //   testAPI();
      // } else {
      //   // The person is not logged into your app or we are unable to tell.
      //   document.getElementById('status').innerHTML = 'Please log ' +
      //     'into this app.';
      // }
    });
  });

};
