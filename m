Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606315AC
	for <iommu@lists.linux.dev>; Tue, 18 Apr 2023 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681858838; x=1713394838;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fykUQ6tOFpliVc9yTRFVWqzndLzgQbjRZBsWfW5WetA=;
  b=Ix+zL0kYnROct4s3xWJma+3ogFuNL4Ou2hLjEXshLUx4VuAY5lmckuUL
   WU9iErRwrE8LTbRMW/BO5AbxSwrufrZJYa9A+t5yXnd9WZZbKpUy+OF4A
   flOFEAkBFEgvvdH11Q69GvucjXCfOaYPnV5C4jLK0stkXZTacjgH5gPKN
   +5vuRw0BtQbO5VrszUO1SeQfgIlM4CG7k1+pz79NAhKVuVRp0GwxpV8gp
   XitOPnVlSeyj9LLMOQSHlpTAyel1yo+YSkCWuPhux8hHFiG2FepJ/qmDi
   JrMOnEgTtChvglc+RgXQsZYrCPYCNuxT9H/ARgExpS9icD6w2YGKPC80h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="342790582"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="342790582"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 16:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="802707078"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="802707078"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 16:00:36 -0700
Date: Tue, 18 Apr 2023 16:04:50 -0700
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
 <tom.zanussi@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 3/7] iommu: Support allocation of global PASIDs
 outside SVA
Message-ID: <20230418160450.4ea7fb7d@jacob-builder>
In-Reply-To: <a1a82bc0-9a7a-5363-cda8-a0226eff0073@linux.intel.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
	<20230407180554.2784285-4-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB5276D09F18BA65AD074777948C9A9@BN9PR11MB5276.namprd11.prod.outlook.com>
	<5882ee52-9657-250d-0474-13edffa7b6b9@linux.intel.com>
	<20230417094629.59fcfde6@jacob-builder>
	<a1a82bc0-9a7a-5363-cda8-a0226eff0073@linux.intel.com>
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

On Tue, 18 Apr 2023 10:06:12 +0800, Baolu Lu <baolu.lu@linux.intel.com>
wrote:

> On 4/18/23 12:46 AM, Jacob Pan wrote:
> > On Wed, 12 Apr 2023 09:37:48 +0800, Baolu Lu<baolu.lu@linux.intel.com>
> > wrote:
> >   
> >> On 4/11/23 4:02 PM, Tian, Kevin wrote:  
> >>>> From: Jacob Pan<jacob.jun.pan@linux.intel.com>
> >>>> Sent: Saturday, April 8, 2023 2:06 AM
> >>>> @@ -28,8 +26,8 @@ static int iommu_sva_alloc_pasid(struct mm_struct
> >>>> *mm, ioasid_t min, ioasid_t ma
> >>>>    		goto out;
> >>>>    	}
> >>>>
> >>>> -	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> >>>> GFP_KERNEL);
> >>>> -	if (ret < min)
> >>>> +	ret = iommu_alloc_global_pasid(min, max);  
> >>> I wonder whether this can take a device pointer so
> >>> dev->iommu->max_pasids is enforced inside the alloc function.  
> >> Agreed. Instead of using the open code, it looks better to have a
> >> helper like dev_iommu_max_pasids().  
> > yes, probably export dev_iommu_get_max_pasids(dev)?
> > 
> > But if I understood Kevin correctly, he's also suggesting that the
> > interface should be changed to iommu_alloc_global_pasid(dev), my
> > concern is that how do we use this function to reserve RID_PASID which
> > is not specific to a device?  
> 
> Probably we can introduce a counterpart dev->iommu->min_pasids, so that
> there's no need to reserve the RID_PASID. At present, we can set it to 1
> in the core as ARM/AMD/Intel all treat PASID 0 as a special pasid.
> 
> In the future, if VT-d supports using arbitrary number as RID_PASID for
> any specific device, we can call iommu_alloc_global_pasid() for that
> device.
> 
> The device drivers don't know and don't need to know the range of viable
> PASIDs, so the @min, @max parameters seem to be unreasonable.
Sure, that is reasonable. Another question is whether global PASID
allocation is always for a single device, if not I prefer to keep the
current iommu_alloc_global_pasid() and add a wrapper
iommu_alloc_global_pasid_dev(dev) to extract the @min, @max. OK?


Thanks,

Jacob
