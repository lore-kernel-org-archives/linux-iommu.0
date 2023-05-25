Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C71952A
	for <iommu@lists.linux.dev>; Thu, 25 May 2023 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685029820; x=1716565820;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=emj39pN1Kh0TKycX7k6GT4QnYMEV4/dD9je4KRuZQhU=;
  b=hSpy2nPzS6W0mbSbMCFddffZgycbxFsu9A6dKtpJIbzOZEBHrLIDWv2u
   UryCKMbW1O53hLyDWHOoiFBQjz1wAXtkj+mWYlgzhK3mSrLgiIK8Wm7GL
   HsaXOHCdSewPR75zAZ6Dk1KOfDs3oIK7jgse5xQOhS4AFumVV0r5bzP6i
   Xy9g3mixj+G6TONMzbgZ9vmg9EHNo6NRM2I9e1prUOsKxdCGOW8Y76UF0
   EwO2JPgjpIZR+IS6LGAv5U8+5zqrtoKMKO1ADujs7F9ltzGezOAq+eTtq
   uVqNzWt1q0fqsIzcdl5OkuzKbBovDuMZtbVA/5aCA+zthyjrwQBneNesn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="333547643"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="333547643"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 08:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="682371590"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="682371590"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 08:50:15 -0700
Date: Thu, 25 May 2023 08:54:48 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
 <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "vkoul@kernel.org"
 <vkoul@kernel.org>, Will Deacon <will@kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave"
 <dave.jiang@intel.com>, "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom"
 <tom.zanussi@intel.com>, "Ranganathan, Narayan"
 <narayan.ranganathan@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 2/4] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <20230525085448.40194a42@jacob-builder>
In-Reply-To: <BN9PR11MB5276F7D03C5595F03A9A14858C469@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230523173451.2932113-1-jacob.jun.pan@linux.intel.com>
	<20230523173451.2932113-3-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB5276F7D03C5595F03A9A14858C469@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Thu, 25 May 2023 06:27:40 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Wednesday, May 24, 2023 1:35 AM
> > 
> >  /* Allocate a PASID for the mm within range (inclusive) */
> > -static int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min,
> > ioasid_t max)
> > +static int iommu_sva_alloc_pasid(struct mm_struct *mm, struct device
> > *dev) {
> > +	ioasid_t pasid;
> >  	int ret = 0;
> > 
> > -	if (min == IOMMU_PASID_INVALID ||
> > -	    max == IOMMU_PASID_INVALID ||
> > -	    min == 0 || max < min)
> > -		return -EINVAL;
> > -
> >  	if (!arch_pgtable_dma_compat(mm))
> >  		return -EBUSY;
> > 
> >  	mutex_lock(&iommu_sva_lock);
> >  	/* Is a PASID already associated with this mm? */
> >  	if (mm_valid_pasid(mm)) {
> > -		if (mm->pasid < min || mm->pasid > max)
> > +		if (mm->pasid > dev->iommu->max_pasids)  
> 
> ">" should be ">="  
right, will do

> > +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> > +{
> > +	int ret;
> > +	ioasid_t max;
> > +
> > +	max = dev->iommu->max_pasids;
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida,
> > IOMMU_FIRST_GLOBAL_PASID, max, GFP_KERNEL);  
> 
> max is inclusive. Here should minus one.
yeah, should be -1

> otherwise looks good to me,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>


Thanks,

Jacob
