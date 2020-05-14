Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E650EC433E0
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 03:18:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97056205CB
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 03:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkrLDyQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97056205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 443308961C;
	Thu, 14 May 2020 03:18:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fxTr1mjNKqn3; Thu, 14 May 2020 03:18:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 513B589631;
	Thu, 14 May 2020 03:18:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FC22C0178;
	Thu, 14 May 2020 03:18:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D584C016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 03:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 13C7189631
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 03:18:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9VIMAhQhi3ZR for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 03:18:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7C78E8961C
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 03:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589426324;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type; bh=asqYu1Io84Hc74evsgnkwdMNUeCYVbUW4PlP/c85uvY=;
 b=AkrLDyQgEbzU6Kjui03wwMnL4piCUrmX87ljjQ/LcuZ/e0F5irfbrnAhlrMe4p4kyWJFJ8
 pMExt/9Z7aQezjxwGB3N8dl5TokWTcus1JLAYe8GF8GRoxutKmfQK1HIHux+1VcFe0LMXf
 gzrChHFd0yB1QF37dlZ+tlgJts7Jhs0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-bE7RnxtWMnSNiqf0hQPwkg-1; Wed, 13 May 2020 23:18:42 -0400
X-MC-Unique: bE7RnxtWMnSNiqf0hQPwkg-1
Received: by mail-qt1-f197.google.com with SMTP id v18so2027906qtq.22
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 20:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:mime-version:content-disposition;
 bh=asqYu1Io84Hc74evsgnkwdMNUeCYVbUW4PlP/c85uvY=;
 b=kIlXob4k/3X1pM6CPcPMoUdkcO5lOmqQHeidiioHJSFoonvf02zDWiMLrVekw3Jkdf
 hXEjraLWNI6bNND57nKlmcLbfht/j7Z8TwnOAcyaEhRjCbLe/q04oSHINx82oT4rAtWa
 N6L3l/cfGi/RY2fPlKXB/MKtkpqGpYqKK+xtP7Zqi30Hu/RTWNhfW8rTBHqFw//z1xmt
 hTdDNDHgSPcDDxP4mtUUlXZvW9bUolxfFbWLB2ZVXcDCLleJBaeFICRqNQyJOcuK9HxI
 V+mCyDhKvRcmHp+yOtiCcbUay0uz+mWmgEsy/ep47x4jPFt8l2RJcdNpwX0uTITLEIsK
 4kWQ==
X-Gm-Message-State: AOAM532McycR8DgLLVmUiFI+kXEB3/6/2jVDqUBJI2qtX/N4zHngnww7
 YQKFxgwuEivlMLVYfTfkoR4rGhORaG+DZ3bect0G+dlLFAPtC67b2sqeCO1Yp+d8xuhmwpAqoY7
 FFDUdVSIq9xPn2V1McS7t7ypdmuo2JA==
X-Received: by 2002:a05:620a:208f:: with SMTP id
 e15mr2675134qka.377.1589426321101; 
 Wed, 13 May 2020 20:18:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn2d7Jag/5cHR213Dg1PLABPyU6dlnEnCoEgKQlDFCue9b4NXw3YUiW0VH8dfCyNSF7FeVew==
X-Received: by 2002:a05:620a:208f:: with SMTP id
 e15mr2675112qka.377.1589426320577; 
 Wed, 13 May 2020 20:18:40 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id i3sm1729197qkf.39.2020.05.13.20.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 20:18:39 -0700 (PDT)
Date: Wed, 13 May 2020 20:18:38 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: amd kdump failure with iommu=nopt
Message-ID: <20200514031838.2oklmyrc3n5it2ox@cantor>
Mail-Followup-To: linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Tom Murphy <murphyt7@tcd.ie>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Tom Murphy <murphyt7@tcd.ie>
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

We've seen kdump failures with recent kernels (5.5, 5.6, 5.7-rc1) on
amd systems when iommu is enabled in translation mode. In the cases so
far there has been mpt3sas involved, but I'm also seeing io page
faults for ahci right before mpt3sas has an io page fault:

