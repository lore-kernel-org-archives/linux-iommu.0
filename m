Return-Path: <SRS0=eKRE=6H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA0CC54FD0
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 14:12:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638642087E
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 14:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGPhU/k5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638642087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 277A7875C7;
	Thu, 23 Apr 2020 14:12:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XFpXut9QH8go; Thu, 23 Apr 2020 14:12:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D2E418542B;
	Thu, 23 Apr 2020 14:12:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B61ECC1797;
	Thu, 23 Apr 2020 14:12:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94B92C0175
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 09:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 817ED227AD
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 09:12:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nphmEVzTkWEN for <iommu@lists.linux-foundation.org>;
 Thu, 23 Apr 2020 09:12:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by silver.osuosl.org (Postfix) with ESMTPS id B1EC02002E
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 09:12:11 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id s10so5956681wrr.0
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ckTkXMIImLZQkAABiP/OQlaCBE4okxOqOEwcuo+QihQ=;
 b=CGPhU/k5RIRq/GFoi45Fu4ezt1ylxNxG0BsXsC66yUpI/wEdOGE52pRZ99hdWHVdHo
 ED8QknOGEkDx3xTAlYE0P2uCZCYzbpKWfolHtVo7PO+5mgR91sXmKgavfGlZ0Hvj2FuR
 D+MDElbRcjCbzkwYdq1g0AuNredPP+l2iQVztZSG4FAvIWTCrWBQoebxVz19TL4nC7RE
 hBxfPp9wp55zxMw2d2lR6p6EBNTLVMwHfXrSEbOsI9r8qDd/xP4/Cm1okAHPtOWf0wzk
 YZkFva/LzdhN/R4bxBTAmL40LP6e16Q6PzZoJtKwAQdtBG+YljES1z1vu8qJ67O1gQ4w
 BwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ckTkXMIImLZQkAABiP/OQlaCBE4okxOqOEwcuo+QihQ=;
 b=gipTW1ELyXCyVivXzJCSi++1NOS9cf8VuwfnYFTVouxrXtGDTJ3ipG6ussa7NfFa6c
 72i2WeY+LasaEwHR2w2coGU8rY5hvpb+LDjNhHWdxuLVdinYUjbv2Np/SNMp6XkzDF3h
 NPJOx7zxA3Fu4WJqX6RfIv9zZi7sy2ShkfEVTVLGY7fJ3LFvMMmlDlqWez3602F670/A
 wVWPatX4/AiN6nYAU83k++zybnHs5YWqqckluVhWFec2a5IiBReMHpcRHpnqVuO0pljV
 PDw89Jm6t5FtkITh7jB1pc6Bqjq5WRDO4F3EYX9LwoTiPOGxD12NYj4tavx35185cQdZ
 2nUA==
X-Gm-Message-State: AGi0PuY7LyPaezqzqiwfUgTtcvW7nl5o9IZ9v7JiJ/BPp93ZLecS5O1K
 r5BUDAAX1Sz0RjY9lg6lwbDpJSSPPXRxZ7XuLFskt317alM=
X-Google-Smtp-Source: APiQypJK+SZZBTzMApnx9Bi/TWk35EJMH+3xyTw54s+lNuvGvmuMLRru96Ohty53c9ayH8v5a14oWbcevU8nxZokhew=
X-Received: by 2002:adf:84c2:: with SMTP id 60mr3726730wrg.65.1587633129634;
 Thu, 23 Apr 2020 02:12:09 -0700 (PDT)
MIME-Version: 1.0
From: Bin <anole1949@gmail.com>
Date: Thu, 23 Apr 2020 17:11:58 +0800
Message-ID: <CAEbUFv6SHY8z2kuNFwZ4khFwgqLZjxi4-KfDv5kVANeROMU_Vw@mail.gmail.com>
Subject: iommu_iova slab eats too much memory
To: iommu@lists.linux-foundation.org
X-Mailman-Approved-At: Thu, 23 Apr 2020 14:12:44 +0000
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1863747385704331581=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============1863747385704331581==
Content-Type: multipart/alternative; boundary="000000000000b9c03205a3f1a4ae"

