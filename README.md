# [film figures](https://kfrn.github.io/film-figures/)

#### _calculate footage, duration, and frame count for analogue film_

### About

Choose a film gauge (options are 35mm, 28mm, 16mm, and 9.5mm) and set one of these three parameters: the footage (in feet or metres), the duration, or the framecount. The other two parameters will thereby be calculated.

Other online film calculators exist, but I made this one because I wanted a cleaner UI - I am not fond of forms that include many input boxes, some of which are mutually exclusive.

If this calculator doesn't suit your needs, you may wish to consult [Kodak's Film Calculator](https://www.kodak.com/gb/en/motion/tools/film_calculator/default.htm) or [Scenesavers' Film Footage Calculator](http://www.scenesavers.com/content/show/film-footage-calculator).

**film figures** is multilingual:  
🇫🇷 Disponible aussi en français et italien!  
🇮🇹 Disponibile anche in italiano e francese!

### Background

**film figures** is a sister project to [**reel time**](https://kfrn.github.io/reel-time), my open-reel audio duration calculator. Both projects are inspired by open-source preservation tools like [ffmprovisr](https://amiaopensource.github.io/ffmprovisr/) and [Cable Bible](https://amiaopensource.github.io/cable-bible/).

Suggestions and contributions are welcome! I'm happy to receive feature requests, bug reports, code changes, translations, general comments, etc. You can submit a github issue (or pull request), or [email me](mailto:kfnagels@gmail.com) directly.

### Local setup

Dependencies:
* [Elm](https://guide.elm-lang.org/install.html)
* [Node](https://nodejs.org/en/download/)

```
git clone git@github.com:kfrn/film-figures.git
cd film-figures/
elm-package install
npm install -g create-elm-app
elm-app start
```

To run tests:
```
elm-app test
```

<!-- To deploy to github pages:
```
elm-app build
gh-pages -d build
``` -->

### Acknowledgements

This web app was scaffolded using [`create-elm-app`](https://www.npmjs.com/package/create-elm-app) and styled with assistance from [Bulma](https://bulma.io/).
