From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/9] iommu/dma-iommu: Add function to flush any cached not
 present IOTLB entries
Date: Tue, 16 Apr 2019 15:00:59 +0100
Message-ID: <82ce70dc-b370-3bb0-bce8-2d32db4d6a0d@arm.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
 <20190411184741.27540-3-tmurphy@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411184741.27540-3-tmurphy@arista.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Murphy <tmurphy@arista.com>, iommu@lists.linux-foundation.org
Cc: dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Clark <robdclark@gmail.com>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 11/04/2019 19:47, Tom Murphy wrote:
> Both the AMD and Intel drivers can cache not present IOTLB entries. To
> convert these drivers to the dma-iommu api we need a generic way to
> flush the NP cache. IOMMU drivers which have a NP cache can implement
> the .flush_np_cache function in the iommu ops struct. I will implement
> .flush_np_cache for both the Intel and AMD drivers in later patches.
> 
> The Intel np-cache is described here:
> https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf#G7.66452
> 
> And the AMD np-cache is described here:
> https://developer.amd.com/wordpress/media/2012/10/34434-IOMMU-Rev_1.26_2-11-09.pdf#page=63

Callers expect that once iommu_map() returns successfully, the mapping 
exists and is ready to use - if these drivers aren't handling this 
flushing internally, how are they not already broken for e.g. VFIO?

> Signed-off-by: Tom Murphy <tmurphy@arista.com>
> ---
>   drivers/iommu/dma-iommu.c | 10 ++++++++++
>   include/linux/iommu.h     |  3 +++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 1a4bff3f8427..cc5da30d6e58 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -594,6 +594,9 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   			< size)
>   		goto out_free_sg;
>   
> +	if (domain->ops->flush_np_cache)
> +		domain->ops->flush_np_cache(domain, iova, size);
> +

This doesn't scale. At the very least, it should be internal to 
iommu_map() and exposed to be the responsibility of every external 
caller now and forever after.

That said, I've now gone and looked and AFAICS both the Intel and AMD 
drivers *do* appear to handle this in their iommu_ops::map callbacks 
already, so the whole patch does indeed seem bogus. What might be 
worthwhile, though, is seeing if there's scope to refactor those drivers 
to push some of it into an iommu_ops::iotlb_sync_map callback to 
optimise the flushing for multi-page mappings.

Robin.

>   	*handle = iova;
>   	sg_free_table(&sgt);
>   	return pages;
> @@ -652,6 +655,10 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
>   		iommu_dma_free_iova(cookie, iova, size);
>   		return DMA_MAPPING_ERROR;
>   	}
> +
> +	if (domain->ops->flush_np_cache)
> +		domain->ops->flush_np_cache(domain, iova, size);
> +
>   	return iova + iova_off;
>   }
>   
> @@ -812,6 +819,9 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	if (iommu_map_sg_atomic(domain, iova, sg, nents, prot) < iova_len)
>   		goto out_free_iova;
>   
> +	if (domain->ops->flush_np_cache)
> +		domain->ops->flush_np_cache(domain, iova, iova_len);
> +
>   	return __finalise_sg(dev, sg, nents, iova);
>   
>   out_free_iova:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 75559918d9bd..47ff8d731d6a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -173,6 +173,7 @@ struct iommu_resv_region {
>    * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
>    * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
>    *            queue
> + * @flush_np_cache: Flush the non present entry cache
>    * @iova_to_phys: translate iova to physical address
>    * @add_device: add device to iommu grouping
>    * @remove_device: remove device from iommu grouping
> @@ -209,6 +210,8 @@ struct iommu_ops {
>   				unsigned long iova, size_t size);
>   	void (*iotlb_sync_map)(struct iommu_domain *domain);
>   	void (*iotlb_sync)(struct iommu_domain *domain);
> +	void (*flush_np_cache)(struct iommu_domain *domain,
> +				unsigned long iova, size_t size);
>   	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
>   	int (*add_device)(struct device *dev);
>   	void (*remove_device)(struct device *dev);
> 
