Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98918460
	for <iommu@lists.linux.dev>; Mon, 17 Apr 2023 16:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681747387; x=1713283387;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7tLU5hrc39P7zYp6lZlpanLIEtDU8xZ/pBPxVlbteKA=;
  b=Vaf46s0MzgPsKvpGVBMpwOsxZXnO+OuN9BcHudNx7w8nKkqz9jc2G82k
   rKopUpCEB4jKnRzskqQ72YyTwrM20Y/tegvsjgjoZCYQArL6AElda3iNj
   SjVKJmzYbfaqQXAxVqLVjxLsPVB8/7Vdu/qCmJUaS03pcCu+j2K8wHlgE
   UNIWl0gaXCnZ8Ai/p3qqkyXzu+nkr75jQm7+7/WzMJE7tA8CVWHM7zJXx
   B9QEfjv6ai75T2Y3vBy9Iu0o6o0Erludwob6yOSRwd73qazB0MTKKJpxK
   NTASDkgQpT+Br1MLotv6zMCpHVgU88Qo6jKqcQe5ViBmUWNpy5Dek5oGW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="344927321"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="344927321"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 09:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="802172627"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="802172627"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 09:02:52 -0700
Date: Mon, 17 Apr 2023 09:07:06 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Robin Murphy <robin.murphy@arm.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg
 Roedel <joro@8bytes.org>, "dmaengine@vger.kernel.org"
 <dmaengine@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>, Will
 Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Yu,
 Fenghua" <fenghua.yu@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 3/7] iommu: Support allocation of global PASIDs
 outside SVA
Message-ID: <20230417090706.3ac5f858@jacob-builder>
In-Reply-To: <BN9PR11MB5276D09F18BA65AD074777948C9A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230407180554.2784285-1-jacob.jun.pan@linux.intel.com>
	<20230407180554.2784285-4-jacob.jun.pan@linux.intel.com>
	<BN9PR11MB5276D09F18BA65AD074777948C9A9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On Tue, 11 Apr 2023 08:02:55 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, April 8, 2023 2:06 AM
> > @@ -28,8 +26,8 @@ static int iommu_sva_alloc_pasid(struct mm_struct
> > *mm, ioasid_t min, ioasid_t ma
> >  		goto out;
> >  	}
> > 
> > -	ret = ida_alloc_range(&iommu_global_pasid_ida, min, max,
> > GFP_KERNEL);
> > -	if (ret < min)
> > +	ret = iommu_alloc_global_pasid(min, max);  
> 
> I wonder whether this can take a device pointer so dev->iommu->max_pasids
> is enforced inside the alloc function.
> 
> and do we even need the min/max parameters? With special pasids reserved
> then what driver needs is just to get a free pasid from the global space
> within dev->iommu->max_pasids constraint...
> 
> iommu_sva_alloc_pasid() can be reworked to avoid min/max by taking a 
> device pointer too.
I think that will work too albeit a philosophical change. It probably
should be called iommu_alloc_dev_global_pasid(dev).

But I feel the current approach is more flexible in that device drivers
can control the range if for some reason it does not want go max_pasid.


Thanks,

Jacob
