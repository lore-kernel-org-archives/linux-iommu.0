Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B452D063E
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986179; cv=none; b=fxeOMCj9zI97ZJlMP27n0gIaJQVOlyTrZ1p/OBJ0jn+/UzRbaudLClQD6gq8BS7BetSEPGCBjUzN2NvWVRRSrwkc53/dNKNlDREI7RWmg5WY4YsXnj31d5RQZmms6khfon9eUVW67NghwRCltCIJZuD1W5hrMnA10mqhOFFBsD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986179; c=relaxed/simple;
	bh=1nPt0jMenK9foxrM3p/sw5FChCH1n394SDkI1BEWCNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ1Jsqu2T38zsVW6jmrcljK+XrvrCPUsGQMEcJWJxWVpTNFXF62oTB6q6zof9Km10KJTeHyco+G1uNvAzUJkNKt56zN+yUGkFRnhJrg4heDrdWivXAJ2hlSlFAEuEMIvwPMFvc06kIw7swn2BI7qeZcs1S9KNhHRuJZYHjjZH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5gwI5SC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5gwI5SC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a35ae38bdfso12845ad.1
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 11:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767986177; x=1768590977; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OY298V/mlr0e0R/jNCYCk/cEMiQwxaFCVZQ5rO28hR8=;
        b=l5gwI5SCetDxwasoPcyUC/FRpRj7uEAFWeQpv+vxLuGmg/GAh3XMKfcZYYxQtsMhrP
         p2LrwELrEMjpLZVWhho1mV7Clf/a1ozjB4gf9YIqz5Ph3tKbVV8h7+mjsrtIeLR3jKw4
         sANgxfM+DHX1C5tMhoRmGLE2xEbvLSOEmUvyxlsi9lXdJFKJLXIMJ06clgLHiaRcQVmf
         nxVuixlhJvBan9v002jSXtkw0Tq6yc/FZIEMO6mKEzPk+LSlulx/8eIrWn5psGdSPQgJ
         kZsdhME2y1f1oD4foKGkKT7jvyDVcdhyyINBmlllK0SRIbLvlOPbpEnCuN922hLlz3mP
         II8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767986177; x=1768590977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OY298V/mlr0e0R/jNCYCk/cEMiQwxaFCVZQ5rO28hR8=;
        b=KzucSKhPrAtah5+6EI/E4LVevxtMailkXhvR6oIMQyS36+rTYb9rsrCWOpkjjOjxGJ
         /OAdhcl7TpZvs+U9BacDcLmkNViax0t6IINADusxxfRQJ3uypYXDEpTMjuZ1oz8Bjcxz
         Qe9T9vRWFCU4aJp/xXU8HrxvQLcXgRJKbylcKw9OEPP2b9Z/JhRBFib7xbrGkJBB2n0o
         rlOyN+EAl32HmesGfynAHS/lhES4V2/AovH0LLwxT2ckbohl9EH7e/o2nG4rywCjKQlf
         AFogc0Xtw5di9oLBoSciMjpf5gTdBPwtWp3oflwcM1iIeM1iIVFKzIQUDrzFzbf6oZFg
         hdXA==
X-Forwarded-Encrypted: i=1; AJvYcCWmSZoKsi2II0jIE9cM9hAcDI+nX4oXWZgO3NAC6ph+0iCLQSFkwytWdzCemWyy9SgGh3V9nw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGzDqc/ELi/P8NaFGAEwIDxkNIwgS1/bKMD7k4rcZiYfTk0h6D
	zERQrOXsGX5Db6hPm1uU6xqtwtbmUmoUcjN02D2ed5HYYDLQxX3sp0qk0VtWR/jtc8kAKMSRelP
	qbD9n0g==
X-Gm-Gg: AY/fxX6HpA10pTw1/Rs3nox3r5GZEyyfw4UJ+9etUgfqtiplcWdrJocTpRZfELsxJr0
	j1IRyQNRFgI9Q1POntfctFLkJSdjB8HOymVzlZW92AYpBAohiYrebtFsEXiA27X0Rs4mOpe4md6
	S8VT5yIYkLjrWbMeBcMeUYfti8yv1XLtuDGMzAheLWKnXSS9qGfBWw07tkXoFXj68ZZnrL5dtxD
	3NcKN7KF+omy/JPlSwEZAEMeZwYEhEUYPF665Q2hqA0tEr2y71mV47j9kV/5poavwjY5GQjV7Z1
	YSsRwJkDaju1dKahMhKIWKCAkM0Y9iKlPKMmj1R/TuXYV+UPxIdru9NSiJuXM1KcqbwM4RFpLfW
	Sx98Ugq0mzGAS70JoFpR0wa27EKyYjKKBq0lhn1i3bN8czz+oHn5DWkihIlpT5DKcWV+DiiZiFg
	E7EQbuceH193mbof0A1pg/6O2GtATCjbkMHoLq/FdaNXO50hAQ
