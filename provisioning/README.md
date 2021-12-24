# u6kサービス用Dockerホスト _(my-services/provisioning)_

> u6kサービス用のDockerホストを構築するAnsible Playbook

## Install

ローカル環境をセットアップする手順です。

### 最低限のソフトウェアをインストール

```
apt update && apt -y upgrade && apt -y --no-install-recommends install git python3-pip python3-apt vim tmux && ln -s /usr/bin/python3 /usr/bin/python && pip install ansible
```

他に必要なソフトウェアがある場合は、Ansible Playbookに追加します。

### `my-services`リポジトリをダウンロード

```
git clone https://github.com/u6k/my-services.git
```

### 準備

`settings.yml.example`を参考に`settings.yml`を作成します。

### Ansible Playbookを実行

```
ansible-playbook debian-for-docker.yml -i localhost, -c local
```

### Vimセットアップ

> __TODO:__ Playbookで実行したい

```
wget https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh
chmod +x install.sh
./install.sh
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
