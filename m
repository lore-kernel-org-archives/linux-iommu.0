Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140213AE19D
	for <iommu@lists.linux.dev>; Wed,  4 Mar 2026 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649710; cv=none; b=Cbs2jQF5du0syMREwTKJiOUmRmc8/TQ6gkjm4uGU8O1uNQzxpek3V99/miHcD0CjY0L2K3ZqK9wdRFZ9b+QFa3al1pvRdahg3VgezO0mg8avJbdm1JmISFIO7ubOr/C1X8jOYlaWPPEzBKk4t8gjxv+6rUBZxjzCFka5Z5PyfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649710; c=relaxed/simple;
	bh=nM9PKWzGnDcGXYElv74S2uG/vUXsk74rknYOJmrstKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iK0PUR5oSMs0sk3wGYwOf4jBdFHTrfZLZi3ndvtUxG0eGLMUSfVf+4h+cX+CwNHZb9uMacG35Ua7HBgJOv7uSS6qR4U3zn9VosN0s//IyizgzjCgxk6gb+8UHbfkA+tXaqCENPwJo8x+cosWQvKoYGiIh7fDJT8lCRwlt/X8iro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19534339;
	Wed,  4 Mar 2026 10:41:41 -0800 (PST)
Received: from [10.57.57.167] (unknown [10.57.57.167])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 711053F836;
	Wed,  4 Mar 2026 10:41:46 -0800 (PST)
Message-ID: <116b79a2-fadb-4796-8cb7-9c2dfde54999@arm.com>
Date: Wed, 4 Mar 2026 18:41:44 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/iova: Add NULL check in iova_magazine_free()
To: Lynn Liu <liulynn@google.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260304080636.167426-1-liulynn@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260304080636.167426-1-liulynn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-04 8:06 am, Lynn Liu wrote:
> When iova_domain_init_rcaches() fails to allocate an iova_magazine
> during the initialization of per-cpu rcaches, it jumps to out_err and
> calls free_iova_rcaches() for cleanup.
> 
> In free_iova_rcaches(), the code iterates through all possible CPUs to
> free both cpu_rcache->loaded and cpu_rcache->prev. However, if the
> original allocation failed mid-way through the CPU loop, the pointers
> for the remaining CPUs remain NULL.
> 
> Since kmem_cache_free() does not explicitly handle NULL pointers like
> kfree() does, passing these NULL pointers leads to a kernel paging
> request fault.
> 
> The crash can be observed when fault injection triggers a failure in
> iova_magazine_alloc():
> 
> pc : _compound_head include/linux/page-flags.h:251 [inline]
> pc : virt_to_folio include/linux/mm.h:1395 [inline]
> pc : virt_to_slab mm/slab.h:215 [inline]
> pc : kmem_cache_free+0x90/0x5c4 mm/slub.c:4769
> ...
> Call trace:
>   trace_kmem_cache_free include/trace/events/kmem.h:114 [inline]
>   kmem_cache_free+0x90/0x5c4 mm/slub.c:4768
>   iova_magazine_free drivers/iommu/iova.c:623 [inline]
>   free_iova_rcaches+0x114/0x344 drivers/iommu/iova.c:894
>   iova_domain_init_rcaches drivers/iommu/iova.c:762 [inline]
>   iova_domain_init_rcaches+0x3d0/0x528 drivers/iommu/iova.c:717
> 
> Add a NULL check in iova_magazine_free() to safely handle partially
> initialized rcaches in error paths.

Wouldn't it be even better to just break the for_each_possible_cpu() 
loop in free_iova_rcaches() on the first NULL, much like the outer 
rcache->cpu_rcaches condition? Since the cleanup is already trying to be 
symmetric to the allocation, I'd rather fix that than add a blanket 
check that's redundant for every other caller.

Thanks,
Robin.

> Fixes: 84e6f56be9c6 ("iommu/iova: use named kmem_cache for iova magazines")
> Signed-off-by: Lynn Liu <liulynn@google.com>
> ---
> v1: https://lore.kernel.org/linux-iommu/20260214080919.390846-1-liulynn@google.com/T/#u
> Changelog in v1 -> v2:
>   - Update author name to full name.
>   - Add Fixes tag.
>   - Include the Call trace from the kernel crash.
> 
>   drivers/iommu/iova.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 18f839721813..e026be5e068b 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -611,7 +611,8 @@ static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
>   
>   static void iova_magazine_free(struct iova_magazine *mag)
>   {
> -	kmem_cache_free(iova_magazine_cache, mag);
> +	if (mag)
> +		kmem_cache_free(iova_magazine_cache, mag);
>   }
>   
>   static void

