Return-Path: <SRS0=h1an=BY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E70C433DF
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 12:08:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0885E2054F
	for <iommu@archiver.kernel.org>; Fri, 14 Aug 2020 12:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sH84eu5A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0885E2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC08088B4B;
	Fri, 14 Aug 2020 12:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id icW9wjC+jgY1; Fri, 14 Aug 2020 12:08:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DA8EB88B52;
	Fri, 14 Aug 2020 12:08:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6D3AC013C;
	Fri, 14 Aug 2020 12:08:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 776D9C004D
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 12:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 654DE88B52
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 12:08:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wlm0RWUD0+5K for <iommu@lists.linux-foundation.org>;
 Fri, 14 Aug 2020 12:08:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2C3CD88B4B
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 12:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=YOFwabxIxaXlgO37Qtp0PlozZJdfNtJ1u/Fi1FvFj9c=; b=sH84eu5ALjjch6DREwOjil+fLC
 +H933uNacXDupxhBQXil4MzkdrQjGIfBLLv0CXngXsIJbFb2e9jnOUHh007dZuOE3uC3moX5ea5Ha
 3wyqRXMEub4xfiT4M/9pflMjbAlYOsddlzv1ysnPUHczu6sDYxIZ0GrpwPH0Qh/EJUYmNQX217C1D
 g0Y+fQsIBNIIcbjhXDHcamhdK9De10xMl3uUW5mQLmKyzyEk7h1sU9eTHpEQoJmXRY8N1NNb5WDUs
 daS2ksV5AC1ggATcX4bR1Fzl3SyOYN8GKpVuCLykBTv6BEjqyD5h6izmjYQBRgEA5qF+p/kwKun52
 nuODzd2A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k6YVU-0000sN-6L; Fri, 14 Aug 2020 12:08:24 +0000
Date: Fri, 14 Aug 2020 13:08:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: nvme crash - Re: linux-next: Tree for Aug 13
Message-ID: <20200814120824.GB1872@infradead.org>
References: <20200813155009.GA2303@infradead.org>
 <81e42d30-ede3-d7b0-ad7b-8192bcf27a4c@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81e42d30-ede3-d7b0-ad7b-8192bcf27a4c@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, chaitanya.kulkarni@wdc.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, Aug 14, 2020 at 01:00:30PM +0100, John Garry wrote:
> 
> > > I have experienced this this crash below on linux-next for the last few days
> > > on my arm64 system. Linus' master branch today also has it.
> > Adding Robin and the iommu list as this seems to be in the dma-iommu
> > code.
> > 
> > > root@ubuntu:/home/john# insmod nvme.ko
> > > [148.254564] nvme 0000:81:00.0: Adding to iommu group 21
> > > [148.260973] nvme nvme0: pci function 0000:81:00.0
> > > root@ubuntu:/home/john# [148.272996] Unable to handle kernel NULL pointer
> > > dereference at virtual address 0000000000000010
> > > [148.281784] Mem abort info:
> > > [148.284584] ESR = 0x96000004
> > > [148.287641] EC = 0x25: DABT (current EL), IL = 32 bits
> > > [148.292950] SET = 0, FnV = 0
> > > [148.295998] EA = 0, S1PTW = 0
> > > [148.299126] Data abort info:
> > > [148.302003] ISV = 0, ISS = 0x00000004
> > > [148.305832] CM = 0, WnR = 0
> > > [148.308794] user pgtable: 4k pages, 48-bit VAs, pgdp=00000a27bf3c9000
> > > [148.315229] [0000000000000010] pgd=0000000000000000, p4d=0000000000000000
> > > [148.322016] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > > [148.327577] Modules linked in: nvme nvme_core
> > > [148.331927] CPU: 56 PID: 256 Comm: kworker/u195:0 Not tainted
> > > 5.8.0-next-20200812 #27
> > > [148.339744] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI RC0 -
> > > V1.16.01 03/15/2019
> > > [148.348260] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
> > > [148.353822] pstate: 80c00009 (Nzcv daif +PAN +UAO BTYPE=--)
> > > [148.359390] pc : __sg_alloc_table_from_pages+0xec/0x238
> > > [148.364604] lr : __sg_alloc_table_from_pages+0xc8/0x238
> > > [148.369815] sp : ffff800013ccbad0
> > > [148.373116] x29: ffff800013ccbad0 x28: ffff0a27b3d380a8
> > > [148.378417] x27: 0000000000000000 x26: 0000000000002dc2
> > > [148.383718] x25: 0000000000000dc0 x24: 0000000000000000
> > > [148.389019] x23: 0000000000000000 x22: ffff800013ccbbe8
> > > [148.394320] x21: 0000000000000010 x20: 0000000000000000
> > > [148.399621] x19: 00000000fffff000 x18: ffffffffffffffff
> > > [148.404922] x17: 00000000000000c0 x16: fffffe289eaf6380
> > > [148.410223] x15: ffff800011b59948 x14: ffff002bc8fe98f8
> > > [148.415523] x13: ff00000000000000 x12: ffff8000114ca000
> > > [148.420824] x11: 0000000000000000 x10: ffffffffffffffff
> > > [148.426124] x9 : ffffffffffffffc0 x8 : ffff0a27b5f9b6a0
> > > [148.431425] x7 : 0000000000000000 x6 : 0000000000000001
> > > [148.436726] x5 : ffff0a27b5f9b680 x4 : 0000000000000000
> > > [148.442027] x3 : ffff0a27b5f9b680 x2 : 0000000000000000
> > > [148.447328] x1 : 0000000000000001 x0 : 0000000000000000
> > > [148.452629] Call trace:
> > > [148.455065]__sg_alloc_table_from_pages+0xec/0x238
> > > [148.459931]sg_alloc_table_from_pages+0x18/0x28
> > > [148.464541]iommu_dma_alloc+0x474/0x678
> > > [148.468455]dma_alloc_attrs+0xd8/0xf0
> > > [148.472193]nvme_alloc_queue+0x114/0x160 [nvme]
> > > [148.476798]nvme_reset_work+0xb34/0x14b4 [nvme]
> > > [148.481407]process_one_work+0x1e8/0x360
> > > [148.485405]worker_thread+0x44/0x478
> > > [148.489055]kthread+0x150/0x158
> > > [148.492273]ret_from_fork+0x10/0x34
> > > [148.495838] Code: f94002c3 6b01017f 540007c2 11000486 (f8645aa5)
> > > [148.501921] ---[ end trace 89bb2b72d59bf925 ]---
> > > 
> > > Anything to worry about? I guess not since we're in the merge window, but
> > > mentioning just in case ...
> 
> I bisected, and this patch looks to fix it (note the comments below the
> '---'):
> 
> From 263891a760edc24b901085bf6e5fe2480808f86d Mon Sep 17 00:00:00 2001
> From: John Garry <john.garry@huawei.com>
> Date: Fri, 14 Aug 2020 12:45:18 +0100
> Subject: [PATCH] nvme-pci: Use u32 for nvme_dev.q_depth
> 
> Recently nvme_dev.q_depth was changed from int to u16 type.
> 
> This falls over for the queue depth calculation in nvme_pci_enable(),
> where NVME_CAP_MQES(dev->ctrl.cap) + 1 may overflow, as NVME_CAP_MQES()
> gives a 16b number also. That happens for me, and this is the result:

Oh, interesting.  Please also switch the module option parsing to
use kstrtou32 and param_set_uint and send this as a formal patch.

Thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
