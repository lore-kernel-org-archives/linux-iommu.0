Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794E27990A;
	Thu, 23 Oct 2025 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203415; cv=none; b=NQ8J8bhKorEJvlQler5gDJo9jRLDG7tBX2vBcvtPbAL9Bqb9ICGPZUytlThJjAbdRjkcUVkzxn4LJsvFJrdqmFseBqbFL3drvIgmZgVfuT6cKjmm7odFgtipPqSiO1GbTrs5zs1VSNyYYtVIq3uDgXx+57kxQRA7bR4HfJmqlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203415; c=relaxed/simple;
	bh=3eigXBLiimevcUcf8KdhhD/v0+6ZZjko+MbkPytVjq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9MbRriVZ1klkjPGyfkkfvs+D9X7hTV2Ej8KgtRhNP03OtJeLHo8n2OtKe2RH4ZN+lVqiw/rqr8Nflkmieiini7dmsOmw9mYy9Paek/dNx3eGGqs3CGFBervN+ddVAP+pLUoyTTPG+ZhdeBc8UDaQLX7nG3M8kiMlLLOJbgqGTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcJFhi8t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcJFhi8t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49433C4CEE7;
	Thu, 23 Oct 2025 07:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761203414;
	bh=3eigXBLiimevcUcf8KdhhD/v0+6ZZjko+MbkPytVjq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WcJFhi8tSHC6qd0/sKDdW4POrtY8pODQNVNADd8AbwXFN47Qw7Av6RR1wEc8y4kIg
	 JriUhZcFP08MpUvg7WoV5KC/BLx+T15pEJUTAZL4YKbdd0QUPaMUqNe6eKQei9BIPt
	 iZD6Lzb1MPz+qfvA9FiR+0j5SDrjIUzzy36JQEVxXKzf8CYmxDuEhZgEq0imUVzddw
	 FJQ6UC2tuwX6mBhwn7+8RGIo714r6Xcq43rmXGtlGUfLOhwwKygTbmAvh1S+7Y81rB
	 UNChcCRiu/B5WjBWPYRF0OnYurR8gHb34HJqm738Db4V7qykDKpHPE+nJCi3XDtEMS
	 a7N2hWzjZKP2Q==
Date: Thu, 23 Oct 2025 10:10:01 +0300
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
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v7 7/8] mm: Introduce deferred freeing for kernel page
 tables
Message-ID: <aPnUyYS8N9Lp59vS@kernel.org>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
 <20251022082635.2462433-8-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022082635.2462433-8-baolu.lu@linux.intel.com>

On Wed, Oct 22, 2025 at 04:26:33PM +0800, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This introduces a conditional asynchronous mechanism, enabled by
> CONFIG_ASYNC_KERNEL_PGTABLE_FREE. When enabled, this mechanism defers the
> freeing of pages that are used as page tables for kernel address mappings.
> These pages are now queued to a work struct instead of being freed
> immediately.
> 
> This deferred freeing allows for batch-freeing of page tables, providing
> a safe context for performing a single expensive operation (TLB flush)
> for a batch of kernel page tables instead of performing that expensive
> operation for each page table.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/Kconfig           |  3 +++
>  include/linux/mm.h   | 16 +++++++++++++---
>  mm/pgtable-generic.c | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0e26f4fc8717..a83df9934acd 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -908,6 +908,9 @@ config PAGE_MAPCOUNT
>  config PGTABLE_HAS_HUGE_LEAVES
>  	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
>  
> +config ASYNC_KERNEL_PGTABLE_FREE
> +	def_bool n
> +
>  # TODO: Allow to be enabled without THP
>  config ARCH_SUPPORTS_HUGE_PFNMAP
>  	def_bool n
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 52ae551d0eb4..d521abd33164 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3031,6 +3031,14 @@ static inline void __pagetable_free(struct ptdesc *pt)
>  	__free_pages(page, compound_order(page));
>  }
>  
> +#ifdef CONFIG_ASYNC_KERNEL_PGTABLE_FREE
> +void pagetable_free_kernel(struct ptdesc *pt);
> +#else
> +static inline void pagetable_free_kernel(struct ptdesc *pt)
> +{
> +	__pagetable_free(pt);
> +}
> +#endif
>  /**
>   * pagetable_free - Free pagetables
>   * @pt:	The page table descriptor
> @@ -3040,10 +3048,12 @@ static inline void __pagetable_free(struct ptdesc *pt)
>   */
>  static inline void pagetable_free(struct ptdesc *pt)
>  {
> -	if (ptdesc_test_kernel(pt))
> +	if (ptdesc_test_kernel(pt)) {
>  		ptdesc_clear_kernel(pt);
> -
> -	__pagetable_free(pt);
> +		pagetable_free_kernel(pt);
> +	} else {
> +		__pagetable_free(pt);
> +	}
>  }
>  
>  #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 567e2d084071..1c7caa8ef164 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -406,3 +406,40 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
>  	pte_unmap_unlock(pte, ptl);
>  	goto again;
>  }
> +
> +#ifdef CONFIG_ASYNC_KERNEL_PGTABLE_FREE
> +static void kernel_pgtable_work_func(struct work_struct *work);
> +
> +static struct {
> +	struct list_head list;
> +	/* protect above ptdesc lists */
> +	spinlock_t lock;
> +	struct work_struct work;
> +} kernel_pgtable_work = {
> +	.list = LIST_HEAD_INIT(kernel_pgtable_work.list),
> +	.lock = __SPIN_LOCK_UNLOCKED(kernel_pgtable_work.lock),
> +	.work = __WORK_INITIALIZER(kernel_pgtable_work.work, kernel_pgtable_work_func),
> +};
> +
> +static void kernel_pgtable_work_func(struct work_struct *work)
> +{
> +	struct ptdesc *pt, *next;
> +	LIST_HEAD(page_list);
> +
> +	spin_lock(&kernel_pgtable_work.lock);
> +	list_splice_tail_init(&kernel_pgtable_work.list, &page_list);
> +	spin_unlock(&kernel_pgtable_work.lock);
> +
> +	list_for_each_entry_safe(pt, next, &page_list, pt_list)
> +		__pagetable_free(pt);
> +}
> +
> +void pagetable_free_kernel(struct ptdesc *pt)
> +{
> +	spin_lock(&kernel_pgtable_work.lock);
> +	list_add(&pt->pt_list, &kernel_pgtable_work.list);
> +	spin_unlock(&kernel_pgtable_work.lock);
> +
> +	schedule_work(&kernel_pgtable_work.work);
> +}
> +#endif
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
