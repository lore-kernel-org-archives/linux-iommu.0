Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A39566C
	for <iommu@lists.linux.dev>; Mon,  6 Mar 2023 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678127110; x=1709663110;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SYxEnLu9FHhcZWF+7is1RQbEqS+MDzdMBJ+igGqK7HE=;
  b=J49Y/BitCSXLC0EsqGOBwTJSC9T/Ig/sFVIuG6v3koMWp4k9WYnlfBaE
   cT0kHr7KDRE3S0F3oY4YleF7L5qcoPlb+0Bpq8dW5WeOHT8HCrFHyw7h7
   VFwkmFxL6yUOzhKaaxAIzzFtYraYQmcN6my8pmaZHViQch4e7wJJK5wAR
   IHtW2hQwNaqeSV9yLsfRJqL4wgmd373kn97rkNSm07htGTnaPgJP6+2V1
   aNHaS0WWl0voukK74R9tX2ovXbrma98sk1g6+QnlZRP0QaZtDlI5pi7C/
   H1Ac5PHm/WQXhIbdrM51jzDwlMnQD5nZ4ONkfZZptJM2jF9DwEtWOYeuz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="421911942"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="421911942"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:25:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="819396352"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="819396352"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 10:25:09 -0800
Date: Mon, 6 Mar 2023 10:29:00 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, LKML
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
Message-ID: <20230306102900.0fa3a4b2@jacob-builder>
In-Reply-To: <c54aebf7-4282-b8a6-f03b-03af2deea59c@linux.intel.com>
References: <20230302005959.2695267-1-jacob.jun.pan@linux.intel.com>
	<20230302005959.2695267-2-jacob.jun.pan@linux.intel.com>
	<fad7f28f-b4e8-c1c3-4ca4-a48c5c6d7f4a@linux.intel.com>
	<BN9PR11MB527627C597F6478536477A8F8CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20230303083512.663ce758@jacob-builder>
	<c54aebf7-4282-b8a6-f03b-03af2deea59c@linux.intel.com>
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

On Sun, 5 Mar 2023 11:05:50 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 3/4/23 12:35 AM, Jacob Pan wrote:
> >>> From: Baolu Lu<baolu.lu@linux.intel.com>
> >>> Sent: Thursday, March 2, 2023 10:07 PM
> >>>      
> >>>> +
> >>>> +	if (hw_pass_through && domain_type_is_si(dmar_domain))
> >>>> +		ret = intel_pasid_setup_pass_through(iommu,
> >>>> dmar_domain,
> >>>> +						     dev, pasid);
> >>>> +	else if (dmar_domain->use_first_level)
> >>>> +		ret = domain_setup_first_level(iommu, dmar_domain,
> >>>> +					       dev, pasid);
> >>>> +	else
> >>>> +		ret = intel_pasid_setup_second_level(iommu,
> >>>> dmar_domain,
> >>>> +						     dev, pasid);
> >>>> +
> >>>> +	return ret;
> >>>> +}  
> >>> Do you need to consider pasid cache invalidation?
> >>>      
> >> To avoid confusion this is not about invalidation of pasid cache itself
> >> which should be covered by above setup functions already.
> >>
> >> Here actually means per-PASID invalidation in iotlb and devtlb. Today
> >> only RID is tracked per domain for invalidation. it needs extension to
> >> walk attached pasid too.  
> > Yes, will add.
> > 
> > For the set up path, there is no need to flush IOTLBs,  because we're
> > going from non present to present.
> > 
> > On the remove path, IOTLB flush should be covered when device driver
> > calls iommu_detach_device_pasid(). Covered with this patch.  
> 
> It's not only for the PASID teardown path, but also for unmap(). As the
> device has issued DMA requests with PASID, the IOMMU probably will cache
> the DMA translation with PASID tagged. Hence, we need to invalidate the
> PASID-specific IOTLB and device TLB in the unmap() path.
> 
> I once had a patch for this:
> 
> https://lore.kernel.org/linux-iommu/20220614034411.1634238-1-baolu.lu@linux.intel.com/
> 
> Probably you can use it as a starting point.
understood, actually my previous version had unmap flush, based on yours as
well.
https://lore.kernel.org/lkml/20220518182120.1136715-1-jacob.jun.pan@linux.intel.com/T/
> 
> Best regards,
> baolu


Thanks,

Jacob
