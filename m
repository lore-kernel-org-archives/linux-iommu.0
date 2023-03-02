Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3110FA
	for <iommu@lists.linux.dev>; Thu,  2 Mar 2023 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677784891; x=1709320891;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=185T5+NRzBkDdWR4gv2cKMGAHH4lIzpAm3CJgwITzls=;
  b=mqyJJIYuU5ZIiv9gXtT+X0USoK4H7QK2cznE1y6SskIM+0UXUeC5X0YZ
   s9tHiSl3XBJCYgY+sJ3aco5iqPoCH9A1giHQnwl+hZ+VEBKKnWYVVioBk
   Rb0a00NqxLOh0vy7/U683a1xuNlvdqR+7HYy/GCE9awIbmWzChQ1TObrl
   QR3wk1nzfiB1EPQpkUNDAjtD3vqnKBY0JosQqTDrL+PbfuljghRM8ks/e
   JDa7BeplfvLxz4/dH92wjWS3tkHYZDzpRh+j0e9YEhA61g6SLEaBjvyrX
   vEozX/XYTfk8RlrZp5FRm3K7Vw7zyaRvc1eG6XBBUMP/36GGdSvi3FY4x
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="318647378"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="318647378"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 11:21:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="764136375"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="764136375"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 11:21:28 -0800
Date: Thu, 2 Mar 2023 11:25:17 -0800
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
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Message-ID: <20230302112517.17819fb2@jacob-builder>
In-Reply-To: <BN9PR11MB52760B805DDD6CC70C0E1D6D8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
	<20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB52760B805DDD6CC70C0E1D6D8CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Thu, 2 Mar 2023 09:37:30 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Thursday, March 2, 2023 9:00 AM
> > 
> > @@ -4675,6 +4679,33 @@ static void
> > intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> >  	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> >  }
> > 
> > +static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> > +				   struct device *dev, ioasid_t pasid)
> > +{
> > +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct intel_iommu *iommu = info->iommu;
> > +	int ret = 0;
> > +
> > +	if (!sm_supported(iommu) || !info)
> > +		return -ENODEV;
> > +
> > +	if (WARN_ON(pasid == PASID_RID2PASID))
> > +		return -EINVAL;
> > +
> > +	if (hw_pass_through && domain_type_is_si(dmar_domain))
> > +		ret = intel_pasid_setup_pass_through(iommu,
> > dmar_domain,
> > +						     dev, pasid);
> > +	else if (dmar_domain->use_first_level)
> > +		ret = domain_setup_first_level(iommu, dmar_domain,
> > +					       dev, pasid);
> > +	else
> > +		ret = intel_pasid_setup_second_level(iommu,
> > dmar_domain,
> > +						     dev, pasid);
> > +  
> 
> check whether pasid capability has been enabled on this device.
> 
> it's unlike SVA which has separate capability to tell.
yes, it is a little tricky in that enabling PASID should be done before ATS
but for now anything uses ENQCMDS should support ATS. I will add
	/*
	 * PASID should be enabled as part of PCI caps enabling where
	 * ordering is required relative to ATS.
	 */
	if (WARN_ON(!pdev->pasid_enabled))
		return -ENODEV;

Thanks,

Jacob
