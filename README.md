# my-services

自宅サービスの構成を設計し、構築します。

## セットアップ

macOSをDockerホストとして運用します。アクセスは、VNCおよびsshでアクセスします。

### VNCをセットアップ

macOSの共有機能で、VNCをセットアップします。

### sshをセットアップ

macOSの共有機能で、sshをセットアップします。

### Docker for macOSをセットアップ

Docker for macOSをセットアップします。

### コンテナをセットアップ

以下のコンテナをセットアップします。launchdやsystemdではなく、`$HOME/Documents`に起動スクリプトを作成し、それで起動します。

* u6k/nginx-proxy https://github.com/u6k/nginx-proxy
* u6k/redmine https://github.com/u6k/redmine
* u6k/owncloud https://github.com/u6k/owncloud
* u6k/jenkins https://github.com/u6k/jenkins
* minio/minio: Minio is an open source object storage server compatible with Amazon S3 APIs https://github.com/minio/minio
* jpillora/docker-dnsmasq: dnsmasq in a docker container, configurable via a simple web UI https://github.com/jpillora/docker-dnsmasq

## ファイル構造

主なファイル、フォルダ構造は以下の通り。

* `$HOME/Documents`
    * Dockerコンテナ起動スクリプト
* `/Volumes/STORAGExxx/docker-volumes/`
    * Dockerデータ・ボリューム

## ハードウェア構造

* [ハードウェア構成図](doc/hardware.pu)

## サービス構造

* [自宅サービス構成図](doc/my-services.pu)

## Author

* [os-setup - u6k.Redmine()](https://redmine.u6k.me/projects/os-setup)
* [my-services](https://github.com/u6k/my-services)
* [u6k.Blog()](http://blog.u6k.me/)

## License

* [MIT License](https://github.com/u6k/coreos/blob/master/LICENSE)
