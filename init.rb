# Include hook code here
require File.join(File.dirname(__FILE__), *%w[lib maptastic-form form_builder])
Formtastic::FormHelper.builder = MaptasticForm::FormBuilder