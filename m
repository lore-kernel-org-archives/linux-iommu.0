Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9FF8BE0
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 15:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680017229; x=1711553229;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9pUw4qfwnuIM9w2+fwl4/XvGsd+TBbX0140QHxhWmfQ=;
  b=mhqFed2VZtqPTwU03C/Grf0aGn4sYSVJFUbhwNHJ/if35BrWoOwx3OCl
   AKETTW5GM6z1RCTDuVyzuYdIUO0jjDwIdQlkkHoN5HHf8aDjqCxeQlJy+
   zo3bXF1UOwRmKTkBMEQnLTrfpLpp+U6UhhlQHehTyaTzFib9mPmzNaod5
   MkbkH3ECewXfZZ8O2iLnl4F0Rhxmf+bTVR64WSAz9ZIulClp3v1EvAWT1
   sSne0XEuUF+y8Ft6jAB9Q0HLsM0O25l25rbGAeHsX2mjTAJVHFNXo8G6o
   hGBeR/+XHfbffKx5dFTfmM9zBkDJ+80Zt+BIe+k/ZQrJMGaaILj+JxHE7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="426869781"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="426869781"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:27:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="683944706"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="683944706"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:27:07 -0700
Date: Tue, 28 Mar 2023 08:31:10 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "vkoul@kernel.org"
 <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon
 <will@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Raj, Ashok"
 <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu, Fenghua"
 <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Luck, Tony"
 <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 3/8] iommu/sva: Support reservation of global SVA
 PASIDs
Message-ID: <20230328083110.294a327c@jacob-builder>
In-Reply-To: <BN9PR11MB527652D88D15437F52FCE8268C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
	<20230327232138.1490712-4-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527652D88D15437F52FCE8268C889@BN9PR11MB5276.namprd11.prod.outlook.com>
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

Hi Kevin,

On Tue, 28 Mar 2023 07:35:43 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 28, 2023 7:22 AM
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
> 
> Look at this function. There is no single word about sva except
> in the function name.
> 
> sva is just one user of global pasids.
> 
> when a driver supports sva it has to always use global pasids even
> for non-sva usages like dma pasid.
> 
> but this doesn't mean that we should build the API around sva.
> 
> it's really about global pasids.
> 
> let's just call it clearly as iommu_alloc_global_pasid(min, max).
> 
> Then we can define a wrapper iommu_reserve_global_pasid(pasid)
> as iommu_alloc_global_pasid(pasid, pasid).
> 
> for PASID#0 driver calls iommu_reserve_global_pasid(0).
> 
> for dma pasid driver calls iommu_alloc_global_pasid() to get a random
> one instead of reserving pasid#1.
> 
> this would be future proof when the same driver starts to allocate
> more pasids for other usages e..g siov.
I don't have strong preference here. Jason and others?

For the DMA vs. SVA use cases, these APIs are used to carve out PASIDs from
the SVA space. Let it be the entire global space or a subset, we don't care.
We just don't want conflicts with SVA. e.g. if the SVA space shrank in the
future, this still works.

Thanks,

Jacob
