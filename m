Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500BE8BFB
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680018260; x=1711554260;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4pyh949E97gRjYQQaTn6XtjnpRmrAxMmEo978KIuT4s=;
  b=UU1DkpS7+q47MmfinpDr66Ols0RTfSFWsq65jOKHW9246JIOo5FKzz4s
   fle2cQfpH4kxgHclr6VI4WrA03SqFcvAEbx5Jc5OtB+6ifGqsZLi6IWgo
   Xqgi5usKVG9oMo58EGYrBYn2n2Reqi4Fmh2JRcZlj1gDQqQxdNJtbunKS
   WCEXCqlxzUv0/Ih/IbqKzewYmeASkKMw19/KjpNTvjnYgogvzn/wN/zQi
   wD5mSJoqvMKDT5rAfEkOqkOKdVff8zjMCsSCu1uJ0Sv60gjUJO0s6Wonl
   4bIIDmivD7ZwJL5cEyFeH7qxlAX0ayHO6WEKWweVdI7RSgZjQlvN9QmM4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="321005872"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="321005872"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:44:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="716525655"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="716525655"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:44:19 -0700
Date: Tue, 28 Mar 2023 08:48:22 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 7/8] iommu: Export iommu_get_dma_domain
Message-ID: <20230328084822.4b46e649@jacob-builder>
In-Reply-To: <BN9PR11MB527623AC2CE25EDA10FF81548C889@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
	<20230327232138.1490712-8-jacob.jun.pan@linux.intel.com>
	<e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
	<BN9PR11MB527623AC2CE25EDA10FF81548C889@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Tue, 28 Mar 2023 07:52:23 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Tuesday, March 28, 2023 2:04 PM
> > 
> > On 3/28/23 7:21 AM, Jacob Pan wrote:  
> > > Devices that use ENQCMDS to submit work needs to retrieve its DMA
> > > domain. It can then attach PASID to the DMA domain for shared mapping
> > > (with RID) established by DMA API.
> > >
> > > Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> > > ---
> > >   drivers/iommu/iommu.c | 1 +
> > >   include/linux/iommu.h | 5 +++++
> > >   2 files changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 10db680acaed..c51d343a75d2 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -2118,6 +2118,7 @@ struct iommu_domain  
> > *iommu_get_dma_domain(struct device *dev)  
> > >   {
> > >   	return dev->iommu_group->default_domain;
> > >   }
> > > +EXPORT_SYMBOL_GPL(iommu_get_dma_domain);  
> > 
> > Directly exporting this function for external use seems unsafe. If the
> > caller is the kernel driver for this device, it's fine because default
> > domain remains unchanged during the life cycle of the driver. Otherwise,
> > using this function may cause UAF. Keep in mind that group's default
> > domain could be changed through sysfs.
> > 
> > However, iommu_get_domain_for_dev() has already done so and has been
> > exported. Maybe I'm worried too much. :-)
> >   
> 
> Agree. The kernel driver managing the device wants to get the current 
> domain of the device then iommu_get_domain_for_dev() is the right
> interface. It knows the domain is the dma domain.
This goes back to v1 then :)

I thought the comments from v1 is that we don't want to check the domain
type is DMA domain returned by iommu_get_domain_for_dev()

If the driver "knows" the domain is dma domain, why can't it use
iommu_get_dma_domain()? seems paradoxical.

Thanks,

Jacob
