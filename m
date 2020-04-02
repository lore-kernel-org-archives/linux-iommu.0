Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2539CC18E5B
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 10:17:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4B42074D
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 10:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="JhIvBQda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4B42074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8E41687062;
	Thu,  2 Apr 2020 10:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AC8V4-FdFyJj; Thu,  2 Apr 2020 10:17:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 452DE8705F;
	Thu,  2 Apr 2020 10:17:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A327C1AE2;
	Thu,  2 Apr 2020 10:17:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D19EC07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 10:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5DC1F87060
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 10:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X1zjgrVTSja8 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 10:17:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400095.outbound.protection.outlook.com [40.107.140.95])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E0D758705F
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 10:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STvEh8RFWYYIG8PKcmhnOClH1qjUBdgyZnJMpysLcMDOKZL8ixrte2qOOG+RRvAGSoRZJUtcIH+xAx9v48rt57DP7zCh5d+gwidtaCfaTUh6cE4afkiPP07koxBGoTH5y0TXegINY2YwwwL0EfWSFLiCEOg0lHprgNBm70dc/0tyKL49e04nRNGxfMYnpYgRqkjeoNv/Wnpwe1gXq2/MKptKSWKxS2+33BEXM5yeVMXxSaG66vY150nYxl/HGdoW21qQfEOl/6v7C/Lu7owrx0dnCgs2FFFca/nyWphBAbtFoxhgPk/nEWK7ggANewauCwfB2D65P2JYu7fniqwyDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OucAHMG7V+JNdinkxG+DEYL+r6Hu/V/CEV72pwq+2Go=;
 b=LygeAQ63m8gPwTOoaSgO7UJHyY4zTQO4gmdfNSRuOw6OaqSDuerMIju7kFtefvzYDHpAqcV8q/QXQzPncX/7YHtTKLNvADT+oo7NlJmo1fDA9ZtZQbDSuTO980pFi6zFwSWYd9w/3wuZ8IOZ0dvtufGK6w2xVPbxC+kqt7Oudig95KcN1ErTebpIcqwm7tOTfzprn6FAvDYl+bXJEKQrrwpIxy208vf8beiT436wi/JznGxPZT7tGXfMGRiNyyFM3jslrVWd6IH/gfRV/6/Syyk1Vlu68RPbRTX+7dQlguR1ut/Kj/2mX6XYVBjG9BDj3RQjGYLmEhsHjmMtmnL+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OucAHMG7V+JNdinkxG+DEYL+r6Hu/V/CEV72pwq+2Go=;
 b=JhIvBQda65ZKtE7gkpXzNk4n/4hbEGPrHq9tDjxWfPVNnYipc9J/UaE7ZaoQgRWN2+29drUa/dQ6QsCG+CSHJjm1YoWG8vR6gguondP6ULzfCSo3VV4Ms3HMCWWU9rRG7Gc3tUgcstiyQoNwLZkytHmOi5lQgJEw2nvPBtdEE5k=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB2541.jpnprd01.prod.outlook.com (20.177.101.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Thu, 2 Apr 2020 10:16:57 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 10:16:57 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: "john.stultz@linaro.org" <john.stultz@linaro.org>
Subject: How to fix WARN from drivers/base/dd.c in next-20200401 if
 CONFIG_MODULES=y?
Thread-Topic: How to fix WARN from drivers/base/dd.c in next-20200401 if
 CONFIG_MODULES=y?
Thread-Index: AdYI1eHeE+d8Du49RZSXfyqelir+Rg==
Date: Thu, 2 Apr 2020 10:16:57 +0000
Message-ID: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f98ce161-6d5e-4d9b-c5dd-08d7d6eef9b8
x-ms-traffictypediagnostic: TYAPR01MB2541:
x-microsoft-antispam-prvs: <TYAPR01MB2541199369B9C0F8E904EB8BD8C60@TYAPR01MB2541.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB4544.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(6506007)(66446008)(55236004)(33656002)(55016002)(478600001)(8936002)(45080400002)(81166006)(81156014)(2906002)(9686003)(8676002)(66946007)(7696005)(76116006)(4326008)(66556008)(26005)(86362001)(186003)(66476007)(64756008)(71200400001)(52536014)(30864003)(5660300002)(54906003)(6916009)(316002)(559001)(579004);
 DIR:OUT; SFP:1102; 
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OfxY4XYLC3oB6TQn/BUNp/ug4hxWwSHDF3ta6sP0P17Iy1RhGF7DdXDbl9TJrGFwCbwd+Kp7v5RU3F5OA5hwNGYHvhd0D6GmbpQaYkJQNJRMEuS5MWuvF5C7dW6ZipWqKOdQwokyo9lokwcGlzoHZxGUwMmjdThleBVLELRs/CsziTXEYVi4ph5rf+vOB9rmx/54RXwUJa/aQW6ayqBKSQF1ZTweKcQ5+iDd1hx96PeNtSi2+WTcnf7kf5Zz5VQg0N/nWjAX0L3xgRH7w65+0OfF1LiJukLrc1WdRmPFJH2CrsFeVWbo4kPW+NkhTOnc58Otrzm7IoJBe/o+vyLCOX840P2AShHrYejT9oFLXoYCOfkJsIyy4ytWKx2AG/tnGwgKuiqRzk+JMws/27/vAsvlzRrgMzuSCvWn4XuxjqaqOrtEALchRPPzU3v+6qJu
x-ms-exchange-antispam-messagedata: 0g/9JRv8YlUt79mfARwxGErcji+CXszUSGyMb1pi1F5UQ40aBbX5B8SsX0ydC02SWa8yQC8oiuNFbt+LbKXTEzUDv+SHeQ/nrZbLvcEdI/shOsCJAm4hDk7ivyydQLtkMlbxiGBplnRl5b72C/VC+w==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98ce161-6d5e-4d9b-c5dd-08d7d6eef9b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 10:16:57.4162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: inTicyxIMjbxGF3wwDvAU6vA1iz+d9vImLsCUPbd/aRz/9iJWZqKx3MWItgGdwx3vFCh4bX9EAAfRLAhimiqu/3335gEZ5+Ej5IlOiB/7pxzo+VUh7a+IHE3Uo4lq4GV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2541
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi John,

I found an issue after applied the following patches:
---
64c775f driver core: Rename deferred_probe_timeout and make it global
0e9f8d0 driver core: Remove driver_deferred_probe_check_state_continue()
bec6c0e pinctrl: Remove use of driver_deferred_probe_check_state_continue()
e2cec7d driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set
c8c43ce driver core: Fix driver_deferred_probe_check_state() logic
---

Before these patches, on my environment [1], some device drivers
which has iommus property output the following message when probing:

[    3.222205] ravb e6800000.ethernet: ignoring dependency for device, assuming no driver
[    3.257174] ravb e6800000.ethernet eth0: Base address at 0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.

So, since ravb driver is probed within 4 seconds, we can use NFS rootfs correctly.

However, after these patches are applied, since the patches are always waiting for 30 seconds
for of_iommu_configure() when IOMMU hardware is disabled, drivers/base/dd.c output WARN.
Also, since ravb cannot be probed for 30 seconds, we cannot use NFS rootfs anymore.
JFYI, I copied the kernel log to the end of this email.

I guess the patches will be merged into v5.7-rc1 because the patches are contained from
next-20200316, I'd like to fix the issue in v5.7-rcN cycle somehow.

[1]
- R-Car H3 (r8a77951).
- Using defconfig of arch/arm64.
-- So, the IOMMU hardware of the environment is not enabled.

Best regards,
Yoshihiro Shimoda

--- log ---
[    0.000162] NOTICE:  BL2: R-Car Gen3 Initial Program Loader(CA57) Rev.1.0.21
[    0.005735] NOTICE:  BL2: PRR is R-Car H3 Ver.3.0
[    0.010412] NOTICE:  BL2: Board is Salvator-XS Rev.1.0
[    0.015532] NOTICE:  BL2: Boot device is HyperFlash(160MHz)
[    0.021054] NOTICE:  BL2: LCM state is CM
[    0.025100] NOTICE:  BL2: AVS setting succeeded. DVFS_SetVID=0x53
[    0.031085] NOTICE:  BL2: CH0: 0x400000000 - 0x480000000, 2 GiB
[    0.036956] NOTICE:  BL2: CH1: 0x500000000 - 0x580000000, 2 GiB
[    0.042840] NOTICE:  BL2: CH2: 0x600000000 - 0x680000000, 2 GiB
[    0.048725] NOTICE:  BL2: CH3: 0x700000000 - 0x780000000, 2 GiB
[    0.054650] NOTICE:  BL2: DDR3200(rev.0.33)NOTICE:  [COLD_BOOT]NOTICE:  ..0
[    0.100344] NOTICE:  BL2: DRAM Split is 4ch(DDR f)
[    0.104839] NOTICE:  BL2: QoS is default setting(rev.0.07)
[    0.110291] NOTICE:  BL2: DRAM refresh interval 1.95 usec
[    0.115720] NOTICE:  BL2: v1.4(release):15dba6b
[    0.120156] NOTICE:  BL2: Built : 02:55:27, Sep  4 2018
[    0.125352] NOTICE:  BL2: Normal boot
[    0.129004] NOTICE:  BL2: dst=0xe6322d00 src=0x8180000 len=512(0x200)
[    0.135395] NOTICE:  BL2: dst=0x43f00000 src=0x8180400 len=6144(0x1800)
[    0.142003] NOTICE:  BL2: dst=0x44000000 src=0x81c0000 len=65536(0x10000)
[    0.149012] NOTICE:  BL2: dst=0x44100000 src=0x8200000 len=1048576(0x100000)
[    0.159988] NOTICE:  BL2: dst=0x50000000 src=0x8640000 len=1048576(0x100000)


U-Boot 2015.04 (Sep 04 2018 - 10:09:18)

CPU: Renesas Electronics R8A7795 rev 3.0
Board: Salvator-X
I2C:   ready
DRAM:  7.9 GiB
Bank #0: 0x048000000 - 0x0bfffffff, 1.9 GiB
Bank #1: 0x500000000 - 0x57fffffff, 2 GiB
Bank #2: 0x600000000 - 0x67fffffff, 2 GiB
Bank #3: 0x700000000 - 0x77fffffff, 2 GiB

MMC:   sh-sdhi: 0, sh-sdhi: 1, sh-sdhi: 2
In:    serial
Out:   serial
Err:   serial
Net:   ravb
Hit any key to stop autoboot:  2     1     0 
ravb Waiting for PHY auto negotiation to complete..... done
ravb: 1000Base/Full
Using ravb device
TFTP from server 192.168.10.111; our IP address is 192.168.10.224
Filename 'lava/775/tftp-deploy-8205xjm0/kernel/Image'.
Load address: 0x48080000
Loading: * #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 #################################################################
	 ##########################################################
	 3.2 MiB/s
done
Bytes transferred = 29467136 (1c1a200 hex)
ravb:0 is connected to ravb.  Reconnecting to ravb
ravb Waiting for PHY auto negotiation to complete... done
ravb: 1000Base/Full
Using ravb device
TFTP from server 192.168.10.111; our IP address is 192.168.10.224
Filename 'lava/775/tftp-deploy-8205xjm0/dtb/r8a77951-salvator-xs.dtb'.
Load address: 0x48000000
Loading: * #####
	 6.9 MiB/s
done
Bytes transferred = 72290 (11a62 hex)
## Flattened Device Tree blob at 48000000
   Booting using the fdt blob at 0x48000000
   Loading Device Tree to 00000000bfe3c000, end 00000000bfe50a61 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd073]
