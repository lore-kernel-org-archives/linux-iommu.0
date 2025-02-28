Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE30D272920
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760162; cv=none; b=pcCPpyTxyaFyB9imFm/7jyEkPQ3Y5h2xz1wIVhlFvjoRVSpg/6/x2xCxvSuXusIVIcpJOsJ9PsTF9Af4VEWLNduReSnLI4gvAVAbxWM8b7C+u6BU52oAdpHM6Qlrqp/jaXI+jkCt/PNXL24D1I/nK82M5weHIcctb5IqGrtxYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760162; c=relaxed/simple;
	bh=vOo/Bo1/R1UBloB/ZIJslxn+qsT+sZuKVvLq3RgC1VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSnk6tH5kJl70yA+R2eeSA5O6l5FfxmNd5aSIkKVvF9swAz8kHMwwI66UvudA+ARWG9S361G1BreXD6rm2Itxl+X32q/Hbol/hlCMuoaNSA45Ar9OfM8dvEUojWV8n2O/KBdf6qwHwaWA32Y2McwFVLe//GpcmXOa5rk4oggN74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C1F1150C;
	Fri, 28 Feb 2025 08:29:35 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 291C03F5A1;
	Fri, 28 Feb 2025 08:29:19 -0800 (PST)
Message-ID: <2754908e-f345-43ca-9cb1-9300abe5d402@arm.com>
Date: Fri, 28 Feb 2025 16:29:17 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] iommu: Add private_data_owner to iommu_domain
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1740705776.git.nicolinc@nvidia.com>
 <45c03a1bc86528c9194589cc3a5afe3eb2a15c9e.1740705776.git.nicolinc@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <45c03a1bc86528c9194589cc3a5afe3eb2a15c9e.1740705776.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/02/2025 1:31 am, Nicolin Chen wrote:
> Steal two bits from the 32-bit "type" in struct iommu_domain to store a
> new tag for private data owned by either dma-iommu or iommufd.
> 
> Set the domain->private_data_owner in dma-iommu and iommufd. These will
> be used to replace the sw_msi function pointer.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h                | 7 ++++++-
>   drivers/iommu/dma-iommu.c            | 2 ++
>   drivers/iommu/iommufd/hw_pagetable.c | 3 +++
>   3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e93d2e918599..4f2774c08262 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -209,8 +209,13 @@ struct iommu_domain_geometry {
>   #define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
>   #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
>   
> +#define IOMMU_DOMAIN_DATA_OWNER_NONE (0U)
> +#define IOMMU_DOMAIN_DATA_OWNER_DMA (1U)
> +#define IOMMU_DOMAIN_DATA_OWNER_IOMMUFD (2U)
> +
>   struct iommu_domain {
> -	unsigned type;
> +	u32 type : 30;
> +	u32 private_data_owner : 2;
>   	const struct iommu_domain_ops *ops;
>   	const struct iommu_dirty_ops *dirty_ops;
>   	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 94263ed2c564..78915d74e8fa 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -403,6 +403,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>   
>   	mutex_init(&domain->iova_cookie->mutex);
>   	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
> +	domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_DMA;
>   	return 0;
>   }
>   
> @@ -435,6 +436,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>   	cookie->msi_iova = base;
>   	domain->iova_cookie = cookie;
>   	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
> +	domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_DMA;

This doesn't help all that much when it can still be called on any old 
unmanaged domain and silently overwrite whatever the previous user 
thought they owned...

And really the "owner" of MSI cookies is VFIO, it just happens that all 
the code for them still lives in iommu-dma because it was written to 
piggyback off the same irqchip hooks. TBH I've long been keen on 
separating them further from "real" IOVA cookies, and generalising said 
hooks really removes any remaining reason to keep the implementations 
tied together at all, should they have cause to diverge further (e.g. 
with makign the MSI cookie window programmable). What I absolutely want 
to avoid is a notion of having two types of MSI-mapping cookies, one of 
which is two types of MSI-mapping cookies.

Hopefully that is all clear in the patch I proposed.

Thanks,
Robin.

>   	return 0;
>   }
>   EXPORT_SYMBOL(iommu_get_msi_cookie);
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 7de6e914232e..5640444de475 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -157,6 +157,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   		}
>   	}
>   	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
> +	hwpt->domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_IOMMUFD;
>   
>   	/*
>   	 * Set the coherency mode before we do iopt_table_add_domain() as some
> @@ -253,6 +254,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>   	}
>   	hwpt->domain->owner = ops;
>   	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
> +	hwpt->domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_IOMMUFD;
>   
>   	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
>   		rc = -EINVAL;
> @@ -310,6 +312,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
>   	}
>   	hwpt->domain->owner = viommu->iommu_dev->ops;
>   	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
> +	hwpt->domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_IOMMUFD;
>   
>   	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
>   		rc = -EINVAL;
