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
  - 認証方式: 鍵認証 (変更可能)
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
apt update && apt -y upgrade && apt -y install git python-pip python-apt vim tmux && pip install ansible
```

> __TODO:__ Ansible v2.7.10のufwモジュールにバグがあるため、2.6系をインストールするとよい。例): `pip install ansible==2.6.16`

他に必要なソフトウェアがあれば、Ansible Playbookに追加するとよいです。

### `my-services`リポジトリをダウンロード

当リポジトリをダウンロードします。

```
git clone https://github.com/u6k/my-services.git
```

### Ansible Playbookを実行準備

Ansible Playbookを実行する前に、各種設定を行います。`settings.yml.example`を参考に、`settings.yml`を作成します。このファイルには、[この手順によって構築される環境](#この手順によって構築される環境)で「変更可能」とした設定を記述します。

### Ansible Playbookを実行

いよいよ、Ansible Playbookを実行します。

```
ansible-playbook debian-on-digitalocean.yml -i localhost, -c local
```

問題なく終了したら、まずはsshログイン確認を行います。万が一、ssh設定が失敗していた場合、ログインすらできなくなってしまうので。別のsshクライアントを起動して、`settings.yml`に設定したsshユーザーでログインを試みてください。

## Usage

### Raspbian Stretch Lite仮想マシンを起動

Raspbian Stretch Lite仮想マシンを起動するには、次のコマンドを実行します。ユーザーは`pi`、パスワードは`raspberry`です。

```
cd /var/raspi/
sudo ./start-raspi.sh
```

これだけで一応は使用可能ですが、いくつかの手順を実行すべきです。

### ストレージ容量を拡張

Raspbianイメージそのままだと空き容量が約1GBほどしかないので、イメージを拡張するべきです。Ansible Playbookの実行中に、実はRaspbianイメージを拡張していますが、これだけでは不十分で、Raspbian側でも実行する手順があります。なお、この手順は最初の一回のみ行います。

パーティションを操作するため、`fdisk`を実行します。

```
$ sudo fdisk /dev/sda

Welcome to fdisk (util-linux 2.29.2).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.
```

パーティションのリストを表示して、`/dev/sda2`の`Start`の値を覚えておきます。

```
Command (m for help): p

Disk /dev/sda: 5.8 GiB, 6161432576 bytes, 12034048 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x7ee80803

Device     Boot Start     End Sectors  Size Id Type
/dev/sda1        8192   98045   89854 43.9M  c W95 FAT32 (LBA)
/dev/sda2       98304 3645439 3547136  1.7G 83 Linux
```

`/dev/sda2`を削除します。

```
Command (m for help): d
Partition number (1,2, default 2): 2

Partition 2 has been deleted.
```

パーティションを作成します。

```
Command (m for help): n
Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): p
Partition number (2-4, default 2): 2
First sector (2048-12034047, default 2048): 98304
Last sector, +sectors or +size{K,M,G,T,P} (98304-12034047, default 12034047):

Created a new partition 2 of type 'Linux' and of size 5.7 GiB.
Partition #2 contains a ext4 signature.

Do you want to remove the signature? [Y]es/[N]o: n
```

パーティション情報を反映して、`fdisk`を終了します。

```
Command (m for help): w

The partition table has been altered.
Calling ioctl() to re-read partition table.
Re-reading the partition table failed.: デバイスもしくはリソースがビジー状態です

