Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5259BC433EF
	for <iommu@archiver.kernel.org>; Thu,  9 Dec 2021 18:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3F424256A;
	Thu,  9 Dec 2021 18:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WyhbXMfQIma8; Thu,  9 Dec 2021 18:10:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B9EAC42556;
	Thu,  9 Dec 2021 18:10:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 853C7C002F;
	Thu,  9 Dec 2021 18:10:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35DCAC0012
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 18:10:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 167CC42558
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 18:10:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YZRxYWzDNC2K for <iommu@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 18:10:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 551DB42556
 for <iommu@lists.linux-foundation.org>; Thu,  9 Dec 2021 18:10:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="235684161"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; d="scan'208";a="235684161"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 10:09:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; d="scan'208";a="680433388"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2021 10:09:46 -0800
Date: Thu, 9 Dec 2021 10:14:04 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Message-ID: <20211209101404.6aefbe1c@jacob-builder>
In-Reply-To: <YbHie/Z4bIXwTInx@myrica>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YbHie/Z4bIXwTInx@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Kumar, Sanjay
 K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>
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

Hi Jean-Philippe,

On Thu, 9 Dec 2021 11:03:23 +0000, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> Hi Jacob,
> 
> On Tue, Dec 07, 2021 at 05:47:11AM -0800, Jacob Pan wrote:
> > In-kernel DMA is managed by DMA mapping APIs, which supports per device
> > addressing mode for legacy DMA requests. With the introduction of
> > Process Address Space ID (PASID), device DMA can now target at a finer
> > granularity per PASID + Requester ID (RID).
> > 
> > However, for in-kernel DMA there is no need to differentiate between
> > legacy DMA and DMA with PASID in terms of mapping. DMA address mapping
> > for RID+PASID can be made identical to the RID. The benefit for the
> > drivers is the continuation of DMA mapping APIs without change.
> > 
> > This patch reserves a special IOASID for devices that perform in-kernel
> > DMA requests with PASID. This global IOASID is excluded from the
> > IOASID allocator. The analogous case is PASID #0, a special PASID
> > reserved for DMA requests without PASID (legacy). We could have
> > different kernel PASIDs for individual devices, but for simplicity
> > reasons, a globally reserved one will fit the bill.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
> >  drivers/iommu/intel/iommu.c                     | 4 ++--
> >  drivers/iommu/intel/pasid.h                     | 3 +--
> >  drivers/iommu/intel/svm.c                       | 2 +-
> >  drivers/iommu/ioasid.c                          | 2 ++
> >  include/linux/ioasid.h                          | 4 ++++
> >  6 files changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c index
> > ee66d1f4cb81..ac79a37ffe06 100644 ---
> > a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c +++
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c @@ -329,7 +329,7 @@
> > __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm) return
> > ERR_PTR(-ENOMEM); 
> >  	/* Allocate a PASID for this mm if necessary */
> > -	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) -
> > 1);
> > +	ret = iommu_sva_alloc_pasid(mm, IOASID_ALLOC_BASE, (1U <<
> > master->ssid_bits) - 1);  
> 
> I'd rather keep hardware limits as parameters here. PASID#0 is reserved by
> the SMMUv3 hardware so we have to pass at least 1 here, but VT-d could
> change RID_PASID and pass 0. On the other hand IOASID_DMA_PASID depends on
> device drivers needs and is not needed on all systems, so I think could
> stay within the ioasid allocator. Could VT-d do an
> ioasid_alloc()/ioasid_get() to reserve this global PASID, storing it
> under the device_domain_lock?
> 
Yes, this works. We can delegate DMA PASID allocation to vendor drivers. My
proposal here is driven by simplicity.

> This looks like we're just one step away from device drivers needing
> multiple PASIDs for kernel DMA so I'm trying to figure out how to evolve
> the API towards that. It's probably as simple as keeping a kernel IOASID
> set at first, but then we'll probably want to optimize by having multiple
> overlapping sets for each device driver (all separate from the SVA set).
Sounds reasonable to start with a kernel set for in-kernel DMA once we need
multiple ones. But I am not sure what *overlapping* sets mean here, could
you explain?

> 


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
