# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  unless $.cookie('rumble-warning-dismissed')
    ($ '.happy-rumble-warning').show().find('.close').click =>
      $.cookie('rumble-warning-dismissed', 'true', { path: '/' })

