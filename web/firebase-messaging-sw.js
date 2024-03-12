importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing the generated config
  const firebaseConfig = {
        apiKey: "AIzaSyB0UkyLCEV_rXXrVObe8ve3VsAXUxpj1Ps",
             authDomain: "v-mart-7afb0.firebaseapp.com",
             projectId: "v-mart-7afb0",
             storageBucket: "v-mart-7afb0.appspot.com",
             messagingSenderId: "662438664623",
             appId: "1:662438664623:web:78c81a3a162d6d29e8775a",
             measurementId: "G-0ER9GTCF3H"
    };
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

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