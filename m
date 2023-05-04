Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF37C
	for <iommu@lists.linux.dev>; Thu,  4 May 2023 21:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683236084; x=1714772084;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EP+qQVPq1TXsIe51i7OOoP+qvywU7gMPQc8clIWQK4s=;
  b=lHV9BfJQ6q8LxVpEe3RsmCKsH0AvNqEI/xYZAs3RRP5BkCjdimt3kOR7
   VgRghuxY894usLDupH1af7/h2NVFDcRjuSBpMeWTQnf22yW1/9AJHBO1e
   UTemnGA39yRZCkUXXsa84GLQ/l+ekTxCSJTHT3tBBHY7Xm8iWK9ffuwk0
   oMTy7HjaHPgALAN6RbokJFxjvtT9Iath4eH6e9DOnXwxKmdbpPk6iJCKS
   Tizj1Yp7vWISKAAW4UyNv9+YSDNijXuSc5zPzxm0Y7ea7lXNb1PIeusNl
   W+ViWylCNlQeiEdqE+3ic6lxp+syqOregW/pUk0kc5BSVrRsNostl2BpW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="414585940"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="414585940"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:34:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="943531835"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="943531835"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 14:34:43 -0700
Date: Thu, 4 May 2023 14:39:05 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, LKML
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Robin Murphy <robin.murphy@arm.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "vkoul@kernel.org"
 <vkoul@kernel.org>, Will Deacon <will@kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave"
 <dave.jiang@intel.com>, "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom"
 <tom.zanussi@intel.com>, "Ranganathan, Narayan"
 <narayan.ranganathan@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 4/7] iommu/vt-d: Factoring out PASID set up helper
 function
Message-ID: <20230504143905.66fd14c7@jacob-builder>
In-Reply-To: <9fb1c0dd-ea78-a3f7-9eac-3154f5d08ad5@linux.intel.com>
References: <20230427174937.471668-1-jacob.jun.pan@linux.intel.com>
	<20230427174937.471668-5-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB5276726E67301703BD10833B8C6B9@BN9PR11MB5276.namprd11.prod.outlook.com>
	<9fb1c0dd-ea78-a3f7-9eac-3154f5d08ad5@linux.intel.com>
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

On Wed, 3 May 2023 14:37:16 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 4/28/23 5:47 PM, Tian, Kevin wrote:
> >> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Sent: Friday, April 28, 2023 1:50 AM
> >>
> >>
> >> +static int dmar_domain_attach_device_pasid(struct dmar_domain *domain,
> >> +					   struct intel_iommu *iommu,
> >> +					   struct device *dev,
> >> ioasid_t pasid) +{
> >> +	int ret;
> >> +
> >> +	/* PASID table is mandatory for a PCI device in scalable
> >> mode. */
> >> +	if (!sm_supported(iommu) && dev_is_real_dma_subdevice(dev))
> >> +		return -EOPNOTSUPP;  
> > 
> > "&&" should be "||"
> >   
> 
> Also should return success instead if this is a RID case. Perhaps,
> 
> 	if (!sm_supported(iommu) || dev_is_real_dma_subdevice(dev))
> 		return pasid == RID2PASID ? 0 : -EOPNOTSUPP;
> 
Yeah,  I think this is better.  will do.

I was hoping not to treat RIDPASID special here. The caller of this
function does the check if that is RIDPASID but code is duplicated.

Thanks,

Jacob
