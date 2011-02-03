require File.join(File.dirname(__FILE__), *%w[maptastic-form semantic_form_builder])
Formtastic::SemanticFormHelper.builder = MaptasticForm::SemanticFormBuilder