[    0.000000] Linux version 5.6.0-next-20200401 (root@2b066f1d7ca7) (gcc version 7.3.0 (GCC)) #1203 SMP PREEMPT Wed Apr 1 07:54:21 UTC 2020
[    0.000000] Machine model: Renesas Salvator-X 2nd version board based on r8a77951
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 32 MiB at 0x00000000bdc00000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000048000000-0x000000077fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x77efd9100-0x77efdafff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000048000000-0x000000007fffffff]
[    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000077fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000048000000-0x00000000bfffffff]
[    0.000000]   node   0: [mem 0x0000000500000000-0x000000057fffffff]
[    0.000000]   node   0: [mem 0x0000000600000000-0x000000067fffffff]
[    0.000000]   node   0: [mem 0x0000000700000000-0x000000077fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000048000000-0x000000077fffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS resident on physical CPU 0x0
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] percpu: Embedded 23 pages/cpu s53848 r8192 d32168 u94208
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: EL2 vector hardening
[    0.000000] CPU features: detected: ARM erratum 1319367
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2032128
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: console=ttySC0,115200 rw root=/dev/nfs nfsroot=192.168.10.111:/data/tftpboot/lava/775/extract-nfsrootfs-ymjrkbkv,tcp ip=192.168.10.224
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x7bfff000-0x7ffff000] (64MB)
[    0.000000] Memory: 7968848K/8257536K available (13884K kernel code, 2088K rwdata, 7272K rodata, 5504K init, 485K bss, 255920K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=8.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] random: get_random_bytes called from start_kernel+0x2b0/0x488 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 8.32MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x1eb398c07, max_idle_ns: 440795202503 ns
[    0.000003] sched_clock: 56 bits at 8MHz, resolution 120ns, wraps every 2199023255503ns
[    0.000169] Console: colour dummy device 80x25
[    0.000234] Calibrating delay loop (skipped), value calculated using timer frequency.. 16.64 BogoMIPS (lpj=33280)
[    0.000242] pid_max: default: 32768 minimum: 301
[    0.000296] LSM: Security Framework initializing
[    0.000373] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.000417] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.001691] rcu: Hierarchical SRCU implementation.
[    0.003021] Detected Renesas R-Car Gen3 r8a7795 ES3.0
[    0.004669] EFI services will not be available.
[    0.004960] smp: Bringing up secondary CPUs ...
[    0.005349] Detected PIPT I-cache on CPU1
[    0.005391] CPU1: Booted secondary processor 0x0000000001 [0x411fd073]
[    0.005810] Detected PIPT I-cache on CPU2
[    0.005833] CPU2: Booted secondary processor 0x0000000002 [0x411fd073]
[    0.006217] Detected PIPT I-cache on CPU3
[    0.006239] CPU3: Booted secondary processor 0x0000000003 [0x411fd073]
[    0.006618] CPU features: detected: ARM erratum 845719
[    0.006630] Detected VIPT I-cache on CPU4
[    0.006672] CPU4: Booted secondary processor 0x0000000100 [0x410fd034]
[    0.007110] Detected VIPT I-cache on CPU5
[    0.007134] CPU5: Booted secondary processor 0x0000000101 [0x410fd034]
[    0.007530] Detected VIPT I-cache on CPU6
[    0.007555] CPU6: Booted secondary processor 0x0000000102 [0x410fd034]
[    0.007956] Detected VIPT I-cache on CPU7
[    0.007981] CPU7: Booted secondary processor 0x0000000103 [0x410fd034]
[    0.008063] smp: Brought up 1 node, 8 CPUs
[    0.008083] SMP: Total of 8 processors activated.
[    0.008088] CPU features: detected: 32-bit EL0 Support
[    0.008093] CPU features: detected: CRC32 instructions
[    0.019757] CPU: All CPU(s) started at EL1
[    0.019790] alternatives: patching kernel code
[    0.021027] devtmpfs: initialized
[    0.026319] KASLR disabled due to lack of seed
[    0.026621] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.026634] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.027243] pinctrl core: initialized pinctrl subsystem
[    0.028574] thermal_sys: Registered thermal governor 'step_wise'
[    0.028576] thermal_sys: Registered thermal governor 'power_allocator'
[    0.028970] DMI not present or invalid.
[    0.029370] NET: Registered protocol family 16
[    0.030139] DMA: preallocated 256 KiB pool for atomic allocations
[    0.030149] audit: initializing netlink subsys (disabled)
[    0.030267] audit: type=2000 audit(0.028:1): state=initialized audit_enabled=0 res=1
[    0.031359] cpuidle: using governor menu
[    0.031545] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.031650] ASID allocator initialised with 65536 entries
[    0.032694] Serial: AMBA PL011 UART driver
[    0.035447] sh-pfc e6060000.pin-controller: r8a77951_pfc support registered
[    0.058967] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.058973] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.058978] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.058982] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.060856] cryptd: max_cpu_qlen set to 1000
[    0.064219] ACPI: Interpreter disabled.
[    0.068145] iommu: Default domain type: Translated 
[    0.068385] vgaarb: loaded
[    0.068571] SCSI subsystem initialized
[    0.068810] usbcore: registered new interface driver usbfs
[    0.068829] usbcore: registered new interface driver hub
[    0.068875] usbcore: registered new device driver usb
[    0.069926] i2c-sh_mobile e60b0000.i2c: I2C adapter 7, bus speed 400000 Hz
[    0.070284] pps_core: LinuxPPS API ver. 1 registered
[    0.070288] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.070297] PTP clock support registered
[    0.070431] EDAC MC: Ver: 3.0.0
[    0.071989] FPGA manager framework
[    0.072042] Advanced Linux Sound Architecture Driver Initialized.
[    0.072546] clocksource: Switched to clocksource arch_sys_counter
[    0.072696] VFS: Disk quotas dquot_6.6.0
[    0.072737] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.072853] pnp: PnP ACPI: disabled
[    0.076113] NET: Registered protocol family 2
[    0.076352] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.076413] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.076709] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.077264] TCP: Hash tables configured (established 65536 bind 65536)
[    0.077375] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.077482] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.077707] NET: Registered protocol family 1
[    0.078025] RPC: Registered named UNIX socket transport module.
[    0.078030] RPC: Registered udp transport module.
[    0.078033] RPC: Registered tcp transport module.
[    0.078036] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.078044] PCI: CLS 0 bytes, default 64
[    0.078840] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
[    0.079073] hw perfevents: enabled with armv8_cortex_a57 PMU driver, 7 counters available
[    0.079624] kvm [1]: HYP mode not available
[    0.085109] Initialise system trusted keyrings
[    0.085206] workingset: timestamp_bits=44 max_order=21 bucket_order=0
[    0.088591] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.089018] NFS: Registering the id_resolver key type
[    0.089034] Key type id_resolver registered
[    0.089037] Key type id_legacy registered
[    0.089046] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.089136] 9p: Installing v9fs 9p2000 file system support
[    0.098755] Key type asymmetric registered
[    0.098761] Asymmetric key parser 'x509' registered
[    0.098784] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.098790] io scheduler mq-deadline registered
[    0.098793] io scheduler kyber registered
[    0.112322] gpio_rcar e6050000.gpio: driving 16 GPIOs
[    0.112509] gpio_rcar e6051000.gpio: driving 29 GPIOs
[    0.112715] gpio_rcar e6052000.gpio: driving 15 GPIOs
[    0.112890] gpio_rcar e6053000.gpio: driving 16 GPIOs
[    0.113061] gpio_rcar e6054000.gpio: driving 18 GPIOs
[    0.113231] gpio_rcar e6055000.gpio: driving 26 GPIOs
[    0.113406] gpio_rcar e6055400.gpio: driving 32 GPIOs
[    0.113575] gpio_rcar e6055800.gpio: driving 4 GPIOs
[    0.115254] rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
[    0.115274] rcar-pcie fe000000.pcie:       IO 0x00fe100000..0x00fe1fffff -> 0x0000000000
[    0.115290] rcar-pcie fe000000.pcie:      MEM 0x00fe200000..0x00fe3fffff -> 0x00fe200000
[    0.115304] rcar-pcie fe000000.pcie:      MEM 0x0030000000..0x0037ffffff -> 0x0030000000
[    0.115313] rcar-pcie fe000000.pcie:      MEM 0x0038000000..0x003fffffff -> 0x0038000000
[    0.115324] rcar-pcie fe000000.pcie:   IB MEM 0x0040000000..0x007fffffff -> 0x0040000000
[    0.180068] rcar-pcie fe000000.pcie: PCIe link down
[    0.180207] rcar-pcie ee800000.pcie: host bridge /soc/pcie@ee800000 ranges:
[    0.180223] rcar-pcie ee800000.pcie:       IO 0x00ee900000..0x00ee9fffff -> 0x0000000000
[    0.180238] rcar-pcie ee800000.pcie:      MEM 0x00eea00000..0x00eebfffff -> 0x00eea00000
[    0.180250] rcar-pcie ee800000.pcie:      MEM 0x00c0000000..0x00c7ffffff -> 0x00c0000000
[    0.180259] rcar-pcie ee800000.pcie:      MEM 0x00c8000000..0x00cfffffff -> 0x00c8000000
[    0.180269] rcar-pcie ee800000.pcie:   IB MEM 0x0040000000..0x007fffffff -> 0x0040000000
[    0.244057] rcar-pcie ee800000.pcie: PCIe link down
[    0.246298] EINJ: ACPI disabled.
[    0.261318] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.263436] SuperH (H)SCI(F) driver initialized
[    0.263828] e6550000.serial: ttySC1 at MMIO 0xe6550000 (irq = 34, base_baud = 0) is a hscif
[    0.264299] e6e88000.serial: ttySC0 at MMIO 0xe6e88000 (irq = 120, base_baud = 0) is a scif
[    1.294234] printk: console [ttySC0] enabled
[    1.299351] msm_serial: driver initialized
[    1.311162] loop: module loaded
[    1.315557] megasas: 07.713.01.00-rc1
[    1.324653] libphy: Fixed MDIO Bus: probed
[    1.329073] tun: Universal TUN/TAP device driver, 1.6
[    1.335038] thunder_xcv, ver 1.0
[    1.338289] thunder_bgx, ver 1.0
[    1.341529] nicpf, ver 1.0
[    1.345449] hclge is initializing
[    1.348797] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[    1.356020] hns3: Copyright (c) 2017 Huawei Corporation.
[    1.361357] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    1.368404] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.374169] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.380000] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.385937] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
[    1.392896] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.398488] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    1.406317] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    1.412622] sky2: driver version 1.30
[    1.417571] VFIO - User Level meta-driver version: 0.3
[    1.424618] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.431147] ehci-pci: EHCI PCI platform driver
[    1.435606] ehci-platform: EHCI generic platform driver
[    1.441177] ehci-platform ee0a0100.usb: EHCI Host Controller
[    1.446855] ehci-platform ee0a0100.usb: new USB bus registered, assigned bus number 1
[    1.454779] ehci-platform ee0a0100.usb: irq 166, io mem 0xee0a0100
[    1.476556] ehci-platform ee0a0100.usb: USB 2.0 started, EHCI 1.10
[    1.483074] hub 1-0:1.0: USB hub found
[    1.486840] hub 1-0:1.0: 1 port detected
[    1.491058] ehci-platform ee0c0100.usb: EHCI Host Controller
[    1.496727] ehci-platform ee0c0100.usb: new USB bus registered, assigned bus number 2
[    1.504606] ehci-platform ee0c0100.usb: irq 167, io mem 0xee0c0100
[    1.524553] ehci-platform ee0c0100.usb: USB 2.0 started, EHCI 1.10
[    1.530993] hub 2-0:1.0: USB hub found
[    1.534757] hub 2-0:1.0: 1 port detected
[    1.564598] ehci-platform ee0e0100.usb: EHCI Host Controller
[    1.570273] ehci-platform ee0e0100.usb: new USB bus registered, assigned bus number 3
[    1.578157] ehci-platform ee0e0100.usb: irq 168, io mem 0xee0e0100
[    1.596553] ehci-platform ee0e0100.usb: USB 2.0 started, EHCI 1.10
[    1.602996] hub 3-0:1.0: USB hub found
[    1.606761] hub 3-0:1.0: 1 port detected
[    1.610938] ehci-orion: EHCI orion driver
[    1.615160] ehci-exynos: EHCI Exynos driver
[    1.619443] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.625635] ohci-pci: OHCI PCI platform driver
[    1.630110] ohci-platform: OHCI generic platform driver
[    1.635592] ohci-platform ee0a0000.usb: Generic Platform OHCI controller
[    1.642308] ohci-platform ee0a0000.usb: new USB bus registered, assigned bus number 4
[    1.650177] ohci-platform ee0a0000.usb: irq 166, io mem 0xee0a0000
[    1.743513] hub 4-0:1.0: USB hub found
[    1.747279] hub 4-0:1.0: 1 port detected
[    1.751412] ohci-platform ee0c0000.usb: Generic Platform OHCI controller
[    1.758121] ohci-platform ee0c0000.usb: new USB bus registered, assigned bus number 5
[    1.765985] ohci-platform ee0c0000.usb: irq 167, io mem 0xee0c0000
[    1.859402] hub 5-0:1.0: USB hub found
[    1.863166] hub 5-0:1.0: 1 port detected
[    1.867306] ohci-platform ee0e0000.usb: Generic Platform OHCI controller
[    1.874015] ohci-platform ee0e0000.usb: new USB bus registered, assigned bus number 6
[    1.881877] ohci-platform ee0e0000.usb: irq 168, io mem 0xee0e0000
[    1.975344] hub 6-0:1.0: USB hub found
[    1.979111] hub 6-0:1.0: 1 port detected
[    1.983257] ohci-exynos: OHCI Exynos driver
[    1.988017] xhci-hcd ee000000.usb: xHCI Host Controller
[    1.993250] xhci-hcd ee000000.usb: new USB bus registered, assigned bus number 7
[    2.000693] xhci-hcd ee000000.usb: Direct firmware load for r8a779x_usb3_v3.dlmem failed with error -2
[    2.010013] xhci-hcd ee000000.usb: can't setup: -2
[    2.014812] xhci-hcd ee000000.usb: USB bus 7 deregistered
[    2.020242] xhci-hcd: probe of ee000000.usb failed with error -2
[    2.026644] usbcore: registered new interface driver usb-storage
[    2.035603] i2c /dev entries driver
[    2.047518] cs2000-cp 2-004f: revision - C1
[    2.051753] i2c-rcar e6510000.i2c: probed
[    2.056144] pca953x 4-0020: supply vcc not found, using dummy regulator
[    2.063577] GPIO line 355 (PCIE/SATA switch) hogged as output/low
[    2.075409] random: fast init done
[    2.079190] i2c-rcar e66d8000.i2c: probed
[    2.090506] rcar_gen3_thermal e6198000.thermal: TSC0: Loaded 1 trip points
[    2.101529] rcar_gen3_thermal e6198000.thermal: TSC1: Loaded 1 trip points
[    2.112534] rcar_gen3_thermal e6198000.thermal: TSC2: Loaded 2 trip points
[    2.122193] energy_model: pd0: hertz/watts ratio non-monotonically decreasing: em_cap_state 1 >= em_cap_state0
[    2.132201] energy_model: pd0: hertz/watts ratio non-monotonically decreasing: em_cap_state 2 >= em_cap_state1
[    2.142322] cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 1497600 KHz
[    2.149748] cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 1500000 KHz
[    2.158590] energy_model: pd4: hertz/watts ratio non-monotonically decreasing: em_cap_state 1 >= em_cap_state0
[    2.168594] energy_model: pd4: hertz/watts ratio non-monotonically decreasing: em_cap_state 2 >= em_cap_state1
[    2.178680] cpufreq: cpufreq_online: CPU4: Running at unlisted freq: 1198080 KHz
[    2.186389] cpufreq: cpufreq_online: CPU4: Unlisted initial frequency changed to: 1200000 KHz
[    2.197031] sdhci: Secure Digital Host Controller Interface driver
[    2.203212] sdhci: Copyright(c) Pierre Ossman
[    2.208869] Synopsys Designware Multimedia Card Interface Driver
[    2.216058] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.223625] ledtrig-cpu: registered to indicate activity on CPUs
[    2.230967] usbcore: registered new interface driver usbhid
[    2.236542] usbhid: USB HID core driver
[    2.245206] NET: Registered protocol family 17
[    2.249772] 9pnet: Installing 9P2000 support
[    2.254076] Key type dns_resolver registered
[    2.258678] registered taskstats version 1
[    2.262783] Loading compiled-in X.509 certificates
[    2.276809] renesas_irqc e61c0000.interrupt-controller: driving 6 irqs
[    2.292451] bd9571mwv 7-0030: Device: BD9571MWV rev. 4
[    2.336574] ehci-platform ee080100.usb: EHCI Host Controller
[    2.342251] ehci-platform ee080100.usb: new USB bus registered, assigned bus number 7
[    2.350131] ehci-platform ee080100.usb: irq 165, io mem 0xee080100
[    2.408559] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    2.424555] ehci-platform ee080100.usb: USB 2.0 started, EHCI 1.10
[    2.431198] hub 7-0:1.0: USB hub found
[    2.434963] hub 7-0:1.0: 1 port detected
[    2.439734] ohci-platform ee080000.usb: Generic Platform OHCI controller
[    2.442742] usb-storage 1-1:1.0: USB Mass Storage device detected
[    2.446449] ohci-platform ee080000.usb: new USB bus registered, assigned bus number 8
[    2.453488] scsi host0: usb-storage 1-1:1.0
[    2.460403] ohci-platform ee080000.usb: irq 165, io mem 0xee080000
[    2.559603] hub 8-0:1.0: USB hub found
[    2.563370] hub 8-0:1.0: 1 port detected
[    2.581397] input: keys as /devices/platform/keys/input/input0
[    3.493831] scsi 0:0:0:0: Direct-Access     SanDisk  Ultra            1.00 PQ: 0 ANSI: 6
[    3.503554] sd 0:0:0:0: [sda] 121307136 512-byte logical blocks: (62.1 GB/57.8 GiB)
[    3.512657] sd 0:0:0:0: [sda] Write Protect is off
[    3.518524] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    3.617985]  sda: sda1
[    3.624341] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   14.884990] ALSA device list:
[   14.887961]   No soundcards found.
[   33.765863] ------------[ cut here ]------------
[   33.770490] renesas_sdhi_internal_dmac ee100000.sd: deferred probe timeout, ignoring dependency
[   33.770538] WARNING: CPU: 3 PID: 194 at ../drivers/base/dd.c:270 driver_deferred_probe_check_state+0x48/0x68
[   33.789044] Modules linked in:
[   33.792096] CPU: 3 PID: 194 Comm: kworker/3:2 Not tainted 5.6.0-next-20200401 #1203
[   33.799744] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
[   33.807657] Workqueue: events deferred_probe_work_func
[   33.812789] pstate: 60000005 (nZCv daif -PAN -UAO)
[   33.817573] pc : driver_deferred_probe_check_state+0x48/0x68
[   33.823225] lr : driver_deferred_probe_check_state+0x48/0x68
[   33.828875] sp : ffff8000121cba70
[   33.832182] x29: ffff8000121cba70 x28: 0000000000000000 
[   33.837487] x27: ffff000734cc51b8 x26: ffff800011ca6cd0 
[   33.842792] x25: ffff8000113c4150 x24: ffff8000113c4160 
[   33.848096] x23: ffff00073f01dbf8 x22: ffff0007355d0410 
[   33.853401] x21: 0000000000000000 x20: ffff8000121cbb28 
[   33.858705] x19: ffff0007355d0410 x18: ffffffffffffffff 
[   33.864009] x17: 0000000000000020 x16: ffff800010ef5118 
[   33.869313] x15: ffff800011a99948 x14: 202c74756f656d69 
[   33.874618] x13: 742065626f727020 x12: 6465727265666564 
[   33.879922] x11: 203a64732e303030 x10: ffff800011caac10 
[   33.885226] x9 : 6d645f6c616e7265 x8 : 65646e6570656420 
[   33.890531] x7 : 676e69726f6e6769 x6 : ffff800011caa85b 
[   33.895835] x5 : 0000000000000000 x4 : 0000000000000000 
[   33.901139] x3 : 00000000ffffffff x2 : ffff80072d8d4000 
[   33.906444] x1 : c105309b57ee0b00 x0 : 0000000000000000 
[   33.911748] Call trace:
[   33.914190]  driver_deferred_probe_check_state+0x48/0x68
[   33.919497]  of_iommu_xlate+0xd8/0xe8
[   33.923153]  of_iommu_configure+0xdc/0x228
[   33.927246]  of_dma_configure+0xd8/0x218
[   33.931162]  platform_dma_configure+0x1c/0xa8
[   33.935512]  really_probe+0xd4/0x378
[   33.939080]  driver_probe_device+0x5c/0x110
[   33.943256]  __device_attach_driver+0x9c/0xc0
[   33.947606]  bus_for_each_drv+0x68/0xd0
[   33.951435]  __device_attach+0xe0/0x148
[   33.955264]  device_initial_probe+0x14/0x20
[   33.959440]  bus_probe_device+0x9c/0xa8
[   33.963268]  deferred_probe_work_func+0x74/0xb0
[   33.967795]  process_one_work+0x1ec/0x368
[   33.971797]  worker_thread+0x20c/0x490
[   33.975539]  kthread+0x150/0x158
[   33.978761]  ret_from_fork+0x10/0x18
[   33.982329] ---[ end trace 03534809175888cc ]---
[   33.987087] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[   33.993025] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[   34.047656] renesas_sdhi_internal_dmac ee100000.sd: mmc0 base at 0xee100000 max clock rate 200 MHz
[   34.057858] ------------[ cut here ]------------
[   34.062480] renesas_sdhi_internal_dmac ee140000.sd: deferred probe timeout, ignoring dependency
[   34.062527] WARNING: CPU: 3 PID: 194 at ../drivers/base/dd.c:270 driver_deferred_probe_check_state+0x48/0x68
[   34.081031] Modules linked in:
[   34.084081] CPU: 3 PID: 194 Comm: kworker/3:2 Tainted: G        W         5.6.0-next-20200401 #1203
[   34.093118] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
[   34.101029] Workqueue: events deferred_probe_work_func
[   34.106161] pstate: 60000005 (nZCv daif -PAN -UAO)
[   34.110945] pc : driver_deferred_probe_check_state+0x48/0x68
[   34.116597] lr : driver_deferred_probe_check_state+0x48/0x68
[   34.122248] sp : ffff8000121cba70
[   34.125555] x29: ffff8000121cba70 x28: 0000000000000000 
[   34.130860] x27: ffff000734cc51b8 x26: ffff800011ca6cd0 
[   34.136164] x25: ffff8000113c4150 x24: ffff8000113c4160 
[   34.141469] x23: ffff00073f01e8b8 x22: ffff0007355d0810 
[   34.146774] x21: 0000000000000000 x20: ffff8000121cbb28 
[   34.152078] x19: ffff0007355d0810 x18: ffffffffffffffff 
[   34.157382] x17: 0000000000000020 x16: ffff800010ef5118 
[   34.162687] x15: ffff800011a99948 x14: 202c74756f656d69 
[   34.167991] x13: 742065626f727020 x12: 6465727265666564 
[   34.173295] x11: 203a64732e303030 x10: ffff800011caac10 
[   34.178599] x9 : 6d645f6c616e7265 x8 : 65646e6570656420 
[   34.183903] x7 : 676e69726f6e6769 x6 : ffff800011caa85b 
[   34.189208] x5 : 0000000000000000 x4 : 0000000000000000 
[   34.194512] x3 : 00000000ffffffff x2 : ffff80072d8d4000 
[   34.199816] x1 : c105309b57ee0b00 x0 : 0000000000000000 
[   34.205120] Call trace:
[   34.207561]  driver_deferred_probe_check_state+0x48/0x68
[   34.212867]  of_iommu_xlate+0xd8/0xe8
[   34.216522]  of_iommu_configure+0xdc/0x228
[   34.220613]  of_dma_configure+0xd8/0x218
[   34.224530]  platform_dma_configure+0x1c/0xa8
[   34.228879]  really_probe+0xd4/0x378
[   34.232447]  driver_probe_device+0x5c/0x110
[   34.236623]  __device_attach_driver+0x9c/0xc0
[   34.240973]  bus_for_each_drv+0x68/0xd0
[   34.244802]  __device_attach+0xe0/0x148
[   34.248631]  device_initial_probe+0x14/0x20
[   34.252806]  bus_probe_device+0x9c/0xa8
[   34.256634]  deferred_probe_work_func+0x74/0xb0
[   34.261160]  process_one_work+0x1ec/0x368
[   34.265161]  worker_thread+0x20c/0x490
[   34.268904]  kthread+0x150/0x158
[   34.272126]  ret_from_fork+0x10/0x18
[   34.275694] ---[ end trace 03534809175888cd ]---
[   34.328930] renesas_sdhi_internal_dmac ee140000.sd: mmc1 base at 0xee140000 max clock rate 200 MHz
[   34.338891] ------------[ cut here ]------------
[   34.343512] renesas_sdhi_internal_dmac ee160000.sd: deferred probe timeout, ignoring dependency
[   34.343553] WARNING: CPU: 3 PID: 194 at ../drivers/base/dd.c:270 driver_deferred_probe_check_state+0x48/0x68
[   34.362058] Modules linked in:
[   34.365107] CPU: 3 PID: 194 Comm: kworker/3:2 Tainted: G        W         5.6.0-next-20200401 #1203
[   34.374143] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
[   34.382054] Workqueue: events deferred_probe_work_func
[   34.387186] pstate: 60000005 (nZCv daif -PAN -UAO)
[   34.391970] pc : driver_deferred_probe_check_state+0x48/0x68
[   34.397621] lr : driver_deferred_probe_check_state+0x48/0x68
[   34.403272] sp : ffff8000121cba70
[   34.406578] x29: ffff8000121cba70 x28: 0000000000000000 
[   34.411884] x27: ffff000734cc51b8 x26: ffff800011ca6cd0 
[   34.417189] x25: ffff8000113c4150 x24: ffff8000113c4160 
[   34.422493] x23: ffff00073f01f0f8 x22: ffff0007355d0c10 
[   34.427797] x21: 0000000000000000 x20: ffff8000121cbb28 
[   34.433102] x19: ffff0007355d0c10 x18: ffffffffffffffff 
[   34.438406] x17: 0000000000000020 x16: ffff800010ef5118 
[   34.443710] x15: ffff800011a99948 x14: 202c74756f656d69 
[   34.449015] x13: 742065626f727020 x12: 6465727265666564 
[   34.454319] x11: 203a64732e303030 x10: ffff800011caac10 
[   34.459623] x9 : 6d645f6c616e7265 x8 : 65646e6570656420 
[   34.464928] x7 : 676e69726f6e6769 x6 : ffff800011caa85b 
[   34.470232] x5 : 0000000000000000 x4 : 0000000000000000 
[   34.475536] x3 : 00000000ffffffff x2 : ffff80072d8d4000 
[   34.480840] x1 : c105309b57ee0b00 x0 : 0000000000000000 
[   34.486145] Call trace:
[   34.488586]  driver_deferred_probe_check_state+0x48/0x68
[   34.493892]  of_iommu_xlate+0xd8/0xe8
[   34.497547]  of_iommu_configure+0xdc/0x228
[   34.501637]  of_dma_configure+0xd8/0x218
[   34.505554]  platform_dma_configure+0x1c/0xa8
[   34.509903]  really_probe+0xd4/0x378
[   34.513471]  driver_probe_device+0x5c/0x110
[   34.517648]  __device_attach_driver+0x9c/0xc0
[   34.521997]  bus_for_each_drv+0x68/0xd0
[   34.525825]  __device_attach+0xe0/0x148
[   34.529654]  device_initial_probe+0x14/0x20
[   34.533830]  bus_probe_device+0x9c/0xa8
[   34.537659]  deferred_probe_work_func+0x74/0xb0
[   34.542183]  process_one_work+0x1ec/0x368
[   34.546186]  worker_thread+0x20c/0x490
[   34.549928]  kthread+0x150/0x158
[   34.553149]  ret_from_fork+0x10/0x18
[   34.556716] ---[ end trace 03534809175888ce ]---
[   34.561463] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[   34.567414] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO
[   34.603185] mmc0: new ultra high speed SDR104 SDHC card at address aaaa
[   34.610327] mmcblk0: mmc0:aaaa AGGCD 29.7 GiB 
[   34.618045]  mmcblk0: p1
[   34.627845] renesas_sdhi_internal_dmac ee160000.sd: mmc2 base at 0xee160000 max clock rate 200 MHz
[   34.637484] ------------[ cut here ]------------
[   34.642117] rcar-dmac e6700000.dma-controller: deferred probe timeout, ignoring dependency
[   34.642159] WARNING: CPU: 3 PID: 194 at ../drivers/base/dd.c:270 driver_deferred_probe_check_state+0x48/0x68
[   34.660230] Modules linked in:
[   34.663281] CPU: 3 PID: 194 Comm: kworker/3:2 Tainted: G        W         5.6.0-next-20200401 #1203
[   34.672317] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
[   34.680229] Workqueue: events deferred_probe_work_func
[   34.685361] pstate: 60000005 (nZCv daif -PAN -UAO)
[   34.690145] pc : driver_deferred_probe_check_state+0x48/0x68
[   34.695797] lr : driver_deferred_probe_check_state+0x48/0x68
[   34.701447] sp : ffff8000121cba70
[   34.704754] x29: ffff8000121cba70 x28: 0000000000000000 
[   34.710060] x27: ffff000734cc51b8 x26: ffff800011ca6cd0 
[   34.715364] x25: ffff8000113c4150 x24: ffff8000113c4160 
[   34.720669] x23: ffff00073eff8158 x22: ffff00073552c410 
[   34.725973] x21: 0000000000000000 x20: ffff8000121cbb28 
[   34.731277] x19: ffff00073552c410 x18: ffffffffffffffff 
[   34.736582] x17: 0000000000000020 x16: 0000000000000001 
[   34.741886] x15: 0000261a1afe96aa x14: 726f6e6769202c74 
[   34.747190] x13: 756f656d69742065 x12: 626f727020646572 
[   34.752495] x11: 7265666564203a72 x10: ffff800011caac10 
[   34.757799] x9 : 632d616d642e3030 x8 : 3030303736652063 
[   34.763103] x7 : 616d642d72616372 x6 : ffff800011caa856 
[   34.768408] x5 : 0000000000000000 x4 : 0000000000000000 
[   34.773712] x3 : 00000000ffffffff x2 : ffff80072d8d4000 
[   34.779016] x1 : c105309b57ee0b00 x0 : 0000000000000000 
[   34.784321] Call trace:
[   34.786762]  driver_deferred_probe_check_state+0x48/0x68
[   34.792068]  of_iommu_xlate+0xd8/0xe8
[   34.795723]  of_iommu_configure+0xdc/0x228
[   34.799816]  of_dma_configure+0xd8/0x218
[   34.803732]  platform_dma_configure+0x1c/0xa8
[   34.808082]  really_probe+0xd4/0x378
[   34.811650]  driver_probe_device+0x5c/0x110
[   34.815825]  __device_attach_driver+0x9c/0xc0
[   34.820175]  bus_for_each_drv+0x68/0xd0
[   34.824004]  __device_attach+0xe0/0x148
[   34.827833]  device_initial_probe+0x14/0x20
[   34.832008]  bus_probe_device+0x9c/0xa8
[   34.835837]  deferred_probe_work_func+0x74/0xb0
[   34.840360]  process_one_work+0x1ec/0x368
[   34.844362]  worker_thread+0x20c/0x490
[   34.848105]  kthread+0x150/0x158
[   34.851328]  ret_from_fork+0x10/0x18
[   34.854896] ---[ end trace 03534809175888cf ]---
[   34.862804] ------------[ cut here ]------------
[   34.867430] rcar-dmac e7300000.dma-controller: deferred probe timeout, ignoring dependency
[   34.867478] WARNING: CPU: 3 PID: 194 at ../drivers/base/dd.c:270 driver_deferred_probe_check_state+0x48/0x68
[   34.885549] Modules linked in:
[   34.888600] CPU: 3 PID: 194 Comm: kworker/3:2 Tainted: G        W         5.6.0-next-20200401 #1203
[   34.897637] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
[   34.905548] Workqueue: events deferred_probe_work_func
[   34.910681] pstate: 60000005 (nZCv daif -PAN -UAO)
[   34.915464] pc : driver_deferred_probe_check_state+0x48/0x68
[   34.921116] lr : driver_deferred_probe_check_state+0x48/0x68
[   34.926767] sp : ffff8000121cba70
[   34.930074] x29: ffff8000121cba70 x28: 0000000000000000 
[   34.935379] x27: ffff000734cc51b8 x26: ffff800011ca6cd0 
[   34.940684] x25: ffff8000113c4150 x24: ffff8000113c4160 
[   34.945988] x23: ffff00073eff8708 x22: ffff00073552c810 
[   34.951293] x21: 0000000000000000 x20: ffff8000121cbb28 
[   34.956597] x19: ffff00073552c810 x18: ffffffffffffffff 
[   34.961901] x17: 00000000000000c0 x16: fffffe001cb28a88 
[   34.967206] x15: ffff800011a99948 x14: 726f6e6769202c74 
[   34.972509] x13: 756f656d69742065 x12: 626f727020646572 
[   34.977814] x11: 7265666564203a72 x10: ffff800011caac10 
[   34.983118] x9 : 632d616d642e3030 x8 : 3030303337652063 
[   34.988422] x7 : 616d642d72616372 x6 : ffff800011caa856 
[   34.993726] x5 : 0000000000000000 x4 : 0000000000000000 
[   34.999031] x3 : 00000000ffffffff x2 : ffff80072d8d4000 
[   35.004335] x1 : c105309b57ee0b00 x0 : 0000000000000000 
[   35.009640] Call trace:
[   35.012080]  driver_deferred_probe_check_state+0x48/0x68
[   35.017386]  of_iommu_xlate+0xd8/0xe8
[   35.021041]  of_iommu_configure+0xdc/0x228
[   35.025132]  of_dma_configure+0xd8/0x218
[   35.029049]  platform_dma_configure+0x1c/0xa8
[   35.033398]  really_probe+0xd4/0x378
[   35.036966]  driver_probe_device+0x5c/0x110
[   35.041142]  __device_attach_driver+0x9c/0xc0
[   35.045491]  bus_for_each_drv+0x68/0xd0
[   35.049320]  __device_attach+0xe0/0x148
[   35.053148]  device_initial_probe+0x14/0x20
[   35.057324]  bus_probe_device+0x9c/0xa8
[   35.061153]  deferred_probe_work_func+0x74/0xb0
[   35.065678]  process_one_work+0x1ec/0x368
[   35.069680]  worker_thread+0x20c/0x490
[   35.073421]  kthread+0x150/0x158
[   35.076644]  ret_from_fork+0x10/0x18
[   35.080211] ---[ end trace 03534809175888d0 ]---
[   35.087228] ------------[ cut here ]------------
[   35.091855] rcar-dmac e7310000.dma-controller: deferred probe timeout, ignoring dependency
[   35.091898] WARNING: CPU: 3 PID: 194 at ../drivers/base/dd.c:270 driver_deferred_probe_check_state+0x48/0x68
[   35.109969] Modules linked in:
[   35.113018] CPU: 3 PID: 194 Comm: kworker/3:2 Tainted: G        W         5.6.0-next-20200401 #1203
[   35.122055] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
[   35.129966] Workqueue: events deferred_probe_work_func
[   35.135098] pstate: 60000005 (nZCv daif -PAN -UAO)
[   35.139882] pc : driver_deferred_probe_check_state+0x48/0x68
[   35.145534] lr : driver_deferred_probe_check_state+0x48/0x68
[   35.151184] sp : ffff8000121cba70
[   35.154491] x29: ffff8000121cba70 x28: 0000000000000000 
[   35.159796] x27: ffff000734cc51b8 x26: ffff800011ca6cd0 
[   35.165100] x25: ffff8000113c4150 x24: ffff8000113c4160 
[   35.170405] x23: ffff00073eff8cb8 x22: ffff00073552cc10 
[   35.175709] x21: 0000000000000000 x20: ffff8000121cbb28 
[   35.181013] x19: ffff00073552cc10 x18: ffffffffffffffff 
[   35.186318] x17: 00000000000000c0 x16: fffffe001cb28a88 
[   35.191622] x15: ffff800011a99948 x14: 726f6e6769202c74 
[   35.196926] x13: 756f656d69742065 x12: 626f727020646572 
[   35.202230] x11: 7265666564203a72 x10: ffff800011caac10 
[   35.207535] x9 : 632d616d642e3030 x8 : 3030313337652063 
[   35.212839] x7 : 616d642d72616372 x6 : ffff800011caa856 
[   35.218143] x5 : 0000000000000000 x4 : 0000000000000000 
[   35.223446] x3 : 00000000ffffffff x2 : ffff80072d8d4000 
[   35.228751] x1 : c105309b57ee0b00 x0 : 0000000000000000 
[   35.234055] Call trace:
[   35.236495]  driver_deferred_probe_check_state+0x48/0x68
[   35.241802]  of_iommu_xlate+0xd8/0xe8
[   35.245457]  of_iommu_configure+0xdc/0x228
[   35.249547]  of_dma_configure+0xd8/0x218
[   35.253464]  platform_dma_configure+0x1c/0xa8
[   35.257813]  really_probe+0xd4/0x378
[   35.261382]  driver_probe_device+0x5c/0x110
[   35.265558]  __device_attach_driver+0x9c/0xc0
[   35.269907]  bus_for_each_drv+0x68/0xd0
[   35.273736]  __device_attach+0xe0/0x148
[   35.277564]  device_initial_probe+0x14/0x20
[   35.281739]  bus_probe_device+0x9c/0xa8
[   35.285568]  deferred_probe_work_func+0x74/0xb0
[   35.290093]  process_one_work+0x1ec/0x368
[   35.294094]  worker_thread+0x20c/0x490
[   35.297836]  kthread+0x150/0x158
[   35.301058]  ret_from_fork+0x10/0x18
[   35.304625] ---[ end trace 03534809175888d1 ]---
[   35.311782] ------------[ cut here ]------------
[   35.316445] rcar-dmac ec700000.dma-controller: deferred probe timeout, ignoring dependency
[   35.316487] WARNING: CPU: 3 PID: 194 at ../drivers/base/dd.c:270 driver_deferred_probe_check_state+0x48/0x68
[   35.334558] Modules linked in:
[   35.337609] CPU: 3 PID: 194 Comm: kworker/3:2 Tainted: G        W         5.6.0-next-20200401 #1203
[   35.346645] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
[   35.354557] Workqueue: events deferred_probe_work_func
[   35.359690] pstate: 60000005 (nZCv daif -PAN -UAO)
[   35.364474] pc : driver_deferred_probe_check_state+0x48/0x68
[   35.370126] lr : driver_deferred_probe_check_state+0x48/0x68
[   35.375777] sp : ffff8000121cba70
[   35.379083] x29: ffff8000121cba70 x28: 0000000000000000 
[   35.384389] x27: ffff000734cc51b8 x26: ffff800011ca6cd0 
[   35.389693] x25: ffff8000113c4150 x24: ffff8000113c4160 
[   35.394998] x23: ffff00073f018998 x22: ffff00073557c410 
[   35.400302] x21: 0000000000000000 x20: ffff8000121cbb28 
[   35.405607] x19: ffff00073557c410 x18: ffffffffffffffff 
[   35.410911] x17: 00000000000000c0 x16: fffffe001cb28a88 
[   35.416215] x15: 0000002a2b34a012 x14: 726f6e6769202c74 
[   35.421520] x13: 756f656d69742065 x12: 626f727020646572 
[   35.426824] x11: 7265666564203a72 x10: ffff800011caac10 
[   35.432128] x9 : 632d616d642e3030 x8 : 3030303763652063 
[   35.437432] x7 : 616d642d72616372 x6 : ffff800011caa856 
[   35.442736] x5 : 0000000000000000 x4 : 0000000000000000 
[   35.448041] x3 : 00000000ffffffff x2 : ffff80072d8d4000 
[   35.453345] x1 : c105309b57ee0b00 x0 : 0000000000000000 
[   35.458650] Call trace:
[   35.461091]  driver_deferred_probe_check_state+0x48/0x68
[   35.466397]  of_iommu_xlate+0xd8/0xe8
[   35.470052]  of_iommu_configure+0xdc/0x228
[   35.474143]  of_dma_configure+0xd8/0x218
[   35.478059]  platform_dma_configure+0x1c/0xa8
[   35.482408]  really_probe+0xd4/0x378
[   35.485976]  driver_probe_device+0x5c/0x110
[   35.490152]  __device_attach_driver+0x9c/0xc0
[   35.494501]  bus_for_each_drv+0x68/0xd0
[   35.498330]  __device_attach+0xe0/0x148
[   35.502159]  device_initial_probe+0x14/0x20
[   35.506334]  bus_probe_device+0x9c/0xa8
[   35.510163]  deferred_probe_work_func+0x74/0xb0
[   35.514688]  process_one_work+0x1ec/0x368
[   35.518690]  worker_thread+0x20c/0x490
[   35.522431]  kthread+0x150/0x158
[   35.525653]  ret_from_fork+0x10/0x18
[   35.529221] ---[ end trace 03534809175888d2 ]---
[   35.536287] ------------[ cut here ]------------
[   35.540939] rcar-dmac ec720000.dma-controller: deferred probe timeout, ignoring dependency
[   35.540985] WARNING: CPU: 3 PID: 194 at ../drivers/base/dd.c:270 driver_deferred_probe_check_state+0x48/0x68
[   35.559056] Modules linked in:
[   35.562106] CPU: 3 PID: 194 Comm: kworker/3:2 Tainted: G        W         5.6.0-next-20200401 #1203
[   35.571142] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
[   35.579054] Workqueue: events deferred_probe_work_func
[   35.584186] pstate: 60000005 (nZCv daif -PAN -UAO)
[   35.588970] pc : driver_deferred_probe_check_state+0x48/0x68
[   35.594622] lr : driver_deferred_probe_check_state+0x48/0x68
[   35.600273] sp : ffff8000121cba70
[   35.603580] x29: ffff8000121cba70 x28: 0000000000000000 
[   35.608885] x27: ffff000734cc51b8 x26: ffff800011ca6cd0 
[   35.614190] x25: ffff8000113c4150 x24: ffff8000113c4160 
[   35.619494] x23: ffff00073f018f48 x22: ffff00073557c810 
[   35.624799] x21: 0000000000000000 x20: ffff8000121cbb28 
[   35.630103] x19: ffff00073557c810 x18: ffffffffffffffff 
[   35.635407] x17: 00000000000000c0 x16: fffffe001cb28a88 
[   35.640711] x15: ffff800011a99948 x14: 726f6e6769202c74 
[   35.646016] x13: 756f656d69742065 x12: 626f727020646572 
[   35.651320] x11: 7265666564203a72 x10: ffff800011caac10 
[   35.656624] x9 : 632d616d642e3030 x8 : 3030323763652063 
[   35.661929] x7 : 616d642d72616372 x6 : ffff800011caa856 
[   35.667233] x5 : 0000000000000000 x4 : 0000000000000000 
[   35.672537] x3 : 00000000ffffffff x2 : ffff80072d8d4000 
[   35.677841] x1 : c105309b57ee0b00 x0 : 0000000000000000 
[   35.683146] Call trace:
[   35.685586]  driver_deferred_probe_check_state+0x48/0x68
[   35.690892]  of_iommu_xlate+0xd8/0xe8
[   35.694547]  of_iommu_configure+0xdc/0x228
[   35.698637]  of_dma_configure+0xd8/0x218
[   35.702553]  platform_dma_configure+0x1c/0xa8
[   35.706903]  really_probe+0xd4/0x378
[   35.710470]  driver_probe_device+0x5c/0x110
[   35.714647]  __device_attach_driver+0x9c/0xc0
[   35.718996]  bus_for_each_drv+0x68/0xd0
[   35.722824]  __device_attach+0xe0/0x148
[   35.726653]  device_initial_probe+0x14/0x20
[   35.730829]  bus_probe_device+0x9c/0xa8
[   35.734657]  deferred_probe_work_func+0x74/0xb0
[   35.739183]  process_one_work+0x1ec/0x368
[   35.743184]  worker_thread+0x20c/0x490
[   35.746926]  kthread+0x150/0x158
[   35.750149]  ret_from_fork+0x10/0x18
[   35.753717] ---[ end trace 03534809175888d3 ]---
[   35.761335] ------------[ cut here ]------------
[   35.765973] sata_rcar ee300000.sata: deferred probe timeout, ignoring dependency
[   35.766016] WARNING: CPU: 3 PID: 194 at ../drivers/base/dd.c:270 driver_deferred_probe_check_state+0x48/0x68
[   35.783219] Modules linked in:
[   35.786269] CPU: 3 PID: 194 Comm: kworker/3:2 Tainted: G        W         5.6.0-next-20200401 #1203
[   35.795305] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
[   35.803216] Workqueue: events deferred_probe_work_func
[   35.808348] pstate: 60000005 (nZCv daif -PAN -UAO)
[   35.813133] pc : driver_deferred_probe_check_state+0x48/0x68
[   35.818785] lr : driver_deferred_probe_check_state+0x48/0x68
[   35.824436] sp : ffff8000121cba70
[   35.827742] x29: ffff8000121cba70 x28: 0000000000000000 
[   35.833048] x27: ffff000734cc51b8 x26: ffff800011ca6cd0 
[   35.838352] x25: ffff8000113c4150 x24: ffff8000113c4160 
[   35.843656] x23: ffff00073f01f938 x22: ffff0007355d1010 
[   35.848961] x21: 0000000000000000 x20: ffff8000121cbb28 
[   35.854265] x19: ffff0007355d1010 x18: ffffffffffffffff 
[   35.859570] x17: 00000000000000c0 x16: fffffe001cb2e808 
[   35.864874] x15: 000000167d716670 x14: 646e657065642067 
[   35.870178] x13: 6e69726f6e676920 x12: 2c74756f656d6974 
[   35.875483] x11: 2065626f72702064 x10: ffff800011caac10 
[   35.880787] x9 : 3a617461732e3030 x8 : 3030303365652072 
[   35.886091] x7 : 6163725f61746173 x6 : ffff800011caa84c 
[   35.891396] x5 : 0000000000000000 x4 : 0000000000000000 
[   35.896700] x3 : 00000000ffffffff x2 : ffff80072d8d4000 
[   35.902004] x1 : c105309b57ee0b00 x0 : 0000000000000000 
[   35.907309] Call trace:
[   35.909750]  driver_deferred_probe_check_state+0x48/0x68
[   35.915056]  of_iommu_xlate+0xd8/0xe8
[   35.918711]  of_iommu_configure+0xdc/0x228
[   35.922802]  of_dma_configure+0xd8/0x218
[   35.926719]  platform_dma_configure+0x1c/0xa8
[   35.931068]  really_probe+0xd4/0x378
[   35.934636]  driver_probe_device+0x5c/0x110
[   35.938812]  __device_attach_driver+0x9c/0xc0
[   35.943161]  bus_for_each_drv+0x68/0xd0
[   35.946990]  __device_attach+0xe0/0x148
[   35.950818]  device_initial_probe+0x14/0x20
[   35.954993]  bus_probe_device+0x9c/0xa8
[   35.958822]  deferred_probe_work_func+0x74/0xb0
[   35.963346]  process_one_work+0x1ec/0x368
[   35.967347]  worker_thread+0x20c/0x490
[   35.971089]  kthread+0x150/0x158
[   35.974311]  ret_from_fork+0x10/0x18
[   35.977880] ---[ end trace 03534809175888d4 ]---
[   35.983218] scsi host1: sata_rcar
[   35.986664] ata1: SATA max UDMA/133 irq 172
[   35.991972] ------------[ cut here ]------------
[   35.996623] ravb e6800000.ethernet: deferred probe timeout, ignoring dependency
[   35.996662] WARNING: CPU: 3 PID: 194 at ../drivers/base/dd.c:270 driver_deferred_probe_check_state+0x48/0x68
[   36.013777] Modules linked in:
[   36.016827] CPU: 3 PID: 194 Comm: kworker/3:2 Tainted: G        W         5.6.0-next-20200401 #1203
[   36.025863] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
[   36.033774] Workqueue: events deferred_probe_work_func
[   36.038905] pstate: 60000005 (nZCv daif -PAN -UAO)
[   36.043690] pc : driver_deferred_probe_check_state+0x48/0x68
[   36.049341] lr : driver_deferred_probe_check_state+0x48/0x68
[   36.054992] sp : ffff8000121cba70
[   36.058299] x29: ffff8000121cba70 x28: 0000000000000000 
[   36.063604] x27: ffff000734cc51b8 x26: ffff800011ca6cd0 
[   36.068908] x25: ffff8000113c4150 x24: ffff8000113c4160 
[   36.074213] x23: ffff00073effc8c8 x22: ffff000735579410 
[   36.079517] x21: 0000000000000000 x20: ffff8000121cbb28 
[   36.084822] x19: ffff000735579410 x18: ffffffffffffffff 
[   36.090126] x17: 0000000000000020 x16: ffff800010ef5118 
[   36.095430] x15: 00009fb67591bca2 x14: 65646e6570656420 
[   36.100735] x13: 676e69726f6e6769 x12: 202c74756f656d69 
[   36.106039] x11: 742065626f727020 x10: ffff800011caac10 
[   36.111343] x9 : 203a74656e726568 x8 : 74652e3030303030 
[   36.116647] x7 : 3836652062766172 x6 : ffff800011caa84b 
[   36.121952] x5 : 0000000000000000 x4 : 0000000000000000 
[   36.127256] x3 : 00000000ffffffff x2 : ffff80072d8d4000 
[   36.132560] x1 : c105309b57ee0b00 x0 : 0000000000000000 
[   36.137865] Call trace:
[   36.140305]  driver_deferred_probe_check_state+0x48/0x68
[   36.145611]  of_iommu_xlate+0xd8/0xe8
[   36.149266]  of_iommu_configure+0xdc/0x228
[   36.153357]  of_dma_configure+0xd8/0x218
[   36.157274]  platform_dma_configure+0x1c/0xa8
[   36.161624]  really_probe+0xd4/0x378
[   36.165192]  driver_probe_device+0x5c/0x110
[   36.169368]  __device_attach_driver+0x9c/0xc0
[   36.173717]  bus_for_each_drv+0x68/0xd0
[   36.177545]  __device_attach+0xe0/0x148
[   36.181374]  device_initial_probe+0x14/0x20
[   36.185550]  bus_probe_device+0x9c/0xa8
[   36.189378]  deferred_probe_work_func+0x74/0xb0
[   36.193903]  process_one_work+0x1ec/0x368
[   36.197904]  worker_thread+0x20c/0x490
[   36.201646]  kthread+0x150/0x158
[   36.204868]  ret_from_fork+0x10/0x18
[   36.208436] ---[ end trace 03534809175888d5 ]---
[   36.213636] libphy: ravb_mii: probed
[   36.218666] ravb e6800000.ethernet eth0: Base address at 0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.
[   36.228658] mmc1: new HS400 MMC card at address 0001
[   36.233965] mmcblk1: mmc1:0001 BGSD4R 29.1 GiB 
[   36.238593] mmcblk1boot0: mmc1:0001 BGSD4R partition 1 31.9 MiB
[   36.244626] mmcblk1boot1: mmc1:0001 BGSD4R partition 2 31.9 MiB
[   36.250737] mmcblk1rpmb: mmc1:0001 BGSD4R partition 3 4.00 MiB, chardev (234:0)
[   36.260159]  mmcblk1: p1
[   36.404638] ata1: link resume succeeded after 1 retries
[   36.506130] mmc2: new ultra high speed SDR104 SDHC card at address aaaa
[   36.513271] mmcblk2: mmc2:aaaa AGGCD 29.7 GiB 
[   36.516163] ata1: SATA link down (SStatus 0 SControl 300)
[  113.637217] VFS: Unable to mount root fs via NFS, trying floppy.
[  113.643691] VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
[  113.650939] Please append a correct "root=" boot option; here are the available partitions:
[  113.659303] 0800        60653568 sda 
[  113.659305]  driver: sd
[  113.665408]   0801        10485760 sda1 8e680d09-01
[  113.665409] 
[  113.671769] b300        31166976 mmcblk0 
[  113.671771]  driver: mmcblk
[  113.678566]   b301        10485760 mmcblk0p1 e38b1b5e-01
[  113.678568] 
[  113.685364] b320        30535680 mmcblk1 
[  113.685366]  driver: mmcblk
[  113.692158]   b321        30534639 mmcblk1p1 250e284c-e8fb-4cfc-b978-084f29d69466
[  113.692159] 
[  113.701127] b380        31166976 mmcblk2 
[  113.701128]  driver: mmcblk
[  113.707920] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)
[  113.716178] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         5.6.0-next-20200401 #1203
[  113.724868] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
[  113.732777] Call trace:
[  113.735227]  dump_backtrace+0x0/0x1b0
[  113.738883]  show_stack+0x18/0x28
[  113.742195]  dump_stack+0xc0/0x10c
[  113.745591]  panic+0x170/0x37c
[  113.748644]  mount_block_root+0x1a4/0x254
[  113.752647]  mount_root+0x130/0x168
[  113.756128]  prepare_namespace+0x13c/0x180
[  113.760218]  kernel_init_freeable+0x244/0x268
[  113.764569]  kernel_init+0x14/0x110
[  113.768051]  ret_from_fork+0x10/0x18
[  113.771628] SMP: stopping secondary CPUs
[  113.775637] Kernel Offset: disabled
[  113.779119] CPU features: 0x090002,21006004
[  113.783294] Memory Limit: none
[  113.786347] ---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0) ]---

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
