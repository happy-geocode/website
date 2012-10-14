initHappyMap = (data=[])->
  if ($ '#happyMap').size() < 1
    return

  if data.length == 0
    center = new L.LatLng(50.941252, 6.958283)

  maximizeMap(($ '#happyMap'))
  map = new L.Map('happyMap', { center: center, zoom: 13 })

  cloudmade = new L.TileLayer('http://{s}.tile.cloudmade.com/29dbe9cf32a84247b2513fc03266b085/997/256/{z}/{x}/{y}.png');
  map.addLayer(cloudmade)

  if data.length > 0
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
    descr += "<br/><small>#{location.accuracy} #{location.lat}, #{location.lon}</small>"

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

  t = null
  hideTooltip = ->
    ($ '#mapSearch').hideBalloon()
    clearTimeout(t)
  t = setTimeout(hideTooltip, 5000)

  ($ '#mapSearch .search-query').focus ->
    hideTooltip()

`$.urlParam = function(name){
  var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(window.location.href);
  if (!results)
  {
      return 0;
  }
  return results[1] || 0;
}`

$ ->
  unless $.cookie('tooltip-shown')
    showTutorialTooltip()

  search_for = $.urlParam('query')
  geocode_api_call = "/api/geocodes"

  if search_for
    geocode_api_call += "?query=#{search_for}"

  $.get geocode_api_call, (data)->
    initHappyMap(data)

  ($ window).resize =>
    maximizeMap(($ '#happyMap'))

