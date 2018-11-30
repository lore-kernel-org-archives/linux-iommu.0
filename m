From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/9] dma-direct: reject highmem pages from
 dma_alloc_from_contiguous
Date: Fri, 30 Nov 2018 19:04:51 +0000
Message-ID: <e479a766-07c0-c319-0d91-318aaafdf7bc@arm.com>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105121931.13481-3-hch@lst.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 05/11/2018 12:19, Christoph Hellwig wrote:
> dma_alloc_from_contiguous can return highmem pages depending on the
> setup, which a plain non-remapping DMA allocator can't handle.  Detect
> this case and try the normal page allocator instead.

...except the actual implementation is "Detect this case and fail the 
entire allocation if so".

Again, the diff itself makes sense, so given an accurate commit message,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/direct.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 680287779b0a..c49849bcced6 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -162,6 +162,18 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>   	if (!page)
>   		return NULL;
>   
> +	if (PageHighMem(page)) {
> +		/*
> +		 * Depending on the cma= arguments and per-arch setup
> +		 * dma_alloc_from_contiguous could return highmem pages.
> +		 * Without remapping there is no way to return them here,
> +		 * so log an error and fail.
> +		 */
> +		dev_info(dev, "Rejecting highmem page from CMA.\n");
> +		__dma_direct_free_pages(dev, size, page);
> +		return NULL;
> +	}
> +
>   	ret = page_address(page);
>   	if (force_dma_unencrypted()) {
>   		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
> 
