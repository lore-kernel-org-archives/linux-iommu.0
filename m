From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] dma-coherent: Change the bitmap APIs
Date: Thu, 31 May 2018 18:38:25 +0100
Message-ID: <8ef2eacf-97af-3449-c3ef-c64516ee05ea@arm.com>
References: <c5765cf69bf222757463ba2653ac760b42b785e6.1527745258.git.baolin.wang@linaro.org>
	<892fabb55ebe7bb35aa3f0be03ee3f93132b7acc.1527745258.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <892fabb55ebe7bb35aa3f0be03ee3f93132b7acc.1527745258.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 31/05/18 06:55, Baolin Wang wrote:
> The device coherent memory uses the bitmap helper functions, which take an
> order of PAGE_SIZE, that means the pages size is always a power of 2 as the
> allocation region. For Example, allocating 33 MB from a 33 MB dma_mem region
> requires 64MB free memory in that region.
> 
> Thus we can change to use bitmap_find_next_zero_area()/bitmap_set()/
> bitmap_clear() to present the allocation coherent memory, and reduce the
> allocation granularity to be one PAGE_SIZE.
> 
> Moreover from Arnd's description:
> "I believe that bitmap_allocate_region() was chosen here because it is
> more efficient than bitmap_find_next_zero_area(), at least that is the
> explanation given in https://en.wikipedia.org/wiki/Buddy_memory_allocation.
> 
> It's quite possible that we don't actually care about efficiency of
> dma_alloc_*() since a) it's supposed to be called very rarely, and
> b) the overhead of accessing uncached memory is likely higher than the
> search through a relatively small bitmap".
> 
> Thus I think we can convert to change the allocation granularity to be
> one PAGE_SIZE replacing with new bitmap APIs, which will not cause
> efficiency issue.

To quote the DMA API docs:

   "The CPU virtual address and the DMA address are both
    guaranteed to be aligned to the smallest PAGE_SIZE order which
    is greater than or equal to the requested size.  This invariant
    exists (for example) to guarantee that if you allocate a chunk
    which is smaller than or equal to 64 kilobytes, the extent of the
    buffer you receive will not cross a 64K boundary."

Now obviously there's a point above which that stops being practical, 
but it's probably safe to assume that a device asking for a 
multi-megabyte buffer doesn't actually have stringent boundary 
requirements either. For smaller sizes, though, it definitely can 
matter. At the very least up to 64KB, and probably up as far as 
MAX_ORDER-size requests, we need to preserve the existing behaviour or 
something, somewhere, will break.

Robin.

> Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>   drivers/base/dma-coherent.c |   54 +++++++++++++++++++++++--------------------
>   include/linux/dma-mapping.h |    6 ++---
>   2 files changed, 32 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
> index ce19832..4131540 100644
> --- a/drivers/base/dma-coherent.c
> +++ b/drivers/base/dma-coherent.c
> @@ -143,34 +143,31 @@ void *dma_mark_declared_memory_occupied(struct device *dev,
>   					dma_addr_t device_addr, size_t size)
>   {
>   	struct dma_coherent_mem *mem = dev->dma_mem;
> -	int order = get_order(size);
>   	unsigned long flags;
> -	int pos, err;
> -
> -	size += device_addr & ~PAGE_MASK;
> +	int start_bit, nbits;
>   
>   	if (!mem)
>   		return ERR_PTR(-EINVAL);
>   
> +	size += device_addr & ~PAGE_MASK;
> +	nbits = (size + (1UL << PAGE_SHIFT) - 1) >> PAGE_SHIFT;
> +
>   	spin_lock_irqsave(&mem->spinlock, flags);
> -	pos = PFN_DOWN(device_addr - dma_get_device_base(dev, mem));
> -	err = bitmap_allocate_region(mem->bitmap, pos, order);
> -	if (!err)
> -		mem->avail -= 1 << order;
> +	start_bit = PFN_DOWN(device_addr - dma_get_device_base(dev, mem));
> +	bitmap_set(mem->bitmap, start_bit, nbits);
> +	mem->avail -= nbits;
>   	spin_unlock_irqrestore(&mem->spinlock, flags);
>   
> -	if (err != 0)
> -		return ERR_PTR(err);
> -	return mem->virt_base + (pos << PAGE_SHIFT);
> +	return mem->virt_base + (start_bit << PAGE_SHIFT);
>   }
>   EXPORT_SYMBOL(dma_mark_declared_memory_occupied);
>   
>   static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
>   		ssize_t size, dma_addr_t *dma_handle)
>   {
> -	int order = get_order(size);
> +	int nbits = (size + (1UL << PAGE_SHIFT) - 1) >> PAGE_SHIFT;
>   	unsigned long flags;
> -	int pageno;
> +	int start_bit, end_bit;
>   	void *ret;
>   
>   	spin_lock_irqsave(&mem->spinlock, flags);
> @@ -178,16 +175,22 @@ static void *__dma_alloc_from_coherent(struct dma_coherent_mem *mem,
>   	if (unlikely(size > (mem->avail << PAGE_SHIFT)))
>   		goto err;
>   
> -	pageno = bitmap_find_free_region(mem->bitmap, mem->size, order);
> -	if (unlikely(pageno < 0))
> +	start_bit = 0;
> +	end_bit = mem->size;
> +
> +	start_bit = bitmap_find_next_zero_area(mem->bitmap, end_bit, start_bit,
> +					       nbits, 0);
> +	if (start_bit >= end_bit)
>   		goto err;
>   
> +	bitmap_set(mem->bitmap, start_bit, nbits);
> +
>   	/*
>   	 * Memory was found in the coherent area.
>   	 */
> -	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
> -	ret = mem->virt_base + (pageno << PAGE_SHIFT);
> -	mem->avail -= 1 << order;
> +	*dma_handle = mem->device_base + (start_bit << PAGE_SHIFT);
> +	ret = mem->virt_base + (start_bit << PAGE_SHIFT);
> +	mem->avail -= nbits;
>   	spin_unlock_irqrestore(&mem->spinlock, flags);
>   	memset(ret, 0, size);
>   	return ret;
> @@ -241,16 +244,17 @@ void *dma_alloc_from_global_coherent(ssize_t size, dma_addr_t *dma_handle)
>   }
>   
>   static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
> -				       int order, void *vaddr)
> +				       int size, void *vaddr)
>   {
>   	if (mem && vaddr >= mem->virt_base && vaddr <
>   		   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
> -		int page = (vaddr - mem->virt_base) >> PAGE_SHIFT;
> +		int nbits = (size + (1UL << PAGE_SHIFT) - 1) >> PAGE_SHIFT;
> +		int start_bit = (vaddr - mem->virt_base) >> PAGE_SHIFT;
>   		unsigned long flags;
>   
>   		spin_lock_irqsave(&mem->spinlock, flags);
> -		bitmap_release_region(mem->bitmap, page, order);
> -		mem->avail += 1 << order;
> +		bitmap_clear(mem->bitmap, start_bit, nbits);
> +		mem->avail += nbits;
>   		spin_unlock_irqrestore(&mem->spinlock, flags);
>   		return 1;
>   	}
> @@ -260,7 +264,7 @@ static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
>   /**
>    * dma_release_from_dev_coherent() - free memory to device coherent memory pool
>    * @dev:	device from which the memory was allocated
> - * @order:	the order of pages allocated
> + * @size:	size of release memory area
>    * @vaddr:	virtual address of allocated pages
>    *
>    * This checks whether the memory was allocated from the per-device
> @@ -269,11 +273,11 @@ static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
>    * Returns 1 if we correctly released the memory, or 0 if the caller should
>    * proceed with releasing memory from generic pools.
>    */
> -int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
> +int dma_release_from_dev_coherent(struct device *dev, int size, void *vaddr)
>   {
>   	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
>   
> -	return __dma_release_from_coherent(mem, order, vaddr);
> +	return __dma_release_from_coherent(mem, size, vaddr);
>   }
>   EXPORT_SYMBOL(dma_release_from_dev_coherent);
>   
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index f8ab1c0..29ae92e 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -162,7 +162,7 @@ static inline int is_device_dma_capable(struct device *dev)
>    */
>   int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
>   				       dma_addr_t *dma_handle, void **ret);
> -int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
> +int dma_release_from_dev_coherent(struct device *dev, int size, void *vaddr);
>   
>   int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
>   			    void *cpu_addr, size_t size, int *ret);
> @@ -174,7 +174,7 @@ int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
>   
>   #else
>   #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
> -#define dma_release_from_dev_coherent(dev, order, vaddr) (0)
> +#define dma_release_from_dev_coherent(dev, size, vaddr) (0)
>   #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
>   
>   static inline void *dma_alloc_from_global_coherent(ssize_t size,
> @@ -540,7 +540,7 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
>   	BUG_ON(!ops);
>   	WARN_ON(irqs_disabled());
>   
> -	if (dma_release_from_dev_coherent(dev, get_order(size), cpu_addr))
> +	if (dma_release_from_dev_coherent(dev, size, cpu_addr))
>   		return;
>   
>   	if (!ops->free || !cpu_addr)
> 
