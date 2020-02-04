Return-Path: <SRS0=/T8B=3Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E382EC35247
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 20:07:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1B32084E
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 20:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKYk5Ra8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1B32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4CEBC20003;
	Tue,  4 Feb 2020 20:07:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id upiW8YYQ6cPf; Tue,  4 Feb 2020 20:07:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3D7B220370;
	Tue,  4 Feb 2020 20:07:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21964C0177;
	Tue,  4 Feb 2020 20:07:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA0CEC0174
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 20:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 91E9781E48
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 20:07:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Au0aZd9WK1V1 for <iommu@lists.linux-foundation.org>;
 Tue,  4 Feb 2020 20:07:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D04A281B3B
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 20:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580846839;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=geGRjyscrsBDWiuFu7NKdhGNNINWr76N/yWWXvC2beI=;
 b=BKYk5Ra8nOWcZKxnfUFcrgB6GJdJA8f5gz/jCJ00pCd8LtBxrkjyjEC9bDW2okWAmwjWz9
 83ck+MBv/EX5EhE24li1/N3f7faFaervnoMoNpXBN/7fy5GDyDncs2lghxFVft0dKFwt/Z
 Nxm0U374z4Q87qa07nwoN1X1WrBtW+w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-4yYvJCQNOzKU5tjPjCpUmQ-1; Tue, 04 Feb 2020 15:07:17 -0500
Received: by mail-qt1-f200.google.com with SMTP id p12so13118220qtu.6
 for <iommu@lists.linux-foundation.org>; Tue, 04 Feb 2020 12:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :mail-followup-to:mime-version:content-disposition;
 bh=geGRjyscrsBDWiuFu7NKdhGNNINWr76N/yWWXvC2beI=;
 b=MJqsDX4gNasa5nwWpz3iq35SuQofbdEGdkQabXIOk9KGGixP3BYvsQ2A9snx3NfOI7
 XPp6bnGfCufAmB3rL9Q7w2O2ozljEsWTZDe6R3XJ0IcaBcPJ5gjzzMmTeO0Cty8SHgKd
 f3DQ1CWBiS9qOzFDoAhKH6fzvfzHpvlnbFSAane7iAUBMyrg40/Iloks1Jw7bPH+Z0D7
 h03Ev1dwKesfb680u5UgQsSMTMmXkZwBZWy9DlZ1RQ6HzJJ2s9v2MMB/Ta0iB5pvCOPY
 OxyyiSiq3y8+VqUneMPOuc0fSp7MTGvXKsS3lrLlhaZyf2FE5yMhpLlBfIPbbp647jIh
 5DwA==
X-Gm-Message-State: APjAAAWnaXdKTke5YG3TQ1w7MiFhxFcXUGMgCQp40JIFi4zaX7kcDdum
 N8WUi2iuM+4stCwn5j84bunq8PAls2MmPZbDEDbvUZ9O4meY153CECsqF3mhXS13hBaOrSsiI5q
 TS8UJRFWRBTMW54YI61904XyppVtxfw==
X-Received: by 2002:ad4:56a7:: with SMTP id bd7mr29701014qvb.238.1580846836737; 
 Tue, 04 Feb 2020 12:07:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLQAjJRQbVUSFZ+x161T/kjJ9SZRCG1YYob8z9h/7atufYdB9Psm1FOsP/c8c4TvblrtbBSQ==
X-Received: by 2002:ad4:56a7:: with SMTP id bd7mr29700987qvb.238.1580846836375; 
 Tue, 04 Feb 2020 12:07:16 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id e64sm12365895qtd.45.2020.02.04.12.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 12:07:15 -0800 (PST)
Date: Tue, 4 Feb 2020 13:07:14 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>
Subject: warning from domain_get_iommu
Message-ID: <20200204200714.u4ezhi6vhqhxog6e@cantor>
Mail-Followup-To: iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
MIME-Version: 1.0
X-MC-Unique: 4yYvJCQNOzKU5tjPjCpUmQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

I'm working on getting a system to reproduce this, and verify it also occurs
with 5.5, but I have a report of a case where the kdump kernel gives
warnings like the following on a hp dl360 gen9:

