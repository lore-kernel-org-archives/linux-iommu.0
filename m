Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203427A927
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986128; cv=none; b=fvzvXntQ/3f3qaMQscQ4SPfIbYNaSCM0iZ8QOGerXiFlliaWs+J2udxJIQcctnofOMNRHkACBYaVwdFEdWaXQdN/Ni//VYGqG0D4I7MNixhDFUw7Unxxr47enl93cIOW2VjwDeoG9YINbSQUEExSFlHoQnBERTpTfLtFixR7UjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986128; c=relaxed/simple;
	bh=gCmfukYXOYMCPHKWzeqGY4ZB2HY/C9NV4Gw5rQYU+S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/fsqp0gkKw4jA3dEpExZBOXukoemwZXRyAPTHFRdMQ8xebppm2DOnmqfI1LDCot1msNOmBsJ9D0jY917f8MSoJJNmdt7f52f+6kT1dS2nQ3bA+onxPh9G70lSWYb7fA91vd0GeFiOEkSYikB0eeHdiDtkHr7sKhj3e8ORfC+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4gjBK5qc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4gjBK5qc"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a1462573caso14255ad.0
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 11:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767986126; x=1768590926; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zIYiJ3AeStpupvGSL4Hm+WwwUI7TJ76QSjzNdMxPRw=;
        b=4gjBK5qc6tO+o7yRje2m3CASLzdJrtSnc5uxNLT3xVoTtMGz8+Y4gEdBBYg5qsasoZ
         fzgGaRUNhqo6szE8+u8N7DWXmvaIaqXyjq4D9X8+ZsZemBUF1kK5Lhis4KNv42xNpNYs
         kTsBfh3t7JtnZL+6WP6v+QL3vxjj4b+E1Vj9+ahccFf7v4+RnxvIEGoSt8nea2SNaMaw
         GJFbFLChQP10DM7ryHs/FulnkYYhqvL5sCDLqerOcUDGhU2bK5U9kQ/f1Pb9eIe+Vf7I
         xlbrtPDtaZFL1sUzEuaVCh64D0hoGzyW5NLT3305sjJeUWIdoZzNxE+97TQY6NtAkWXD
         3/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767986126; x=1768590926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zIYiJ3AeStpupvGSL4Hm+WwwUI7TJ76QSjzNdMxPRw=;
        b=Iu5RG1r7IDOsZ6c8GrOGKmI/aS3ws5kA+eKogzkPLrilsELZyRHOtg/3YvjWrxyyTb
         w9DbiNQrtgGew2HQb4Kv+rwlzPzvwHDSjxjBsc5rjwaZARR5GT0kyVh3f6M3JDroHB3d
         ry0YGT1LhNpfj1vBKY6VW+BYozQbp7SE3hF6gt3oesVhS1ZL0xwqZqb+K/tkQvTjDtlb
         MQ3JUUZI1mWTQUNOubLXbIKwLPVbuEBqQW/kZOdIQd1dV6hveHPsig3R3jXFMnSuGADW
         CL3Lu34PjSQTJuqEhufwQUcc7OpqrUINwudKesu5vf7P+IZduJj+Bb+qI5EjMwsv/T0z
         s0Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUk9W9vNSF5WCG2KXc5QOKyADCZwkwYrJSp2flKowJPjGxJJgmJN1hyuq9cN3APaJvP6GtKCw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0nszQwfCt3WShdKqL8eKjqLAkoxvJ2SeBcJdmXcPAwNlj0qbc
	6gMtoj0tCUSzQKgQU54ccEnc+9xF1VVZcfRO1YdW7UK60R9iMipmOVdmu/3PYB899Q==
X-Gm-Gg: AY/fxX4T8tkHlmKD3YCyXRVUK/KXhROofmLPppfZJtgLZ10NL/iTKjTkJZsj6e5r1p3
	uorzIXwYOTSmu33vMm8uxsvPEPSliy3eKgyML4pJlxg29qp8wuaL9iVro3b4j3WybMxO3pP36J2
	wF9NsSWm4Oh1dJwOPLH7ij6AX5GyP/dxKYKns4FMhVCZQ3BU2EGeA5pdghkSga3faNbzkuSTuf+
	iIbL7vnaTxS7rFgChlgKCxIdlk+y4xCMYzfYWReycMP1zPJNHF7dV48Eb9RzOu2YynGqMiK7vly
	D9xZpNRcf2sDCz6fai06kyLKBBp2mdvIYFuduG2MA+rADYrMCl2U5t0kzoUCRjs4AV1XUu94kls
	sOBQar6M7kPJmcsmlgvxYVKehRl2/mt22QFvqlFCewuwmzcyUojleP0UmSR7oOZ5W+J6jiBMr3v
	JZueiTD5ZhtAdRbFPHH1ooMDSo/dKJ9tC7cIxo8cpbhw7kXDFC
