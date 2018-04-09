From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] base: dma-mapping: Postpone cpu addr translation on mmap()
Date: Mon, 9 Apr 2018 10:52:51 -0700
Message-ID: <20180409175251.GA5426@infradead.org>
References: <1523293148-18726-1-git-send-email-jacopo+renesas@jmondi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1523293148-18726-1-git-send-email-jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>
Cc: dalias-8zAoT0mYgF4@public.gmane.org, ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 09, 2018 at 06:59:08PM +0200, Jacopo Mondi wrote:
> I'm still a bit puzzled on what happens if dma_mmap_from_dev_coherent() fails.
> Does a dma_mmap_from_dev_coherent() failure guarantee anyhow that the
> successive virt_to_page() isn't problematic as it is today?
> Or is it the
>  	if (off < count && user_count <= (count - off))
> check that makes the translation safe?

It doesn't.  I think one major issue is that we should not simply fall
to dma_common_mmap if no method is required, but need every instance of
dma_map_ops to explicitly opt into an mmap method that is known to work.

>  #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
>  	unsigned long user_count = vma_pages(vma);
>  	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
>  	unsigned long off = vma->vm_pgoff;
> +	unsigned long pfn;
> 
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 
> @@ -235,6 +235,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>  		return ret;
> 
>  	if (off < count && user_count <= (count - off)) {
> +		pfn = page_to_pfn(virt_to_page(cpu_addr));
>  		ret = remap_pfn_range(vma, vma->vm_start,
>  				      pfn + off,
>  				      user_count << PAGE_SHIFT,

Why not:

		ret = remap_pfn_range(vma, vma->vm_start,
				page_to_pfn(virt_to_page(cpu_addr)) + off,

and save the temp variable?
