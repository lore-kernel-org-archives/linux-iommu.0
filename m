Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359DE320A32;
	Thu, 13 Nov 2025 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031623; cv=none; b=qUDyX1MHmT4xUzUQLCp/D6iga64jEAM/StxXi+oRJrQVyD1/hmkYc3ItJvNly1nu/OqgN37Aa0v74d1CCCmZwx/FB53FTRYKYvQbeNjBioshlvB5WG8LS7zVW7QoELnDB04aSy3S695FwvoisS71EA0D0bxMVYhp7FIbCHsgH18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031623; c=relaxed/simple;
	bh=sU+vpaFb7g3JamdPyyLQFH7lkaq5LNFLro/B2yJZ8D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBRcQTh8ZadnwZzOc2VOYklt5WdnTZDQfo567mHuya7/Ph6K7TAj/UPjG0jP71yZeB7hRr5ADYwfj+lPcrIee9bVYpJ6uET7vgZb6fjNSv0uag/wYgKkHEclgpYXM+DrOT7OG060IIuxP4oIvaK51q4nUqtcNBCZXPEKJv67Hrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWSMkeEz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWSMkeEz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1FAC4AF09;
	Thu, 13 Nov 2025 11:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763031622;
	bh=sU+vpaFb7g3JamdPyyLQFH7lkaq5LNFLro/B2yJZ8D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oWSMkeEziLzsMhyEQr+UK97S9luMDwyWNVRrH+XzbhgHPvSuA3m5VS6+J8auQIGEc
	 PdjlS4ykBGjKHM3phiQQCUjWphpTKqYeFFY1k4UGdCHRjAnnlEbYIUsRhL8tp2b0cM
	 lryaa72GaIK7Xyi9o+rV7u8w0A/vPvDP7WX0hGCC4HBdiunMjfc6Wq2KV2zWWIMX+c
	 a2+i1bF3bVS2Oh41uoThrsQDbZP7q4GkiE+mcAmE5N+3JAIq7r2Zlpt9q5gHH+1trM
	 ztiKDX3w+JWkxm6N1L4CN3cyvCwaglxI1rhXAdILefnNe+7Sp+2OGuTONTaDvEyBqE
	 qdVaPbrSZx8+A==
Date: Thu, 13 Nov 2025 11:00:15 +0000
From: Will Deacon <will@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, Qinxin Xia <xiaqinxin@huawei.com>
Subject: Re: [PATCH v2 2/4] drivers/iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
Message-ID: <aRW6P7vhTIZvm2Qf@willie-the-truck>
References: <20251106163953.1971067-1-smostafa@google.com>
 <20251106163953.1971067-3-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106163953.1971067-3-smostafa@google.com>

On Thu, Nov 06, 2025 at 04:39:51PM +0000, Mostafa Saleh wrote:
> Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
> - iommu_debug_init: Enable the debug mode if configured by the user.
> - iommu_debug_map: Track iommu pages mapped, using physical address.
> - iommu_debug_unmap: Track iommu pages unmapped, using IO virtual
>   address.
> - iommu_debug_remap: Track iommu pages, already mapped using IOVA.
> 
> We have to do the unmap/remap as once pages are unmapped we lose the
> information of the physical address.
> This is racy, but the API is racy by construction as it uses refcounts
> and doesn't attempt to lock/synchronize with the IOMMU API as that will
> be costly, meaning that possibility of false negative exists.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  drivers/iommu/iommu-debug-pagealloc.c | 23 ++++++++++++
>  drivers/iommu/iommu.c                 | 14 ++++++-
>  include/linux/iommu-debug-pagealloc.h | 54 +++++++++++++++++++++++++++
>  3 files changed, 89 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> index 385c8bfae02b..a6a2f844b09d 100644
> --- a/drivers/iommu/iommu-debug-pagealloc.c
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -5,11 +5,13 @@
>   * IOMMU API debug page alloc sanitizer
>   */
>  #include <linux/atomic.h>
> +#include <linux/iommu.h>
>  #include <linux/iommu-debug-pagealloc.h>
>  #include <linux/kernel.h>
>  #include <linux/page_ext.h>
>  
>  static bool needed;
> +DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
>  
>  struct iommu_debug_metadate {
>  	atomic_t ref;
> @@ -25,6 +27,27 @@ struct page_ext_operations page_iommu_debug_ops = {
>  	.need = need_iommu_debug,
>  };
>  
> +void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
> +{
> +}
> +
> +void __iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
> +{
> +}
> +
> +void __iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size)
> +{
> +}

Since the IOMMU API doesn't really have a "remap" operation, I wonder
whether it would be clearer to have unmap_begin() and unmap_end()
functions instead? You'd probably want to call them as a pair, so the
check for unmapped < size would move into unmap_end().

Will
