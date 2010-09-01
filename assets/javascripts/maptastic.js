MaptasticMap = function(options) {
	this.init(options);
}
MaptasticMap.prototype = {
	marker: null,
	options: { mapId: null, latitudeInput: null, longitudeInput: null }, // default options
	setMarker: function(map, location) {
		if (!this.marker) this.createMarker(map, location);
		this.marker.setPosition(location);
	},
	createMarker: function(map, location) {
		this.marker = new google.maps.Marker({
			map: map,
			title: 'Drag to reposition',
			draggable: true
		});
		var clazz = this;
		google.maps.event.addListener(this.marker, 'dragend', function(event) {
			clazz.updateInputs(event);
		});
	},
	updateInputs: function(event) {
		document.getElementById(this.options.latInput).value = event.latLng.lat();
		document.getElementById(this.options.lngInput).value = event.latLng.lng();
	},
	init: function(options) {
		this.options = options;
		var map = new google.maps.Map(document.getElementById(this.options.mapId), {
			zoom: 6,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		});
		if (document.getElementById(this.options.latInput).value && document.getElementById(this.options.lngInput).value) {
			var location = new google.maps.LatLng(document.getElementById(this.options.latInput).value, document.getElementById(this.options.lngInput).value);
			map.setCenter(location);
			this.setMarker(map, location);
		} else if (navigator.geolocation) {
  			navigator.geolocation.getCurrentPosition(function(position) {
    			initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
    			map.setCenter(initialLocation);
  			});
		}
		var clazz = this;
		google.maps.event.addListener(map, 'click', function(event){
			clazz.setMarker(map, event.latLng);
			clazz.updateInputs(event);
		});
	}
}