X-Received: by 2002:a17:902:f690:b0:2a1:3cda:8e99 with SMTP id d9443c01a7336-2a4149da4e3mr360525ad.21.1767986176660;
        Fri, 09 Jan 2026 11:16:16 -0800 (PST)
Received: from google.com (222.245.187.35.bc.googleusercontent.com. [35.187.245.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81d87955bb6sm4087620b3a.50.2026.01.09.11.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 11:16:16 -0800 (PST)
Date: Fri, 9 Jan 2026 19:16:08 +0000
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
Subject: Re: [PATCH v6 4/4] iommu: debug-pagealloc: Check mapped/unmapped
 kernel memory
Message-ID: <aWFT-Oh9bQsbqrXj@google.com>
References: <20260109171805.901995-1-smostafa@google.com>
 <20260109171805.901995-5-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109171805.901995-5-smostafa@google.com>

On Fri, Jan 09, 2026 at 05:18:05PM +0000, Mostafa Saleh wrote:
> Now, as the page_ext holds count of IOMMU mappings, we can use it to
> assert that any page allocated/freed is indeed not in the IOMMU.
> 
> The sanitizer doesn’t protect against mapping/unmapping during this
> period. However, that’s less harmful as the page is not used by the
> kernel.
> 
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/iommu/iommu-debug-pagealloc.c | 23 +++++++++++++++++++++++
>  include/linux/iommu-debug-pagealloc.h | 14 ++++++++++++++
>  include/linux/mm.h                    |  5 +++++
>  3 files changed, 42 insertions(+)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

> diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
> index 9eb49e1230ee..c080a38f45a4 100644
> --- a/drivers/iommu/iommu-debug-pagealloc.c
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -9,6 +9,7 @@
>  #include <linux/iommu-debug-pagealloc.h>
>  #include <linux/kernel.h>
>  #include <linux/page_ext.h>
> +#include <linux/page_owner.h>
>  
>  #include "iommu-priv.h"
>  
> @@ -73,6 +74,28 @@ static size_t iommu_debug_page_size(struct iommu_domain *domain)
>  	return 1UL << __ffs(domain->pgsize_bitmap);
>  }
>  
> +static bool iommu_debug_page_count(const struct page *page)
> +{
> +	unsigned int ref;
> +	struct page_ext *page_ext = page_ext_get(page);
> +	struct iommu_debug_metadata *d = get_iommu_data(page_ext);
> +
> +	ref = atomic_read(&d->ref);
> +	page_ext_put(page_ext);
> +	return ref != 0;
> +}
> +
> +void __iommu_debug_check_unmapped(const struct page *page, int numpages)
> +{
> +	while (numpages--) {
> +		if (WARN_ON(iommu_debug_page_count(page))) {
> +			pr_warn("iommu: Detected page leak!\n");
> +			dump_page_owner(page);
> +		}
> +		page++;
> +	}
> +}
> +
>  void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
>  {
>  	size_t off, end;
> diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
> index a439d6815ca1..46c3c1f70150 100644
> --- a/include/linux/iommu-debug-pagealloc.h
> +++ b/include/linux/iommu-debug-pagealloc.h
> @@ -13,6 +13,20 @@ DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
>  
>  extern struct page_ext_operations page_iommu_debug_ops;
>  
> +void __iommu_debug_check_unmapped(const struct page *page, int numpages);
> +
> +static inline void iommu_debug_check_unmapped(const struct page *page, int numpages)
> +{
> +	if (static_branch_unlikely(&iommu_debug_initialized))
> +		__iommu_debug_check_unmapped(page, numpages);
> +}
> +
> +#else
> +static inline void iommu_debug_check_unmapped(const struct page *page,
> +					      int numpages)
> +{
> +}
> +
>  #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
>  
>  #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6f959d8ca4b4..32205d2a24b2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -36,6 +36,7 @@
>  #include <linux/rcuwait.h>
>  #include <linux/bitmap.h>
>  #include <linux/bitops.h>
> +#include <linux/iommu-debug-pagealloc.h>
>  
>  struct mempolicy;
>  struct anon_vma;
> @@ -4133,12 +4134,16 @@ extern void __kernel_map_pages(struct page *page, int numpages, int enable);
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>  static inline void debug_pagealloc_map_pages(struct page *page, int numpages)
>  {
> +	iommu_debug_check_unmapped(page, numpages);
> +
>  	if (debug_pagealloc_enabled_static())
>  		__kernel_map_pages(page, numpages, 1);
>  }
>  
>  static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages)
>  {
> +	iommu_debug_check_unmapped(page, numpages);
> +
>  	if (debug_pagealloc_enabled_static())
>  		__kernel_map_pages(page, numpages, 0);
>  }
> -- 
> 2.52.0.457.g6b5491de43-goog
> 
> 
