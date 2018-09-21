From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] dma-debug: Check for drivers mapping vmalloc addresses
Date: Fri, 21 Sep 2018 12:09:50 +0100
Message-ID: <ef22f1b4-a2c5-25a4-451e-9191b3579a26@arm.com>
References: <20180920223559.136915-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920223559.136915-1-swboyd@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Hi Stephen,

On 20/09/18 23:35, Stephen Boyd wrote:
> I recently debugged a DMA mapping oops where a driver was trying to map
> a buffer returned from request_firmware() with dma_map_single(). Memory
> returned from request_firmware() is mapped into the vmalloc region and
> this isn't a valid region to map with dma_map_single() per the DMA
> documentation's "What memory is DMA'able?" section.
> 
> Unfortunately, we don't really check that in the DMA debugging code, so
> enabling DMA debugging doesn't help catch this problem. Let's add a new
> DMA debug function to check for a vmalloc address and print a warning if
> this happens. This makes it a little easier to debug these sorts of
> problems, instead of seeing odd behavior or crashes when drivers attempt
> to map the vmalloc space for DMA.

Good idea!

> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   include/linux/dma-debug.h   |  8 ++++++++
>   include/linux/dma-mapping.h |  1 +
>   kernel/dma/debug.c          | 12 ++++++++++++
>   3 files changed, 21 insertions(+)

However I can't help thinking this looks a little heavyweight for a 
single specific check. It seems like it would be enough to simply pass 
the VA as an extra argument to debug_dma_map_page(), since we already 
have the map_single argument which would indicate when it's valid. What 
do you reckon?

Robin.

> diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
> index a785f2507159..5aec2ca8a426 100644
> --- a/include/linux/dma-debug.h
> +++ b/include/linux/dma-debug.h
> @@ -32,6 +32,9 @@ extern void dma_debug_add_bus(struct bus_type *bus);
>   
>   extern int dma_debug_resize_entries(u32 num_entries);
>   
> +extern void debug_dma_check_vmalloc(struct device *dev, const void *addr,
> +				    unsigned long len);
> +
>   extern void debug_dma_map_page(struct device *dev, struct page *page,
>   			       size_t offset, size_t size,
>   			       int direction, dma_addr_t dma_addr,
> @@ -103,6 +106,11 @@ static inline int dma_debug_resize_entries(u32 num_entries)
>   	return 0;
>   }
>   
> +static inline void debug_dma_check_vmalloc(struct device *dev, const void *addr,
> +					   unsigned long len)
> +{
> +}
> +
>   static inline void debug_dma_map_page(struct device *dev, struct page *page,
>   				      size_t offset, size_t size,
>   				      int direction, dma_addr_t dma_addr,
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index eafd6f318e78..a0e67fd5433c 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -232,6 +232,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>   	dma_addr_t addr;
>   
>   	BUG_ON(!valid_dma_direction(dir));
> +	debug_dma_check_vmalloc(dev, ptr, size);
>   	addr = ops->map_page(dev, virt_to_page(ptr),
>   			     offset_in_page(ptr), size,
>   			     dir, attrs);
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index c007d25bee09..7ee7978868d4 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -1312,6 +1312,18 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
>   #endif
>   }
>   
> +void debug_dma_check_vmalloc(struct device *dev, const void *addr,
> +		unsigned long len)
> +{
> +	if (unlikely(dma_debug_disabled()))
> +		return;
> +
> +	if (is_vmalloc_addr(addr))
> +		err_printk(dev, NULL, "DMA-API: device driver maps memory from vmalloc area [addr=%p] [len=%lu]\n",
> +			   addr, len);
> +}
> +EXPORT_SYMBOL(debug_dma_check_vmalloc);
> +
>   void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
>   			size_t size, int direction, dma_addr_t dma_addr,
>   			bool map_single)
> 
