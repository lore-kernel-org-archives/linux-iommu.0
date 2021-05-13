Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EF6C433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 12:57:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8897061421
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 12:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8897061421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 26ED840267;
	Thu, 13 May 2021 12:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NQ3L5pFa1bAW; Thu, 13 May 2021 12:57:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 14487400D0;
	Thu, 13 May 2021 12:57:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D88CAC000D;
	Thu, 13 May 2021 12:57:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69C9CC0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 12:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5783F608A2
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 12:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t0f1kXwXiqhY for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 12:57:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F022608A0
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 12:57:49 +0000 (UTC)
IronPort-SDR: v1cP6dhd9Ped8TJOF7tNOOlWeSyNLlJ6gSaWZEiNM59kZl/+Tj7+HUBAA8Aa/GaUtzKguBFHUI
 swT/fhdTERSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="261182170"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="261182170"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 05:57:46 -0700
IronPort-SDR: +Ka8K3jSvMdk9JcfAqQ9xlSFFWZUb8o2IAO9JmMQkfdxsdh1yWj+ZikhEso8Y9ZUOqF/o6pWfw
 a9IAufpbsw6Q==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="392272892"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 05:57:46 -0700
Date: Thu, 13 May 2021 06:00:12 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210513060012.0fcc7653@jacob-builder>
In-Reply-To: <YJt3tGlzFK3b4E82@infradead.org>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>
 <20210510203145.086835cc@jacob-builder>
 <20210511114848.GK1002214@nvidia.com>
 <20210511091452.721e9a03@jacob-builder>
 <20210511163521.GN1002214@nvidia.com>
 <20210511110550.477a434f@jacob-builder>
 <20210511194726.GP1002214@nvidia.com>
 <YJt3tGlzFK3b4E82@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Luck,
 Tony" <tony.luck@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, zhangfei.gao@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

Hi Christoph,

On Wed, 12 May 2021 07:37:40 +0100, Christoph Hellwig <hch@infradead.org>
wrote:

> On Tue, May 11, 2021 at 04:47:26PM -0300, Jason Gunthorpe wrote:
> > > Let me try to break down your concerns:
> > > 1. portability - driver uses DMA APIs can function w/ and w/o IOMMU.
> > > is that your concern? But PASID is intrinsically tied with IOMMU and
> > > if the drivers are using a generic sva-lib API, why they are not
> > > portable? SVA by its definition is to avoid map/unmap every time.  
> > 
> > Kernel explicitly does not support this programming model. All DMA is
> > explicit and the DMA API hides platform details like IOMMU and CPU
> > cache coherences. Just because x86 doesn't care about this doesn't
> > make any of it optional.  
> 
> Exactly.
Perhaps we can view these SVA capable devices as FPU or a device that can
be fused onto the CPU by PASID binding. We don't require DMA map/unmap for
FPU to use kernel virtual address, right?

> 
> > If you want to do SVA PASID then it also must come with DMA APIs to
> > manage the CPU cache coherence that are all NOP's on x86.  
> 
> Yes.  And we have plenty of precende where an IOMMU is in "bypass" mode
> to allow access to all memory and then uses the simple dma-direct case.
I agree it is better not to expose the entire direct map. But the missing
piece of using DMA APIs is the PASID. The caller needs the PASID value to
do work submission once buffer is mapped.

Perhaps we can add a parameter to the DMA API to specify the address space?
As Jason suggested the definition of IOASID, which represents a page table.
Just my quick thought, can you help us with a viable solution?

I know we are supposed to hide IOMMU by using DMA APIs which makes drivers
portable w/ and w/o IOMMU. This IOASID can be optional.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
