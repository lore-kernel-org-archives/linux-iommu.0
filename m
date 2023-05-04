Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F327C133
	for <iommu@lists.linux.dev>; Thu,  4 May 2023 21:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683236955; x=1714772955;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OkJcPMLVT1UXEftiFVOxxBid+OvrRMbUZ16uZL2VXuM=;
  b=TenchVWFe/4I77HbNlHhY0+B5Y+rR1Gr3bkoYdab6YLkUfEan8d8ge8K
   0BX+I3SWJZ1zHZF3XChR4IQoTWqhOecscJlWxsPH4Grf6wLE+ClmJ84ac
   RdJbKzIeazOj8L4RsMxV9aGp3/mZQ3PQqNi+DQBgwzmMeANrk23iy4J4w
   eGf/f4FxiYdJ5jMXNP2MHHbuBh64WTV9uUXow8DTkQXEWRVCDywW91m7P
   x7dWqXtNabzyMcu06dLmkhC6QP2f4dZh2TMhx22Xv96LUz8ZvTghv3XB5
   jgDvSp8L/+4TeN4ZazHjUb5faHaag6Cf+UrFCO8gpBakPoV66wg+Y3tJY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="328688097"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="328688097"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:49:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="841384356"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="841384356"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:49:06 -0700
Date: Thu, 4 May 2023 14:53:28 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, dmaengine@vger.kernel.org, vkoul@kernel.org, Will Deacon
 <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Raj Ashok
 <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>, "Zanussi, Tom"
 <tom.zanussi@intel.com>, narayan.ranganathan@intel.com,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 5/7] iommu/vt-d: Prepare PASID attachment beyond
 RID_PASID
Message-ID: <20230504145328.6b43cffb@jacob-builder>
In-Reply-To: <75bdf30c-d38f-ef95-7618-91ebf35ea297@linux.intel.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
	<20230427174937.471668-6-jacob.jun.pan@linux.intel.com>
	<75bdf30c-d38f-ef95-7618-91ebf35ea297@linux.intel.com>
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

