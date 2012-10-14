initHappyMap = (data={})->
  if ($ '#happyMap').size() < 1
    return

  unless data
    center = new L.LatLng(50.941252, 6.958283)

  maximizeMap(($ '#happyMap'))
  map = new L.Map('happyMap', { center: center, zoom: 13 })

  cloudmade = new L.TileLayer('http://{s}.tile.cloudmade.com/29dbe9cf32a84247b2513fc03266b085/997/256/{z}/{x}/{y}.png');
  map.addLayer(cloudmade)

  if data
    drawEachLocation(map, data.locations)
    map.fitBounds(getPoints(data.locations))


drawEachLocation = (map, locations)->
  for location in locations
    marker = new L.Marker(new L.LatLng(location.lat, location.lng))
    map.addLayer(marker)


getPoints = (locations)->
  points = []
  for location in locations
    points.push [location.lat, location.lng]
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
      borderRadius: 'none'
      boxShadow: 'none'
      padding: '10px'
      color: '#D9EDF7'
      opacity: 1
  )

  ($ '#mapSearch').focus ->
    hideTooltip()

  t = null
  hideTooltip = ->
    ($ '#mapSearch').hideBalloon()
    clearTimeout(t)
  t = setTimeout(hideTooltip, 5000)


$ ->
  showTutorialTooltip()

  $.get '/api/geocodes', 'json', (data)->
    initHappyMap(data)

  ($ window).resize =>
    maximizeMap(($ '#happyMap'))

