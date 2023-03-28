Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B18BFB
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680018298; x=1711554298;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aANfklT01Q50VoPynu4eI92dQQpk9aNu69RWvGsHYk8=;
  b=LoiKL2Nxo79PJR3m1fJlTtUijCFjBJZ1k0cRtQ4ezNNJAQ7pQd5eTSBc
   hKFAO6aM1lQnf2KgufHvPgxRsMi+OMjgwFgbX6YFg3dGtgxhCUPm7r+cO
   OeNMqHqQ+S+kh4+WX6bW/j5AU1PFEVNQeleoIdXVaA3MCs4s4OxG+G5cA
   gGXZTzfMRPTIz2wA1DiGDLAbbv5J6NSagBe4Kd/x5Uj/RgMUkaVnbJVlV
   JNODc+nVuDxjvb+tq1RzGzvGFBApziOoHuLDoGL+nmN/9WqwhS9pjmhQi
   dKUJGPoSzhUIGw/z2NPh5JViJoo6qkG48x6BnDloJ1oC/HyJg0zt+hRcj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="368365971"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="368365971"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="753195774"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="753195774"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:44:52 -0700
Date: Tue, 28 Mar 2023 08:48:55 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, Jason
 Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 dmaengine@vger.kernel.org, vkoul@kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, David Woodhouse
 <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua"
 <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>, Tony Luck
 <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 7/8] iommu: Export iommu_get_dma_domain
Message-ID: <20230328084855.7b9cd981@jacob-builder>
In-Reply-To: <e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
	<20230327232138.1490712-8-jacob.jun.pan@linux.intel.com>
	<e7d53d04-6b7f-05a4-3077-42470c6d2823@linux.intel.com>
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

On Tue, 28 Mar 2023 14:04:15 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 3/28/23 7:21 AM, Jacob Pan wrote:
> > Devices that use ENQCMDS to submit work needs to retrieve its DMA
> > domain. It can then attach PASID to the DMA domain for shared mapping
> > (with RID) established by DMA API.
> > 
> > Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/iommu.c | 1 +
> >   include/linux/iommu.h | 5 +++++
> >   2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 10db680acaed..c51d343a75d2 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2118,6 +2118,7 @@ struct iommu_domain *iommu_get_dma_domain(struct
> > device *dev) {
> >   	return dev->iommu_group->default_domain;
> >   }
> > +EXPORT_SYMBOL_GPL(iommu_get_dma_domain);  
> 
> Directly exporting this function for external use seems unsafe. If the
> caller is the kernel driver for this device, it's fine because default
> domain remains unchanged during the life cycle of the driver. Otherwise,
> using this function may cause UAF. Keep in mind that group's default
> domain could be changed through sysfs.
don't you have to unload the driver? 

> However, iommu_get_domain_for_dev() has already done so and has been
> exported. Maybe I'm worried too much. :-)
> 
> Best regards,
> baolu


Thanks,

Jacob
