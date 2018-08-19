[![version](https://img.shields.io/badge/chromium-67-green.svg?style=flat-square)](https://pkgs.alpinelinux.org/package/edge/community/x86_64/chromium) [![build](https://img.shields.io/docker/build/deepsweet/ungoogled-chromium-headless-remote.svg?label=build&style=flat-square)](https://hub.docker.com/r/deepsweet/ungoogled-chromium-headless-remote/) [![size](https://img.shields.io/microbadger/image-size/deepsweet/ungoogled-chromium-headless-remote.svg?label=size&style=flat-square)](https://microbadger.com/images/deepsweet/ungoogled-chromium-headless-remote)

Dockerized [Ungoogled Chromium](https://github.com/Eloston/ungoogled-chromium) in [headless](https://chromium.googlesource.com/chromium/src/+/lkgr/headless/README.md) [remote debugging mode](https://chromedevtools.github.io/devtools-protocol/).

## Usage

```sh
docker pull deepsweet/ungoogled-chromium-headless-remote:67
docker run -it --rm -p 9222:9222 deepsweet/ungoogled-chromium-headless-remote:67
```

Example using [Puppeteer](https://github.com/GoogleChrome/puppeteer) (note that Chromium 67 works only with `puppeteer@~1.4.0`):

```js
import puppeteer from 'puppeteer'
import request from 'request-promise-native'

(async () => {
  try {
    const { body: { webSocketDebuggerUrl } } = await request({
      uri: 'http://localhost:9222/json/version',
      json: true,
      resolveWithFullResponse: true
    })
    const browser = await puppeteer.connect({
      browserWSEndpoint: webSocketDebuggerUrl
    })
    const page = await browser.newPage()

    await page.goto('https://example.com')
    await page.screenshot({ path: 'example.png' })
    await browser.close()
  } catch (err) {
    console.error(err)
  }
})()
```

## Fonts

It's possible to mount a folder with custom fonts to be used later by Chromium: add `-v $(pwd)/path/to/fonts:/home/chromium/.fonts` to `docker run` arguments.

## Related

* [chromium-headless-remote](https://github.com/deepsweet/chromium-headless-remote)
* [firefox-headless-remote](https://github.com/deepsweet/firefox-headless-remote)