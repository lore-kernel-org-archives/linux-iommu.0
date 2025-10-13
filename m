Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD5A27F01E;
	Mon, 13 Oct 2025 07:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340308; cv=none; b=rdYtySM5rZzdxgQj0yPL+IcLqPNquTpFLtGXysWaY3C8LAgIgDNUNG+TR8B2kgmUrvG1YjARMaFrJS3oW8FGOxQSkA+uBO1NT1AZWz8/pj+NTo750V6FtxlPB2gUc8krWZMFuvs9dCFPU3PIaettPJyMIjWcfii1ktT8EqrLsF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340308; c=relaxed/simple;
	bh=gII/rqVdzvgABnhQTeiRtQ3APigY1bkGSbg2ncs8UI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqL1FwaFOfkAH7wt+iA96FCY7hoHNBZzTxU4OXJdgDti78rvaYDwMqbfCGWBmTJdCx6YhKkZnhJoCj8uo2e68SR+KOU5J0vavikV3wpAZXARpXERFf3GGENCgVzoPvMXzWmr1sUZ5f5QJtPrBcQmXdT8QVmd6ZfcIbQYRXTnB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTcUiFNg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTcUiFNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482E7C4CEE7;
	Mon, 13 Oct 2025 07:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760340308;
	bh=gII/rqVdzvgABnhQTeiRtQ3APigY1bkGSbg2ncs8UI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTcUiFNgA8f9RQj1G+tmaaat8FQKV2nAO0xl6ARFmhVEnywlrEbAdsxzK+vuKFBYs
	 TzHUu0gA77BvaT3EVRa1ADwjhvw5OPKPkMdbYUAgdekcznzJmuY1ru5DskWelfOJlW
	 pHUXLZMgnvlaJzByHaFEKyNS17LZFh861tjyGQ0VtFpDvdHylb1oXYpO/IERDn6m81
	 PRQ+pyktSTOh4+XSyYooxudt99fp1ADhp2HpaebagpT5bOeST8g+LCo49sc14mO2Cw
	 qRMZfB2rnuFa9MFUtm0CFDB6o8glTXc6sLiVBNn8Yp+mnD0enK9UpXFLEzd4cqNUAP
	 W4UpxzoosZWYA==
Date: Mon, 13 Oct 2025 10:24:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 4/8] mm: Introduce pure page table freeing function
Message-ID: <aOypSS-Pk-LppKhV@kernel.org>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919054007.472493-5-baolu.lu@linux.intel.com>

On Fri, Sep 19, 2025 at 01:40:02PM +0800, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The pages used for ptdescs are currently freed back to the allocator
> in a single location. They will shortly be freed from a second
> location.
> 
> Create a simple helper that just frees them back to the allocator.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f3db3a5ebefe..668d519edc0f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2884,6 +2884,13 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
>  }
>  #define pagetable_alloc(...)	alloc_hooks(pagetable_alloc_noprof(__VA_ARGS__))
>  
> +static inline void __pagetable_free(struct ptdesc *pt)
> +{
> +	struct page *page = ptdesc_page(pt);
> +
> +	__free_pages(page, compound_order(page));
> +}
> +
>  /**
>   * pagetable_free - Free pagetables
>   * @pt:	The page table descriptor
> @@ -2893,12 +2900,10 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
>   */
>  static inline void pagetable_free(struct ptdesc *pt)
>  {
> -	struct page *page = ptdesc_page(pt);
> -
>  	if (ptdesc_test_kernel(pt))
>  		ptdesc_clear_kernel(pt);
>  
> -	__free_pages(page, compound_order(page));
> +	__pagetable_free(pt);
>  }
>  
>  #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
