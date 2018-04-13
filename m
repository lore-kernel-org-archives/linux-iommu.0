From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] base: dma-mapping: Postpone cpu addr translation on
	mmap()
Date: Fri, 13 Apr 2018 18:43:29 +0100
Message-ID: <c0f27cac-163d-d7b1-7c27-e1476a6d77b0@arm.com>
References: <1523640337-26064-1-git-send-email-jacopo+renesas@jmondi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1523640337-26064-1-git-send-email-jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: dalias-8zAoT0mYgF4@public.gmane.org, ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 13/04/18 18:25, Jacopo Mondi wrote:
> Postpone calling virt_to_page() translation on memory locations not
> guaranteed to be backed by a struct page. Try first to map memory from
> device's coherent memory pool, then perform translation if that fails.
> 
> On some architectures, specifically SH when configured with SPARSEMEM
> memory model, assuming a struct page is always assigned to a memory
> address lead to unexpected hangs during the virtual to page address
> translation. This patch fixes that specific issue but applies in the
> general case too.

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> Suggested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> Signed-off-by: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
> 
> ---
> 
> It has now been clarified this patch does not resolve the issue, but only
> mitigate it on platforms where dma_mmap_from_dev_coherent() succeeds and
> delay page_to_pfn() faulty conversion.
> 
> A suggested proper solution would be not relying on dma_common_mmap() but
> require all platforms to implement an mmap methods known to work, as noted
> by Christoph in v1 review.

Note that that "proper solution" should still involve having 
dma_common_mmap() since we certainly don't want an explosion of code 
duplication. It just means that architectures that do use it should be 
defining their dma_map_ops with an explicit ".mmap = dma_common_mmap" 
instead of relying on dma_mmap_attrs() calling it by default. Thus the 
more architectures this implementation *is* definitely safe for, the 
better :)

Robin.

> v1 -> v2:
> - Save the 'pfn' temp variable performing the page_to_pfn() conversion in the
>    remap_pfn_range() function call as suggested by Christoph.
> 
> ---
>   drivers/base/dma-mapping.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
> index 3b11835..d82566d 100644
> --- a/drivers/base/dma-mapping.c
> +++ b/drivers/base/dma-mapping.c
> @@ -226,7 +226,6 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>   #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
>   	unsigned long user_count = vma_pages(vma);
>   	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
>   	unsigned long off = vma->vm_pgoff;
> 
>   	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> @@ -234,12 +233,11 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>   	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
>   		return ret;
> 
> -	if (off < count && user_count <= (count - off)) {
> +	if (off < count && user_count <= (count - off))
>   		ret = remap_pfn_range(vma, vma->vm_start,
> -				      pfn + off,
> +				      page_to_pfn(virt_to_page(cpu_addr)) + off,
>   				      user_count << PAGE_SHIFT,
>   				      vma->vm_page_prot);
> -	}
>   #endif	/* !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
> 
>   	return ret;
> --
> 2.7.4
> 
