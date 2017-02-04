# coreos

自宅サーバーのCoreOSを構築します。

## Installation

最初にCoreOSを構築するときは、`wget`で`cloud-config.yml`をダウンロードして、`coreos-cloudinit`を行います。

```
$ wget https://raw.githubusercontent.com/u6k/coreos/master/cloud-config.yml
$ coreos-cloudinit -validate=true -from-file=./cloud-config.yml
$ sudo coreos-cloudinit -from-file=./cloud-config.yml
```

## Author

* [os-setup - u6k.Redmine()](https://redmine.u6k.me/projects/os-setup)
* [u6k/coreos](https://github.com/u6k/coreos)
* [u6k.Blog()](http://blog.u6k.me/)

## License

* [MIT License](https://github.com/u6k/coreos/blob/master/LICENSE)
