Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E4A938
	for <iommu@lists.linux.dev>; Fri,  3 Mar 2023 22:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677881315; x=1709417315;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F0jJypZHaRaBJ6BMYaW1CHf7YuZJ1wW4P1q1vVBdKzE=;
  b=hwm9DZTfV7IntQWWM0S8Jgpps8+VprWU7eeaPtjtMlAux2Ylet6W/hK6
   AfvABRVQ+qS7ygXICLaqL17jylVrVT8YItOPTCo9Y8geOpwBmAfs6Yknm
   IY8EDNe32NXeXNzZd0j2xGP2zEcxl2ZTUMeEYUWQF5/Qda7UYYn0h8H5Q
   HTbcXbWqyvoQ1WmsJMzV3TD4p6F2cV0GPwGCnEQTzc7ehSsOA/6rwPJ4v
   HMU6+T5g23iUelwEvsfNGdomQhu2/OrIoBigA3pea87xwTrlyKTu9pckd
   SP6SEhpfAp38MljZOW1wO5GD9naMljO4xgy5lZ8+M7Uqdqysa9khHDROZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="421443553"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="421443553"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 14:08:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="677809639"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="677809639"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 14:08:34 -0800
Date: Fri, 3 Mar 2023 14:12:24 -0800
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
Subject: Re: [PATCH 4/4] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <20230303141224.7f1bf7e0@jacob-builder>
In-Reply-To: <BN9PR11MB527624EDB9FCD26751C73B128CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
	<20230302005959.2695267-5-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB527624EDB9FCD26751C73B128CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Thu, 2 Mar 2023 09:47:00 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 2, 2023 9:00 AM
> > 
> >  static int idxd_enable_system_pasid(struct idxd_device *idxd)
> >  {
> > -	return -EOPNOTSUPP;
> > +	struct pci_dev *pdev = idxd->pdev;
> > +	struct device *dev = &pdev->dev;
> > +	struct iommu_domain *domain;
> > +	union gencfg_reg gencfg;
> > +	ioasid_t pasid;
> > +	int ret;
> > +
> > +	domain = iommu_get_domain_for_dev(dev);
> > +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> > +		return -EPERM;  
> 
> what about UNMANAGED?
will fix this by getting the dma domain.
> 
> > +
> > +	pasid = iommu_sva_reserve_pasid(1, dev->iommu->max_pasids);
> > +	if (pasid == IOMMU_PASID_INVALID)
> > +		return -ENOSPC;  
> 
> as commented in last patch we can just pass a device pointer to a
> general allocation interface.
will do
> 
> > +
> > +	ret = iommu_attach_device_pasid(domain, dev, pasid);
> > +	if (ret) {
> > +		dev_err(dev, "failed to attach device pasid %d, domain
> > type %d",
> > +			pasid, domain->type);
> > +		iommu_sva_unreserve_pasid(pasid);
> > +		return ret;
> > +	}
> > +
> > +	/* Since we set user privilege for kernel DMA, enable
> > completion IRQ */
> > +	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
> > +	gencfg.user_int_en = 1;
> > +	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
> > +	idxd->pasid = pasid;  
> 
> Why does user privilege requires a completion interrupt?
> 
> Or instead it's more due to doing kernel DMA itself then we certainly
> don't want to poll in the kernel?
yes, kernel wq does not support polling, therefore it needs interrupts.
Without user_int_en bit set, there would be no interrupts if we use user
privilege for kernel wq.

Thanks,

Jacob
