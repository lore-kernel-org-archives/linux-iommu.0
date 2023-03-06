Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88F2CA7
	for <iommu@lists.linux.dev>; Mon,  6 Mar 2023 18:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678127995; x=1709663995;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LGzMj6SEWczKGd/+Bs1LUvlMn+f9r7qzBVfF1JbDiRE=;
  b=OLZ6FLdUY7MkxjJRdhemtdbORNOtg1Myj4NgRCvpa5Em3xcvykcE9ilx
   cx9KUgemONEOHiHYFWzNZ3kL6Sqd02Wqm2G0WMXiIn5G6nzgHWSSZU+eS
   iWhNStUoP15YSCRaimTLulnYQcYosRPG8ZjoGAwv9HET2hWOT48uQO9Le
   VD6XfLDLb22xiJ3YKmB4iRUaR5p1LQEndb1g5VSFYRSn8v6OdR3dZ8odw
   cAZki+jceL6JfbsLxfM2OAstKUuvaTmTlcEA3QuTjoJGNPYSxeDcTH/9a
   7/rNM9bt5uSviDmZMYBlQiSqSQqpbgBZXK60yzXozO3+DEAovqn2B7eKX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398224566"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398224566"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="626252082"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="626252082"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:39:54 -0800
Date: Mon, 6 Mar 2023 10:43:46 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 1/4] iommu/vt-d: Implement set device pasid op for
 default domain
Message-ID: <20230306104346.022849ee@jacob-builder>
In-Reply-To: <BN9PR11MB527649B07E006466882F3D278CB69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
	<20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
	<fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
	<BN9PR11MB527627C597F6478536477A8F8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20230303083512.663ce758@jacob-builder>
	<c54aebf7-4282-b8a6-f03b-03af2deea59c@linux.intel.com>
	<BN9PR11MB527649B07E006466882F3D278CB69@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Mon, 6 Mar 2023 08:18:37 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Sunday, March 5, 2023 11:06 AM
> > 
> > On 3/4/23 12:35 AM, Jacob Pan wrote:  
> > >>> From: Baolu Lu<baolu.lu@linux.intel.com>
> > >>> Sent: Thursday, March 2, 2023 10:07 PM
> > >>>  
> > >>>> +
> > >>>> +	if (hw_pass_through && domain_type_is_si(dmar_domain))
> > >>>> +		ret = intel_pasid_setup_pass_through(iommu,
> > >>>> dmar_domain,
> > >>>> +						     dev, pasid);
> > >>>> +	else if (dmar_domain->use_first_level)
> > >>>> +		ret = domain_setup_first_level(iommu, dmar_domain,
> > >>>> +					       dev, pasid);
> > >>>> +	else
> > >>>> +		ret = intel_pasid_setup_second_level(iommu,
> > >>>> dmar_domain,
> > >>>> +						     dev, pasid);
> > >>>> +
> > >>>> +	return ret;
> > >>>> +}  
> > >>> Do you need to consider pasid cache invalidation?
> > >>>  
> > >> To avoid confusion this is not about invalidation of pasid cache
> > >> itself which should be covered by above setup functions already.
> > >>
> > >> Here actually means per-PASID invalidation in iotlb and devtlb. Today
> > >> only RID is tracked per domain for invalidation. it needs extension
> > >> to walk attached pasid too.  
> > > Yes, will add.
> > >
> > > For the set up path, there is no need to flush IOTLBs,  because we're
> > > going from non present to present.
> > >
> > > On the remove path, IOTLB flush should be covered when device driver
> > > calls iommu_detach_device_pasid(). Covered with this patch.  
> > 
> > It's not only for the PASID teardown path, but also for unmap(). As the
> > device has issued DMA requests with PASID, the IOMMU probably will cache
> > the DMA translation with PASID tagged. Hence, we need to invalidate the
> > PASID-specific IOTLB and device TLB in the unmap() path.
> > 
> > I once had a patch for this:
> > 
> > https://lore.kernel.org/linux-iommu/20220614034411.1634238-1-
> > baolu.lu@linux.intel.com/
> > 
> > Probably you can use it as a starting point.
> >   
> 
> just that we should not have a sub-device term there. Just name
> the tracking information per pasid.
Sounds good, I should be enable to use Baolu's patch for the most part.

Thanks,

Jacob
