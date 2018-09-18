From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 2/6] iommu/dma: Add support for non-strict mode
Date: Tue, 18 Sep 2018 18:10:07 +0100
Message-ID: <20180918171007.GJ16498@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
 <0a891cec4bb164f8cf2f57c753791a7d1f5f1d81.1536935328.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0a891cec4bb164f8cf2f57c753791a7d1f5f1d81.1536935328.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Fri, Sep 14, 2018 at 03:30:20PM +0100, Robin Murphy wrote:
> From: Zhen Lei <thunder.leizhen@huawei.com>
> 
> 1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
>    capable call domain->ops->flush_iotlb_all to flush TLB.
> 2. During the iommu domain initialization phase, base on domain->non_strict
>    field to check whether non-strict mode is supported or not. If so, call
>    init_iova_flush_queue to register iovad->flush_cb callback.
> 3. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
>    -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
>    put off iova freeing, and omit iommu_tlb_sync operation.

Hmm, this is basically just a commentary on the code. Please could you write
it more in terms of the problem that's being solved?

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> [rm: convert raw boolean to domain attribute]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 29 ++++++++++++++++++++++++++++-
>  include/linux/iommu.h     |  1 +
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 511ff9a1d6d9..092e6926dc3c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -55,6 +55,9 @@ struct iommu_dma_cookie {
>  	};
>  	struct list_head		msi_page_list;
>  	spinlock_t			msi_lock;
> +
> +	/* Only be assigned in non-strict mode, otherwise it's NULL */
> +	struct iommu_domain		*domain;
>  };
>  
>  static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
> @@ -257,6 +260,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
>  	return ret;
>  }
>  
> +static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
> +{
> +	struct iommu_dma_cookie *cookie;
> +	struct iommu_domain *domain;
> +
> +	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
> +	domain = cookie->domain;
> +
> +	domain->ops->flush_iotlb_all(domain);

Can we rely on this function pointer being non-NULL? I think it would
be better to call iommu_flush_tlb_all(cookie->domain) instead.

> +}
> +
>  /**
>   * iommu_dma_init_domain - Initialise a DMA mapping domain
>   * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> @@ -275,6 +289,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iova_domain *iovad = &cookie->iovad;
>  	unsigned long order, base_pfn, end_pfn;
> +	int attr = 1;

Do we actually need to initialise this?

Will
