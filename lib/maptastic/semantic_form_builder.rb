module Maptastic
  class SemanticFormBuilder < Formtastic::SemanticFormBuilder
    
    def multi_input(*args)
      options = args.extract_options!

      if (options[:as] == :map)
        map_input(args, options)
      else
        args.inject('') {|html, arg| html << input(arg, options)}
      end
    end
    
  private
    
    def map_div_id(methods)
      methods.map(&:to_s).join('_') << '_map'
    end
    
    def map_input_id(method)
      "#{@object.class.to_s.underscore}_#{method.to_s}"
    end
    
    def map_js(methods)
      "
      <script lang='javascript'>
        function init_#{map_div_id(methods)}() {
          var myOptions = {
            zoom: 6,
            mapTypeId: google.maps.MapTypeId.ROADMAP
          };
          
          map = new google.maps.Map(document.getElementById('#{map_div_id(methods)}'), myOptions);
          
          if(navigator.geolocation) {
              browserSupportFlag = true;
              navigator.geolocation.getCurrentPosition(function(position) {
                initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
                contentString = 'Location found using W3C standard';
                map.setCenter(initialLocation);
                infowindow.setContent(contentString);
                infowindow.setPosition(initialLocation);
                infowindow.open(map);
              }, function() {
              }
            );
          }
          
          click_listener = google.maps.event.addListener(map, 'click', function(event){
            marker = new google.maps.Marker({
              position: event.latLng, 
              map: map,
              title:'Hello World!',
              draggable: true
            });
            
            google.maps.event.removeListener(click_listener);
            document.getElementById('#{map_input_id(methods.first)}').value = event.latLng.lat();
            document.getElementById('#{map_input_id(methods.last)}').value = event.latLng.lng();
            
            google.maps.event.addListener(marker, 'dragend', function(event){
              document.getElementById('#{map_input_id(methods.first)}').value = event.latLng.lat();
              document.getElementById('#{map_input_id(methods.last)}').value = event.latLng.lng();
            });
          });
          
        }
        
        init_#{map_div_id(methods)}();
      </script>"
    end
    
    def map_input(methods, options = {})
      inputs_html = methods.inject('') {|html, method| html << input(method)}
      map_html = @template.content_tag(:li, @template.content_tag(:div, nil, :class => 'map', :id => map_div_id(methods)) << map_js(methods))
      
      inputs_html + map_html
    end

  end

end