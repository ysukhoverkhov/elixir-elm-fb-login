
export function initializeFb (app) {

  // Initializes FB SDK
  app.ports.fbInit.subscribe(function ({appId, sdkVersion}) {
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
  app.ports.fbCheckLoginStatus.subscribe(function () {
    FB.getLoginStatus(function(response) {
      console.log('fbCheckLoginStatus');
      console.log(response);

      // TODO: send proper information about the login status.
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

  // Log current guy in.
  app.ports.fbLogin.subscribe(function () {
    FB.login(function(response) {
      console.log('fbLogin');
      console.log(response);

      // TODO: send proper information about the login status.
      app.ports.fbLoginStatus.send(response.status);

    }, {scope: 'email'});
  });

  // Log current guy out.
  app.ports.fbLogout.subscribe(function () {
    FB.logout(function(response) {
      console.log('fbLogout');
      console.log(response);

      // TODO: send proper information about the login status.
      app.ports.fbLoginStatus.send(response.status);
    });
  });


};
