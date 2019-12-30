Return-Path: <SRS0=hfNk=2U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86131C2D0C0
	for <iommu@archiver.kernel.org>; Mon, 30 Dec 2019 00:36:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1B3207FD
	for <iommu@archiver.kernel.org>; Mon, 30 Dec 2019 00:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1B3207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CE4F18594B;
	Mon, 30 Dec 2019 00:36:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Gu8a1zh24OY; Mon, 30 Dec 2019 00:36:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A06B385740;
	Mon, 30 Dec 2019 00:36:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64941C1796;
	Mon, 30 Dec 2019 00:36:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E585EC077D
 for <iommu@lists.linux-foundation.org>; Mon, 30 Dec 2019 00:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C543582404
 for <iommu@lists.linux-foundation.org>; Mon, 30 Dec 2019 00:36:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mCQ7q1W4OJcw for <iommu@lists.linux-foundation.org>;
 Mon, 30 Dec 2019 00:36:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EBE3081F23
 for <iommu@lists.linux-foundation.org>; Mon, 30 Dec 2019 00:36:17 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Dec 2019 16:36:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,373,1571727600"; d="scan'208";a="243722551"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 29 Dec 2019 16:36:15 -0800
Subject: Re: [PATCH] iommu/vt-d fix adding non-PCI devices to Intel IOMMU
To: Patrick Steinhardt <ps@pks.im>, iommu@lists.linux-foundation.org
References: <b47f83548d855ac920ad06b0ff78b877fa4f5189.1577404477.git.ps@pks.im>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4a0cb002-bd41-b1df-5b63-16ea6f50f406@linux.intel.com>
Date: Mon, 30 Dec 2019 08:35:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b47f83548d855ac920ad06b0ff78b877fa4f5189.1577404477.git.ps@pks.im>
Content-Language: en-US
Cc: David Woodhouse <dwmw2@infradead.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

On 12/27/19 7:56 AM, Patrick Steinhardt wrote:
> Starting with commit fa212a97f3a3 ("iommu/vt-d: Probe DMA-capable ACPI
> name space devices"), we now probe DMA-capable ACPI name
> space devices. On Dell XPS 13 9343, which has an Intel LPSS platform
> device INTL9C60 enumerated via ACPI, this change leads to the following
> warning:
> 
>      ------------[ cut here ]------------
>      WARNING: CPU: 1 PID: 1 at pci_device_group+0x11a/0x130
>      CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 5.5.0-rc3+ #22
>      Hardware name: Dell Inc. XPS 13 9343/0310JH, BIOS A20 06/06/2019
>      RIP: 0010:pci_device_group+0x11a/0x130
>      Code: f0 ff ff 48 85 c0 49 89 c4 75 c4 48 8d 74 24 10 48 89 ef e8 48 ef ff ff 48 85 c0 49 89 c4 75 af e8 db f7 ff ff 49 89 c4 eb a5 <0f> 0b 49 c7 c4 ea ff ff ff eb 9a e8 96 1e c7 ff 66 0f 1f 44 00 00
>      RSP: 0000:ffffc0d6c0043cb0 EFLAGS: 00010202
>      RAX: 0000000000000000 RBX: ffffa3d1d43dd810 RCX: 0000000000000000
>      RDX: ffffa3d1d4fecf80 RSI: ffffa3d12943dcc0 RDI: ffffa3d1d43dd810
>      RBP: ffffa3d1d43dd810 R08: 0000000000000000 R09: ffffa3d1d4c04a80
>      R10: ffffa3d1d4c00880 R11: ffffa3d1d44ba000 R12: 0000000000000000
>      R13: ffffa3d1d4383b80 R14: ffffa3d1d4c090d0 R15: ffffa3d1d4324530
>      FS:  0000000000000000(0000) GS:ffffa3d1d6700000(0000) knlGS:0000000000000000
>      CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>      CR2: 0000000000000000 CR3: 000000000460a001 CR4: 00000000003606e0
>      Call Trace:
>       ? iommu_group_get_for_dev+0x81/0x1f0
>       ? intel_iommu_add_device+0x61/0x170
>       ? iommu_probe_device+0x43/0xd0
>       ? intel_iommu_init+0x1fa2/0x2235
>       ? pci_iommu_init+0x52/0xe7
>       ? e820__memblock_setup+0x15c/0x15c
>       ? do_one_initcall+0xcc/0x27e
>       ? kernel_init_freeable+0x169/0x259
>       ? rest_init+0x95/0x95
>       ? kernel_init+0x5/0xeb
>       ? ret_from_fork+0x35/0x40
>      ---[ end trace 28473e7abc25b92c ]---
>      DMAR: ACPI name space devices didn't probe correctly
> 
> The bug results from the fact that while we now enumerate ACPI devices,
> we aren't able to handle any non-PCI device when generating the device
> group. Fix the issue by implementing an Intel-specific callback that
> returns `pci_device_group` only if the device is a PCI device.
> Otherwise, it will return a generic device group.
> 
> Fixes: fa212a97f3a3 ("iommu/vt-d: Probe DMA-capable ACPI name space devices")
> Signed-off-by: Patrick Steinhardt<ps@pks.im>

This will allocate per-device group for the ANDD device. Different
devices that couldn't be isolated should be put in a single group.
Unfortunately, the spec doesn't state how the ANDD devices are isolated.

Currently we don't support assigning a platform device to user level as
far as I can see, so though this fix is not the best, it won't break
anything. I will ack this fix so that the kernel crash could be fixed
before we figure out a better solution.

Cc: stable@vger.kernel.org # v5.3+
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
-baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