The kernel still uses the old table. The new table will be used at the next reboot or after you run partprobe(8) or kpartx(8).
```

Raspbianを再起動します。

```
$ sudo halt
```

```
$ sudo ./start-raspi.sh
```

ファイルシステムのリサイズします。

```
$ sudo resize2fs /dev/sda2
resize2fs 1.43.4 (31-Jan-2017)
Filesystem at /dev/sda2 is mounted on /; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 1
The filesystem on /dev/sda2 is now 1491968 (4k) blocks long.
```

`df`でファイルシステムを確認してみると、ストレージ容量が拡張されていることが分かります。

```
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       9.6G  1.1G  8.1G  12% /
devtmpfs        124M     0  124M   0% /dev
tmpfs           124M     0  124M   0% /dev/shm
tmpfs           124M  1.9M  122M   2% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           124M     0  124M   0% /sys/fs/cgroup
/dev/sda1        44M   23M   22M  51% /boot
tmpfs            25M     0   25M   0% /run/user/1000
```

### スワップ領域を追加

Raspbian仮想マシンはメモリが256MBしかないため、すぐにメモリを使い果たしてしまいます。そこで、スワップ領域を追加することでメモリ不足に対応します。`mkswap`は1回のみでよいですが、`swapon`はRaspbian仮想マシンの起動ごとに実行する必要があります。

Ansible Playbookの実行時に、`temp.img`というイメージを作成しており、`sdb`としてマウント済みです。ですので、次のコマンドでスワップ領域を作成することができます。

```
$ sudo mkswap /dev/sdb
Setting up swapspace version 1, size = 4 GiB (4294963200 bytes)
no label, UUID=c9aeeeea-f89e-4c7b-9ade-ee18a2736d15
```

`/dev/sdb`をスワップ領域として有効にするため、次のコマンドを実行します。

```
$ sudo swapon /dev/sdb
```

### OS設定

Raspbianでおなじみの`raspi-config`を実行します。

```
$ sudo raspi-config
```

次の項目を変更すればよいです。

- 5 Interfacing Options
  - P2 SSH
- 6 Overclock
  - Turbo

> __NOTE:__ ロケール、タイムゾーンは後でAnsibleで設定します。`raspi-config`の更新は、後で`apt upgrade`で行います。

これで、Raspbian仮想マシンのsshが有効化されます。試しに、DropletからRaspbian仮想マシンにssh接続してみます。

```
$ ssh -p 10022 pi@localhost
```

### ファームウェアを更新

ファームウェアを更新します。

```
$ sudo rpi-update
```

### バックアップ

これで、いろいろ実験できるRaspbian仮想マシンが整いました。念のため、バックアップを取得しておきます。Raspbian仮想マシンをシャットダウンして、イメージをコピーします。

```
$ sudo halt
```

```
$ cp 2019-04-08-raspbian-stretch-lite.img 2019-04-08-raspbian-stretch-lite.img.bak
```

何かあっても、`.bak`ファイルで上書きすれば、現時点の状況まで戻ります。

### Ansible PlaybookをRaspbian仮想マシンに実行

Raspbian仮想マシンをセットアップするために、Ansible Playbookを実行します。実行手順は、DebianにAnsible Playbookを実行した時と同様です。Playbookは `raspi.yml` を使います。

### サーバー証明書を生成

`raspi.yml`を実行すると、次のようにセットアップされます。

- minioサービス
- nginxによるリバース・プロキシ
- certbot-auto
- MyDNSのIPアドレスの定期更新

minioサービスをHTTPSで公開するため、サーバー証明書を生成します。次のコマンドを実行して、質問に回答します。

```
$ certbot-auto certonly --webroot -w /var/www/s3.u6k.me -d s3.u6k.me
```

生成されたサーバー証明書の有効期限は3か月間なので、定期的に次のコマンドを実行してサーバー証明書を更新します。

```
$ certbot-auto renew
```

### HTTPSでminioサービスを公開

`/etc/nginx/sites-available/minio-https`に、minioサービスをHTTPSで公開するための設定が記述されているので、これを有効かします。

```
$ sudo ln -s /etc/nginx/sites-available/minio-https /etc/nginx/sites-enabled/minio-https
```

その後、nginxサービスをリロードして、設定を反映します。

```
$ sudo systemctl reload nginx
```

https://s3.u6k.me にブラウザや`aws-cli`からアクセスできることを確認します。

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
