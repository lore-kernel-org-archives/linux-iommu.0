Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D936A44
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 05:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679980805; x=1711516805;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2WDW1HbB8GiBw48W4/RWUGSXww0Cy5qMfC0++e9jU44=;
  b=GLnAKJu88VH2dHAeeeD+Nrwg0OmQX4qRxy6KZbVOZwtqFYIgdtBtk4gM
   dOfcbPfy5WjJuDx28SPjmh2+jgT16VxvEe59rI6KYUbEhCsyJ3zV+Lr8K
   +kwCLZYFtcHGKQ8WsqKw8XxlESMz9lr0c/TVyrC0iwFlw0hdqLCAf+c09
   pscQccPt79654w5ip8k/1ASpXWWH6EMTA+iaQhbmm0cwssNWH5KMx8kiR
   ivkc6RwV74iywg7kqRdJtQcDbj89yGabxqOcPB6D0GLvUIst39qe+SbGt
   zQRyFRMQLC30hWn2wE1/wisG2QAtJDW93ZvJdhhkD05Rp+x6ORzTR0210
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="403082809"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="403082809"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 22:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="633887906"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="633887906"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2023 22:20:00 -0700
Message-ID: <41d31adf-577e-431c-c400-2708885400c1@linux.intel.com>
Date: Tue, 28 Mar 2023 13:20:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Raj Ashok <ashok.raj@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>,
 "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v2 4/8] iommu/vt-d: Reserve RID_PASID from global SVA
 PASID space
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 dmaengine@vger.kernel.org, vkoul@kernel.org
References: <20230327232138.1490712-1-jacob.jun.pan@linux.intel.com>
 <20230327232138.1490712-5-jacob.jun.pan@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230327232138.1490712-5-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/23 7:21 AM, Jacob Pan wrote:
> On VT-d platforms, RID_PASID is used for DMA request without PASID. We
> should not treat RID_PASID special instead let it be allocated from the
> global SVA PASID number space.

It's same to AMD and ARM SMMUv3, right? They also need an explicit
reservation of PASID 0.

> 
> Consequently, for devices also do DMA with PASID, drivers will not worry
> about conflicts when it comes to allocating PASIDs for in-kernel DMA.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9f737ef55463..61c06f7ad8f7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3956,6 +3956,10 @@ int __init intel_iommu_init(void)
>   
>   	intel_iommu_enabled = 1;
>   
> +#ifdef CONFIG_INTEL_IOMMU_SVM

Do we really need this #ifdef? IOMMU_SVA is selected by INTEL_IOMMU_SVM,
right? So if CONFIG_INTEL_IOMMU_SVM is not set,
iommu_sva_reserve_pasid() is just a dumb.

> +	/* Reserved RID_PASID from the global namespace for legacy DMA */
> +	iommu_sva_reserve_pasid(PASID_RID2PASID, PASID_RID2PASID);
> +#endif
>   	return 0;
>   
>   out_free_dmar:

Best regards,
baolu