X-Received: by 2002:a17:903:40ce:b0:292:b6a0:80df with SMTP id d9443c01a7336-2a414932d4bmr384275ad.10.1767986126281;
        Fri, 09 Jan 2026 11:15:26 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a2ecsm110215965ad.6.2026.01.09.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 11:15:25 -0800 (PST)
Date: Fri, 9 Jan 2026 19:15:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, akpm@linux-foundation.org,
	vbabka@suse.cz, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
	baolu.lu@linux.intel.com, rdunlap@infradead.org,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v6 3/4] iommu: debug-pagealloc: Track IOMMU pages
Message-ID: <aWFTxlaGWy23R-Qs@google.com>
References: <20260109171805.901995-1-smostafa@google.com>
 <20260109171805.901995-4-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109171805.901995-4-smostafa@google.com>

On Fri, Jan 09, 2026 at 05:18:04PM +0000, Mostafa Saleh wrote:
> Using the new calls, use an atomic refcount to track how many times
> a page is mapped in any of the IOMMUs.
> 
> For unmap we need to use iova_to_phys() to get the physical address
> of the pages.
> 
> We use the smallest supported page size as the granularity of tracking
> per domain.
> This is important as it is possible to map pages and unmap them with
> larger sizes (as in map_sg()) cases.
> 
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/iommu-debug-pagealloc.c | 84 +++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> index 1d343421da98..9eb49e1230ee 100644
> --- a/drivers/iommu/iommu-debug-pagealloc.c
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -29,19 +29,103 @@ struct page_ext_operations page_iommu_debug_ops = {
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
> +static struct iommu_debug_metadata *get_iommu_data(struct page_ext *page_ext)
> +{
> +	return page_ext_data(page_ext, &page_iommu_debug_ops);
> +}
> +
> +static void iommu_debug_inc_page(phys_addr_t phys)
> +{
> +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> +	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
> +
> +	WARN_ON(atomic_inc_return_relaxed(&d->ref) <= 0);
> +	page_ext_put(page_ext);
> +}
> +
> +static void iommu_debug_dec_page(phys_addr_t phys)
> +{
> +	struct page_ext *page_ext = get_iommu_page_ext(phys);
> +	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
> +
> +	WARN_ON(atomic_dec_return_relaxed(&d->ref) < 0);
> +	page_ext_put(page_ext);
> +}
> +
> +/*
> + * IOMMU page size doesn't have to match the CPU page size. So, we use
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
> +	size_t off, end;
> +	size_t page_size = iommu_debug_page_size(domain);
> +
> +	if (WARN_ON(!phys || check_add_overflow(phys, size, &end)))
> +		return;
> +
> +	for (off = 0 ; off < size ; off += page_size) {
> +		if (!pfn_valid(__phys_to_pfn(phys + off)))
> +			continue;
> +		iommu_debug_inc_page(phys + off);
> +	}
> +}
> +
> +static void __iommu_debug_update_iova(struct iommu_domain *domain,
> +				      unsigned long iova, size_t size, bool inc)
> +{
> +	size_t off, end;
> +	size_t page_size = iommu_debug_page_size(domain);
> +
> +	if (WARN_ON(check_add_overflow(iova, size, &end)))
> +		return;
> +
> +	for (off = 0 ; off < size ; off += page_size) {
> +		phys_addr_t phys = iommu_iova_to_phys(domain, iova + off);
> +
> +		if (!phys || !pfn_valid(__phys_to_pfn(phys)))
> +			continue;
> +
> +		if (inc)
> +			iommu_debug_inc_page(phys);
> +		else
> +			iommu_debug_dec_page(phys);
> +	}
>  }
>  
>  void __iommu_debug_unmap_begin(struct iommu_domain *domain,
>  			       unsigned long iova, size_t size)
>  {
> +	__iommu_debug_update_iova(domain, iova, size, false);
>  }
>  
>  void __iommu_debug_unmap_end(struct iommu_domain *domain,
>  			     unsigned long iova, size_t size,
>  			     size_t unmapped)
>  {
> +	if ((unmapped == size) || WARN_ON_ONCE(unmapped > size))
> +		return;
> +

Looks good!

> +	/* If unmap failed, re-increment the refcount. */
> +	__iommu_debug_update_iova(domain, iova + unmapped,
> +				  size - unmapped, true);
>  }
>  

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks!

>  void iommu_debug_init(void)
> -- 
> 2.52.0.457.g6b5491de43-goog
> 
> 
