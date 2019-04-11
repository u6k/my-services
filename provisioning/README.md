# u6kサービス用Dockerホスト _(my-services/provisioning)_

> u6kサービス用のDockerホストを構築するAnsible Playbook

## Install

ローカル環境をセットアップする手順です。

### 最低限のソフトウェアをインストール

```
apt update && apt -y upgrade && apt -y install git ansible python-apt vim tmux
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
