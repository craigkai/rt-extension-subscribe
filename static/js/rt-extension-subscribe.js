jQuery(function() {
    if( window.location.href.indexOf("Ticket/Display.html" ) > -1 ) {
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
    } else if ( window.location.href.indexOf("Ticket/Modify.html" &&  jQuery('#NonAdminTraveler').length ) > -1 ) {
        jQuery('.titlebox.card.ticket-info-basics').hide()
    }
})

const UpdateFlightInfo = (flight_info) => {
    jQuery('#travelers-flight-info').html(
      '<div id="travelers-flight-info">'
        +'<p style="color:red;">Flight Delayed: ' + flight_info.Delay + '</p>'
        +'<p>Terminal: ' + flight_info.Terminal + '</p>'
        +'<p>Gate: ' + flight_info.Gate + '</p>'
      +'</div>'
    )
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
