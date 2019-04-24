jQuery(function() {
    if ( !jQuery('#NonAdminTraveler').length > 0 ) {
        jQuery('#announce').hide()
    }
    if( window.location.href.indexOf("Ticket/Display.html" ) > 0 && jQuery('#NonAdminTraveler').length > 0 ) {
            const hide = ['.ticket-info-basics', '.ticket-info-requestor',
                '.ticket-info-dates', '.ticket-info-links', '.ticket-info-people',
                '.titlebox.card.ticket-info-cfs.ticket-info-cfs-Flight_Information',
                '.titlebox.card.ticket-info-cfs.ticket-info-cfs-Travelers',
                '.titlebox.card.ticket-info-cfs.ticket-info-cfs-Travel_Dates',
                '.titlebox.card.ticket-info-cfs'
            ]

            hide.forEach(function(element) {
                jQuery(element).hide()
            })
        jQuery("span:contains('Ticket metadata')").text("Travel Information")

    } else if ( window.location.href.indexOf("Ticket/Modify.html") > 1 && jQuery('#NonAdminTraveler').length > 0 ) {
        jQuery('.titlebox.card.ticket-info-basics').hide()
    } else if ( window.location.href.indexOf("Ticket/Create.html") > 1 && jQuery('#NonAdminTraveler').length > 0 ) {
        jQuery('.titlebox.card.ticket-info-basics').hide()

        const message_box = jQuery('#ticket-create-message').find('.fields')
        message_box.children('.field').each(function(){
            const val = this
            const isSafe = jQuery.grep(['[name=Subject]', '#attach-dropzone', '#Content'], function(e) {
                return jQuery(val).children().find(e).length
            })
            if ( isSafe.length ) {
            } else {
                jQuery(this).hide()
            }
        })
    }
})

const UpdateFlightInfo = (flight_info) => {
    if ( flight_info.Delay ) {
        jQuery('#travelers-flight-info').html('<div id="travelers-flight-info" class="col-md-12">'
            +'<div class="form-row">'
                +'<div class="label">Arrival Time:</div>'
                +'<div class="value entry" style="color:red;">'+flight_info.Delay+'</div>'
            +'</div>'
            +'<div class="form-row">'
                +'<div class="label">Terminal:</div>'
                +'<div class="value entry">'+flight_info.Terminal+'</div>'
            +'</div>'
            +'<div class="form-row">'
                +'<div class="label">Gate:</div>'
                +'<div class="value entry">'+flight_info.Gate+'</div>'
            +'</div>'
        +'</div>')
    } else {
        jQuery('#travelers-flight-info').html('<div id="travelers-flight-info">No flight information available</div>')
    }
}

const UpdateFlightNumber = (TicketId) => {
    const flight_number = jQuery("#Travelers-Flight-Number-"+TicketId).val()

    const values = {
        "TicketId"     : TicketId,
        "FlightNumber" : flight_number
    }
    fetch(RT.Config.WebHomePath + "/Helpers/Flights", {
        method: 'POST',
        headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
        },
        body: JSON.stringify(values),
    }).then(function(response) { return response.json(); }
    ).then(function(flight_info){
        UpdateFlightInfo(flight_info)
    })
}

jQuery(function () {
    jQuery('[data-toggle="tooltip"]').tooltip()
})
