# Include hook code here
require File.join(File.dirname(__FILE__), *%w[lib maptastic semantic_form_builder])
Formtastic::SemanticFormHelper.builder = Maptastic::SemanticFormBuilder