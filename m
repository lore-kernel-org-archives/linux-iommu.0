Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120DDC433B4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 15:08:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92183613BF
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 15:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92183613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4335860A41;
	Thu, 13 May 2021 15:08:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QSEVjxEnyMGb; Thu, 13 May 2021 15:08:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E702606CE;
	Thu, 13 May 2021 15:08:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7283AC000E;
	Thu, 13 May 2021 15:08:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92943C0001
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 15:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8035641463
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 15:08:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n4k3qhgvQc3X for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 15:08:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F14D441461
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 15:08:25 +0000 (UTC)
IronPort-SDR: DDjvqxPIjY+KM6LsWpSOCsBH0FTily57jP9UrljnBW2Kc4J8uUOHv6akFjXxVUA64qoZ69t0JS
 qnRt1hzJa10g==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="261210602"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="261210602"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 08:08:24 -0700
IronPort-SDR: h8cnr1lRgYszrkpIKJZgTT5deHWSNW4DKLnW4hv/nIRhPifQYiZdb19NeQKFI2GUvfxErDsCe7
 cGsYelF/g5Lg==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; d="scan'208";a="409665304"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2021 08:08:24 -0700
Date: Thu, 13 May 2021 08:10:50 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit flags
Message-ID: <20210513081050.5cf6a6ed@jacob-builder>
In-Reply-To: <20210513133834.GC1002214@nvidia.com>
References: <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>
 <20210510203145.086835cc@jacob-builder>
 <20210511114848.GK1002214@nvidia.com>
 <20210511091452.721e9a03@jacob-builder>
 <20210511163521.GN1002214@nvidia.com>
 <20210511110550.477a434f@jacob-builder>
 <20210511194726.GP1002214@nvidia.com>
 <YJt3tGlzFK3b4E82@infradead.org>
 <20210513060012.0fcc7653@jacob-builder>
 <20210513133834.GC1002214@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: vkoul@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, "Luck,
 Tony" <tony.luck@intel.com>, zhangfei.gao@linaro.org,
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

Hi Jason,

On Thu, 13 May 2021 10:38:34 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, May 13, 2021 at 06:00:12AM -0700, Jacob Pan wrote:
> > > > If you want to do SVA PASID then it also must come with DMA APIs to
> > > > manage the CPU cache coherence that are all NOP's on x86.    
> > > 
> > > Yes.  And we have plenty of precende where an IOMMU is in "bypass"
> > > mode to allow access to all memory and then uses the simple
> > > dma-direct case.  
> > I agree it is better not to expose the entire direct map. But the
> > missing piece of using DMA APIs is the PASID. The caller needs the
> > PASID value to do work submission once buffer is mapped.  
> 
> You still haven't explained why the kernel driver should have a PASID at
> all.
> 
For shared workqueue, it can only generate DMA request with PASID. The
submission is done by ENQCMDS (S for supervisor) instruction.

If we were not to share page tables with init_mm, we need a system PASID
that doing the same direct mapping in IOMMU page tables.

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