[   15.156620] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xfff9b300 flags=0x0020]
[   15.166889] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xfff9b320 flags=0x0020]
[   15.177169] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   15.186100] ata4.00: failed to IDENTIFY (device reports invalid type, err_mask=0x0)
[   15.193786] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f730c0 flags=0x0020]
[   15.204059] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f732c0 flags=0x0020]
[   15.214327] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f734c0 flags=0x0020]
[   15.224597] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f736c0 flags=0x0020]
[   15.234867] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f738c0 flags=0x0020]
[   15.245138] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73ac0 flags=0x0020]
[   15.255407] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73cc0 flags=0x0020]
[   15.265677] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73ec0 flags=0x0020]
[   20.599101] ata2.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   20.916172] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   20.922429] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xfff9b300 flags=0x0020]
[   20.932703] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xfff9b320 flags=0x0020]
[   20.943234] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   20.949430] ata4.00: failed to IDENTIFY (device reports invalid type, err_mask=0x0)
[   20.957115] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f730c0 flags=0x0020]
[   20.967384] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f732c0 flags=0x0020]
[   20.977654] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f734c0 flags=0x0020]
[   20.987923] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f736c0 flags=0x0020]
[   20.998193] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f738c0 flags=0x0020]
[   21.008464] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73ac0 flags=0x0020]
[   21.018733] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73cc0 flags=0x0020]
[   21.029005] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73ec0 flags=0x0020]
[   26.231097] ata2.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   26.238415] ata2: limiting SATA link speed to 3.0 Gbps
[   26.548169] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   26.564483] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 320)
[   26.571026] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f730c0 flags=0x0020]
[   26.581301] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f732c0 flags=0x0020]
[   26.591568] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f734c0 flags=0x0020]
[   26.601839] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f736c0 flags=0x0020]
[   26.612109] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f738c0 flags=0x0020]
[   26.622377] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73ac0 flags=0x0020]
[   26.632647] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73cc0 flags=0x0020]
[   26.642917] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73ec0 flags=0x0020]
[   26.654047] ata2.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   26.743097] xhci_hcd 0000:05:00.3: Error while assigning device slot ID
[   26.749718] xhci_hcd 0000:05:00.3: Max number of devices this xHCI host supports is 64.
[   26.757730] usb usb1-port2: couldn't allocate usb_device
[   26.987555] mpt3sas version 33.100.00.00 loaded
[   26.994668] mpt3sas_cm0: 63 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (226256 kB)
[   27.060443] mpt3sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
[   27.068469] mpt3sas_cm0: MSI-X vectors supported: 96
[   27.073444] 	 no of cores: 1, max_msix_vectors: -1
[   27.078244] mpt3sas_cm0:  0 1
[   27.081471] mpt3sas_cm0: High IOPs queues : disabled
[   27.086458] mpt3sas0-msix0: PCI-MSI-X enabled: IRQ 81
[   27.091525] mpt3sas_cm0: iomem(0x00000000cf600000), mapped(0x000000001e78b962), size(65536)
[   27.099884] mpt3sas_cm0: ioport(0x0000000000007000), size(256)
[   27.163505] mpt3sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
[   27.171515] mpt3sas_cm0: sending message unit reset !!
[   27.178166] mpt3sas_cm0: message unit reset: SUCCESS
[   27.210746] mpt3sas_cm0: scatter gather: sge_in_main_msg(1), sge_per_chain(7), sge_per_io(32), chains_per_io(5)
[   27.220864] mpt3sas_cm0: request pool(0x00000000fed2db53) - dma(0xfffe0000): depth(437), frame_size(128), pool_size(54 kB)
[   27.232004] mpt3sas_cm0: sense pool(0x000000009497c16e)- dma(0xfffb0000): depth(200),element_size(96), pool_size(18 kB)
[   27.242811] mpt3sas_cm0: config page(0x000000009f24a585) - dma(0xfff9e000): size(512)
[   27.250648] mpt3sas_cm0: Allocated physical memory: size(170 kB)
[   27.256658] mpt3sas_cm0: Current Controller Queue Depth(197),Max Controller Queue Depth(9584)
[   27.265187] mpt3sas_cm0: Scatter Gather Elements per IO(32)
[   27.315042] mpt3sas 0000:61:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0041 address=0xfffe9e80 flags=0x0000]
[   32.182274] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 320)
[   29.241641] systemd-udevd[414]: link_config: autonegotiation is unset or enabled, the speed and duplex are not writable.
[   42.615097] mpt3sas_cm0: _base_display_fwpkg_version: complete
[   42.620943] mpt3sas_cm0: _base_display_fwpkg_version: timeout
[   42.626702] mf:
[   42.626702] 	
[   42.626703] 12000001 
[   42.630031] 00000000 
[   42.632319] 00000000 
[   42.634604] 00000000 
[   42.636891] 00000000 
[   42.639179] 00000000 
[   42.641466] 00000000 
[   42.643754] 00000100 
[   42.646041] 
[   42.646041] 	
[   42.648323] fff9d000 
[   42.651389] 00000000 
[   42.653677] 00000100 
[   42.655968] 40000000 
[   42.658255] 
[   42.662212] mpt3sas_cm0 fault info from func: _base_make_ioc_ready
[   42.668399] mpt3sas_cm0: fault_state(0x2623)!
[   42.672770] mpt3sas_cm0: sending diag reset !!
[   43.590290] mpt3sas_cm0: diag reset: SUCCESS
[   43.594953] mpt3sas_cm0: failure at drivers/scsi/mpt3sas/mpt3sas_scsih.c:10790/_scsih_probe()!
[  167.493060] dracut-initqueue[416]: Warning: dracut-initqueue timeout - starting timeout scripts
[  168.037841] dracut-initqueue[416]: Warning: dracut-initqueue timeout - starting timeout scripts
[  168.565044] dracut-initqueue[416]: Warning: dracut-initqueue timeout - starting timeout scripts
[  169.091831] dracut-initqueue[416]: Warning: dracut-initqueue timeout - starting timeout scripts

