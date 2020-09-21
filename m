Return-Path: <SRS0=nwur=C6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807C0C43465
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 14:51:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0451B20735
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 14:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0451B20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A67CB86E5C;
	Mon, 21 Sep 2020 14:51:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fhm9Zx+Rk7M3; Mon, 21 Sep 2020 14:51:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BA75386DB0;
	Mon, 21 Sep 2020 14:51:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9241FC0859;
	Mon, 21 Sep 2020 14:51:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85FD8C0051
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 14:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7599E85FAE
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 14:51:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S1it9PNNIq2A for <iommu@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 14:51:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6566285FAD
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 14:51:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B432D1476;
 Mon, 21 Sep 2020 07:51:27 -0700 (PDT)
Received: from [10.57.43.251] (unknown [10.57.43.251])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73BA33F718;
 Mon, 21 Sep 2020 07:51:24 -0700 (PDT)
Subject: Re: arm-smmu 5000000.iommu: Cannot accommodate DMA offset for IOMMU
 page tables
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 linux-mtd@lists.infradead.org, open list <linux-kernel@vger.kernel.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 lkft-triage@lists.linaro.org,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
References: <CA+G9fYvuq58q+GsWnzni0sKSHbubuQz-UaK3TASX26V_a7yBVw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c799eecf-8f47-8b57-5a9d-3c2a28cfde9a@arm.com>
Date: Mon, 21 Sep 2020 15:51:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <CA+G9fYvuq58q+GsWnzni0sKSHbubuQz-UaK3TASX26V_a7yBVw@mail.gmail.com>
Content-Language: en-GB
Cc: Poonam Aggrwal <poonam.aggrwal@nxp.com>, robh@kernel.org,
 Joerg Roedel <jroedel@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Richard Weinberger <richard@nod.at>, Zhiqiang.Hou@nxp.com,
 Miquel Raynal <miquel.raynal@bootlin.com>, Suram Suram <suram@nxp.com>,
 masonccyang@mxic.com.tw
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

On 2020-09-21 14:20, Naresh Kamboju wrote:
[...]
> [    2.256403] e1000e 0000:01:00.0: Adding to iommu group 0
> [    2.261733] arm-smmu 5000000.iommu: Cannot accommodate DMA offset
> for IOMMU page tables

Ah, I know what's going on there - the dma_range_map stuff has 
overlooked a subtlety, but it's easily fixed.

> [    2.269752] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000

...although either way that's really not how we should subsequently 
handle failing to allocate a pagetable. I guess I'll take a look into 
what the deal is there as well :(

Robin.

> [    2.278544] Mem abort info:
> [    2.281334]   ESR = 0x96000004
> [    2.284389]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    2.289705]   SET = 0, FnV = 0
> [    2.292759]   EA = 0, S1PTW = 0
> [    2.295900] Data abort info:
> [    2.298781]   ISV = 0, ISS = 0x00000004
> [    2.302618]   CM = 0, WnR = 0
> [    2.305581] [0000000000000000] user address but active_mm is swapper
> [    2.311941] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [    2.317512] Modules linked in:
> [    2.320566] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
>    5.9.0-rc5-next-20200921 #1
> [    2.329352] Hardware name: Freescale Layerscape 2088A RDB Board (DT)
> [    2.335705] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> [    2.341715] pc : arm_smmu_flush_iotlb_all+0x28/0x90
> [    2.346590] lr : iommu_create_device_direct_mappings.isra.0+0x1f0/0x218
> [    2.353203] sp : ffff80001005b9b0
> [    2.356511] x29: ffff80001005b9b0 x28: 0000000000000000
> [    2.361822] x27: ffffdc3792e904e0 x26: ffff80001005ba48
> [    2.367134] x25: ffff0082ee6b0000 x24: ffff0082ed88e0a8
> [    2.372445] x23: 00000000fffffff4 x22: 0000000000001000
> [    2.377755] x21: ffff80001005ba48 x20: 0000000000000000
> [    2.383066] x19: ffff0082cceeeb58 x18: 0000000000000010
> [    2.388377] x17: 0000000000000000 x16: 00000000833b5ff2
> [    2.393688] x15: ffff0082ee6b0480 x14: 203a756d6d6f692e
> [    2.398999] x13: 3030303030303520 x12: 61646f6d6d6f6363
> [    2.404311] x11: 6120746f6e6e6143 x10: 6f66207465736666
> [    2.409622] x9 : ffffdc3791d31078 x8 : ffff0082ed8ffd00
> [    2.414933] x7 : 0000000000000000 x6 : 000000000000003f
> [    2.420244] x5 : 0000000000000040 x4 : ffff80001005b970
> [    2.425554] x3 : 0000000000000000 x2 : 0000000000000000
> [    2.430865] x1 : ffffdc37927dd2f0 x0 : ffff0082cceeeb58
> [    2.436176] Call trace:
> [    2.438618]  arm_smmu_flush_iotlb_all+0x28/0x90
> [    2.443144]  iommu_create_device_direct_mappings.isra.0+0x1f0/0x218
> [    2.449409]  iommu_probe_device+0x6c/0x120
> [    2.453501]  of_iommu_configure+0x134/0x218
> [    2.457683]  of_dma_configure_id+0x110/0x2e8
> [    2.461950]  pci_dma_configure+0x4c/0xd8
> [    2.465870]  really_probe+0xac/0x4d8
> [    2.469441]  driver_probe_device+0xfc/0x168
> [    2.473620]  device_driver_attach+0x7c/0x88
> [    2.477799]  __driver_attach+0xac/0x178
> [    2.481631]  bus_for_each_dev+0x78/0xc8
> [    2.485463]  driver_attach+0x2c/0x38
> [    2.489033]  bus_add_driver+0x14c/0x230
> [    2.492865]  driver_register+0x6c/0x128
> [    2.496696]  __pci_register_driver+0x4c/0x58
> [    2.500964]  e1000_init_module+0x44/0x50
> [    2.504882]  do_one_initcall+0x4c/0x2d0
> [    2.508714]  kernel_init_freeable+0x214/0x280
> [    2.513068]  kernel_init+0x1c/0x120
> [    2.516552]  ret_from_fork+0x10/0x30
> [    2.520124] Code: 910003fd a90153f3 aa0003f3 f85a8014 (f9400280)
> [    2.526224] ---[ end trace d051012f465b08ec ]---
> [    2.530848] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    2.538506] SMP: stopping secondary CPUs
> [    2.542431] Kernel Offset: 0x5c3781480000 from 0xffff800010000000
> [    2.548521] PHYS_OFFSET: 0xffffdb6ac0000000
> [    2.552700] CPU features: 0x0240022,21806008
> [    2.556965] Memory Limit: none
> 
> full test log,
> https://lavalab.nxp.com/scheduler/job/86650#L849
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
