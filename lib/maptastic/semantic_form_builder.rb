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
      generate_html_id(methods.map(&:to_s).join('_') << '_map')
    end
    
    def map_input_id(method)
      generate_html_id("map_#{method}")
    end
    
    def js_class_name(methods)
      "Maptastic#{map_input_id(methods.map(&:to_s).join('_')).camelize}"
    end
    
    def map_js(methods)
      @template.content_tag("script", :lang => "javascript") do
        "
MaptasticMap.init({
  mapId: '#{map_div_id(methods)}',
  latInput: '#{map_input_id(methods.first)}', 
  lngInput: '#{map_input_id(methods.last)}'
});
"
      end
    end
    
    def map_input(methods, options = {})
      options[:hint] ||= "Click to select a location, then drag the marker to position"
      inputs_html = methods.inject('') {|html, method| html << input(method, :id => map_input_id(method), :as => :hidden)}
      hint_html = inline_hints_for(methods.first, options)
      map_container = @template.content_tag(:div, nil, :class => 'map', :id => map_div_id(methods))
      map_html = @template.content_tag(:li,  Formtastic::Util.html_safe("#{map_container} #{hint_html.to_s} #{options[:skip_js] == true ? '' : map_js(methods).to_s}"))
      
      Formtastic::Util.html_safe(inputs_html + map_html)
    end

  end

end