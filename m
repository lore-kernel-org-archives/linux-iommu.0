Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC1A935
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 21:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680558265; x=1712094265;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kNRta8Lnta0mBFF+JAUbDr7was+Q3+2h+SR8Tx/D7kI=;
  b=Gg01ltKXC5JumlV7HKdcmIHA+5VCDvgBnpxGZrxyOlNZpF9Scv1FwcUE
   jXq+nD0ALFYQHSVtsu0vM/p7KB8MocWcnkAVj+rYB9Lkn9q8NI2JL49p2
   QQdztPo4V5ycEHkMLfXZDDKgIXVzJM/Df5W+lw1BawEr+BfiVcVVsenrm
   NclCBM2LAsaVmgG7DWRwCDH4jrS+gO+uEMo8IsZ7mnlB18o9OifahWdnE
   MDoEy/JXHamk3RMgIvqbXkGkrI5leKyfCQHMViMw29nZsQHZ/DDdIHnIk
   957vFDWUBGARjIt/CRaj5JF0j+/VVSfcL9U/bMPkYY6FmSThZcklgzSoQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="404776415"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="404776415"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="755406809"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="755406809"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 14:44:21 -0700
Date: Mon, 3 Apr 2023 14:48:27 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, dmaengine@vger.kernel.org, vkoul@kernel.org, Will Deacon
 <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Raj Ashok
 <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>, "Zanussi, Tom"
 <tom.zanussi@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 6/7] iommu/vt-d: Implement set_dev_pasid domain op
Message-ID: <20230403144827.7b2c1ccb@jacob-builder>
In-Reply-To: <a63e70cc-8890-bb99-3326-0b19e81ea92e@linux.intel.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
	<20230331231137.1947675-7-jacob.jun.pan@linux.intel.com>
	<a63e70cc-8890-bb99-3326-0b19e81ea92e@linux.intel.com>
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

On Sat, 1 Apr 2023 21:48:36 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 2023/4/1 7:11, Jacob Pan wrote:
> > Devices that use ENQCMDS to submit work on buffers mapped by DMA API
> > must attach a PASID to the default domain of the device. In preparation
> > for this use case, this patch implements set_dev_pasid() for the
> > default_domain_ops.
> > 
> > If the device context has not been set up prior to this call, this will
> > set up the device context in addition to PASID attachment.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 52b9d0d3a02c..1ad9c5a4bd8f 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -4784,6 +4784,26 @@ static void intel_iommu_remove_dev_pasid(struct
> > device *dev, ioasid_t pasid) domain_detach_iommu(dmar_domain,
> > info->iommu); }
> >   
> > +static int intel_iommu_attach_device_pasid(struct iommu_domain *domain,
> > +					   struct device *dev,
> > ioasid_t pasid) +{
> > +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct intel_iommu *iommu = info->iommu;
> > +	int ret;
> > +
> > +	if (!pasid_supported(iommu))
> > +		return -ENODEV;  
> 
> As the domain ID will be set to the pasid entry, need to get a refcount
> of the domain ID. Call domain_attach_iommu() here, and release it after
> the pasid entry is torn down.
dmar_domain_attach_device_pasid() below will call domain_attach_iommu() and
release in intel_iommu_remove_dev_pasid(). The previous patch has
consolidated the code path with device attachment.
would it be sufficient?

> > +	ret = prepare_domain_attach_device(domain, dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return dmar_domain_attach_device_pasid(dmar_domain, dev,
> > pasid); +}
> > +
> > +
> > +
> >   const struct iommu_ops intel_iommu_ops = {
> >   	.capable		= intel_iommu_capable,
> >   	.domain_alloc		= intel_iommu_domain_alloc,
> > @@ -4803,6 +4823,7 @@ const struct iommu_ops intel_iommu_ops = {
> >   #endif
> >   	.default_domain_ops = &(const struct iommu_domain_ops) {
> >   		.attach_dev		=
> > intel_iommu_attach_device,
> > +		.set_dev_pasid          =
> > intel_iommu_attach_device_pasid, .map_pages		=
> > intel_iommu_map_pages, .unmap_pages		=
> > intel_iommu_unmap_pages, .iotlb_sync_map		=
> > intel_iommu_iotlb_sync_map,  
> 
> Best regards,
> baolu


Thanks,

Jacob
