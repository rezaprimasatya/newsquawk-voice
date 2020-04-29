import dayjs from 'dayjs';
import Mustache from 'mustache';
URL = 'https://webrtc.newsquawk.com/flussonic/api/media'

getData = (url) ->
  try
    response = await fetch(url, headers: new Headers('Authorization': 'Basic ' + btoa('view:ReadMe890')))
    do response.json
  catch error
    throw 'error while fetching data :' + error

extractData = (json, channel_list) ->
   json.map (item) ->
    now = (new Date).getTime()
    start_time = dayjs now - item.value.stats.lifetime
    name: item.value.name.replace('live/', ''),
    start_time: start_time.format('DD-MM-YYYY HH:mm:ss')

#if the json data matches the channel list then filter if not then remove string from array
filterActive = (json, channel_list) ->
  json.filter (item) ->
    channel_list.find (label) ->
      item.value.name.match label

run = ->
  json = await getData URL
  active = filterActive json, [
    'audio_test'
    'forex-realtime'
    'multi_asset-realtime'
    'blah'
  ]
  extractData active

loadtemp = ->
  view = 'channels': await do run
  console.log TEST: view.channels
  output = Mustache.render('<ul>{{#channels}}<li>The channels running are {{name}} since {{start_time}}</li>{{/channels}}</ul>', view)
  console.log output
  document.body.innerHTML = output

recurring = ->
  do loadtemp
  setTimeout recurring, 2000

do recurring
