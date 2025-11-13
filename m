Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD82DC33B;
	Thu, 13 Nov 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031636; cv=none; b=cWQPgm6yKHQsi6m13JwYoSmWDgVYVhxlXCTIyaNycNhSVRIA6YVBMPdW4jxZ2hRETLWt66yo5y/KiDuKwX5QoSvrb10AEFsOzArxgDHbInXwY1ewui0kDQYY6KEuPVWxHtY6KXW/o/LfJvDwU2lAsUbNXf276k2ba7d4I6H+TXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031636; c=relaxed/simple;
	bh=60CqqKZhKyJWhvXbxjipGwZaOFWeYx8t/B7NuToA0qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWELDcjF+NOqYK7s66ny9xqqkhFqLM+MgsSNVHUC7+qIClzP86xd3n7lRJCaTzh8qwuSTXv1MyjQbA2iIcvBXgFaeO+X9S1oGYuyWcqWgduI6f6kMgffFocJ5ASLVsSzG0OqQRepLSzo+EHtl1m2H6Cr4arZvKNnnn0/XpDVaOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XprYqLZl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XprYqLZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830DAC4CEF8;
	Thu, 13 Nov 2025 11:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763031636;
	bh=60CqqKZhKyJWhvXbxjipGwZaOFWeYx8t/B7NuToA0qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XprYqLZl0n7S0uKqVe+CWa2LIB6Ck69UtfeF/nby7RAfR2gTWAOCSYAmCXZIkD9NY
	 p2b9pRk1jOsaovvn4m6GLJ+x1SjWdmxEKkCfo0FZ5rcyfQGOM+Qax1yjUkhljKcjJE
	 hGFz/mD/buVOCxa4jhShkdYg+2z99ADEx1QIbeg5p/n2pFuEPBeU1gp8YcfYhfHgM4
	 j5Q+OXwo5qXd8x40MMLMJYQ3tWpSjIYpQUF+O1etquIVAEgFN6dvwAppS4x1bRWBTo
	 9XmBVzGwaYs+I8qHma7t9haazKdJdjfIRXfpdbmZ0mCTV6jTDFr5ACh2Gt3XXV0deI
	 aIf2OK9jhTnUA==
Date: Thu, 13 Nov 2025 11:00:29 +0000
From: Will Deacon <will@kernel.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
	surenb@google.com, mhocko@suse.com, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, Qinxin Xia <xiaqinxin@huawei.com>
Subject: Re: [PATCH v2 3/4] drivers/iommu-debug-pagealloc: Track IOMMU pages
Message-ID: <aRW6Tf_G2ObR__vE@willie-the-truck>
References: <20251106163953.1971067-1-smostafa@google.com>
 <20251106163953.1971067-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106163953.1971067-4-smostafa@google.com>

On Thu, Nov 06, 2025 at 04:39:52PM +0000, Mostafa Saleh wrote:
> Using the new calls, use an atomic refcount to track how many times
> a page is mapped in any of the IOMMUs.
> 
> For unmap we need to use iova_to_phys() to get the physical address
> of the pages.
> 
> We use the smallest supported page size as the granularity of tracking
> per domain.
> This is important as it possible to map pages and unmap them with
> larger sizes (as in map_sg()) cases.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  drivers/iommu/iommu-debug-pagealloc.c | 74 +++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> index a6a2f844b09d..0e14104b971c 100644
> --- a/drivers/iommu/iommu-debug-pagealloc.c
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -27,16 +27,90 @@ struct page_ext_operations page_iommu_debug_ops = {
>  	.need = need_iommu_debug,
>  };
>  
> +static struct page_ext *get_iommu_page_ext(phys_addr_t phys)
> +{
> +	struct page *page = phys_to_page(phys);
> +	struct page_ext *page_ext = page_ext_get(page);
> +
> +	return page_ext;
> +}
> +
> +static struct iommu_debug_metadate *get_iommu_data(struct page_ext *page_ext)
> +{
> +	return page_ext_data(page_ext, &page_iommu_debug_ops);
> +}
> +
> +static void iommu_debug_inc_page(phys_addr_t phys)
> +{
> +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> +	struct iommu_debug_metadate *d = get_iommu_data(page_ext);
> +
> +	WARN_ON(atomic_inc_return(&d->ref) <= 0);

Is it worth dumping some information about the page in addition to the
WARN_ON()? That way, you might be able to benefit from other debug
options (e.g. PAGE_OWNER) if they are enabled.

> +	page_ext_put(page_ext);
> +}
> +
> +static void iommu_debug_dec_page(phys_addr_t phys)
> +{
> +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> +	struct iommu_debug_metadate *d = get_iommu_data(page_ext);
> +
> +	WARN_ON(atomic_dec_return(&d->ref) < 0);

nit: I can't see why you need memory ordering guarantees for the refcount,
so you could use the relaxed variants for the inc/dec operations.

> +	page_ext_put(page_ext);
> +}
> +
> +/*
> + * IOMMU page size might not match the CPU page size, in that case, we use
> + * the smallest IOMMU page size to refcount the pages in the vmemmap.
> + * That is important as both map and unmap has to use the same page size
> + * to update the refcount to avoid double counting the same page.
> + * And as we can't know from iommu_unmap() what was the original page size
> + * used for map, we just use the minimum supported one for both.
> + */
> +static size_t iommu_debug_page_size(struct iommu_domain *domain)
> +{
> +	return 1UL << __ffs(domain->pgsize_bitmap);
> +}
> +
>  void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
>  {
> +	size_t off;
> +	size_t page_size = iommu_debug_page_size(domain);

Since this is a debug feature, is it worth checking other properties of
the arguments too? For example, that phys is non-zero and that phys +
size doesn't overflow?

> +	for (off = 0 ; off < size ; off += page_size) {
> +		if (!pfn_valid(__phys_to_pfn(phys + off)))
> +			continue;
> +		iommu_debug_inc_page(phys + off);
> +	}
>  }
>  
>  void __iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
>  {
> +	size_t off;
> +	size_t page_size = iommu_debug_page_size(domain);
> +
> +	for (off = 0 ; off < size ; off += page_size) {
> +		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
> +
> +		if (!phys || !pfn_valid(__phys_to_pfn(phys + off)))
> +			continue;

Hmm, it looks weird to add 'off' to both 'iova' _and_ the resulting
physical address. Is that correct?

> +		iommu_debug_dec_page(phys);
> +	}
>  }
>  
>  void __iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size)
>  {
> +	size_t off;
> +	size_t page_size = iommu_debug_page_size(domain);
> +
> +	for (off = 0 ; off < size ; off += page_size) {
> +		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
> +
> +		if (!phys || !pfn_valid(__phys_to_pfn(phys + off)))
> +			continue;
> +
> +		iommu_debug_inc_page(phys);
> +	}

You can make the bulk of this code common with the unmap function.

Will