--000000000000b9c03205a3f1a4ae
Content-Type: text/plain; charset="UTF-8"

Hey, guys:

I'm running a batch of CoreOS boxes, the lsb_release is:

```
# cat /etc/lsb-release
DISTRIB_ID="Container Linux by CoreOS"
DISTRIB_RELEASE=2303.3.0
DISTRIB_CODENAME="Rhyolite"
DISTRIB_DESCRIPTION="Container Linux by CoreOS 2303.3.0 (Rhyolite)"
```

```
# uname -a
Linux cloud-worker-25 4.19.86-coreos #1 SMP Mon Dec 2 20:13:38 -00 2019
x86_64 Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz GenuineIntel GNU/Linux
```
Recently, I found my vms constently being killed due to OOM, and after
digging into the problem, I finally realized that the kernel is leaking
memory.

Here's my slabinfo:

 Active / Total Objects (% used)    : 83818306 / 84191607 (99.6%)
 Active / Total Slabs (% used)      : 1336293 / 1336293 (100.0%)
 Active / Total Caches (% used)     : 152 / 217 (70.0%)
 Active / Total Size (% used)       : 5828768.08K / 5996848.72K (97.2%)
 Minimum / Average / Maximum Object : 0.01K / 0.07K / 23.25K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME

80253888 80253888 100%    0.06K 1253967       64   5015868K iommu_iova

489472 489123  99%    0.03K   3824      128     15296K kmalloc-32

297444 271112  91%    0.19K   7082       42     56656K dentry

254400 252784  99%    0.06K   3975       64     15900K anon_vma_chain

222528  39255  17%    0.50K   6954       32    111264K kmalloc-512

202482 201814  99%    0.19K   4821       42     38568K vm_area_struct

200192 200192 100%    0.01K    391      512      1564K kmalloc-8

170528 169359  99%    0.25K   5329       32     42632K filp

158144 153508  97%    0.06K   2471       64      9884K kmalloc-64

149914 149365  99%    0.09K   3259       46     13036K anon_vma

146640 143123  97%    0.10K   3760       39     15040K buffer_head

130368  32791  25%    0.09K   3104       42     12416K kmalloc-96

129752 129752 100%    0.07K   2317       56      9268K Acpi-Operand

105468 105106  99%    0.04K   1034      102      4136K
selinux_inode_security
 73080  73080 100%    0.13K   2436       30      9744K kernfs_node_cache

 72360  70261  97%    0.59K   1340       54     42880K inode_cache

 71040  71040 100%    0.12K   2220       32      8880K eventpoll_epi

 68096  59262  87%    0.02K    266      256      1064K kmalloc-16

 53652  53652 100%    0.04K    526      102      2104K pde_opener

 50496  31654  62%    2.00K   3156       16    100992K kmalloc-2048

 46242  46242 100%    0.19K   1101       42      8808K cred_jar

 44496  43013  96%    0.66K    927       48     29664K proc_inode_cache

 44352  44352 100%    0.06K    693       64      2772K task_delay_info

 43516  43471  99%    0.69K    946       46     30272K sock_inode_cache

 37856  27626  72%    1.00K   1183       32     37856K kmalloc-1024

 36736  36736 100%    0.07K    656       56      2624K eventpoll_pwq

 34076  31282  91%    0.57K   1217       28     19472K radix_tree_node

 33660  30528  90%    1.05K   1122       30     35904K ext4_inode_cache

 32760  30959  94%    0.19K    780       42      6240K kmalloc-192

 32028  32028 100%    0.04K    314      102      1256K ext4_extent_status

 30048  30048 100%    0.25K    939       32      7512K skbuff_head_cache

 28736  28736 100%    0.06K    449       64      1796K fs_cache

 24702  24702 100%    0.69K    537       46     17184K files_cache

 23808  23808 100%    0.66K    496       48     15872K ovl_inode

 23104  22945  99%    0.12K    722       32      2888K kmalloc-128

 22724  21307  93%    0.69K    494       46     15808K shmem_inode_cache

 21472  21472 100%    0.12K    671       32      2684K seq_file

 19904  19904 100%    1.00K    622       32     19904K UNIX

 17340  17340 100%    1.06K    578       30     18496K mm_struct

 15980  15980 100%    0.02K     94      170       376K avtab_node

 14070  14070 100%    1.06K    469       30     15008K signal_cache

 13248  13248 100%    0.12K    414       32      1656K pid

 12128  11777  97%    0.25K    379       32      3032K kmalloc-256

 11008  11008 100%    0.02K     43      256       172K
