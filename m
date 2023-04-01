Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A633232
	for <iommu@lists.linux.dev>; Sat,  1 Apr 2023 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680356601; x=1711892601;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MFKyQgWRfmOJKme2+efm2K6/Azaun05Iy1yrj8qyo5E=;
  b=Sb+4y0zWVvdj5EEZpvZV/ACIHdfkWIGTjRyf17us4frl3JcHUcHmhhiI
   Pwv2qdeMazYRDsU6ch1DEApNFuu5iVCQ4y21eF/y1X1h8H8Lo5t+XIQDz
   Z/SZYjHbOOo657IZS8iEcUGLoxBp2rlbFUhFKAKXPojLVIrcsuni32tVd
   xpoBFkX6+Gn1jXJF/yLgAQpZwD2Bb9MOkN+fsFi6n5tN/Dcfxv8DVVCgV
   rK2wkIva7lhB03B9MSMoSlP9sy3q8C/ITZ5N6Fd8MR/y2LqLVdrZdb0tU
   RuWDVDz0SVj6OZwFRaOWqK/IvKH+qDN3faDbN7maK4YSbR/HMCa2fTm2g
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="341673179"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="341673179"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10667"; a="749978248"
X-IronPort-AV: E=Sophos;i="5.98,310,1673942400"; 
   d="scan'208";a="749978248"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.241]) ([10.254.211.241])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2023 06:43:15 -0700
Message-ID: <13bf4050-7563-798a-1776-dd6c948bc1f8@linux.intel.com>
Date: Sat, 1 Apr 2023 21:43:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Raj Ashok <ashok.raj@intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v3 4/7] iommu/vt-d: Reserve RID_PASID from global PASID
 space
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
 <20230331231137.1947675-5-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230331231137.1947675-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/4/1 7:11, Jacob Pan wrote:
> On VT-d platforms, RID_PASID is used for DMA request without PASID. We
> should not treat RID_PASID special instead let it be allocated from the
> global PASID number space. Non-zero value can be used in RID_PASID on
> Intel VT-d.
> 
> For ARM, AMD and others that _always_ use 0 as RID_PASID, there is no
> impact in that SVA PASID allocation base is 1.
> 
> With this change, devices do both DMA with PASID and SVA will not worry
> about conflicts when it comes to allocating PASIDs for in-kernel DMA.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9f737ef55463..cbb2670f88ca 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3956,6 +3956,10 @@ int __init intel_iommu_init(void)
>   
>   	intel_iommu_enabled = 1;
>   
> +	/* Reserved RID_PASID from the global namespace for legacy DMA */
> +	WARN_ON(iommu_alloc_global_pasid(PASID_RID2PASID, PASID_RID2PASID) !=
> +		PASID_RID2PASID);

This looks odd. With the previous patch unchanged,
iommu_alloc_global_pasid() will always return IOMMU_PASID_INVALID if
CONFIG_IOMMU_SVA is not set.

> +
>   	return 0;
>   
>   out_free_dmar:

Best regards,
baolu
