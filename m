Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871718BE0
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 15:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680016629; x=1711552629;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FfJ1TINuQuVPs7UZIOzocUmQ5lVfAYUGiyzWGlomdoo=;
  b=VWvb6OXVZLTLZeA2n2i/aVyfQNE8qnrdK7XLBYXY6yfuH/rcGBSxBGPH
   nIof772zYQPeI65RuKnBCSwD9KiqXAdSQgvQT4P+6eXXkSrn5htcua981
   SzswthPYPgeP3x0a8tYl2T1FiD9NedkAhDvxEtFdt7RMWRuDJL5u4SlGC
   pG9v7TW/MnTgp9QjhE/ZCku5bm1w6BbO1PxQikCBpAOKa2OiZAQt4pFmC
   7YkFd5g51RGmkCcqVBDXUfKSzSwrcpOVSHAcRnqfBJJ31RHVNnqDLxBcc
   JmG2zprFS1Bmohv041IPLdVQAn5cLxAjOu9Dw6/WUlL3tLunVdHNJkAYM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="368356435"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="368356435"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="748430713"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="748430713"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:17:08 -0700
Date: Tue, 28 Mar 2023 08:21:10 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Jason
 Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 dmaengine@vger.kernel.org, vkoul@kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua"
 <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Tony Luck
 <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/8] iommu/sva: Support reservation of global SVA
 PASIDs
Message-ID: <20230328082110.2b49f5de@jacob-builder>
In-Reply-To: <e1e23af3-b627-ac5d-64d0-9547ed982dc4@linux.intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
	<20230327232138.1490712-4-jacob.jun.pan@linux.intel.com>
	<e1e23af3-b627-ac5d-64d0-9547ed982dc4@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Baolu,

On Tue, 28 Mar 2023 13:11:12 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 3/28/23 7:21 AM, Jacob Pan wrote:
> > Devices that use Intel ENQCMD to submit work must use global PASIDs in
> > that the PASID are stored in a per CPU MSR. When such device need to
> > submit work for in-kernel DMA with PASID, it must allocate PASIDs from
> > the same global number space to avoid conflict.
> > 
> > This patch introduces IOMMU SVA APIs to reserve and release global
> > PASIDs. It is expected that device drivers will use the allocated
> > PASIDs to attach to appropriate IOMMU domains for use.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/iommu-sva.c | 33 +++++++++++++++++++++++++++++++++
> >   include/linux/iommu.h     | 14 ++++++++++++++
> >   2 files changed, 47 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index c434b95dc8eb..84b9de84b3e0 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -148,6 +148,39 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> >   }
> >   EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> >   
> > +/**
> > + * @brief
> > + *	Reserve a PASID from the SVA global number space.
> > + *
> > + * @param min starting range, inclusive
> > + * @param max ending range, inclusive
> > + * @return The reserved PASID on success or IOMMU_PASID_INVALID on
> > failure.
> > + */
> > +ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max)
> > +{
> > +	int ret;
> > +
> > +	if (!pasid_valid(min) || !pasid_valid(max) ||
> > +	    min == 0 || max < min)  
> 
> I still think we should make "min == 0" a valid case. The ARM/AMD/Intel
> drivers should reserve PASID 0 for special usage with this interface.
> 
> Probably we should also make "min == max" a valid case. Both @min and
> @max are inclusive.
I agreed, 0 should not be special.

> 
> > +		return IOMMU_PASID_INVALID;
> > +
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > GFP_KERNEL);
> > +	if (ret < 0)
> > +		return IOMMU_PASID_INVALID;
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_reserve_pasid);
> > +
> > +void iommu_sva_release_pasid(ioasid_t pasid)
> > +{
> > +	if (!pasid_valid(pasid))  
> 
> The caller should never release an invalid pasid. So perhaps,
> 
> 	if (WARN_ON(!pasid_valid(pasid)))
> 		return;
> 
good point!

> to discover bugs during development.
> 
> > +		return;
> > +
> > +	ida_free(&iommu_global_pasid_ida, pasid);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_release_pasid);
> > +
> >   /*
> >    * I/O page fault handler for SVA
> >    */
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 54f535ff9868..0471089dc1d0 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -1187,6 +1187,9 @@ struct iommu_sva *iommu_sva_bind_device(struct
> > device *dev, struct mm_struct *mm);
> >   void iommu_sva_unbind_device(struct iommu_sva *handle);
> >   u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> > +ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max);
> > +void iommu_sva_release_pasid(ioasid_t pasid);
> > +
> >   #else
> >   static inline struct iommu_sva *
> >   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> > @@ -1202,6 +1205,17 @@ static inline u32 iommu_sva_get_pasid(struct
> > iommu_sva *handle) {
> >   	return IOMMU_PASID_INVALID;
> >   }
> > +
> > +static inline ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t
> > max) +{
> > +	return IOMMU_PASID_INVALID;
> > +}
> > +
> > +static inline void iommu_sva_release_pasid(ioasid_t pasid)
> > +{
> > +
> > +}
> > +
> >   static inline void mm_pasid_init(struct mm_struct *mm) {}
> >   static inline void mm_pasid_drop(struct mm_struct *mm) {}
> >   #endif /* CONFIG_IOMMU_SVA */  
> 
> Best regards,
> baolu


Thanks,

Jacob
