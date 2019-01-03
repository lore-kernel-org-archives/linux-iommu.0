From: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] dma-mapping: remove unused attrs parameter to
 dma_common_get_sgtable
Date: Thu, 3 Jan 2019 09:54:58 -0800 (PST)
Message-ID: <alpine.DEB.2.10.1901030954240.800@sstabellini-ThinkPad-X260>
References: <20190103082908.9988-1-yehs2007@zoho.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103082908.9988-1-yehs2007@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huaisheng Ye <yehs2007@zoho.com>
Cc: hch@lst.de, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org, m.szyprowski@samsung.com, robin.murphy@arm.com, linux-kernel@vger.kernel.org, chengnt@lenovo.com, xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org, Huaisheng Ye <yehs1@lenovo.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, 3 Jan 2019, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> dma_common_get_sgtable has parameter attrs which is not used at all.
> Remove it.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

FYI the patch doesn't apply cleanly to master.


> ---
>  drivers/xen/swiotlb-xen.c   | 2 +-
>  include/linux/dma-mapping.h | 5 ++---
>  kernel/dma/mapping.c        | 3 +--
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 2a7f545..2dc17a5 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -697,7 +697,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>  							   handle, size, attrs);
>  	}
>  #endif
> -	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
> +	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size);
>  }
>  
>  static int xen_swiotlb_mapping_error(struct device *dev, dma_addr_t dma_addr)
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d327bdd..bbfad44 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -483,7 +483,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
>  
>  int
>  dma_common_get_sgtable(struct device *dev, struct sg_table *sgt, void *cpu_addr,
> -		dma_addr_t dma_addr, size_t size, unsigned long attrs);
> +		dma_addr_t dma_addr, size_t size);
>  
>  static inline int
>  dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
> @@ -495,8 +495,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
>  	if (ops->get_sgtable)
>  		return ops->get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
>  					attrs);
> -	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
> -			attrs);
> +	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
>  }
>  
>  #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 58dec7a..6b33f10 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -202,8 +202,7 @@ void dmam_release_declared_memory(struct device *dev)
>   * Create scatter-list for the already allocated DMA buffer.
>   */
>  int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
> -		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		 unsigned long attrs)
> +		 void *cpu_addr, dma_addr_t dma_addr, size_t size)
>  {
>  	struct page *page;
>  	int ret;
> -- 
> 1.8.3.1
> 
> 
