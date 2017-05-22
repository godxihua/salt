include:
  - zabbix
  - sysctl

service-disable:
  service.disabled:
    - name: NetworkManager
    - name: iscsi
    - name: portmap
    - name: rpcidmapd
    - name: rpcgssd
    - name: cups
    - name: iscsid
    - name: bluetooth
    - name: autofs
    - name: acpid
    - name: avahi-daemon
    - name: hidd
    - name: isdn
    - name: portmap
    - name: portreserve
    - name: ip6tables
    - name: netfs
    - name: nfslock
    - name: iptables

basic-svc-install:
  pkg.installed:
    - ntpdate
    - vim
    - openssh-client
    - zip
    - tree
    - telnet
    - nc
    - net-tools
    - dos2unix


/etc/security/limits.conf:
    - source: salt://files/limits.conf
      - user: root
      - group: root
      - mode: 644

/etc/security/limits.d/90-nproc.conf:
  file.managed:
    - source: salt://files/90-nproc.conf
      - user: root
      - group: root
      - mode: 644

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://files/sshd_config
      - user: root
      - group: root
      - mode: 644

/etc/resolv.conf:
  file.managed:
    - source: salt://files/resolv.conf
      - user: root
      - group: root
      - mode: 644

/data/scripts/travelzen_log_compress.sh:
  cmd.run:
    -name: mkir /data/scripts -p
  file.managed:
    - source: salt://files/travelzen_log_compress.sh
      - user: root
      - group: root
      - mode: 755

/data/log:
  cmd.run:
    -name: mkdir -p /data/log && chown -R tomcat. /data/log

/etc/cron.d/compress_log:
  file.managed:
    - source: salt://files/compress_log
      - user: root
      - group: root
      - mode: 755

/etc/profile:
  file.managed:
    - source: salt://files/profile
      - user: root
      - group: root
      - mode: 644
  cmd.run:
    - name: source /etc/profile

/etc/profile.d/java.sh:
  file.managed:
    - source: salt://files/java.sh
      - user: root
      - group: root
      - mode: 755
  cmd.run:
    - name: source /etc/profile.d/java.sh
    - require:
      - pkg: jdk-install

change-selinux:
  cmd.run:
    -name: setenforce 0 && sed -i '/^SELINUX=/c\SELINUX=disabled' /etc/selinux/config


jdk-install:
  file.managed:
    -name: /data/jdk1.8.0_77.tar.gz
    - source: salt://files/jdk1.8.0_77.tar.gz
  cmd.run:
    - name: cd /data && tar xf jdk1.8.0_77.tar.gz && ln -s jdk1.8.0_77 java

/data/apache-tomcat-8.0.35.tar.gz:
  file.managed:
    - source: salt://files/apache-tomcat-8.0.35.tar.gz

/opt/conf/tz-data/global/properties/zkService.properties:
  cmd.run:
    - name: mkdir -p /opt/conf/tz-data/global/properties
  file.managed:
    - source: salt://files/zkService.properties
      - user: root
      - group: root
      - mode: 644

/data/etc/local/ip:
  cmd.run:
    - name: mkdir /data/etc/local -p && echo ip=`ifconfig|grep 192|awk -F "[ :]+" '{print $4}'` >/data/etc/local/ip


