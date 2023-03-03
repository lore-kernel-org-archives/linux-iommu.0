Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C629446
	for <iommu@lists.linux.dev>; Fri,  3 Mar 2023 21:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677879845; x=1709415845;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kj65eZ6x1XaMxzFMjvimVXP1TU9dIZpyh6Wk8sLAlnk=;
  b=kn+Fr9EhqNEd2eCfKeHuu3tA2/mqOounzHQvwzs3ikC/ich137UI5l2E
   arBUKH5rOqiV3/H+TMbworbN6ujcJoYwAGH3mBz6gs0E3LVZZZOaS0X3X
   vsn5Zius+MER4E0OsidFn8fCbbs0Q1cnRAbgbZrzMmp20+asMNWr+k1Tk
   CwpalWosi4o+a9U+2Tm+ByN4gGIG1FK0n2zkmnc70twIf7TzAufnLmFgN
   sfZmbsSCUvGaswOibTRs173S5E6pDhFZzSzdy2iR+gmeEwcB1EayBQK3s
   BSeNAJX7LWDyQKR4ug+1e0T3X5rvO2SwQh6nFsgPOxAVCNSTcyLnoUDXf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="337481928"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="337481928"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:44:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="668795971"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="668795971"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:44:03 -0800
Date: Fri, 3 Mar 2023 13:47:53 -0800
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
Subject: Re: [PATCH 3/4] iommu/sva: Support reservation of global PASIDs
Message-ID: <20230303134753.660d0755@jacob-builder>
In-Reply-To: <BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
	<20230302005959.2695267-4-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB52765C5E0DC0759880C08E258CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Thu, 2 Mar 2023 09:43:03 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 2, 2023 9:00 AM
> > 
> > Global PASID allocation is under IOMMU SVA code since it is the primary
> > use case.  However, some architecture such as VT-d, global PASIDs are
> > necessary for its internal use of DMA API with PASID.  
> 
> No, global PASID is not a VT-d restriction. It's from ENQCMD/S hence a
> device requirement.
I meant VT-d based platforms, it is kind of intertwined in that ENQCMDS
does not restrict RIDPASID!=DMA PASID, vt-d does. Without this
restriction, there wouldn't be a need for this patch. Let me reword.
> > 
> > This patch introduces SVA APIs to reserve and release global PASIDs.
> > 
> > Link: https://lore.kernel.org/all/20230301235646.2692846-4-
> > jacob.jun.pan@linux.intel.com/
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/iommu-sva.c | 25 +++++++++++++++++++++++++
> >  include/linux/iommu.h     | 14 ++++++++++++++
> >  2 files changed, 39 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index 8c92a145e15d..cfdeafde88a9 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -149,6 +149,31 @@ u32 iommu_sva_get_pasid(struct iommu_sva
> > *handle)
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> > 
> > +ioasid_t iommu_sva_reserve_pasid(ioasid_t min, ioasid_t max)
> > +{
> > +	int ret;
> > +
> > +	if (min == IOMMU_PASID_INVALID || max ==
> > IOMMU_PASID_INVALID ||
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
> I'm not sure it's the right way. It's not related to SVA.
> 
> We should move iommu_global_pasid_ida to iomm.c and then have
> another interface for allocation.
> 
> Above is pretty generic so probably a general one like:
> 
> 	ioasid_t iommu_allocate_global_pasid(struct device *dev)
> 
> internally it can use [1, dev->iommu->max_pasids] as min/max instead
> of passed in from the caller.
sounds good to me, will do.


Thanks,

Jacob