[    2.830589] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.832615] ehci-pci: EHCI PCI platform driver
[    2.834190] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    2.835974] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    2.838276] ehci-pci 0000:00:1a.0: debug port 2
[    2.839700] WARNING: CPU: 0 PID: 1 at drivers/iommu/intel-iommu.c:598 domain_get_iommu+0x55/0x60
[    2.840671] Modules linked in:
[    2.840671] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-170.el8.kdump2.x86_64 #1
[    2.840671] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 07/21/2019
[    2.840671] RIP: 0010:domain_get_iommu+0x55/0x60
[    2.840671] Code: c2 01 eb 0b 48 83 c0 01 8b 34 87 85 f6 75 0b 48 63 c8 48 39 c2 75 ed 31 c0 c3 48 c1 e1 03 48 8b 05 70 f3 91 01 48 8b 04 08 c3 <0f> 0b 31 c0 c3 31 c9 eb eb 66 90 0f 1f 44 00 00 41 55 40 0f b6 f6
[    2.840671] RSP: 0018:ffffc900000dfab8 EFLAGS: 00010202
[    2.840671] RAX: ffff88ec7f1c8000 RBX: 0000006c7c867000 RCX: 0000000000000000
[    2.840671] RDX: 00000000fffffff0 RSI: 0000000000000000 RDI: ffff88ec7f1c8000
[    2.840671] RBP: ffff88ec6f7000b0 R08: ffff88ec7f19d000 R09: ffff88ec7cbfcd00
[    2.840671] R10: 0000000000000095 R11: ffffc900000df928 R12: 0000000000000000
[    2.840671] R13: ffff88ec7f1c8000 R14: 0000000000001000 R15: 00000000ffffffff
[    2.840671] FS:  0000000000000000(0000) GS:ffff88ec7f600000(0000) knlGS:0000000000000000
[    2.840671] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.840671] CR2: 00007ff3e1713000 CR3: 0000006c7de0a004 CR4: 00000000001606b0
[    2.840671] Call Trace:
[    2.840671]  __intel_map_single+0x62/0x140
[    2.840671]  intel_alloc_coherent+0xa6/0x130
[    2.840671]  dma_pool_alloc+0xd8/0x1e0
[    2.840671]  e_qh_alloc+0x55/0x130
[    2.840671]  ehci_setup+0x284/0x7b0
[    2.840671]  ehci_pci_setup+0xa3/0x530
[    2.840671]  usb_add_hcd+0x2b6/0x800
[    2.840671]  usb_hcd_pci_probe+0x375/0x460
[    2.840671]  local_pci_probe+0x41/0x90
[    2.840671]  pci_device_probe+0x105/0x1b0
[    2.840671]  driver_probe_device+0x12d/0x460
[    2.840671]  device_driver_attach+0x50/0x60
[    2.840671]  __driver_attach+0x61/0x130
[    2.840671]  ? device_driver_attach+0x60/0x60
[    2.840671]  bus_for_each_dev+0x77/0xc0
[    2.840671]  ? klist_add_tail+0x3b/0x70
[    2.840671]  bus_add_driver+0x14d/0x1e0
[    2.840671]  ? ehci_hcd_init+0xaa/0xaa
[    2.840671]  ? do_early_param+0x91/0x91
[    2.840671]  driver_register+0x6b/0xb0
[    2.840671]  ? ehci_hcd_init+0xaa/0xaa
[    2.840671]  do_one_initcall+0x46/0x1c3
[    2.840671]  ? do_early_param+0x91/0x91
[    2.840671]  kernel_init_freeable+0x1af/0x258
[    2.840671]  ? rest_init+0xaa/0xaa
[    2.840671]  kernel_init+0xa/0xf9
[    2.840671]  ret_from_fork+0x35/0x40
[    2.840671] ---[ end trace e87b0d9a1c8135c4 ]---
[    3.010848] ehci-pci 0000:00:1a.0: Using iommu dma mapping
[    3.012551] ehci-pci 0000:00:1a.0: 32bit DMA uses non-identity mapping
[    3.018537] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    3.021188] ehci-pci 0000:00:1a.0: irq 18, io mem 0x93002000
[    3.029006] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    3.030918] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.18
[    3.033491] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.035900] usb usb1: Product: EHCI Host Controller
[    3.037423] usb usb1: Manufacturer: Linux 4.18.0-170.el8.kdump2.x86_64 ehci_hcd
[    3.039691] usb usb1: SerialNumber: 0000:00:1a.0

It looks like the device finishes initializing once it figures out it
needs dma mapping instead of the default
passthrough. intel_alloc_coherent calls iommu_need_mapping, before it
calls __intel_map_single, so I'm not sure why it is tripping over the
WARN_ON in domain_get_iommu.

one thing I noticed while looking at this is that domain_get_iommu can
return NULL. So should there be something like the following in
__intel_map_single after the domain_get_iommu call?

if (!iommu)
    goto error;

It is possible to deref the null pointer later otherwise.

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