selinux_file_security
 10812  10812 100%    0.04K    106      102       424K Acpi-Namespace

These information shows that the 'iommu_iova' is the top memory consumer.
In order to optimize the network performence of Openstack virtual machines,
I enabled the vt-d feature in bios and sriov feature of Intel 82599 10G
NIC. I'm assuming this is the root cause of this issue.

Is there anything I can do to fix it?

--000000000000b9c03205a3f1a4ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGV5LCBndXlzOjxkaXY+PGJyPjwvZGl2PjxkaXY+SSYjMzk7bSBydW5u
aW5nIGEgYmF0Y2ggb2YgQ29yZU9TIGJveGVzLCB0aGUgbHNiX3JlbGVhc2UgaXM6PGJyPjxicj5g
YGA8YnI+IyBjYXQgL2V0Yy9sc2ItcmVsZWFzZTxicj5ESVNUUklCX0lEPSZxdW90O0NvbnRhaW5l
ciBMaW51eCBieSBDb3JlT1MmcXVvdDs8YnI+RElTVFJJQl9SRUxFQVNFPTIzMDMuMy4wPGJyPkRJ
U1RSSUJfQ09ERU5BTUU9JnF1b3Q7Umh5b2xpdGUmcXVvdDs8YnI+RElTVFJJQl9ERVNDUklQVElP
Tj0mcXVvdDtDb250YWluZXIgTGludXggYnkgQ29yZU9TIDIzMDMuMy4wIChSaHlvbGl0ZSkmcXVv
dDs8YnI+YGBgPGJyPjxicj5gYGA8YnI+IyB1bmFtZSAtYTxicj5MaW51eCBjbG91ZC13b3JrZXIt
MjUgNC4xOS44Ni1jb3Jlb3MgIzEgU01QIE1vbiBEZWMgMiAyMDoxMzozOCAtMDAgMjAxOTxicj54
ODZfNjQgSW50ZWwoUikgWGVvbihSKSBDUFUgRTUtMjY0MCB2MiBAIDIuMDBHSHogR2VudWluZUlu
dGVsIEdOVS9MaW51eDxicj5gYGA8YnI+UmVjZW50bHksIEkgZm91bmQgbXkgdm1zIGNvbnN0ZW50
bHkgYmVpbmcga2lsbGVkIGR1ZSB0byBPT00sIGFuZCBhZnRlcjxicj5kaWdnaW5nIGludG8gdGhl
IHByb2JsZW0sIEkgZmluYWxseSByZWFsaXplZCB0aGF0IHRoZSBrZXJuZWwgaXMgbGVha2luZzxi
cj5tZW1vcnkuPGJyPjxicj5IZXJlJiMzOTtzIG15IHNsYWJpbmZvOjxicj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PsKgQWN0aXZlIC8gVG90YWwgT2JqZWN0cyAoJSB1c2VkKSDCoCDCoDogODM4
MTgzMDYgLyA4NDE5MTYwNyAoOTkuNiUpPGJyPsKgQWN0aXZlIC8gVG90YWwgU2xhYnMgKCUgdXNl
ZCkgwqAgwqAgwqA6IDEzMzYyOTMgLyAxMzM2MjkzICgxMDAuMCUpPGJyPsKgQWN0aXZlIC8gVG90
YWwgQ2FjaGVzICglIHVzZWQpIMKgIMKgIDogMTUyIC8gMjE3ICg3MC4wJSk8YnI+wqBBY3RpdmUg
LyBUb3RhbCBTaXplICglIHVzZWQpIMKgIMKgIMKgIDogNTgyODc2OC4wOEsgLyA1OTk2ODQ4Ljcy
SyAoOTcuMiUpPGJyPsKgTWluaW11bSAvIEF2ZXJhZ2UgLyBNYXhpbXVtIE9iamVjdCA6IDAuMDFL
IC8gMC4wN0sgLyAyMy4yNUs8YnI+PGJyPsKgIE9CSlMgQUNUSVZFIMKgVVNFIE9CSiBTSVpFIMKg
U0xBQlMgT0JKL1NMQUIgQ0FDSEUgU0laRSBOQU1FIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IDxicj44MDI1Mzg4OCA4MDI1Mzg4OCAxMDAlIMKgIMKgMC4wNksgMTI1Mzk2NyDCoCDCoCDCoCA2
NCDCoCA1MDE1ODY4SyBpb21tdV9pb3ZhIMKgIMKgIMKgIMKgIMKgIMKgIDxicj40ODk0NzIgNDg5
MTIzIMKgOTklIMKgIMKgMC4wM0sgwqAgMzgyNCDCoCDCoCDCoDEyOCDCoCDCoCAxNTI5Nksga21h
bGxvYy0zMiDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+Mjk3NDQ0IDI3MTExMiDCoDkxJSDCoCDCoDAu
MTlLIMKgIDcwODIgwqAgwqAgwqAgNDIgwqAgwqAgNTY2NTZLIGRlbnRyeSDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCA8YnI+MjU0NDAwIDI1Mjc4NCDCoDk5JSDCoCDCoDAuMDZLIMKgIDM5NzUgwqAg
wqAgwqAgNjQgwqAgwqAgMTU5MDBLIGFub25fdm1hX2NoYWluIMKgIMKgIMKgIMKgIDxicj4yMjI1
MjggwqAzOTI1NSDCoDE3JSDCoCDCoDAuNTBLIMKgIDY5NTQgwqAgwqAgwqAgMzIgwqAgwqAxMTEy
NjRLIGttYWxsb2MtNTEyIMKgIMKgIMKgIMKgIMKgIMKgPGJyPjIwMjQ4MiAyMDE4MTQgwqA5OSUg
wqAgwqAwLjE5SyDCoCA0ODIxIMKgIMKgIMKgIDQyIMKgIMKgIDM4NTY4SyB2bV9hcmVhX3N0cnVj
dCDCoCDCoCDCoCDCoCA8YnI+MjAwMTkyIDIwMDE5MiAxMDAlIMKgIMKgMC4wMUsgwqAgwqAzOTEg
wqAgwqAgwqA1MTIgwqAgwqAgwqAxNTY0SyBrbWFsbG9jLTggwqAgwqAgwqAgwqAgwqAgwqAgwqA8
YnI+MTcwNTI4IDE2OTM1OSDCoDk5JSDCoCDCoDAuMjVLIMKgIDUzMjkgwqAgwqAgwqAgMzIgwqAg
wqAgNDI2MzJLIGZpbHAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgPGJyPjE1ODE0NCAxNTM1
MDggwqA5NyUgwqAgwqAwLjA2SyDCoCAyNDcxIMKgIMKgIMKgIDY0IMKgIMKgIMKgOTg4NEsga21h
bGxvYy02NCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+MTQ5OTE0IDE0OTM2NSDCoDk5JSDCoCDCoDAu
MDlLIMKgIDMyNTkgwqAgwqAgwqAgNDYgwqAgwqAgMTMwMzZLIGFub25fdm1hIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIDxicj4xNDY2NDAgMTQzMTIzIMKgOTclIMKgIMKgMC4xMEsgwqAgMzc2MCDCoCDC
oCDCoCAzOSDCoCDCoCAxNTA0MEsgYnVmZmVyX2hlYWQgwqAgwqAgwqAgwqAgwqAgwqA8YnI+MTMw
MzY4IMKgMzI3OTEgwqAyNSUgwqAgwqAwLjA5SyDCoCAzMTA0IMKgIMKgIMKgIDQyIMKgIMKgIDEy
NDE2SyBrbWFsbG9jLTk2IMKgIMKgIMKgIMKgIMKgIMKgIDxicj4xMjk3NTIgMTI5NzUyIDEwMCUg
wqAgwqAwLjA3SyDCoCAyMzE3IMKgIMKgIMKgIDU2IMKgIMKgIMKgOTI2OEsgQWNwaS1PcGVyYW5k
IMKgIMKgIMKgIMKgIMKgIDxicj4xMDU0NjggMTA1MTA2IMKgOTklIMKgIMKgMC4wNEsgwqAgMTAz
NCDCoCDCoCDCoDEwMiDCoCDCoCDCoDQxMzZLIHNlbGludXhfaW5vZGVfc2VjdXJpdHkgPGJyPsKg
NzMwODAgwqA3MzA4MCAxMDAlIMKgIMKgMC4xM0sgwqAgMjQzNiDCoCDCoCDCoCAzMCDCoCDCoCDC
oDk3NDRLIGtlcm5mc19ub2RlX2NhY2hlIMKgIMKgIMKgPGJyPsKgNzIzNjAgwqA3MDI2MSDCoDk3
JSDCoCDCoDAuNTlLIMKgIDEzNDAgwqAgwqAgwqAgNTQgwqAgwqAgNDI4ODBLIGlub2RlX2NhY2hl
IMKgIMKgIMKgIMKgIMKgIMKgPGJyPsKgNzEwNDAgwqA3MTA0MCAxMDAlIMKgIMKgMC4xMksgwqAg
MjIyMCDCoCDCoCDCoCAzMiDCoCDCoCDCoDg4ODBLIGV2ZW50cG9sbF9lcGkgwqAgwqAgwqAgwqAg
wqA8YnI+wqA2ODA5NiDCoDU5MjYyIMKgODclIMKgIMKgMC4wMksgwqAgwqAyNjYgwqAgwqAgwqAy
NTYgwqAgwqAgwqAxMDY0SyBrbWFsbG9jLTE2IMKgIMKgIMKgIMKgIMKgIMKgIDxicj7CoDUzNjUy
IMKgNTM2NTIgMTAwJSDCoCDCoDAuMDRLIMKgIMKgNTI2IMKgIMKgIMKgMTAyIMKgIMKgIMKgMjEw
NEsgcGRlX29wZW5lciDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+wqA1MDQ5NiDCoDMxNjU0IMKgNjIl
IMKgIMKgMi4wMEsgwqAgMzE1NiDCoCDCoCDCoCAxNiDCoCDCoDEwMDk5Mksga21hbGxvYy0yMDQ4
IMKgIMKgIMKgIMKgIMKgIDxicj7CoDQ2MjQyIMKgNDYyNDIgMTAwJSDCoCDCoDAuMTlLIMKgIDEx
MDEgwqAgwqAgwqAgNDIgwqAgwqAgwqA4ODA4SyBjcmVkX2phciDCoCDCoCDCoCDCoCDCoCDCoCDC
oCA8YnI+wqA0NDQ5NiDCoDQzMDEzIMKgOTYlIMKgIMKgMC42NksgwqAgwqA5MjcgwqAgwqAgwqAg
NDggwqAgwqAgMjk2NjRLIHByb2NfaW5vZGVfY2FjaGUgwqAgwqAgwqAgPGJyPsKgNDQzNTIgwqA0
NDM1MiAxMDAlIMKgIMKgMC4wNksgwqAgwqA2OTMgwqAgwqAgwqAgNjQgwqAgwqAgwqAyNzcySyB0
YXNrX2RlbGF5X2luZm8gwqAgwqAgwqAgwqA8YnI+wqA0MzUxNiDCoDQzNDcxIMKgOTklIMKgIMKg
MC42OUsgwqAgwqA5NDYgwqAgwqAgwqAgNDYgwqAgwqAgMzAyNzJLIHNvY2tfaW5vZGVfY2FjaGUg
wqAgwqAgwqAgPGJyPsKgMzc4NTYgwqAyNzYyNiDCoDcyJSDCoCDCoDEuMDBLIMKgIDExODMgwqAg
wqAgwqAgMzIgwqAgwqAgMzc4NTZLIGttYWxsb2MtMTAyNCDCoCDCoCDCoCDCoCDCoCA8YnI+wqAz
NjczNiDCoDM2NzM2IDEwMCUgwqAgwqAwLjA3SyDCoCDCoDY1NiDCoCDCoCDCoCA1NiDCoCDCoCDC
oDI2MjRLIGV2ZW50cG9sbF9wd3EgwqAgwqAgwqAgwqAgwqA8YnI+wqAzNDA3NiDCoDMxMjgyIMKg
OTElIMKgIMKgMC41N0sgwqAgMTIxNyDCoCDCoCDCoCAyOCDCoCDCoCAxOTQ3MksgcmFkaXhfdHJl
ZV9ub2RlIMKgIMKgIMKgIMKgPGJyPsKgMzM2NjAgwqAzMDUyOCDCoDkwJSDCoCDCoDEuMDVLIMKg
IDExMjIgwqAgwqAgwqAgMzAgwqAgwqAgMzU5MDRLIGV4dDRfaW5vZGVfY2FjaGUgwqAgwqAgwqAg
PGJyPsKgMzI3NjAgwqAzMDk1OSDCoDk0JSDCoCDCoDAuMTlLIMKgIMKgNzgwIMKgIMKgIMKgIDQy
IMKgIMKgIMKgNjI0MEsga21hbGxvYy0xOTIgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAzMjAyOCDC
oDMyMDI4IDEwMCUgwqAgwqAwLjA0SyDCoCDCoDMxNCDCoCDCoCDCoDEwMiDCoCDCoCDCoDEyNTZL
IGV4dDRfZXh0ZW50X3N0YXR1cyDCoCDCoCA8YnI+wqAzMDA0OCDCoDMwMDQ4IDEwMCUgwqAgwqAw
LjI1SyDCoCDCoDkzOSDCoCDCoCDCoCAzMiDCoCDCoCDCoDc1MTJLIHNrYnVmZl9oZWFkX2NhY2hl
IMKgIMKgIMKgPGJyPsKgMjg3MzYgwqAyODczNiAxMDAlIMKgIMKgMC4wNksgwqAgwqA0NDkgwqAg
wqAgwqAgNjQgwqAgwqAgwqAxNzk2SyBmc19jYWNoZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+
wqAyNDcwMiDCoDI0NzAyIDEwMCUgwqAgwqAwLjY5SyDCoCDCoDUzNyDCoCDCoCDCoCA0NiDCoCDC
oCAxNzE4NEsgZmlsZXNfY2FjaGUgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAyMzgwOCDCoDIzODA4
IDEwMCUgwqAgwqAwLjY2SyDCoCDCoDQ5NiDCoCDCoCDCoCA0OCDCoCDCoCAxNTg3Mksgb3ZsX2lu
b2RlIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGJyPsKgMjMxMDQgwqAyMjk0NSDCoDk5JSDCoCDCoDAu
MTJLIMKgIMKgNzIyIMKgIMKgIMKgIDMyIMKgIMKgIMKgMjg4OEsga21hbGxvYy0xMjggwqAgwqAg
wqAgwqAgwqAgwqA8YnI+wqAyMjcyNCDCoDIxMzA3IMKgOTMlIMKgIMKgMC42OUsgwqAgwqA0OTQg
wqAgwqAgwqAgNDYgwqAgwqAgMTU4MDhLIHNobWVtX2lub2RlX2NhY2hlIMKgIMKgIMKgPGJyPsKg
MjE0NzIgwqAyMTQ3MiAxMDAlIMKgIMKgMC4xMksgwqAgwqA2NzEgwqAgwqAgwqAgMzIgwqAgwqAg
wqAyNjg0SyBzZXFfZmlsZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+wqAxOTkwNCDCoDE5OTA0
IDEwMCUgwqAgwqAxLjAwSyDCoCDCoDYyMiDCoCDCoCDCoCAzMiDCoCDCoCAxOTkwNEsgVU5JWCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+wqAxNzM0MCDCoDE3MzQwIDEwMCUgwqAgwqAx
LjA2SyDCoCDCoDU3OCDCoCDCoCDCoCAzMCDCoCDCoCAxODQ5NksgbW1fc3RydWN0IMKgIMKgIMKg
IMKgIMKgIMKgIMKgPGJyPsKgMTU5ODAgwqAxNTk4MCAxMDAlIMKgIMKgMC4wMksgwqAgwqAgOTQg
wqAgwqAgwqAxNzAgwqAgwqAgwqAgMzc2SyBhdnRhYl9ub2RlIMKgIMKgIMKgIMKgIMKgIMKgIDxi
cj7CoDE0MDcwIMKgMTQwNzAgMTAwJSDCoCDCoDEuMDZLIMKgIMKgNDY5IMKgIMKgIMKgIDMwIMKg
IMKgIDE1MDA4SyBzaWduYWxfY2FjaGUgwqAgwqAgwqAgwqAgwqAgPGJyPsKgMTMyNDggwqAxMzI0
OCAxMDAlIMKgIMKgMC4xMksgwqAgwqA0MTQgwqAgwqAgwqAgMzIgwqAgwqAgwqAxNjU2SyBwaWQg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YnI+wqAxMjEyOCDCoDExNzc3IMKgOTclIMKg
IMKgMC4yNUsgwqAgwqAzNzkgwqAgwqAgwqAgMzIgwqAgwqAgwqAzMDMySyBrbWFsbG9jLTI1NiDC
oCDCoCDCoCDCoCDCoCDCoDxicj7CoDExMDA4IMKgMTEwMDggMTAwJSDCoCDCoDAuMDJLIMKgIMKg
IDQzIMKgIMKgIMKgMjU2IMKgIMKgIMKgIDE3Mksgc2VsaW51eF9maWxlX3NlY3VyaXR5IMKgPGJy
PsKgMTA4MTIgwqAxMDgxMiAxMDAlIMKgIMKgMC4wNEsgwqAgwqAxMDYgwqAgwqAgwqAxMDIgwqAg
wqAgwqAgNDI0SyBBY3BpLU5hbWVzcGFjZcKgIMKgIMKgPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+VGhlc2UgaW5mb3JtYXRpb24gc2hvd3MgdGhhdCB0aGUgJiMzOTtpb21tdV9pb3ZhJiMz
OTsgaXMgdGhlIHRvcCBtZW1vcnkgY29uc3VtZXIuIEluIG9yZGVyIHRvIG9wdGltaXplIHRoZSBu
ZXR3b3JrIHBlcmZvcm1lbmNlIG9mIE9wZW5zdGFjayB2aXJ0dWFsIG1hY2hpbmVzLCBJIGVuYWJs
ZWQgdGhlIHZ0LWQgZmVhdHVyZSBpbiBiaW9zIGFuZCBzcmlvdiBmZWF0dXJlIG9mIEludGVsIDgy
NTk5IDEwRyBOSUMuIEkmIzM5O20gYXNzdW1pbmcgdGhpcyBpcyB0aGUgcm9vdCBjYXVzZSBvZiB0
aGlzIGlzc3VlLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXMgdGhlcmUgYW55dGhpbmcgSSBj
YW4gZG8gdG8gZml4IGl0PzwvZGl2PjwvZGl2Pg0K
--000000000000b9c03205a3f1a4ae--

--===============1863747385704331581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1863747385704331581==--
