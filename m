From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 3/3] videobuf2: replace a layering violation with
 dma_map_resource
Date: Mon, 14 Jan 2019 13:42:26 +0100
Message-ID: <6f8892ac-c2aa-10df-c74f-ba032bf75160@samsung.com>
References: <20190111181731.11782-1-hch@lst.de>
 <CGME20190111181812epcas2p1eeb68a16701631513eaf297073f7299f@epcas2p1.samsung.com>
 <20190111181731.11782-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190111181731.11782-4-hch@lst.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, Pawel Osciak <pawel@osciak.com>, Kyungmin Park <kyungmin.park@samsung.com>, =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Christoph,

On 2019-01-11 19:17, Christoph Hellwig wrote:
> vb2_dc_get_userptr pokes into arm direct mapping details to get the
> resemblance of a dma address for a a physical address that does is
> not backed by a page struct.  Not only is this not portable to other
> architectures with dma direct mapping offsets, but also not to uses
> of IOMMUs of any kind.  Switch to the proper dma_map_resource /
> dma_unmap_resource interface instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

There are checks for IOMMU presence in other places in vb2-dma-contig,
so it was used only when no IOMMU is available, but I agree that the
hacky code should be replaced by a generic code if possible.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

V4L2 pipeline works fine on older Exynos-based boards with CMA and IOMMU
disabled.

> ---
>  .../common/videobuf2/videobuf2-dma-contig.c   | 41 ++++---------------
>  1 file changed, 9 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index aff0ab7bf83d..82389aead6ed 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -439,42 +439,14 @@ static void vb2_dc_put_userptr(void *buf_priv)
>  				set_page_dirty_lock(pages[i]);
>  		sg_free_table(sgt);
>  		kfree(sgt);
> +	} else {
> +		dma_unmap_resource(buf->dev, buf->dma_addr, buf->size,
> +				   buf->dma_dir, 0);
>  	}
>  	vb2_destroy_framevec(buf->vec);
>  	kfree(buf);
>  }
>  
> -/*
> - * For some kind of reserved memory there might be no struct page available,
> - * so all that can be done to support such 'pages' is to try to convert
> - * pfn to dma address or at the last resort just assume that
> - * dma address == physical address (like it has been assumed in earlier version
> - * of videobuf2-dma-contig
> - */
> -
> -#ifdef __arch_pfn_to_dma
> -static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
> -{
> -	return (dma_addr_t)__arch_pfn_to_dma(dev, pfn);
> -}
> -#elif defined(__pfn_to_bus)
> -static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
> -{
> -	return (dma_addr_t)__pfn_to_bus(pfn);
> -}
> -#elif defined(__pfn_to_phys)
> -static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
> -{
> -	return (dma_addr_t)__pfn_to_phys(pfn);
> -}
> -#else
> -static inline dma_addr_t vb2_dc_pfn_to_dma(struct device *dev, unsigned long pfn)
> -{
> -	/* really, we cannot do anything better at this point */
> -	return (dma_addr_t)(pfn) << PAGE_SHIFT;
> -}
> -#endif
> -
>  static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
>  	unsigned long size, enum dma_data_direction dma_dir)
>  {
> @@ -528,7 +500,12 @@ static void *vb2_dc_get_userptr(struct device *dev, unsigned long vaddr,
>  		for (i = 1; i < n_pages; i++)
>  			if (nums[i-1] + 1 != nums[i])
>  				goto fail_pfnvec;
> -		buf->dma_addr = vb2_dc_pfn_to_dma(buf->dev, nums[0]);
> +		buf->dma_addr = dma_map_resource(buf->dev,
> +				__pfn_to_phys(nums[0]), size, buf->dma_dir, 0);
> +		if (dma_mapping_error(buf->dev, buf->dma_addr)) {
> +			ret = -ENOMEM;
> +			goto fail_pfnvec;
> +		}
>  		goto out;
>  	}
>  

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
