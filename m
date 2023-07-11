Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C014AB5
	for <iommu@lists.linux.dev>; Tue, 11 Jul 2023 14:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689085652; x=1720621652;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hd7KPTyRP0JRvFe990SYWoGyr6006I4GxCYcQVy1VCM=;
  b=XVPXaaqvO1y92gS14aEtWTGC/Bo7UOmojG8MNgh+pXkfIXM5VXiMcNeg
   E8fViRf3CDGjkOk+MwA9G87qlrAsKeoNc2C/bHAry98n4lYHC9U50agT8
   1klXTMGlOnLQhvrv/bm9VMR50J2GsMRSRw70Jpk0wTd2FogbJagESE1ZP
   A8UngZv/SDjTJqXSf54pt2t9Geb0P0bt9fmtb+ul+L+kN+/8Xlk2wPuG6
   zX/QEQdxdTE7wTyK5gCRDhwTWuY9Z7MQrZzp1kK2+N5uT3T9bJ9RJreJc
   bCWW2dIMF3p5Lp5MEN3PK/adnDxv1oVQ3BHleT1VAHKvbaCSkIJhJsv2m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367212621"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="367212621"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:27:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="750774534"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="750774534"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 07:27:31 -0700
Date: Tue, 11 Jul 2023 07:32:28 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Jason
 Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
 <robin.murphy@arm.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 dmaengine@vger.kernel.org, vkoul@kernel.org, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Tony
 Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 rex.zhang@intel.com, xiaochen.shen@intel.com,
 narayan.ranganathan@intel.com, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v8 2/7] iommu: Move global PASID allocation from SVA to
 core
Message-ID: <20230711073228.7c4977f8@jacob-builder>
In-Reply-To: <08830c11-5528-0c42-0bc3-89c3796611fe@linux.intel.com>
References: <20230602182212.150825-1-jacob.jun.pan@linux.intel.com>
	<20230602182212.150825-3-jacob.jun.pan@linux.intel.com>
	<08830c11-5528-0c42-0bc3-89c3796611fe@linux.intel.com>
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

On Sat, 10 Jun 2023 20:13:03 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 6/3/23 2:22 AM, Jacob Pan wrote:
> > +ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> > +{
> > +	int ret;
> > +	ioasid_t max;
> > +
> > +	max = dev->iommu->max_pasids;
> > +	/*
> > +	 * max_pasids is set up by vendor driver based on number of
> > PASID bits
> > +	 * supported but the IDA allocation is inclusive.
> > +	 */
> > +	ret = ida_alloc_range(&iommu_global_pasid_ida,
> > IOMMU_FIRST_GLOBAL_PASID, max - 1, GFP_KERNEL);
> > +	if (ret < 0)
> > +		return IOMMU_PASID_INVALID;
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);  
> 
> "dev->iommu->max_pasids == 0" indicates no pasid support on the device.
> The code should return IOMMU_PASID_INVALID explicitly. Perhaps we can
> make this function like this:
> 
> ioasid_t iommu_alloc_global_pasid_dev(struct device *dev)
> {
>          int ret;
> 
>          if (!dev->iommu->max_pasids)
>                  return IOMMU_PASID_INVALID;
> 
>          /*
>           * max_pasids is set up by vendor driver based on number of 
> PASID bits
>           * supported but the IDA allocation is inclusive.
>           */
>          ret = ida_alloc_range(&iommu_global_pasid_ida, 
> IOMMU_FIRST_GLOBAL_PASID,
>                                dev->iommu->max_pasids - 1, GFP_KERNEL);
> 
>          return ret < 0 ? IOMMU_PASID_INVALID : ret;
> }
> EXPORT_SYMBOL_GPL(iommu_alloc_global_pasid_dev);
> 
good catch, sorry i missed this. let me send an updated version.

> Other change in this series looks good to me.
> 
> I hope I can queue this series including above change as part of my VT-d
> update for v6.5 to Joerg if no objection.
> 
> Let's try to re-enable this key feature of Intel idxd driver in v6.5.
> 
> Best regards,
> baolu


Thanks,

Jacob