On Wed, 3 May 2023 14:49:36 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 4/28/23 1:49 AM, Jacob Pan wrote:
> > @@ -2433,12 +2477,17 @@ static int
> > dmar_domain_attach_device_pasid(struct dmar_domain *domain, struct
> > intel_iommu *iommu, struct device *dev, ioasid_t pasid)
> >   {
> > +	struct device_pasid_info *dev_pasid;
> > +	unsigned long flags;
> >   	int ret;
> >   
> > -	/* PASID table is mandatory for a PCI device in scalable mode.
> > */ if (!sm_supported(iommu) && dev_is_real_dma_subdevice(dev))
> >   		return -EOPNOTSUPP;
> >   
> > +	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
> > +	if (!dev_pasid)
> > +		return -ENOMEM;
> > +
> >   	if (hw_pass_through && domain_type_is_si(domain))
> >   		ret = intel_pasid_setup_pass_through(iommu, domain,
> > dev, pasid); else if (domain->use_first_level)
> > @@ -2446,6 +2495,17 @@ static int
> > dmar_domain_attach_device_pasid(struct dmar_domain *domain, else
> >   		ret = intel_pasid_setup_second_level(iommu, domain,
> > dev, pasid); 
> > +	if (ret) {
> > +		kfree(dev_pasid);
> > +		return ret;
> > +	}
> > +
> > +	dev_pasid->pasid = pasid;
> > +	dev_pasid->dev = dev;
> > +	spin_lock_irqsave(&domain->lock, flags);
> > +	list_add(&dev_pasid->link_domain, &domain->dev_pasids);
> > +	spin_unlock_irqrestore(&domain->lock, flags);
> > +
> >   	return 0;
> >   }
> >   
> > @@ -2467,16 +2527,13 @@ static int dmar_domain_attach_device(struct
> > dmar_domain *domain, return ret;
> >   	info->domain = domain;
> >   	spin_lock_irqsave(&domain->lock, flags);
> > +	if (info->dev_attached) {
> > +		spin_unlock_irqrestore(&domain->lock, flags);
> > +		return 0;
> > +	}
> >   	list_add(&info->link, &domain->devices);
> >   	spin_unlock_irqrestore(&domain->lock, flags);
> >   
> > -	ret = dmar_domain_attach_device_pasid(domain, iommu, dev,
> > -					      IOMMU_DEF_RID_PASID);
> > -	if (ret) {
> > -		dev_err(dev, "Setup RID2PASID failed\n");
> > -		device_block_translation(dev);
> > -	}
> > -
> >   	ret = domain_context_mapping(domain, dev);
> >   	if (ret) {
> >   		dev_err(dev, "Domain context map failed\n");
> > @@ -2485,8 +2542,9 @@ static int dmar_domain_attach_device(struct
> > dmar_domain *domain, }
> >   
> >   	iommu_enable_pci_caps(info);
> > +	info->dev_attached = 1;
> >   
> > -	return 0;
> > +	return ret;
> >   }
> >   
> >   static bool device_has_rmrr(struct device *dev)
> > @@ -4044,6 +4102,7 @@ static void device_block_translation(struct
> > device *dev) 
> >   	spin_lock_irqsave(&info->domain->lock, flags);
> >   	list_del(&info->link);
> > +	info->dev_attached = 0;
> >   	spin_unlock_irqrestore(&info->domain->lock, flags);
> >   
> >   	domain_detach_iommu(info->domain, iommu);
> > @@ -4175,8 +4234,15 @@ static int intel_iommu_attach_device(struct
> > iommu_domain *domain, struct device *dev)
> >   {
> >   	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct intel_iommu *iommu;
> > +	u8 bus, devfn;
> >   	int ret;
> >   
> > +	iommu = device_to_iommu(dev, &bus, &devfn);
> > +	if (!iommu)
> > +		return -ENODEV;
> > +
> >   	if (domain->type == IOMMU_DOMAIN_UNMANAGED &&
> >   	    device_is_rmrr_locked(dev)) {
> >   		dev_warn(dev, "Device is ineligible for IOMMU domain
> > attach due to platform RMRR requirement.  Contact your platform
> > vendor.\n"); @@ -4190,7 +4256,23 @@ static int
> > intel_iommu_attach_device(struct iommu_domain *domain, if (ret) return
> > ret; 
> > -	return dmar_domain_attach_device(to_dmar_domain(domain), dev);
> > +	ret = dmar_domain_attach_device(to_dmar_domain(domain), dev);
> > +	if (ret) {
> > +		dev_err(dev, "Attach device failed\n");
> > +		return ret;
> > +	}
> > +
> > +	/* PASID table is mandatory for a PCI device in scalable mode.
> > */
> > +	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
> > +		/* Setup the PASID entry for requests without PASID: */
> > +		ret = dmar_domain_attach_device_pasid(dmar_domain,
> > iommu, dev,
> > +
> > IOMMU_DEF_RID_PASID);
> > +		if (ret) {
> > +			dev_err(dev, "Setup RID2PASID failed\n");
> > +			device_block_translation(dev);
> > +		}
> > +	}
> > +	return ret;
> >   }
> >   
> >   static int intel_iommu_map(struct iommu_domain *domain,  
> 
> I am not following why do you need to change the attach_device path in
> this patch. Perhaps you want to make sure that context entry for the
> device is configured before attach_device_pasid?
This is just refactoring, with this patch attach_device is broken down into
1. prepare_domain_attach_device()
2. dmar_domain_attach_device()
3. dmar_domain_attach_device_pasid()
the change is due to factoring out dmar_domain_attach_device_pasid(). 
device context set up in #2, already ensured before PASID attachment.

perhaps I miss your point?


Thanks,

Jacob
