Event.observe(window, 'load', function() {
	if (GBrowserIsCompatible()) {
		
		//Initialize the map
	  var map = new GMap2($("map_div"));
	
		//Initialize the latitude and longitude values and center the map
		var point = new GLatLng($("latitude").readAttribute('value'), $("longitude").readAttribute('value'));
		map.setCenter(point, 13);
		
		// Add marker
		var $marker = new GMarker(point);
		map.addOverlay($marker);
		
		// Add map controls	    
		map.addControl(new GSmallMapControl());
		
		// User map click event handler
		GEvent.addListener(map, "click", function(overlay, latlng) {
			map.removeOverlay($marker);
			$marker.setLatLng(latlng);
			$("latitude").writeAttribute({value: latlng.lat()});
			$("longitude").writeAttribute({value: latlng.lng()});
			map.addOverlay($marker);		    
		});
					
		// User click city select box event handler
		Event.observe("article_city_id", "change", function(event) {
		  $$("#article_city_id option").each(function(elem){
				 if (elem.selected){
					city = elem.text;
					var	point = new GLatLng(eval("window.settings."+city+".lat"),eval("window.settings."+city+".lng")); 
					map.setCenter(point);
					$marker.setLatLng(point);
					$("latitude").writeAttribute({value: point.lat()});
					$("longitude").writeAttribute({value: point.lng()});
				}
			});
		});
		
	 }
 });
