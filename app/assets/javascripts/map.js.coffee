initHappyMap = (data=[])=>
  if ($ '#happyMap').size() < 1
    return

  maximizeMap(($ '#happyMap'))
  map = new L.Map('happyMap', { center: new L.LatLng(50.9413,6.958), zoom: 13 })

  window.markerLayers = []

  cloudmade = new L.TileLayer('http://{s}.tile.cloudmade.com/29dbe9cf32a84247b2513fc03266b085/997/256/{z}/{x}/{y}.png');
  map.addLayer(cloudmade)
  map

addGeoPoints = (map, data=[]) ->
  if data.length == 0
    center = new L.LatLng(50.941252, 6.958283)
    map.setView(center, 13)
    alert "I'm afraid I can't do that, Dave :(\nBut I will try to improve our dataset in the following weeks"
  else
    drawEachLocation(map, data)
    map.fitBounds(getPoints(data))

drawEachLocation = (map, locations)->
  for location in locations
    marker = new L.Marker(new L.LatLng(location.lat, location.lon))

    descr = "<strong>"
    descr += "#{location.street_name}" if location.street_name?
    descr += " #{location.street_number}" if location.street_number?
    descr += "</strong><br/>"
    descr += "#{location.zip}" if location.zip?
    descr += " #{location.city}" if location.city?
    descr += "<br/><small>#{location.lat}, #{location.lon} (#{location.accuracy})</small>"

    window.markerLayers.push marker
    map.addLayer(marker)
    marker.bindPopup(descr)


getPoints = (locations)->
  points = []
  for location in locations
    points.push [location.lat, location.lon]
  return points


maximizeMap = (map)->
  map.width(($ window).width())
  map.height(($ window).height())


showTutorialTooltip = ->
  tooltip = ($ '#mapSearch').showBalloon(
    contents: ($ '#mapTooltip').clone().show()
    position: 'bottom'
    delay: 200
    showDuration: 100
    showAnimation: -> ($ this).fadeIn()

    css:
      backgroundColor: 'rgba(0, 0, 0, 0.7)'
      border: 'none'
      borderRadius: '10px'
      boxShadow: 'none'
      padding: '10px 20px'
      color: 'white'
      opacity: 0.9
  )
  # Save cookie so the tooltip can be omitted after first load
  $.cookie('tooltip-shown', 'true', { path: '/' })

  hideTooltip = ->
    ($ '#mapSearch').hideBalloon()

  ($ '#mapSearch .search-query').focus ->
    hideTooltip()
  ($ '#mapTooltip .close').click ->
    hideTooltip()

`$.urlParam = function(name){
  var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(window.location.href);
  if (!results)
  {
      return 0;
  }
  return results[1] || 0;
}`

executeSearch = (map, search_for) ->
  for layer in window.markerLayers
    map.removeLayer layer

  geocode_api_call = "/api/geocodes?query=#{search_for}"
  $.get geocode_api_call, (data)=>
    addGeoPoints(map, data)

$ =>
  unless $.cookie('tooltip-shown')
    showTutorialTooltip()

  search_for = $.urlParam('query')

  map = initHappyMap()

  if search_for
    executeSearch(map, search_for)

  ($ window).resize =>
    maximizeMap(($ '#happyMap'))

  $(".form-search").on "submit", =>
    executeSearch(map, $(".search-query").val())
    false

