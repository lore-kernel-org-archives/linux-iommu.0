From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] dma-debug: Check for drivers mapping invalid addresses
 in dma_map_single()
Date: Tue, 2 Oct 2018 15:01:42 +0100
Message-ID: <62816605-0cc9-3743-e98c-682bf7996c6c@arm.com>
References: <20181001215337.13358-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181001215337.13358-1-swboyd@chromium.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

On 01/10/18 22:53, Stephen Boyd wrote:
> I recently debugged a DMA mapping oops where a driver was trying to map
> a buffer returned from request_firmware() with dma_map_single(). Memory
> returned from request_firmware() is mapped into the vmalloc region and
> this isn't a valid region to map with dma_map_single() per the DMA
> documentation's "What memory is DMA'able?" section.
> 
> Unfortunately, we don't really check that in the DMA debugging code, so
> enabling DMA debugging doesn't help catch this problem. Let's add a new
> DMA debug function to check for a vmalloc address or an invalid virtual
> address and print a warning if this happens. This makes it a little
> easier to debug these sorts of problems, instead of seeing odd behavior
> or crashes when drivers attempt to map the vmalloc space for DMA.
> 
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Changes from v1:
>   * Update code to check for invalid virtual address too
>   * Rename function to debug_dma_map_single()
> 
>   include/linux/dma-debug.h   |  8 ++++++++
>   include/linux/dma-mapping.h |  1 +
>   kernel/dma/debug.c          | 16 ++++++++++++++++
>   3 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
> index a785f2507159..30213adbb6b9 100644
> --- a/include/linux/dma-debug.h
> +++ b/include/linux/dma-debug.h
> @@ -32,6 +32,9 @@ extern void dma_debug_add_bus(struct bus_type *bus);
>   
>   extern int dma_debug_resize_entries(u32 num_entries);
>   
> +extern void debug_dma_map_single(struct device *dev, const void *addr,
> +				 unsigned long len);
> +
>   extern void debug_dma_map_page(struct device *dev, struct page *page,
>   			       size_t offset, size_t size,
>   			       int direction, dma_addr_t dma_addr,
> @@ -103,6 +106,11 @@ static inline int dma_debug_resize_entries(u32 num_entries)
>   	return 0;
>   }
>   
> +static inline void debug_dma_map_single(struct device *dev, const void *addr,
> +					unsigned long len)
> +{
> +}
> +
>   static inline void debug_dma_map_page(struct device *dev, struct page *page,
>   				      size_t offset, size_t size,
>   				      int direction, dma_addr_t dma_addr,
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d23fc45c8208..99ccba66c06a 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -231,6 +231,7 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>   	dma_addr_t addr;
>   
>   	BUG_ON(!valid_dma_direction(dir));
> +	debug_dma_check_single(dev, ptr, size);

Ahem...

With that (and below) fixed so that it actually compiles,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   	addr = ops->map_page(dev, virt_to_page(ptr),
>   			     offset_in_page(ptr), size,
>   			     dir, attrs);
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index c007d25bee09..0f34bce82a62 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -1312,6 +1312,22 @@ static void check_sg_segment(struct device *dev, struct scatterlist *sg)
>   #endif
>   }
>   
> +void debug_dma_check_single(struct device *dev, const void *addr,
> +			    unsigned long len)
> +{
> +	if (unlikely(dma_debug_disabled()))
> +		return;
> +
> +	if (!virt_addr_valid(addr))
> +		err_printk(dev, NULL, "DMA-API: device driver maps memory from invalid area [addr=%p] [len=%lu]\n",
> +			   addr, len);
> +
> +	if (is_vmalloc_addr(addr))
> +		err_printk(dev, NULL, "DMA-API: device driver maps memory from vmalloc area [addr=%p] [len=%lu]\n",
> +			   addr, len);
> +}
> +EXPORT_SYMBOL(debug_dma_check_single);
> +
>   void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
>   			size_t size, int direction, dma_addr_t dma_addr,
>   			bool map_single)
> 
