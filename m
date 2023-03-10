Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3452F49
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 11:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678448673; x=1709984673;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G3Aal91iKGPfbK6b60D4eM6q2BxHVO7zC/wBF1TRZPM=;
  b=DpjkIZo3s0qdT1Jw/zEAvA6cYjtBdQ4FKg6nDcGpWew7isIDN5VcpWaw
   QjlPK2QF9XHxLMq5mO/XbD8YRlZAmIu3lpxAPeq0QPpgRNt9WbRHPz+EY
   KJOU3Kkir92KSawOqEtodlyFDVP1kUOibd0AvGIFlOCwh01cVr2olIeT0
   v1HpYRXEFi4a7udlJc9BNroc15Hrq6W9gptoyBv1lx8gT2rIxkfBHPqeB
   ZctO+TcIy4RpmUIO7/cOPrEa2oUddwvB3bJQNFuRGJAPlMRJuGI9G8D8T
   ucGmhBEvJcnaX9RqK61xW4JS9Js5qaK7CstwZkCe3HJPcB3MUQmGARroA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="335406752"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="335406752"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:44:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="766805866"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="766805866"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.50]) ([10.254.213.50])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 03:44:31 -0800
Message-ID: <72947a6e-228c-9432-b6b1-2735b0975cb8@linux.intel.com>
Date: Fri, 10 Mar 2023 19:44:29 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc: baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 2/3] iommu/amd: Allocate page table using numa locality
 info
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
References: <20230310093130.6064-1-vasant.hegde@amd.com>
 <20230310093130.6064-3-vasant.hegde@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230310093130.6064-3-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/10 17:31, Vasant Hegde wrote:
> Allocate page table pages using IOMMU numa locality info. This optimizes
> page table walk by IOMMU.
> 
> Reviewed-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu.h     |  8 ++++++++
>   drivers/iommu/amd/io_pgtable.c    |  4 ++--
>   drivers/iommu/amd/io_pgtable_v2.c | 16 ++++++----------
>   3 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index c160a332ce33..916e888a941a 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -122,6 +122,14 @@ static inline int get_pci_sbdf_id(struct pci_dev *pdev)
>   	return PCI_SEG_DEVID_TO_SBDF(seg, devid);
>   }
>   
> +static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
> +{
> +	struct page *page;
> +
> +	page = alloc_pages_node(nid, gfp | GFP_ATOMIC | __GFP_ZERO, 0);

Out of curiosity, the caller has already input a gfp, why do you add
GFP_ATOMIC?

> +	return page ? page_address(page) : NULL;
> +}

Best regards,
baolu
