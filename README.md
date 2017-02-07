# coreos

自宅サーバーのCoreOSを構築します。

## Installation

最初にCoreOSを構築するときは、`wget`で`cloud-config.yml`をダウンロードして、`coreos-install`を行います。

```
$ wget https://raw.githubusercontent.com/u6k/coreos/master/cloud-config.yml
$ sudo coreos-install -d /dev/sda -C stable -c ./cloud-config.yml
```

2回目以降は、`coreos-cloudinit`を行います。

```
$ sudo coreos-cloudinit -from-file=./cloud-config.yml
$ sudo cp cloud-config.yml /var/lib/coreos-install/user_data
```

## Link

* [【CoreOS】cloud-config解説〜インストール - Qiita](http://qiita.com/xshsaku/items/1ba3f930ff80bef685a6)

## Author

* [os-setup - u6k.Redmine()](https://redmine.u6k.me/projects/os-setup)
* [u6k/coreos](https://github.com/u6k/coreos)
* [u6k.Blog()](http://blog.u6k.me/)

## License

* [MIT License](https://github.com/u6k/coreos/blob/master/LICENSE)
