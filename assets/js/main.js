$(document).ready(function () {
  // Check if WebGL is supported
  function isWebGLSupported() {
    try {
      var canvas = document.createElement("canvas");
      return !!(
        window.WebGLRenderingContext &&
        (canvas.getContext("webgl") || canvas.getContext("experimental-webgl"))
      );
    } catch (e) {
      return false;
    }
  }

  // Wait for all elements to load
  $(window).on("load", function () {
    try {
      if (!isWebGLSupported()) {
        console.log("WebGL is not supported in your browser.");
        return;
      }

      // Initialize ripples with error handling
      $(".full-mountain-image")
        .ripples({
          resolution: 512,
          dropRadius: 20,
          perturbance: 0.04,
          interactive: true,
          crossOrigin: "",
        })
        .on("error", function (e, err) {
          console.error("Ripples error: ", err);
        });

      // Handle window resize
      var resizeTimeout;
      $(window).on("resize", function () {
        clearTimeout(resizeTimeout);
        resizeTimeout = setTimeout(function () {
          try {
            $(".full-mountain-image").ripples("updateSize");
          } catch (e) {
            console.error("Resize error: ", e);
          }
        }, 100);
      });
    } catch (e) {
      console.error("Initialization error: ", e);
    }
  });
});
