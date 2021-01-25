Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564FBC433E0
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 15:28:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7EC23129
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 15:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7EC23129
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elloe.vision
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F09AB870D0;
	Mon, 25 Jan 2021 15:28:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kb1NU8aDOnG7; Mon, 25 Jan 2021 15:28:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4A7BC870C3;
	Mon, 25 Jan 2021 15:28:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D35BC0FA7;
	Mon, 25 Jan 2021 15:28:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E8B7C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 09:33:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 13354861F4
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 09:33:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wrQhtXOWcX9T for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 09:33:45 +0000 (UTC)
X-Greylist: delayed 00:08:58 by SQLgrey-1.7.6
Received: from iam.tj (yes.iam.tj [109.74.197.121])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9CA5D8614D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 09:33:45 +0000 (UTC)
Received: from [IPv6:2a02:8011:2007:0:8b3e:ff86:373f:70fe] (unknown
 [IPv6:2a02:8011:2007:0:8b3e:ff86:373f:70fe])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by iam.tj (Postfix) with ESMTPSA id 6CBAE340F6
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 09:24:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=elloe.vision; s=2019;
 t=1611566684; bh=GfZUxh8sQKXmCiIfehXmy0GsNiNUcK//JIH33HNCsmM=;
 h=To:From:Subject:Date:From;
 b=p/MHkWg02U77pxKaOXaaneQrCFVyZn7ICJjicu1Zf7yJ+WjMx4PL8a2kU0UK6jirH
 9pdNUtG65Duby3hX+tZDHKAK2zypdE1Roz0Rd40p5OGG83uA9/Gv4IHHdxMg3d6Jvm
 4HYN3PhcRkrwMfvHkvghXlC4AjHDUmLB2bzT5SB7FBmsbgqGZuWF9hoLVPGgk2ooft
 iNbHYtYRzd+p6V4idfHvIt1dXCWRS1zpiVIIcFu3XxjU2RLNDpxKbsl2j37U9CmGn1
 ZleB/KWlCP4o231Pw6oPXjP91WwA2hUDXHOXtlPxVzGsV+gjpRIEBemL9yktg5q+Q9
 1p5JPy/9gKkaA==
To: iommu@lists.linux-foundation.org
From: "Tj (Elloe Linux)" <ml.linux@elloe.vision>
Subject: AMD-Vi: Unable to read/write to IOMMU perf counter
Organization: Elloe CIC
Message-ID: <b44a9f38-adc2-f1f2-d544-c907920a7452@elloe.vision>
Date: Mon, 25 Jan 2021 09:24:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Language: en-GB
X-Mailman-Approved-At: Mon, 25 Jan 2021 15:28:46 +0000
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

Lenovo E495 reports:

pci 0000:00:00.2: AMD-Vi: Unable to read/write to IOMMU perf counter.
pci 0000:00:00.2: can't derive routing for PCI INT A
pci 0000:00:00.2: PCI INT A: not connected

I found an existing identical bug report that doesn't seem to have
gained any attention:

https://bugzilla.kernel.org/show_bug.cgi?id=201753

Linux version 5.11.0-rc4+ (tj@elloe000) (gcc (Ubuntu
9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #12
SMP PREEMPT Sun Jan 24 11:28:01 GMT 2021
Command line: BOOT_IMAGE=/vmlinuz-5.11.0-rc4+
root=/dev/mapper/ELLOE000-rootfs ro acpi_osi=! "acpi_osi=Windows 2016"
systemd.unified_cgroup_hierarchy=1 nosplash
...
DMI: LENOVO 20NECTO1WW/20NECTO1WW, BIOS R11ET32W (1.12 ) 12/23/2019
...
AMD-Vi: ivrs, add hid:PNPD0040, uid:, rdevid:152
...
smpboot: CPU0: AMD Ryzen 7 3700U with Radeon Vega Mobile Gfx (family:
0x17, model: 0x18, stepping: 0x1)
...
pci 0000:00:00.2: AMD-Vi: Unable to read/write to IOMMU perf counter.
pci 0000:00:00.2: can't derive routing for PCI INT A
pci 0000:00:00.2: PCI INT A: not connected
pci 0000:00:01.0: Adding to iommu group 0
pci 0000:00:01.1: Adding to iommu group 1
pci 0000:00:01.2: Adding to iommu group 2
pci 0000:00:01.3: Adding to iommu group 3
pci 0000:00:01.6: Adding to iommu group 4
pci 0000:00:08.0: Adding to iommu group 5
pci 0000:00:08.1: Adding to iommu group 6
pci 0000:00:14.0: Adding to iommu group 7
pci 0000:00:14.3: Adding to iommu group 7
pci 0000:00:18.0: Adding to iommu group 8
pci 0000:00:18.1: Adding to iommu group 8
pci 0000:00:18.2: Adding to iommu group 8
pci 0000:00:18.3: Adding to iommu group 8
pci 0000:00:18.4: Adding to iommu group 8
pci 0000:00:18.5: Adding to iommu group 8
pci 0000:00:18.6: Adding to iommu group 8
pci 0000:00:18.7: Adding to iommu group 8
pci 0000:01:00.0: Adding to iommu group 9
pci 0000:02:00.0: Adding to iommu group 10
pci 0000:03:00.0: Adding to iommu group 11
pci 0000:04:00.0: Adding to iommu group 12
pci 0000:05:00.0: Adding to iommu group 13
pci 0000:05:00.1: Adding to iommu group 14
pci 0000:05:00.2: Adding to iommu group 14
pci 0000:05:00.3: Adding to iommu group 14
pci 0000:05:00.4: Adding to iommu group 14
pci 0000:05:00.5: Adding to iommu group 14
pci 0000:05:00.6: Adding to iommu group 14
pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
pci 0000:00:00.2: AMD-Vi: Extended features (0x4f77ef22294ada):
 PPR NX GT IA GA PC GA_vAPIC
AMD-Vi: Interrupt remapping enabled
AMD-Vi: Virtual APIC enabled
AMD-Vi: Lazy IO/TLB flushing enabled
amd_uncore: 4  amd_df counters detected
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
