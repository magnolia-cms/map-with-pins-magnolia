# Map with Pins - Component template for Magnolia CMS

A component to create a simple custom map with pins/markers.


## Features

Component allow editors to use any image as a map (background). And add unlimited amount of pins with a 'title' and 'address' properties.

Each pin then can be moved to his exact position. This is drag&drop feature is allowed only in Magnolia pages edit mode (author instance only), and once pin is moved his new location is imediatelly saved. So in preview the pins are in proper locations. Same as on public instances after activation / publication.

![Dialog](/_dev/README-dialog.png)

![Component](/_dev/README-map.png)


## Instalation

Copy/drop `map-with-pins-mangolia` folder into Magnolia's `light-modules` folder. Or any folder you have configured in `magnolia.properties` file in `magnolia.resources.dir=` parameter.


## Requirments

Drag&drop functionality is sending data about new position over default Magnolia REST API to website workspace. This API is enabled by default on author instance, but its always good to double check and you can do it in `security app > roles > rest role > web access` and have `Get & Post` for `/.rest/nodes/v1/website*` (this is need only on author instance).


## Usage

This component contains decoration for `mtk:pages/basic` so when its installed it already available on 'Basic' page.

To make it available on other pages, just use similar 'decoration' or manually add availability for:
```
  map-with-pins-magnolia:
    id: map-with-pins-magnolia:components/map
```

## Advanced usage

This component allow you to choose any image as a background and then unlimited number of pins / markers / pointers, so it can be used not only for map, but for anything where you need point things in X and Y axis. E.g graphs with points, etc. Pin image exists in `webresources/img/pin-white.svg` so you can easily replace with any image for your use case.


## Tips

This component is using Jquery and Jquery-ui libraries. By default they are loaded in component ftl, but we suggest to move them to hrml > head of your page for better functionality or to avoid a collision with other Jquery libraries in your project.


## License

MIT


## Contributors

Magnolia, https://www.magnolia-cms.com

Tomáš Gregovský, tomas.gregovsky@magnolia.com
