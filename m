Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CB42F34
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 11:55:18 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF71F1474;
	Fri, 15 Jul 2022 04:55:18 -0700 (PDT)
Received: from [10.57.86.139] (unknown [10.57.86.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94ED63F73D;
	Fri, 15 Jul 2022 04:55:17 -0700 (PDT)
Message-ID: <3d30d93b-ec12-46b3-576b-c3ac8ebb799f@arm.com>
Date: Fri, 15 Jul 2022 12:55:12 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/6] iommu/amd: Initial support for AMD IOMMU v2 page
 table
Content-Language: en-GB
To: Vasant Hegde <vasant.hegde@amd.com>, joro@8bytes.org,
 iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com
References: <20220713053034.12061-1-vasant.hegde@amd.com>
 <20220713053034.12061-4-vasant.hegde@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220713053034.12061-4-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-07-13 06:30, Vasant Hegde wrote:
[...]
> +static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> +{
> +	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
> +	struct protection_domain *pdom = (struct protection_domain *)cookie;
> +	int ret;
> +
> +	pgtable->pgd = alloc_pgtable_page();
> +	if (!pgtable->pgd)
> +		return NULL;
> +
> +	ret = amd_iommu_domain_set_gcr3(&pdom->domain, 0, iommu_virt_to_phys(pgtable->pgd));
> +	if (ret)
> +		goto err_free_pgd;
> +
> +	pgtable->iop.ops.map          = iommu_v2_map_page;
> +	pgtable->iop.ops.unmap        = iommu_v2_unmap_page;

It would be good to use this opportunity to convert AMD over to 
map_pages/unmap_pages - not only for the future goal of removing 
map/unmap (it's not worth maintaining two interfaces where one is a 
trivial subset of the other), but also since it should be appreciably 
more efficient for you in practice, especially for v2 with the more 
limited set of basic page sizes.

Cheers,
Robin.

> +	pgtable->iop.ops.iova_to_phys = iommu_v2_iova_to_phys;
> +
> +	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2,
> +	cfg->ias           = IOMMU_IN_ADDR_BIT_SIZE,
> +	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE,
> +	cfg->tlb           = &v2_flush_ops;
> +
> +	return &pgtable->iop;
> +
> +err_free_pgd:
> +	free_pgtable_page(pgtable->pgd);
> +
> +	return NULL;
> +}
