Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2015A5
	for <iommu@lists.linux.dev>; Thu, 17 Nov 2022 01:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668650133; x=1700186133;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=uuP5q8gUlbvgaw8quTq8oqXHFLQt2Yhg3IPq6GPh/j8=;
  b=kyzPc3OhUoVlT2pPzR/XVs5KXd3N9Egb1n6jyUCuc4bnjPaostM4761b
   xYUc3G6kMMiSJmi6pZsMmk0/LNJwQpLjnjrM71wx2XxkraIBHi/SOAa4p
   uiJF8BNlYxuCUV8viCe9GlzBKeHWasoigiegFzbZgkiL5oQUCHWztrTvY
   C3rSKSJxo9YV1eqxQfz0eA4xZp2NTl+Icet+Cx0nqFx6ND0EQb+vdNWfQ
   XccNlrZZXNIpqFxY7b25D2emookkWvNAGhj4hpA52a2sDoPGZhFQlEOVy
   Bwn+u9/ZgjZLH1xceUrE3GMJmGZCUh3nodtkMBwNoAuUMjAyS/snFLSiW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296087991"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="296087991"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:55:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="764562079"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="764562079"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.247]) ([10.254.210.247])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 17:55:27 -0800
Message-ID: <33eea9bd-e101-4836-19e8-d4b191b78b00@linux.intel.com>
Date: Thu, 17 Nov 2022 09:55:25 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: baolu.lu@linux.intel.com, Pierre Morel <pmorel@linux.ibm.com>,
 linux-s390@vger.kernel.org, borntraeger@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
 svens@linux.ibm.com, linux-kernel@vger.kernel.org,
 Julian Ruess <julianr@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Wenjia Zhang <wenjia@linux.ibm.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-5-schnelle@linux.ibm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 4/7] iommu: Let iommu.strict override
 ops->def_domain_type
In-Reply-To: <20221116171656.4128212-5-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/11/17 1:16, Niklas Schnelle wrote:
> When iommu.strict=1 is set or iommu_set_dma_strict() was called we
> should use IOMMU_DOMAIN_DMA irrespective of ops->def_domain_type.
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>   drivers/iommu/iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 65a3b3d886dc..d9bf94d198df 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1562,6 +1562,9 @@ static int iommu_get_def_domain_type(struct device *dev)
>   {
>   	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   
> +	if (iommu_dma_strict)
> +		return IOMMU_DOMAIN_DMA;

If any quirky device must work in IOMMU identity mapping mode, this
might introduce functional regression. At least for VT-d platforms, some
devices do require IOMMU identity mapping mode for functionality.

> +
>   	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
>   		return IOMMU_DOMAIN_DMA;
>   

Best regards,
baolu
