Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA061C32
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680097215; x=1711633215;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oryWoffr6NmZHUcVdOnsY708PPCN5mZHMc+qZtLTXVs=;
  b=MRGsOmhMtW1oXiN+LXlpZmPya3/zpCZtyk48pTRNJ4sdfJoKF9BN3eJf
   FPe9fdrDbNVatR8rw/XcediSpVDkY/7088WNxgs/XakuAjEdhQs0Qqz5R
   w9h4W7fmCF+v37RpDZLA1Rn/mDKTBjNqDHwnAr5HsrtaPMtvkjMPUakVG
   4Ko2/EeV/47dCXJTOIf3hBfW4S6GcXVPpuwl3yphC48GZHWylkRiREeH1
   L7B7XewnDWuRgliKNlSFbjC1uXvOfmauJA198gtiESSN6rsfV6dV/8JNF
   SS2wpn8vUXTwf/HTJUZsUjfnitOfJUboB4JNR+BIIE2zJKDUh+oLov+Xt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="343302841"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343302841"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:40:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="858497030"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="858497030"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.217]) ([10.254.214.217])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:40:13 -0700
Message-ID: <2bc952b2-311a-cac2-d9ba-223a124bdf74@linux.intel.com>
Date: Wed, 29 Mar 2023 21:40:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH 4/4] iommu/vt-d: Replace BUG()/BUG_ON() with
 WARN_ON/WARN_ON_ONCE()
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20230329124654.2698853-1-tina.zhang@intel.com>
 <20230329124654.2698853-5-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230329124654.2698853-5-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/3/29 20:46, Tina Zhang wrote:
> Remove legacy BUG()/BUG_ON() and turn them into WARN_ON/WARN_ON_ONCE()
> with errors.

Yes. WARN() is better than BUG().

Best regards,
baolu

> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/dmar.c  |  6 ++++--
>   drivers/iommu/intel/iommu.c | 39 ++++++++++++++++++++++++-------------
>   2 files changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 7c77a59889ea..39b0bad000ea 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -127,7 +127,8 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
>   	struct pci_dev *tmp;
>   	struct dmar_pci_notify_info *info;
>   
> -	BUG_ON(dev->is_virtfn);
> +	if (WARN_ON(dev->is_virtfn))
> +		return NULL;
>   
>   	/*
>   	 * Ignore devices that have a domain number higher than what can
> @@ -264,7 +265,8 @@ int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
>   						   get_device(dev));
>   				return 1;
>   			}
> -		BUG_ON(i >= devices_cnt);
> +		if (WARN_ON_ONCE(i >= devices_cnt))
> +			return -EINVAL;
>   	}
>   
>   	return 0;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 286bb17973a4..20f7a9b3a6a7 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -391,6 +391,14 @@ static inline int domain_pfn_supported(struct dmar_domain *domain,
>   	return !(addr_width < BITS_PER_LONG && pfn >> addr_width);
>   }
>   
> +static inline bool domain_pfn_range_valid(struct dmar_domain *domain,
> +					  unsigned long start_pfn,
> +					  unsigned long last_pfn)
> +{
> +	return (!domain_pfn_supported(domain, last_pfn)) ? false :
> +		(start_pfn > last_pfn) ? false : true;
> +}
> +
>   /*
>    * Calculate the Supported Adjusted Guest Address Widths of an IOMMU.
>    * Refer to 11.4.2 of the VT-d spec for the encoding of each bit of
> @@ -915,7 +923,8 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>   	int level = agaw_to_level(domain->agaw);
>   	int offset;
>   
> -	BUG_ON(!domain->pgd);
> +	if (WARN_ON_ONCE(!domain->pgd))
> +		return NULL;
>   
>   	if (!domain_pfn_supported(domain, pfn))
>   		/* Address beyond IOMMU's addressing capabilities. */
> @@ -1005,9 +1014,8 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
>   	unsigned int large_page;
>   	struct dma_pte *first_pte, *pte;
>   
> -	BUG_ON(!domain_pfn_supported(domain, start_pfn));
> -	BUG_ON(!domain_pfn_supported(domain, last_pfn));
> -	BUG_ON(start_pfn > last_pfn);
> +	if (WARN_ON_ONCE(!domain_pfn_range_valid(domain, start_pfn, last_pfn))
> +		return;
>   
>   	/* we don't need lock here; nobody else touches the iova range */
>   	do {
> @@ -1166,9 +1174,8 @@ static void dma_pte_clear_level(struct dmar_domain *domain, int level,
>   static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
>   			 unsigned long last_pfn, struct list_head *freelist)
>   {
> -	BUG_ON(!domain_pfn_supported(domain, start_pfn));
> -	BUG_ON(!domain_pfn_supported(domain, last_pfn));
> -	BUG_ON(start_pfn > last_pfn);
> +	if (WARN_ON_ONCE(!domain_pfn_range_valid(domain, start_pfn, last_pfn))
> +		return;
>   
>   	/* we don't need lock here; nobody else touches the iova range */
>   	dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
> @@ -1272,7 +1279,7 @@ static void __iommu_flush_context(struct intel_iommu *iommu,
>   			| DMA_CCMD_SID(source_id) | DMA_CCMD_FM(function_mask);
>   		break;
>   	default:
> -		BUG();
> +		WARN_ON_ONCE(1);
>   	}
>   	val |= DMA_CCMD_ICC;
>   
> @@ -1308,7 +1315,7 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
>   		val_iva = size_order | addr;
>   		break;
>   	default:
> -		BUG();
> +		WARN_ON_ONCE(1);
>   	}
>   	/* Note: set drain read/write */
>   #if 0
> @@ -1508,7 +1515,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>   	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
>   	u16 did = domain_id_iommu(domain, iommu);
>   
> -	BUG_ON(pages == 0);
> +	if (WARN_ON_ONCE(pages == 0))
> +		return;
>   
>   	if (ih)
>   		ih = 1 << 6;
> @@ -1930,7 +1938,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>   	pr_debug("Set context mapping for %02x:%02x.%d\n",
>   		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
>   
> -	BUG_ON(!domain->pgd);
> +	if (WARN_ON_ONCE(!domain->pgd))
> +		return -EINVAL;
>   
>   	spin_lock(&iommu->lock);
>   	ret = -ENOMEM;
> @@ -2183,7 +2192,8 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
>   	phys_addr_t pteval;
>   	u64 attr;
>   
> -	BUG_ON(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1));
> +	if (WARN_ON_ONCE(!domain_pfn_supported(domain, iov_pfn + nr_pages - 1)))
> +		return -EINVAL;
>   
>   	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
>   		return -EINVAL;
> @@ -4339,8 +4349,9 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
>   
>   	/* Cope with horrid API which requires us to unmap more than the
>   	   size argument if it happens to be a large-page mapping. */
> -	BUG_ON(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level,
> -			       GFP_ATOMIC));
> +	if (WARN_ON_ONCE(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level,
> +					 GFP_ATOMIC)))
> +		return 0;
>   
>   	if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
>   		size = VTD_PAGE_SIZE << level_to_offset_bits(level);

