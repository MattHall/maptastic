# Include hook code here
require File.join(File.dirname(__FILE__), *%w[lib maptastic-form semantic_form_builder])
Formtastic::SemanticFormHelper.builder = MaptasticForm::SemanticFormBuilder