Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE98EC7
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 02:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668393197; x=1699929197;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ti7dzhWxXXlzyc1zHT2IUpppeX2lCqGTJzi+9QSifoI=;
  b=NmAZ8r177Rn6OlBj3ASVfu9Uy/IDic/A3J0/Mis+j7EHx3xJqkgH09ws
   CSyYJ2Px2u3QQLT9QezNG+A9/PFO9YYy7IaygagY51f4CjgRPE+sRBe/6
   /CUc88mtA+aC1UDHF+5qm97JnaozFsaVDUHXKSBzR6/7y+NO+QS+QOpFI
   YsDpw9CZjLOlG8vY7HH4ZwHTkUGTwRvPt+470cXfxFI6nYezgaZihxdhk
   4m+7SQJcct0Z27l9VAjigj23H3jitq+D7gfGlc+g82hfOALttzQkZ+Hj/
   aUTYSy/zedBBMOteQ36m/vHPs+hv0ERinl0cvik0ZZTf9MKUzi44JnRxC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="291583094"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="291583094"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 18:33:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="669462648"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="669462648"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 13 Nov 2022 18:33:15 -0800
Message-ID: <ca467b3b-cf4a-caea-99eb-9d9f47819c98@linux.intel.com>
Date: Mon, 14 Nov 2022 10:26:21 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Present Access bit for IOVA in FL non-leaf
 paging entries
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20221113010324.1094483-1-tina.zhang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221113010324.1094483-1-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/22 9:03 AM, Tina Zhang wrote:
> The A/D bits are presented for IOVA over first level(FL) usage for both
> kernel DMA (i.e, domain typs is IOMMU_DOMAIN_DMA) and user space DMA
> usage (i.e., domain type is IOMMU_DOMAIN_UNMANAGED).
> 
> Preseting A bit in FL requires to present the bit in very related paging
> entries, including the non-leaf ones. Otherwise, DMA fault may come out.
> For example, in a case of ECAP_REG.SMPWC==0, the DMA fault would be
> "SM: A/D bit update needed in first-level entry when set up in no
> snoop".
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>

Thanks for this patch.

Fixes: 289b3b005cb9 ("iommu/vt-d: Preset A/D bits for user space DMA usage")

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 48cdcd0a5cf3..996a8b5ee5ee 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -959,11 +959,9 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>   
>   			domain_flush_cache(domain, tmp_page, VTD_PAGE_SIZE);
>   			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
> -			if (domain_use_first_level(domain)) {
> -				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
> -				if (iommu_is_dma_domain(&domain->domain))
> -					pteval |= DMA_FL_PTE_ACCESS;
> -			}
> +			if (domain_use_first_level(domain))
> +				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US | DMA_FL_PTE_ACCESS;
> +
>   			if (cmpxchg64(&pte->val, 0ULL, pteval))
>   				/* Someone else set it while we were thinking; use theirs. */
>   				free_pgtable_page(tmp_page);
