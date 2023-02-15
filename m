Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DFD2F2F
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 21:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676496798; x=1708032798;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lPohpjnYjmGKBqI3h/hmynytkCJLxEoHHjxFGeTY3OM=;
  b=cC7pBe1JDB2HMLk/fk6yj9HB8iEuALv1Nx3Udxu+LutoF4K7K6qrxxEh
   HMilaZFNevQxXMWmDnla8j5JWMVlgp9wMc07bgojHmSnYv1nVfF4IJliN
   ga9P6VjkZ/fWYLufH+yXbE6RDCgR3VAqjAiYArSvt2Z/JBjBqMjOtgOGo
   JRcElfmLi+y2hW/4kZVWCZoJ7HA49qe2yvjOV4QpbHW9jDssi/FhlJGI1
   ivI214jjZnDFW9guNUe27bTd3QCNC8RuOc4GTChQ/D9LQUd1+apoLRqFw
   ti3z/KufIsjiTxdF22WaklnKr5VHYIAoTvSVFeIZxSQ2SEBPmLHjiB3fJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="331545734"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="331545734"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 13:33:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="700187439"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="700187439"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 13:33:10 -0800
Date: Wed, 15 Feb 2023 13:36:51 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Jason
 Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg
 Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, David
 Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 2/3] iommu/sva: Stop using ioasid_set for SVA
Message-ID: <20230215133651.776a1553@jacob-builder>
In-Reply-To: <Y+tW3kxFeOMcELww@myrica>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
	<20230214064414.1038058-3-jacob.jun.pan@linux.intel.com>
	<Y+tW3kxFeOMcELww@myrica>
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

Hi Jean-Philippe,

On Tue, 14 Feb 2023 09:39:42 +0000, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Mon, Feb 13, 2023 at 10:44:13PM -0800, Jacob Pan wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Instead SVA drivers can use a simple global IDA to allocate PASIDs for
> > each mm_struct.
> > 
> > Future work would be to allow drivers using the SVA APIs to reserve
> > global PASIDs from this IDA for their internal use, eg with the DMA API
> > PASID support.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v2: minor fixes
> > 	- let idxd driver use iommu.h for ioasid_t
> > 	- return 0 after mm_pasid_set()
> > ---
> >  drivers/dma/idxd/idxd.h   |  1 +
> >  drivers/iommu/iommu-sva.c | 53 +++++++++++----------------------------
> >  drivers/iommu/iommu-sva.h |  3 ---
> >  include/linux/sched/mm.h  |  8 +-----
> >  4 files changed, 17 insertions(+), 48 deletions(-)
> > 
> > diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> > index 7ced8d283d98..417e602a46b6 100644
> > --- a/drivers/dma/idxd/idxd.h
> > +++ b/drivers/dma/idxd/idxd.h
> > @@ -13,6 +13,7 @@
> >  #include <linux/ioasid.h>
> >  #include <linux/bitmap.h>
> >  #include <linux/perf_event.h>
> > +#include <linux/iommu.h>  
> 
> Unrelated 
this is for ioasid_t, won't compile without it 

> >  #include <uapi/linux/idxd.h>
> >  #include "registers.h"
> >  
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index 24bf9b2b58aa..8fb6f1867af3 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -9,24 +9,11 @@
> >  #include "iommu-sva.h"
> >  
> >  static DEFINE_MUTEX(iommu_sva_lock);
> > -static DECLARE_IOASID_SET(iommu_sva_pasid);
> > +static DEFINE_IDA(iommu_global_pasid_ida);
> >  
> > -/**
> > - * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> > - * @mm: the mm
> > - * @min: minimum PASID value (inclusive)
> > - * @max: maximum PASID value (inclusive)
> > - *
> > - * Try to allocate a PASID for this mm, or take a reference to the
> > existing one
> > - * provided it fits within the [@min, @max] range. On success the
> > PASID is
> > - * available in mm->pasid and will be available for the lifetime of
> > the mm.
> > - *
> > - * Returns 0 on success and < 0 on error.
> > - */
> > -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t
> > max) +static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t
> > min, ioasid_t max) {
> > -	int ret = 0;
> > -	ioasid_t pasid;
> > +	int ret;
> >  
> >  	if (min == INVALID_IOASID || max == INVALID_IOASID ||
> >  	    min == 0 || max < min)
> > @@ -37,39 +24,29 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm,
> > ioasid_t min, ioasid_t max) if (pasid_valid(mm->pasid)) {
> >  		if (mm->pasid < min || mm->pasid >= max)
> >  			ret = -EOVERFLOW;
> > +		else
> > +			ret = 0;
> >  		goto out;
> >  	}
> >  
> > -	pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
> > -	if (!pasid_valid(pasid))
> > -		ret = -ENOMEM;
> > -	else
> > -		mm_pasid_set(mm, pasid);
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > GFP_KERNEL);
> > +	if (ret < min)  
> 
> Just check ret < 0
yes, but i thought < min is safe too. 

> > +		goto out;
> > +	mm_pasid_set(mm, ret);
> > +	ret = 0;
> >  out:
> >  	mutex_unlock(&iommu_sva_lock);
> >  	return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
> >  
> > -/* ioasid_find getter() requires a void * argument */
> > -static bool __mmget_not_zero(void *mm)
> > +void mm_pasid_drop(struct mm_struct *mm)
> >  {
> > -	return mmget_not_zero(mm);
> > -}
> > +	pr_alert("%s %d", __func__, mm->pasid);  
> 
> Debug print
will remove,
Thanks a lot!


Jacob
