
# 個人サービス (my-services)

[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> 個人サービスの構成を設計し、構築します。

## Background

私のサービスは、基本的にDockerコンテナで動作します。それぞれのサービスはそれぞれのリポジトリで開発しています。当リポジトリでは、Dockerホストの構築やジョブの管理を行います。

## Install

本番用個人サーバーを構築する手順を説明します。

### 前提

Dockerホストの構築にAnsibleを使用します。

```
$ ansible --version
ansible 2.5.0
  config file = None
  configured module search path = [u'/Users/yu1/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/Cellar/ansible/2.5.0/libexec/lib/python2.7/site-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 2.7.14 (default, Apr 16 2018, 21:09:19) [GCC 4.2.1 Compatible Apple LLVM 9.0.0 (clang-900.0.39.2)]
```

`vagrant provision` に成功しても、実サーバーへのプロビジョニングが失敗することがしばしばあることに留意してください。

### 設定

`provision/` フォルダに移動します。

`hosts` ファイルに、構築対象サーバーのIPアドレスを記載します。

サーバーの作業者ユーザーに設定する公開鍵を `id_rsa.pub` ファイルとして配置します。

`settings.yml` ファイルを作成します。設定内容は `settings.yml.example.` を参照してください。

`digitalocean.yml` ファイルの `hosts` と `user` を設定します。

### プロビジョニング

まず、疎通確認のために次のコマンドを実行します。

```
$ ansible <対象ホスト> -i hosts -u <対象ホストのユーザー> -m ping
```

成功したら、プロビジョニングを実行します。

```
$ ansible-playbook -i hosts digitalocean.yml | tee ansible.log
```

## Usage

各サービスの使い方は、サービスごとのドキュメントを参照してください。

## Development

個人サーバーの開発を行う手順を説明します。

### 前提

開発作業にはVagrantを使用します。

```
$ vagrant --version
Vagrant 2.0.3
```

### 設定

`digitalocean.yml` ファイル、 `hosts` ファイルは、Vagrant用に設定されています。

`settings.yml.example` Vagrant用に設定されており、 `settings.yml` ファイルとしてコピーすることで使用できます。

`id_rsa.pub` ファイルは、実際の公開鍵を用意してください。

### プロビジョニング

まず、仮想サーバーを起動します。

```
$ vagrant up
```

起動したら、接続確認を行います。

```
$ vagrant ssh
```

プロビジョニングを行います。

```
$ vagrant provision
```

プロビジョニング後は `vagrant up` できません。 `ssh` コマンドで接続する必要があります。

```
$ ssh -p 10022 foo@localhost
```

## ハードウェア構造

TODO

## サービス構造

TODO

## Maintainer

- [os-setup - u6k.Redmine()](https://redmine.u6k.me/projects/os-setup)
- [my-services](https://github.com/u6k/my-services)
- [u6k.Blog()](http://blog.u6k.me/)

## Contribute

ライセンスの範囲内で、ご自由にご利用ください。

## License

- [MIT License](https://github.com/u6k/my-services/blob/master/LICENSE)
