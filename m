Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC841B378
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108023; cv=none; b=SVizHzyVmuOgaLMn0dzcy3EqJABb8fHLmjOM2BjJ65p9k1/lEJbk6jpT8jmNFrbpoCUPf+C7FBCFNxOuwn7N6EF6IEfZJ0Q0TfumJIDAA9Wxafz0EWYQAqUwbnqu74trFYjcJBNzvM2zTMgRlpvdxB3/tuTjqUiTqa4xwKQQM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108023; c=relaxed/simple;
	bh=6RRM4voBsYSRyB2HVWqWgArrKsEBjLYey1NyYvTf804=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUzOH79bQeL9ceO2gZhC63UzdeGA6clDUjGYPivxdfoF93s5q5xOORP/Vz1qmPsA0OIk/qStEJbbKcUvSbrhqlvZ2EHuS9isXGVX7nVxs9yx1JUvb1PyzoZ2SObJegWM/eHgDH1svYLVvrJC9EtXcjMExRhBe6ai4OlLP5mG3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cUYuVwET; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cUYuVwET"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8CE52328;
	Mon, 18 May 2026 05:40:15 -0700 (PDT)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9157D3F632;
	Mon, 18 May 2026 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779108021; bh=6RRM4voBsYSRyB2HVWqWgArrKsEBjLYey1NyYvTf804=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cUYuVwETpvBJ0r9LdBIA+knfi970j52/wfTk5xjo2MAWZyeFjbw/pZEvlPRaftiN9
	 2LNUWAcv8BX3RXPDm9a4ViqcSlfvs3KC2vDXjPKYlN4od2oVU9FS0KL67AXs58zgWw
	 kszVqYLpOQmYIa4a/Z3ZCJXq912/w4ymRQrXwQZU=
Message-ID: <d6366078-3eb9-4445-9f91-27e1dc15970e@arm.com>
Date: Mon, 18 May 2026 13:40:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-direct: Clear pages before coherent remap
To: Rosen Penev <rosenp@gmail.com>, iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260517042955.2218649-1-rosenp@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260517042955.2218649-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/05/2026 5:29 am, Rosen Penev wrote:
> Clear pages through their page mapping before creating a coherent
> remap for dma-direct allocations. Some architectures implement the
> coherent remap as uncached memory, where the generic memset() path may
> use cache-only zeroing instructions that are not valid for the returned
> CPU mapping.

Which architectures? I'd fear they're just broken in that case - there's 
every chance that once the caller gets a coherent allocation back, they 
could also invoke memset() on it - either explicitly, or automatically 
inserted by the compiler for a structure/array initialisation, or if the 
buffer subsequently gets mmap()ed to userspace then who knows what. If 
that's really a problem, this patch isn't going to solve it.

It's rather the point that we clear the buffer the same way that the 
caller is subsequently going to access it (not least to minimise the 
chance of any other possible weird coherency side-effects).

Thanks,
Robin.

> Keep the existing memset() for non-remapped allocations, but avoid
> normal memset() on the remapped coherent allocation path.
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   kernel/dma/direct.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 583c5922bca2..76f7bf43bd28 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -8,6 +8,7 @@
>   #include <linux/export.h>
>   #include <linux/mm.h>
>   #include <linux/dma-map-ops.h>
> +#include <linux/highmem.h>
>   #include <linux/scatterlist.h>
>   #include <linux/pfn.h>
>   #include <linux/vmalloc.h>
> @@ -104,6 +105,15 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
>   	dma_free_contiguous(dev, page, size);
>   }
>   
> +static void dma_direct_zero_pages(struct page *page, size_t size)
> +{
> +	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +	unsigned long i;
> +
> +	for (i = 0; i < count; i++)
> +		clear_highpage(page + i);
> +}
> +
>   static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
>   {
>   	struct page *page = swiotlb_alloc(dev, size);
> @@ -268,6 +278,13 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   	if (remap) {
>   		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
>   
> +		/*
> +		 * Zero via the page mapping before creating a potentially
> +		 * uncached remap.  Some architectures cannot safely run normal
> +		 * memset on uncached memory.
> +		 */
> +		dma_direct_zero_pages(page, size);
> +
>   		if (force_dma_unencrypted(dev))
>   			prot = pgprot_decrypted(prot);
>   
> @@ -283,10 +300,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>   		ret = page_address(page);
>   		if (dma_set_decrypted(dev, ret, size))
>   			goto out_leak_pages;
> +		memset(ret, 0, size);
>   	}
>   
> -	memset(ret, 0, size);
> -
>   	if (set_uncached) {
>   		arch_dma_prep_coherent(page, size);
>   		ret = arch_dma_set_uncached(ret, size);

