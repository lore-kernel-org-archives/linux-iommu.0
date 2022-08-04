Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526057C
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 17:55:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26E7B1063;
	Thu,  4 Aug 2022 10:55:41 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 044CE3F73B;
	Thu,  4 Aug 2022 10:55:39 -0700 (PDT)
Message-ID: <e08386bc-530d-9caf-1130-d952942a6736@arm.com>
Date: Thu, 4 Aug 2022 18:55:34 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] iommu/virtio: Implement viommu_{un,}map_pages
Content-Language: en-GB
To: Erik Kurzinger <ekurzinger@nvidia.com>, iommu@lists.linux.dev
Cc: "Vaibhav Vyas (SW)" <vavyas@nvidia.com>
References: <39a54565-0f33-b807-5983-e7a8e92b927a@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <39a54565-0f33-b807-5983-e7a8e92b927a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/08/2022 9:04 pm, Erik Kurzinger wrote:
> Because virtio-iommu currently only implements the map and unmap iommu
> domain ops, when mapping a block of memory a separate mapping will be
> created for each page. Since the number of DMA mappings which may exist
> on the physical IOMMU is limited (either the user's locked memory limit
> for memory-backed mappings or else the 64K limit imposed by the type1
> driver), this can become problematic for larger blocks of memory.
> 
> To avoid such issues, we provide implementations for the map_pages and
> unmap_pages iommu domain ops. This allow us to only use a single
> mapping, even for multiple-page blocks of memory. These new functions
> will simply defer to the existing map and unmap functions, with the size
> computed from the page size and page count.

FYI, an equivalent patch is already queued up for 5.20/6.0:

https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=virtio

Robin.

> ---
>   drivers/iommu/virtio-iommu.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 25be4b822aa0..37f11a799f2a 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -827,6 +827,18 @@ static int viommu_map(struct iommu_domain *domain, 
> unsigned long iova,
>       return ret;
>   }
> 
> +static int viommu_map_pages(struct iommu_domain *domain,
> +                unsigned long iova, phys_addr_t paddr,
> +                size_t pgsize, size_t pgcount,
> +                int prot, gfp_t gfp, size_t *mapped)
> +{
> +    u64 size = pgsize * pgcount;
> +    int ret = viommu_map(domain, iova, paddr, size, prot, gfp);
> +    if (!ret && mapped)
> +        *mapped = size;
> +    return ret;
> +}
> +
>   static size_t viommu_unmap(struct iommu_domain *domain, unsigned long 
> iova,
>                  size_t size, struct iommu_iotlb_gather *gather)
>   {
> @@ -854,6 +866,15 @@ static size_t viommu_unmap(struct iommu_domain 
> *domain, unsigned long iova,
>       return ret ? 0 : unmapped;
>   }
> 
> +static size_t viommu_unmap_pages(struct iommu_domain *domain,
> +                 unsigned long iova,
> +                 size_t pgsize, size_t pgcount,
> +                 struct iommu_iotlb_gather *gather)
> +{
> +    u64 size = pgsize * pgcount;
> +    return viommu_unmap(domain, iova, size, gather);
> +}
> +
>   static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
>                          dma_addr_t iova)
>   {
> @@ -1019,7 +1040,9 @@ static struct iommu_ops viommu_ops = {
>       .default_domain_ops = &(const struct iommu_domain_ops) {
>           .attach_dev        = viommu_attach_dev,
>           .map            = viommu_map,
> +        .map_pages        = viommu_map_pages,
>           .unmap            = viommu_unmap,
> +        .unmap_pages        = viommu_unmap_pages,
>           .iova_to_phys        = viommu_iova_to_phys,
>           .iotlb_sync        = viommu_iotlb_sync,
>           .free            = viommu_domain_free,
