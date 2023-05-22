Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7531B1640B
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684776463; x=1716312463;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k+PVL4G2rD+urOokHBLSN6dZ+0SzxBkA4MxkypC2+TQ=;
  b=YzbQdFdZI66bEmr/2eOcq9mJkwc+NH6qAZ+D8mMCzbcdxolD25pe/5/f
   GR04hrPVzEB0CkwY1bFr4kEd5PzrEIzg4x9mYpW81O5cQQHdhk8dRiPGy
   RPd1ccGr6naBup1m9aF0YRLjFhxQoHGOAXUkaQ85glzxFP6jVBqyPlXur
   fiJHUx472hf4APjm4+tX+p66TsVAda7sv0cLtN0Fz4QdD9gvpHoWPDfBq
   Y8sUTl8/cBZdLz5Nz++ar62mIaBhuTQeafpn6vjunzYfeSUPdeZGpInW+
   1D1fguAkxsFIXEQcPmLwbKtu6R/y84xLe9ijtGmKnFormJm5K7IjFmOW9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="353011712"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="353011712"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 10:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="703625390"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="703625390"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 10:27:41 -0700
Date: Mon, 22 May 2023 10:32:13 -0700
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
 narayan.ranganathan@intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 2/4] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <20230522103011.2b791d5d@jacob-builder>
In-Reply-To: <b3c543e0-699a-0779-fdd9-b799c5230da0@linux.intel.com>
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
 <20230519203223.2777255-3-jacob.jun.pan@linux.intel.com>
 <b3c543e0-699a-0779-fdd9-b799c5230da0@linux.intel.com>
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

On Sun, 21 May 2023 14:21:25 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 5/20/23 4:32 AM, Jacob Pan wrote:
> > Global PASID can be used beyond SVA. For example, drivers that use
> > Intel ENQCMD to submit work must use global PASIDs in that PASID
> > is stored in a per CPU MSR. When such device need to submit work
> > for in-kernel DMA with PASID, it must allocate PASIDs from the same
> > global number space to avoid conflict.
> > 
> > This patch moves global PASID allocation APIs from SVA to IOMMU APIs.
> > Reserved PASIDs, currently only RID_PASID, are excluded from the global
> > PASID allocation.
> > 
> > It is expected that device drivers will use the allocated PASIDs to
> > attach to appropriate IOMMU domains for use.
> > 
> > Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> > ---
> > v6: explicitly exclude reserved a range from SVA PASID allocation
> >      check mm PASID compatibility with device
> > v5: move PASID range check inside API so that device drivers only pass
> >      in struct device* (Kevin)
> > v4: move dummy functions outside ifdef CONFIG_IOMMU_SVA (Baolu)
> > ---
> >   drivers/iommu/iommu-sva.c | 33 ++++++++++++++-------------------
> >   drivers/iommu/iommu.c     | 24 ++++++++++++++++++++++++
> >   include/linux/iommu.h     | 10 ++++++++++
> >   3 files changed, 48 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> > index 9821bc44f5ac..7fe8e977d8eb 100644
> > --- a/drivers/iommu/iommu-sva.c
> > +++ b/drivers/iommu/iommu-sva.c
> > @@ -10,33 +10,33 @@
> >   #include "iommu-sva.h"
> >   
> >   static DEFINE_MUTEX(iommu_sva_lock);
> > -static DEFINE_IDA(iommu_global_pasid_ida);
> >   
> >   /* Allocate a PASID for the mm within range (inclusive) */
> > -static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min,
> > ioasid_t max) +static int iommu_sva_alloc_pasid(struct mm_struct *mm,
> > struct device *dev) {
> > +	ioasid_t pasid;
> >   	int ret = 0;
> >   
> > -	if (min == IOMMU_PASID_INVALID ||
> > -	    max == IOMMU_PASID_INVALID ||
> > -	    min == 0 || max < min)
> > -		return -EINVAL;
> > -
> >   	if (!arch_pgtable_dma_compat(mm))
> >   		return -EBUSY;
> >   
> >   	mutex_lock(&iommu_sva_lock);
> >   	/* Is a PASID already associated with this mm? */
> >   	if (mm_valid_pasid(mm)) {
> > -		if (mm->pasid < min || mm->pasid > max)
> > -			ret = -EOVERFLOW;
> > +		if (mm->pasid <= dev->iommu->max_pasids)
> > +			goto out;
> > +		dev_err(dev, "current mm PASID %d exceeds device range
> > %d!",
> > +			mm->pasid, dev->iommu->max_pasids);
> > +		ret = -ERANGE;
> >   		goto out;
> >   	}  
> 
> Nit: Above is just refactoring, so it's better to keep the code behavior
> consistent. For example, no need to change the error# from -EOVERFLOW to
> -ERANGE, and no need to leave a new kernel message.
> 
> Anyway, if you think these changes are helpful, it's better to have them
> in separated patches.
> 
> In the end, perhaps we can simply have code like this:
> 
> 	if (mm_valid_pasid(mm)) {
> 		if (mm->pasid > dev->iommu->max_pasids)
> 			ret = -EOVERFLOW;
> 		goto out;
> 	}
> 
> Others look good to me, with above addressed,
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
much better, will fix.

Thanks,

Jacob
