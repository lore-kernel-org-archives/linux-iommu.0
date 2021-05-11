Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C61C43460
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 18:03:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D706616ED
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 18:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D706616ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C7319402B8;
	Tue, 11 May 2021 18:03:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VfVz7wUR4IpL; Tue, 11 May 2021 18:03:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0799400C2;
	Tue, 11 May 2021 18:03:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89530C000D;
	Tue, 11 May 2021 18:03:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33B45C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 18:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E7B682D5D
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 18:03:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YxQFEAsi1Ifc for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 18:03:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6AC8C83C8F
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 18:03:47 +0000 (UTC)
IronPort-SDR: SPPCgYY001G3Fo1v9PBhqj59myU4vsGT/0HWzxCfHxYpvQh6PZUX8VnSNpV1q2JgWzff6CQR+H
 AyxhYwVJrFxw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="196413105"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; d="scan'208";a="196413105"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2021 11:03:25 -0700
IronPort-SDR: igI2hkMwhTJNky0TneHIeis9ZrKM8EdQlPu6AwIr9M00XUdSZvHFazf4kP/W4pKIyGlBPfy9kc
 v0A5mF9aN18w==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; d="scan'208";a="436779964"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2021 11:03:25 -0700
Date: Tue, 11 May 2021 11:05:50 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210511110550.477a434f@jacob-builder>
In-Reply-To: <20210511163521.GN1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>
 <20210510203145.086835cc@jacob-builder>
 <20210511114848.GK1002214@nvidia.com>
 <20210511091452.721e9a03@jacob-builder>
 <20210511163521.GN1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Hi Jason,

On Tue, 11 May 2021 13:35:21 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, May 11, 2021 at 09:14:52AM -0700, Jacob Pan wrote:
> 
> > > Honestly, I'm not convinced we should have "kernel SVA" at all.. Why
> > > does IDXD use normal DMA on the RID for kernel controlled accesses?  
> > 
> > Using SVA simplifies the work submission, there is no need to do
> > map/unmap. Just bind PASID with init_mm, then submit work directly
> > either with ENQCMDS (supervisor version of ENQCMD) to a shared
> > workqueue or put the supervisor PASID in the descriptor for dedicated
> > workqueue.  
> 
> That is not OK, protable drivers in Linux have to sue dma map/unmap
> calls to manage cache coherence. PASID does not opt out of any of
> that.
> 
Let me try to break down your concerns:
1. portability - driver uses DMA APIs can function w/ and w/o IOMMU. is
that your concern? But PASID is intrinsically tied with IOMMU and if
the drivers are using a generic sva-lib API, why they are not portable?
SVA by its definition is to avoid map/unmap every time.

2. cache coherence - as you suggested if we name the flag "direct_map",
there is no mapping change, then there is no need for mmu_notifier like tlb
flush calls, right? it is caller's responsibility to make sure vmalloc are
not used.

> I dislike this whole idea a lot. A single driver should not opt itself
> out of IOMMU based security "just because"
> 
Perhaps I missed your point here. This is NOT a single driver, privileged
access is a PCIe spec defined feature. We are using IOMMU sva-lib APIs, not
sure why it is by-passing.

Perhaps we should add check for struct pci_dev->untrusted && rciep to
address security?

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
