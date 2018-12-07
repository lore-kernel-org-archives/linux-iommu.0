From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 6/9] iommu/dma-iommu.c: Convert to use vm_insert_range
Date: Fri, 7 Dec 2018 13:47:19 +0000
Message-ID: <d02ad9d7-d0f6-c891-bb7e-fdf6661f651c@arm.com>
References: <20181206184343.GA30569@jordon-HP-15-Notebook-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206184343.GA30569@jordon-HP-15-Notebook-PC>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com, joro@8bytes.org
Cc: linux-mm@kvack.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 06/12/2018 18:43, Souptick Joarder wrote:
> Convert to use vm_insert_range() to map range of kernel
> memory to user vma.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> ---
>   drivers/iommu/dma-iommu.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d1b0475..a2c65e2 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -622,17 +622,10 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   
>   int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
>   {
> -	unsigned long uaddr = vma->vm_start;
> -	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	int ret = -ENXIO;
> +	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   
> -	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
> -		ret = vm_insert_page(vma, uaddr, pages[i]);
> -		if (ret)
> -			break;
> -		uaddr += PAGE_SIZE;
> -	}
> -	return ret;
> +	return vm_insert_range(vma, vma->vm_start,
> +				pages + vma->vm_pgoff, count);

You also need to adjust count to compensate for the pages skipped by 
vm_pgoff, otherwise you've got an out-of-bounds dereference triggered 
from userspace, which is pretty high up the "not good" scale (not to 
mention the entire call would then propagate -EFAULT back from 
vm_insert_page() and thus always appear to fail for nonzero offsets).

Robin.

>   }
>   
>   static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> 
