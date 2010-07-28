# Formtastic Location Selector

## Installation

First, you'll need to install [Formtastic][1].

Next, install Maptastic as a plugin:

    script/plugin install git@github.com:MattHall/maptastic.git

You'll need to add the [Google Maps **V3**][3] script include in your page, above your semantic_form:

    <script type='text/javascript' src='http://maps.google.com/maps/api/js?sensor=true'></script>

Note that you no longer need an API key with the latest Google Maps release.

## Usage

Maptastic adds a new #multi_input method as well as the map control:

    <% semantic_form_for @venue do |f| %>
      <%= f.multi_input :latitude, :longitude, :as => :map %>
    <% end %>

Note that the map input expects two parameters - a latitude and longitude. The order is important.

## Development

This plugin is under development. It's pretty simple, and patches are very welcome.

[The Repo is available on GitHub][5]

[Report bugs here][4]

## Project Info

Copyright © 2010 [Matthew Hall][2], released under the MIT license.

[1]:http://github.com/justinfrench/formtastic
[2]:http://codebeef.com
[3]:http://code.google.com/apis/maps/documentation/javascript/
[4]:https://matt.purifyapp.com/projects/maptastic/issues
[5]:http://github.com/MattHall/maptastic