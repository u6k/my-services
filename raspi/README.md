# Raspbian Stretch Lite仮想マシン _(my-services/raspi)_

> Raspbian Stretch Liteの仮想マシンを構築するAnsible Playbook

## Background

Raspbian Stretch LiteをインストールしたRaspberry Piに変更を行う前に、仮想マシンで変更内容の動作確認を行いたいです。この手順を使用することで、QEMU上で動作するRaspbian Stretch Liteの仮想マシンを構築することができます。

## Install

インストール手順を説明します。

### この手順によって構築される環境

この手順では、DigitalOcean Droplet上に環境を構築します。事前に、DigitalOceanを使用可能にしてください。同様の環境であれば、ローカルPC上のDebian仮想マシンなどでも手順を実行可能です。

この手順によって構築される環境を簡単に説明します。

- インストールされる主なソフトウェア
  - git
  - git-flow
  - tig
  - tmux
  - qemu
- SSH
  - ポート: 10022 (変更可能)
  - ユーザー: foo (変更可能)
  - 認証方式: 鍵認証 (公開鍵を要配置)
- git
  - git設定: `~/.gitconfig`を参照
  - gitユーザー: foo (変更可能)
  - メールアドレス: foo@example.com (変更可能)
- Raspbian作業環境
  - 作業ディレクトリ: `/var/raspi`
  - スタートアップ・スクリプト: `start-raspi.sh`

### Dropletを作成、ログイン

DigitalOceanのDropletを事前に作成します。筆者は次のDropletで作業を行いました。

- OS: Debian 9 x64
- Size: 512mb
- Region: sgp1

Dropletを作成したら、`root`でsshログインします。

### 最低限のソフトウェアをインストール

Ansible Playbookを実行するために、最低限のソフトウェアをインストールします。

```
apt update
apt -y upgrade
apt -y install git ansible python-apt
```

他に必要なソフトウェアがあれば、Ansible Playbookに追加するとよいです。

### `my-services`リポジトリをダウンロード

当リポジトリをダウンロードします。

```
git clone git@github.com:u6k/my-services.git
```

### Ansible Playbookを実行準備

Ansible Playbookを実行する前に、各種設定を行います。

現在は`root`で作業していますが、Ansible Playbookによって作業ユーザーが作成されるので、作業ユーザーの公開鍵を`id_rsa.pub`ファイルとして作成します。

`settings.yml.example`を参考に、`settings.yml`を作成します。このファイルには、[この手順によって構築される環境](#この手順によって構築される環境)で「変更可能」とした設定を記述します。

### Ansible Playbookを実行

いよいよ、Ansible Playbookを実行します。

```
ansible-playbook debian-on-digitalocean.yml -i hosts
```

問題なく終了したら、まずはsshログイン確認を行います。万が一、ssh設定が失敗していた場合、ログインすらできなくなってしまうので。

別のsshクライアントを起動して、`settings.yml`に設定したsshユーザーでログインを試みてください。

## Usage

Raspbian Stretch Lite仮想マシンを起動するには、次のコマンドを実行します。

```
cd /var/raspi/
./start-raspi.sh
```

## Maintainer

- u6k
  - [Twitter](https://twitter.com/u6k_yu1)
  - [GitHub](https://github.com/u6k)
  - [Blog](https://blog.u6k.me/)

## Contribute

当プロジェクトに興味を持っていただき、ありがとうございます。プルリクエストをサブミットしていただけると幸いです。

当プロジェクトは、[Contributor Covenant](https://www.contributor-covenant.org/version/1/4/code-of-conduct)に準拠します。

## License

MIT License
