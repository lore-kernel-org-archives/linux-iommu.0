Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6A15C6
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680233117; x=1711769117;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8TnRlIXjE2KdNSmhj7IX8P8JxUT2nkmGg69j0bKXYhw=;
  b=VInlU2yCVjJiX0pASYwoCke5BkCX/BcC4MO0O+tFEN77gey/sVjHAIR0
   qtUKLQU0eQvFwAnL2JaEuuGRQVTAsctX/J7xLW5omDhf3WA1WoM95j42Q
   yC1slZE2WiunLb5WTqxsYVerZp0Xa1fGZoiLxTqR/V4h3ODGBHZKHTfAX
   BtEYsjI1v3wHya5V/RiFm7oGWIJs+IKwrCelNZVki+pPWTHcOgnQ5Z3uh
   bQ9TvkI9kJgLRC+cVnjnuX0w2djPSqdYFEGaq8iz2Cbc27KMYYE0zte/u
   tos4XVLXlgDORT5E9j8oY+abSPU4hnd+k3lwU5uESsuInPYu0hRTmJdVv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="406348232"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="406348232"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 20:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="1014675211"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="1014675211"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 30 Mar 2023 20:25:03 -0700
Message-ID: <3ac862db-297b-068b-743d-18730ac3002b@linux.intel.com>
Date: Fri, 31 Mar 2023 11:25:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 4/7] iommu/vt-d: Remove BUG_ON when domain->pgd is NULL
Content-Language: en-US
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20230331024236.2716001-1-tina.zhang@intel.com>
 <20230331024236.2716001-5-tina.zhang@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230331024236.2716001-5-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/23 10:42 AM, Tina Zhang wrote:
> When performing domain_context_mapping or searching dma-pte of a pfn,
> with invalid domain page table directory address, which is unexpected,
> shouldn't crash kernel. Therefore, using if() instead of BUG_ON.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index de7fe7dcbc5c..e1881d48c2aa 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -915,10 +915,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>   	int level = agaw_to_level(domain->agaw);
>   	int offset;
>   
> -	BUG_ON(!domain->pgd);
> -
> -	if (!domain_pfn_supported(domain, pfn))
> -		/* Address beyond IOMMU's addressing capabilities. */
> +	if (unlikely(!domain->pgd || !domain_pfn_supported(domain, pfn)))
>   		return NULL;
>   
>   	parent = domain->pgd;
> @@ -1927,6 +1924,9 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>   	struct context_entry *context;
>   	int ret;
>   
> +	if (unlikely(!domain->pgd))
> +		return -EINVAL;
> +
>   	WARN_ON(did == 0);
>   
>   	if (hw_pass_through && domain_type_is_si(domain))
> @@ -1935,8 +1935,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>   	pr_debug("Set context mapping for %02x:%02x.%d\n",
>   		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
>   
> -	BUG_ON(!domain->pgd);
> -
>   	spin_lock(&iommu->lock);
>   	ret = -ENOMEM;
>   	context = iommu_context_addr(iommu, bus, devfn, 1);

I'd suggest to remove all checks for domain->pgd.

If a domain has map/unmap ops, it should always have its own page table
(a.k.a. domain->pgd). Hence the domain->pgd check is unnecessary.

Best regards,
baolu
