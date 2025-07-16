# Bind9 DNS Server Configuration Guide

This document provides a detailed, step-by-step guide to installing and configuring Bind9 on a Debian-based server. At the end, you’ll find key points and security considerations to keep your DNS service robust and secure.

---

## Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Core Configuration Files](#core-configuration-files)

   - [named.conf](#namedconfnamed-conf)
   - [named.conf.options](#namedconfoptions)
   - [named.conf.local](#namedconflocal)

5. [Zone File Structure](#zone-file-structure)

   - [SOA Record](#soa-record)
   - [NS Records](#ns-records)
   - [A and AAAA Records](#a-and-aaaa-records)
   - [SRV and Other Records](#srv-and-other-records)

6. [Creating a Master Zone File](#creating-a-master-zone-file)
7. [Validating and Reloading Configuration](#validating-and-reloading-configuration)
8. [Client Configuration](#client-configuration)
9. [Key Points & Security Considerations](#key-points--security-considerations)

---

## Introduction

Bind9 is the most widely used DNS server on Linux systems. It can act as:

- An **authoritative server** for your custom domains (zones)
- A **caching/forwarding server** for recursive queries

This guide covers:

- Installing Bind9
- Configuring core files (`named.conf`, `named.conf.options`, `named.conf.local`)
- Writing zone files
- Best practices and security hardening

---

## Prerequisites

- A Debian-based server (Debian, Ubuntu)
- Root or sudo privileges
- Static public IP for the DNS server
- Basic familiarity with Linux command-line

---

## Installation

Install Bind9 and its utilities:

```bash
sudo apt update
sudo apt install bind9 bind9utils bind9-doc dnsutils
```

Services:

- `bind9`: the actual DNS server
- `rndc`: remote management utility

---

## Core Configuration Files

Bind9’s main configuration resides under `/etc/bind`:

- `named.conf`: top‑level file that includes others
- `named.conf.options`: global server options
- `named.conf.local`: your zone definitions
- `db.*`: individual zone files

### named.conf

```conf
include "/etc/bind/named.conf.options";
include "/etc/bind/named.conf.local";
include "/etc/bind/named.conf.default-zones";
```

### named.conf.options

```conf
options {
    directory "/var/cache/bind";

    recursion yes;
    forward only;
    forwarders { 8.8.8.8; 8.8.4.4; };

    allow-query     { localhost; };
    allow-recursion { localhost; };

    dnssec-validation auto;
    auth-nxdomain no;
};
```

### named.conf.local

```conf
zone "example.com" {
    type master;
    file "/etc/bind/db.example.com";
};

zone "1.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192.168.1";
};
```

---

## Zone File Structure

A DNS zone file defines how domain names map to IP addresses and services.

### SOA Record

**SOA** (Start of Authority) defines the primary DNS server for the zone and metadata.

```zone
@   IN SOA ns.example.com. hostmaster.example.com. (
        2025071601 ; serial
        3600       ; refresh
        1800       ; retry
        604800     ; expire
        86400      ; minimum
)
```

### NS Records

Define the authoritative name servers:

```zone
    IN NS  ns.example.com.
ns  IN A   45.149.79.182
```

### A and AAAA Records

- **A Record** maps a domain name to an **IPv4 address**.
- **AAAA Record** maps a domain name to an **IPv6 address**.

```zone
@   IN A    45.149.79.182
@   IN AAAA 2001:db8::1
www IN A    45.149.79.182
```

These records allow users to access your server via domain name.

### SRV and Other Records

Used to locate services:

```zone
_http._tcp   IN SRV 0 5 80  example.com.
```

---

## Creating a Master Zone File

Example `/etc/bind/db.example.com`:

```zone
$TTL 3600
@   IN SOA ns.example.com. hostmaster.example.com. (
      2025071601 ; serial (YYYYMMDDNN)
      3600       ; refresh
      1800       ; retry
      604800     ; expire
      86400      ; minimum
)
    IN NS   ns.example.com.
ns  IN A    45.149.79.182
@   IN A    45.149.79.182
www IN A    45.149.79.182
```

**Tip:** Increment the serial on every change to notify secondary servers.

---

## Validating and Reloading Configuration

```bash
sudo named-checkconf                         # Validate main config
sudo named-checkzone example.com /etc/bind/db.example.com
sudo systemctl reload bind9                  # Apply changes
sudo systemctl status bind9
```

---

## Client Configuration

Set your client’s DNS to the server’s IP address.

- **Linux**: edit `/etc/resolv.conf` or your network manager
- **Windows**: set "Preferred DNS server" in adapter settings
- **macOS**: System Settings → Network → DNS

Test:

```bash
dig @your_server_ip example.com
```

---

## Key Points & Security Considerations

- **Restrict access** with `allow-query` and `allow-recursion`
- **Enable DNSSEC** for data integrity
- **Use logging** (`logging {}`) to monitor activity
- **Disable zone transfers** unless needed (via `allow-transfer { none; };`)
- **Use proper serial format** `YYYYMMDDNN` and increment on changes
- **Restrict listening interfaces** to required ones only
- **Keep system and Bind9 updated** regularly

---

**With this guide**, you can deploy a robust DNS server capable of authoritative responses, forwarding, and secure operation.
