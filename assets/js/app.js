
import { initializeFb } from './fb'
import Elm from './elm/main';

// Bootstrapping the app.
const elmDiv = document.querySelector('#elm_target');
if (!elmDiv) {
  console.error("#elm_target id is missing.");
}
const app = Elm.Main.embed(elmDiv);


// Loading FB.
window.fbAsyncInit = function() {
  app.ports.appLoaded.send(null);
  initializeFb(app);
};

// Load the SDK asynchronously
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
