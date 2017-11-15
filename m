From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC v2 2/2] base: dma-mapping: Postpone page_to_pfn() on mmap()
Date: Wed, 15 Nov 2017 13:38:23 +0000
Message-ID: <ea4f2d82-6a27-a7c1-091f-6230cfd988a3@arm.com>
References: <1510679286-6988-1-git-send-email-jacopo+renesas@jmondi.org>
 <1510679286-6988-3-git-send-email-jacopo+renesas@jmondi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1510679286-6988-3-git-send-email-jacopo+renesas@jmondi.org>
Content-Language: en-GB
Sender: linux-sh-owner@vger.kernel.org
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp, dalias@libc.org, laurent.pinchart@ideasonboard.com, geert@linux-m68k.org
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 14/11/17 17:08, Jacopo Mondi wrote:
> On SH4 architecture, with SPARSEMEM memory model, translating page to
> pfn hangs the CPU. Post-pone translation to pfn after
> dma_mmap_from_dev_coherent() function call as it succeeds and make page
> translation not necessary.
> 
> This patch was suggested by Laurent Pinchart and he's working to submit
> a proper fix mainline. Not sending for inclusion at the moment.

Y'know, I think this patch does have some merit by itself - until we 
know that cpu_addr *doesn't* represent some device-private memory which 
is not guaranteed to be backed by a struct page, calling virt_to_page() 
on it is arguably semantically incorrect, even if it might happen to be 
benign in most cases.

Robin.

> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>   drivers/base/dma-mapping.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
> index e584edd..73d64d3 100644
> --- a/drivers/base/dma-mapping.c
> +++ b/drivers/base/dma-mapping.c
> @@ -227,8 +227,8 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>   #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
>   	unsigned long user_count = vma_pages(vma);
>   	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
>   	unsigned long off = vma->vm_pgoff;
> +	unsigned long pfn;
> 
>   	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 
> @@ -236,6 +236,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>   		return ret;
> 
>   	if (off < count && user_count <= (count - off)) {
> +		pfn = page_to_pfn(virt_to_page(cpu_addr));
>   		ret = remap_pfn_range(vma, vma->vm_start,
>   				      pfn + off,
>   				      user_count << PAGE_SHIFT,
> --
> 2.7.4
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
