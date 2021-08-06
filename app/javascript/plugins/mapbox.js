import 'mapbox-gl/dist/mapbox-gl.css';
import mapboxgl from 'mapbox-gl';

const fitMapToMarkers = (map, features) => {
  const bounds = new mapboxgl.LngLatBounds();
  features.forEach(({ geometry }) => bounds.extend(geometry.coordinates));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v11'
    });

    map.on('load', function() {
      const cars = JSON.parse(mapElement.dataset.cars);
      map.addSource('cars', {
        type: 'geojson',
        data: cars,
        cluster: true,
        clusterMaxZoom: 14,
        clusterRadius: 50
      });

      map.addLayer({
        id: 'clusters',
        type: 'circle',
        source: 'cars',
        filter: ['has', 'point_count'],
        paint: {
          'circle-color': [
            'step',
            ['get', 'point_count'],
            '#fff',
            100,
            '#8e44ad',
            750,
            '#8e44ad'
          ],
          'circle-radius': [
            'step',
            ['get', 'point_count'],
            20,
            100,
            30,
            750,
            40
          ]
        }
      });

      map.addLayer({
        id: 'cluster-count',
        type: 'symbol',
        source: 'cars',
        filter: ['has', 'point_count'],
        layout: {
          'text-field': '{point_count_abbreviated}',
          'text-font': ['DIN Offc Pro Medium', 'Arial Unicode MS Bold'],
          'text-size': 12
        }
      });

      map.addLayer({
        id: 'unclustered-point',
        type: 'circle',
        source: 'cars',
        filter: ['!', ['has', 'point_count']],
        paint: {
          'circle-color': '#8e44ad',
          'circle-radius': 10,
          'circle-stroke-width': 1,
          'circle-stroke-color': '#fff'
        }
      });

      map.on('click', 'clusters', function (e) {
        const features = map.queryRenderedFeatures(e.point, { layers: ['clusters'] });
        const clusterId = features[0].properties.cluster_id;

        map.getSource('cars').getClusterExpansionZoom(clusterId, function (err, zoom) {
          if (err) return;

          map.easeTo({
            center: features[0].geometry.coordinates,
            zoom: zoom
          });
        });
      });

      map.on('mouseenter', 'clusters', function (e) {
        map.getCanvas().style.cursor = 'pointer';
      });

      map.on('mouseleave', 'clusters', function () {
        map.getCanvas().style.cursor = '';
      });

      map.on('click', 'unclustered-point', function (e) {
        const features = map.queryRenderedFeatures(e.point, { layers: ['unclustered-point'] });
        const infoWindow = features[0].properties.info_window;
        const coordinates = features[0].geometry.coordinates;

        map.easeTo({
          center: features[0].geometry.coordinates
        });

        new mapboxgl.Popup()
          .setLngLat(coordinates)
          .setHTML(infoWindow)
          .addTo(map);
      });

      map.on('mouseenter', 'unclustered-point', function () {
        map.getCanvas().style.cursor = 'pointer';
      });

      map.on('mouseleave', 'unclustered-point', function () {
        map.getCanvas().style.cursor = '';
      });

      fitMapToMarkers(map, cars.features);
    });
  }
};

export { initMapbox };
