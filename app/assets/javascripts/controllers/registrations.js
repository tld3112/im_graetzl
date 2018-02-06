APP.controllers.registrations = (function() {

    function init() {

        APP.components.inputTextareaMovingLabel();
        APP.components.addressSearchAutocomplete();
        APP.components.graetzlSelect();

        // Set Registration Graetzl In Local Storage (for GA Event Tracking)
        $(document).ready(function() {
          $('#btn-register').on('click', function() {
            var reggraetzl = $('#graetzl').html();
            var regdistrict = $('#district').html();
            reggraetzl = reggraetzl.replace('&amp;','&');
            localStorage.setItem('Graetzl', regdistrict + ' ' + reggraetzl);
          });
        });

    }


// ---------------------------------------------------------------------- Public

    return {
        init: init
    }

})();
