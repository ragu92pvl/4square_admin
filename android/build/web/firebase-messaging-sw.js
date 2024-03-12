importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing the generated config
const firebaseConfig = {
  apiKey: "AIzaSyCh_n82sIBkEMuH5BxphEmt1-Z1LlPKwp4",
  authDomain: "huoapp-114ce.firebaseapp.com",
  projectId: "huoapp-114ce",
  storageBucket: "huoapp-114ce.appspot.com",
  messagingSenderId: "494423296745",
  appId: "1:494423296745:web:16777f3492726ac536be78",
  measurementId: "G-G2LNHS28B3"
};
firebase.initializeApp(firebaseConfig);

// Retrieve firebase messaging
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('Received background message ', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions);
});