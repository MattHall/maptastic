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
        function create_marker(map, location) {
          marker = new google.maps.Marker({
            position: location, 
            map: map,
            title:'Drag to reposition',
            draggable: true
          });
          
          google.maps.event.addListener(marker, 'dragend', function(event){
            document.getElementById('#{map_input_id(methods.first)}').value = event.latLng.lat();
            document.getElementById('#{map_input_id(methods.last)}').value = event.latLng.lng();
          });
        }
      
        function init_#{map_div_id(methods)}() {
          var myOptions = {
            zoom: 6,
            mapTypeId: google.maps.MapTypeId.ROADMAP
          };
          
          map = new google.maps.Map(document.getElementById('#{map_div_id(methods)}'), myOptions);
          
          if (document.getElementById('#{map_input_id(methods.first)}').value && document.getElementById('#{map_input_id(methods.last)}').value) {
            var location = new google.maps.LatLng(document.getElementById('#{map_input_id(methods.first)}').value, document.getElementById('#{map_input_id(methods.last)}').value);
            map.setCenter(location);
            create_marker(map, location);
          } else {
            if(navigator.geolocation) {
                browserSupportFlag = true;
                navigator.geolocation.getCurrentPosition(function(position) {
                  initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
                  map.setCenter(initialLocation);
                }
              );
            }
            
            click_listener = google.maps.event.addListener(map, 'click', function(event){
              create_marker(map, event.latLng);
              
              document.getElementById('#{map_input_id(methods.first)}').value = location.lat();
              document.getElementById('#{map_input_id(methods.last)}').value = location.lng();
              
              google.maps.event.removeListener(click_listener);
            });
          }
        }
        
        init_#{map_div_id(methods)}();
      </script>"
    end
    
    def map_input(methods, options = {})
      options[:hint] ||= "Click to select a location, then drag the marker to position"
      inputs_html = methods.inject('') {|html, method| html << input(method, :as => :hidden)}
      hint_html = inline_hints_for(methods.first, options)
      map_html = @template.content_tag(:li, @template.content_tag(:div, nil, :class => 'map', :id => map_div_id(methods)) << hint_html.to_s << map_js(methods).to_s)
      
      inputs_html + map_html
    end

  end

end