'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "d61ad054919f807573800578c6a168a1",
"index.html": "314917dea576d6be1f6fc1d37b7932ad",
"/": "314917dea576d6be1f6fc1d37b7932ad",
"firebase-messaging-sw.js": "f0b450bc21c089d41b1f09db03c62574",
"main.dart.js": "3f84c213de8e96920efd24dc7d964434",
"cors.json": "b9cb08b122cdb1e46a75ce7eec974089",
"favicon.png": "5bd2a7112e85c8c60dd9bb9ce1a4a24c",
"icons/Icon-192.png": "bc04c18aa26506e0e071de617100de23",
"icons/Icon-512.png": "abd18308d44d55650bc9237678dbe3b2",
"manifest.json": "2311d1a3a63f1376deea0fd63f0a50bd",
"assets/AssetManifest.json": "601137fcdecaf1eac7f4fbe09572349f",
"assets/NOTICES": "8efccb3cd569a29480e0d8ebcf5bb187",
"assets/FontManifest.json": "dcf82b67ce314d8e0de45134daff3d81",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/flutter_feather_icons/fonts/feather.ttf": "c96dc22ca29a082af83cce866d35cebc",
"assets/packages/flutter_vector_icons/fonts/Fontisto.ttf": "b49ae8ab2dbccb02c4d11caaacf09eab",
"assets/packages/flutter_vector_icons/fonts/Octicons.ttf": "8e7f807ef943bff1f6d3c2c6e0f3769e",
"assets/packages/flutter_vector_icons/fonts/Feather.ttf": "ca9ce9ff0676a9b04ef0f8a3ad17dd08",
"assets/packages/flutter_vector_icons/fonts/Entypo.ttf": "744ce60078c17d86006dd0edabcd59a7",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Brands.ttf": "c39278f7abfc798a241551194f55e29f",
"assets/packages/flutter_vector_icons/fonts/MaterialCommunityIcons.ttf": "3c851d60ad5ef3f2fe43ebd263490d78",
"assets/packages/flutter_vector_icons/fonts/AntDesign.ttf": "3a2ba31570920eeb9b1d217cabe58315",
"assets/packages/flutter_vector_icons/fonts/Foundation.ttf": "e20945d7c929279ef7a6f1db184a4470",
"assets/packages/flutter_vector_icons/fonts/Ionicons.ttf": "b2e0fc821c6886fb3940f85a3320003e",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Solid.ttf": "b70cea0339374107969eb53e5b1f603f",
"assets/packages/flutter_vector_icons/fonts/FontAwesome5_Regular.ttf": "f6c6f6c8cb7784254ad00056f6fbd74e",
"assets/packages/flutter_vector_icons/fonts/FontAwesome.ttf": "b06871f281fee6b241d60582ae9369b9",
"assets/packages/flutter_vector_icons/fonts/Zocial.ttf": "5cdf883b18a5651a29a4d1ef276d2457",
"assets/packages/flutter_vector_icons/fonts/EvilIcons.ttf": "140c53a7643ea949007aa9a282153849",
"assets/packages/flutter_vector_icons/fonts/SimpleLineIcons.ttf": "d2285965fe34b05465047401b8595dd0",
"assets/packages/flutter_vector_icons/fonts/MaterialIcons.ttf": "a37b0c01c0baf1888ca812cc0508f6e2",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/assets/cfg/configurations.json": "2a923363b6a3cc0be5d195916b52f24b",
"assets/assets/img/resturentdefaultbg.jpg": "ce44e500628acd976c365c93f0b716f2",
"assets/assets/img/stripelogo.png": "33022fddd3270b58a89314e237a20a85",
"assets/assets/img/china.png": "00d7b6d94371a8a31bcfa9f64fd2b8b1",
"assets/assets/img/category_15.jpg": "99299ccfd3350f6bcdc3049fc2fda08d",
"assets/assets/img/userImage.png": "cf89e8e6daa9dabc8174c303e4d53d3a",
"assets/assets/img/Razorpay.png": "3ddda9fc133a892db8a908bf0c237aa3",
"assets/assets/img/couponbox.png": "f79d467ad448311a19d7bb5e81ab77a6",
"assets/assets/img/ready.png": "01a59fcd049a89480a24493feb2078d6",
"assets/assets/img/vendor.png": "c0f2e76b4bf1ca1a37789732d310d89f",
"assets/assets/img/online.gif": "2802d5a7cca03713d25cba431f27a4e5",
"assets/assets/img/cancelled.png": "298693233f5133c81296d34e113ff616",
"assets/assets/img/paypal2.png": "fa5a91f938df57cc1e29865730d8a34f",
"assets/assets/img/android.png": "055618e30b08b58b33e733184d2d5b75",
"assets/assets/img/cod.png": "bc9fb5039a5d829c85590a13f940ef44",
"assets/assets/img/image_placeholder.png": "6305b9c7084fe31d150ec438671cf708",
"assets/assets/img/loading.gif": "3f899a790ab677acd5762723b7743334",
"assets/assets/img/pageloader.gif": "67f355716359e5c07b9df6b268502b39",
"assets/assets/img/loader.gif": "f99a89983ee64a6a9691fd6a77c6889a",
"assets/assets/img/preparing.png": "56f78f3b89565108e2d0168156e4ebbc",
"assets/assets/img/canada.png": "a4122561940e7324ca621f6f9d75050a",
"assets/assets/img/whatsap.png": "79e13859688d1646fbe5021fe53639b9",
"assets/assets/img/completed.png": "0eab325035d5dc96c5db4cb1e595d75b",
"assets/assets/img/banner8.jpg": "9dd7bb6a26ecb26eeacbaae3191046b0",
"assets/assets/img/flutterwave.png": "c805f7b3d325a6ed48ed2824aebacdb5",
"assets/assets/img/food.png": "6855159f38835c1f03289b102a2e8b52",
"assets/assets/img/grocery.png": "14a3e91c7a517b0a2f71dbcd86d2104d",
"assets/assets/img/excel.png": "9ee709f3f229bec4d8608e4edc7c8e79",
"assets/assets/img/germany.png": "8f1bccdeb8a75c86c1a2ebd1d18abb4d",
"assets/assets/img/logo.png": "5bd2a7112e85c8c60dd9bb9ce1a4a24c",
"assets/assets/img/upilogo.png": "09a4c73e4049955552557c573f3d3d6e",
"assets/assets/img/united-arab-emirates.png": "0fd33949c93f53bf0c187a8563ac0f85",
"assets/assets/img/pharmacydefaultbg.jpg": "979178d2373d2190c289f10d7b474b87",
"assets/assets/img/shipped.png": "ac9c9ed4e276429c4e45fc8381a2b9f6",
"assets/assets/img/twitter.png": "4e41ec167b2450237a1b0bea033f213c",
"assets/assets/img/profile_bg.jpg": "6939a562946c43774459304eb85a45d5",
"assets/assets/img/france.png": "78e9f99bc3c993c9c83615d0f3d028c4",
"assets/assets/img/waiting.png": "6a23a7f1ce58120f150ac13edc49f596",
"assets/assets/img/italy.png": "cc79b1867397b8aec17dccce31e6fbef",
"assets/assets/img/mainlogo.png": "02d3e0e7642eb750e8386320e80b0b8c",
"assets/assets/img/no_data_found.png": "7509605ab24b61c511da08730b833fcb",
"assets/assets/img/driverboy.png": "0f0861dc6c524228ff8eea4a0360a62b",
"assets/assets/img/couponcurve1.png": "988859e80f549d8c04ad6397d55074f0",
"assets/assets/img/netherlands.png": "67a6d9209d262d0a9c35196d44f5c6eb",
"assets/assets/img/google.png": "d6754639ecbbea607e88944681c7cc94",
"assets/assets/img/facebook.png": "252efe155d9dfb0901f5697c93e893c8",
"assets/assets/img/autoassign.gif": "2542fa59db54c27d26fb7274c8b60839",
"assets/assets/img/united-states-of-america.png": "e499f1fbaeb06cf2b9f6ddfd4de672b5",
"assets/assets/img/marker.png": "30413dde6df4663c202f6d57337d59d6",
"assets/assets/img/plate-food2.png": "8d20036754fc3be62123fcf1e1783054",
"assets/assets/img/grocerydefaultbg.jpg": "9741dfff740e6131e633317e3fba2aff",
"assets/assets/fonts/proximanova-regular.otf": "bf9f5d50c1b928ff21436517a1a95ad9",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
