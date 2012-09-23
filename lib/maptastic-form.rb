require File.join(File.dirname(__FILE__), *%w[maptastic-form form_builder])
Formtastic::FormHelper.builder = MaptasticForm::FormBuilder