Actually testing just now on another system without mptsas it also fails. It doesn't show io page faults,
but there are some ata errors and it appears to be stuck waiting on a usb device:

[   19.037113] ata1.00: qc timeout (cmd 0xec)
[   19.041215] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   19.509122] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   29.789122] ata1.00: qc timeout (cmd 0xec)
[   29.793235] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   29.799324] ata1: limiting SATA link speed to 3.0 Gbps
[   30.269122] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   60.509121] ata1.00: qc timeout (cmd 0xec)
[   60.513227] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   60.981121] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   61.098503] [drm] Using P2A bridge for configuration
[   61.103473] [drm] AST 2500 detected
[   61.106967] [drm] Analog VGA only
[   61.110297] [drm] dram MCLK=800 Mhz type=7 bus_width=16 size=01000000
[   61.118219] [TTM] Zone  kernel: Available graphics memory: 113168 KiB
[   61.124660] [TTM] Initializing pool allocator
[   61.129040] [TTM] Initializing DMA pool allocator
[   61.143850] fbcon: astdrmfb (fb0) is primary device
[   61.166392] Console: switching to colour frame buffer device 128x48
[   61.195840] ast 0000:64:00.0: fb0: astdrmfb frame buffer device
[   61.201763] [drm] Initialized ast 0.1.0 20120228 for 0000:64:00.0 on minor 0
[   55.456688] systemd-udevd[418]: link_config: autonegotiation is unset or enabled, the speed and duplex are not writable.
[   66.967202] systemd-udevd[395]: seq 3198 '/devices/pci0000:20/0000:20:08.1/0000:23:00.3/usb1' is taking a long time
[  186.967741] systemd-udevd[395]: seq 3198 '/devices/pci0000:20/0000:20:08.1/0000:23:00.3/usb1' killed
[  186.978323] systemd-udevd[395]: worker [419] terminated by signal 9 (KILL)
[  186.987747] systemd-udevd[395]: worker [419] failed while handling '/devices/pci0000:20/0000:20:08.1/0000:23:00.3/usb1'
[  253.021118] INFO: task kworker/0:1:12 blocked for more than 122 seconds.
[  253.027819]       Not tainted 5.5.0-1.elrdy.x86_64 #1
[  253.032871] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  253.040695] kworker/0:1     D    0    12      2 0x80004000
[  253.046181] Workqueue: usb_hub_wq hub_event
[  253.050361] Call Trace:
[  253.052820]  ? __schedule+0x25f/0x690
[  253.056477]  schedule+0x40/0xb0
[  253.059618]  schedule_timeout+0x20d/0x310
[  253.063628]  wait_for_completion+0x113/0x180
[  253.067895]  ? wake_up_q+0xa0/0xa0
[  253.071300]  xhci_alloc_dev+0x9b/0x270
[  253.075050]  usb_alloc_dev+0x6f/0x336
[  253.078708]  hub_port_connect+0x24d/0x850
[  253.082711]  port_event+0x569/0x850
[  253.086194]  hub_event+0x141/0x3a0
[  253.089594]  process_one_work+0x1a1/0x360
[  253.093605]  worker_thread+0x30/0x380
[  253.097262]  ? max_active_store+0x80/0x80
[  253.101266]  kthread+0x112/0x130
[  253.104489]  ? __kthread_parkme+0x70/0x70
[  253.108495]  ret_from_fork+0x22/0x40



It was bisected to:

commit be62dbf554c5b50718a54a359372c148cd9975c7
Author: Tom Murphy <murphyt7@tcd.ie>
Date:   Sun Sep 8 09:56:41 2019 -0700

     iommu/amd: Convert AMD iommu driver to the dma-iommu api
     
     Convert the AMD iommu driver to the dma-iommu api. Remove the iova
     handling and reserve region code from the AMD iommu driver.
     
     Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
     Signed-off-by: Joerg Roedel <jroedel@suse.de>

I've reproduced with 5.7-rc4 + your latest fixes for amd_iommu. With passthrough mode kdump succeeds.

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
