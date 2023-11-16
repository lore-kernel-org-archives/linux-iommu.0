Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744E3F9F7
	for <iommu@lists.linux.dev>; Thu, 16 Nov 2023 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaBIz7Jq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700120118; x=1731656118;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OnxEOY1ocle0WK3u+KG9u2HZaBGzKjOZo80GjbLFg5M=;
  b=TaBIz7JqF9hzB22gqIbIyC4koSB1khHCpAuBJbraG8ITWzso2sQ1Q1cg
   mPMS2wrrlW/sZ/rmCfQuxlX3Z6hvk2odmnyJf4uaAlri+6ym2iMaklQNb
   ILbLnYUfNobw3wiMkEvfIKnjIvEgbbp/afElk5P9rjLfxN0lTJjiIlqXa
   HWqGoVLWmXM7ntRn63HPpzy3GZ6FlNlCZ5bH1ke1o4jbGlOFOC04VuhL9
   /11d8upcwBwNf4d6fhsi6WJVCilD/PIuXofyzIXx6G7kipfsX9LHlfBQe
   pvuxT315NJGMeCi3tPZYF2Urfzk5C91QrZc+6jBqF2Mrj6kaunN2/tTcE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="394950891"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="394950891"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:35:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="741677698"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="741677698"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.199]) ([10.255.31.199])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:35:15 -0800
Message-ID: <0f8c95f3-c16e-497e-9734-85936ae08f82@linux.intel.com>
Date: Thu, 16 Nov 2023 15:35:13 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-3-baolu.lu@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231114011036.70142-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/11/14 9:10, Lu Baolu wrote:
> When IOMMU hardware operates in legacy mode, the TT field of the context
> entry determines the translation type, with three supported types (Section
> 9.3 Context Entry):
> 
> - DMA translation without device TLB support
> - DMA translation with device TLB support
> - Passthrough mode with translated and translation requests blocked
> 
> Device TLB support is absent when hardware is configured in passthrough
> mode.
> 
> Disable the PCI ATS feature when IOMMU is configured for passthrough
> translation type in legacy (non-scalable) mode.
> 
> Fixes: 0faa19a1515f ("iommu/vt-d: Decouple PASID & PRI enabling from SVA")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 11670cd812a3..c3ec09118ab1 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1413,6 +1413,10 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
>   	if (!dev_is_pci(info->dev))
>   		return;
>   
> +	if (!sm_supported(info->iommu) && info->domain &&
> +	    domain_type_is_si(info->domain))
> +		return;
> +
>   	pdev = to_pci_dev(info->dev);
>   
>   	/* The PCIe spec, in its wisdom, declares that the behaviour of

Perhaps we could move the check into the caller and make this helper
transparent to the iommu mode and domain type?

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 11670cd812a3..9bddd4fbbdf8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2492,7 +2492,8 @@ static int dmar_domain_attach_device(struct 
dmar_domain *domain,
                 return ret;
         }

-       iommu_enable_pci_caps(info);
+       if (sm_supported(info->iommu) || !domain_type_is_si(info->domain))
+               iommu_enable_pci_caps(info);

         return 0;
  }

Best regards,
baolu
