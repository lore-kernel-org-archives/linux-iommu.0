Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C22C2FD
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 20:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683318469; x=1714854469;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=attubp1Y5SHGM2s6fxrjpGYDxEhvZVo+MggS/87KNmo=;
  b=FjfUhCedrxP784QCxeBwELgUqjkrkjiTXXIpmTxbPQxcRUxASnJzioAW
   AK2IxM9ZBKl0hL4hKlTS/Dmwe1sK6YT5ZvV7b4OajTU4AIPQTVOXKMG9E
   RNb5rHCwEGEsJMtUGP5+Rtodtns/aVJry9gEMIB4e6OC9XMRBBghQ8SiR
   NLDtCTsk+LmbwxfmMRtWET3AjGowDXExA9W3TLodzfvONpkUaJude1F/Z
   L0K1TE1v31uVxjugQggm74PIg1KohgPtWeli5VHOMjXhIoo1NExM8IYSB
   6zVzhD6BQXwSCWh05IW4mVR2Wsp6qB6BsoAQJM2J1fDAvjg3PRWM7aYfX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="338495576"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="338495576"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 13:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="767259577"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="767259577"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 13:27:39 -0700
Date: Fri, 5 May 2023 13:32:02 -0700
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
Subject: Re: [PATCH v5 6/7] iommu/vt-d: Implement set_dev_pasid domain op
Message-ID: <20230505133202.094bf8be@jacob-builder>
In-Reply-To: <35ceffc2-e306-6215-e90a-43548f6feca6@linux.intel.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
	<20230427174937.471668-7-jacob.jun.pan@linux.intel.com>
	<76c98e62-1cac-2ab6-7721-08ec2c1fceb8@linux.intel.com>
	<20230504160334.496085db@jacob-builder>
	<35ceffc2-e306-6215-e90a-43548f6feca6@linux.intel.com>
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

On Fri, 5 May 2023 10:58:38 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 5/5/23 7:03 AM, Jacob Pan wrote:
> >>> +static int intel_iommu_attach_device_pasid(struct iommu_domain
> >>> *domain,
> >>> +					   struct device *dev,
> >>> ioasid_t pasid) +{
> >>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> >>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> >>> +	struct intel_iommu *iommu = info->iommu;
> >>> +	int ret;
> >>> +
> >>> +	if (!pasid_supported(iommu))
> >>> +		return -ENODEV;
> >>> +
> >>> +	ret = prepare_domain_attach_device(domain, dev);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	/*
> >>> +	 * Most likely the device context has already been set up,
> >>> will only
> >>> +	 * take a domain ID reference. Otherwise, device context will
> >>> be set
> >>> +	 * up here.  
> >> The "otherwise" case is only default domain deferred attaching case,
> >> right?  
> > it might be the only case so far, but my intention is to be general.
> > i.e. no ordering requirements. I believe it is more future proof in case
> > device_attach_pasid called before device_attach.  
> 
> Let's put aside deferred attach and talk about it later.
> 
> The device's context entry is configured when the default domain is
> being attached to the device. And, the default domain attaching is in
> the iommu probe_device path. It always happens before set_device_pasid
> which is designed to be called by the device driver. So the real
> situation is that when the device driver calls set_device_pasid, the
> context entry should already have been configured.
> 
> Then let's pick up the deferred attach case. It is a workaround for
> kdump (Documentation/admin-guide/kdump/kdump.rst). I don't think PASID
> feature is functionally required by any kdump capture kernel as its
> main purpose is to dump the memory of a panic kernel.
> 
> In summary, it seems to be reasonable for the vt-d driver to return
> -EBUSY when a device's context was copied. The idxd driver should
> continue to work without kernel DMA with PASID support.
> 
> 	if (context_copied(iommu, bus, devfn))
> 		return -EBUSY;
> 
> Make things general is always good, but this doesn't mean that we need
> to make the code complex to support cases that do not exist or are not
> used. Thoughts?
> 
Good point, it is better not put dead code in. Let me also document this
behavior for future change that may affect the ordering requirement.

Thanks,

Jacob
