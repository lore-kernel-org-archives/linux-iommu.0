Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9ED1607A4
	for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158105; cv=none; b=Vihhq3ErmeUzEeQ9e3C1EZ6CHBIgnfjTBD/exjdPm1gc3VKAlX44HpqvK1KSv5sX42XfK6n8HS4gdOqg+Tgwqj0I5SEabzbIJZG91fx7CxTeMFGumK8GJfzpq1Hb/wxsoUEfypHo09w2+pGbo6W9yLdSqpiGfOEXtuLhpnJwc/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158105; c=relaxed/simple;
	bh=+o1sFGphAIevJlVAqF7AF9gDgMQ8ZwboV7hCEA1Sfx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYHkYGdQ/QxdLDcLNx5WN3wqXCLSj3q+HdbNOl9108bci/UC7UoMK7oj/Pmd8+N81iGZiyEk53YcD6KgW8vFb0qSB/ER1v9OGR+Sf1p9FsY27pEn/nt5gOIOIlQ4L+ds1JvqG97Q9n4YyYSNO5HcwRWOCDFwJJ+2dmk7qZF7Pz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUEliZag; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUEliZag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761158102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9YqHMSkF5T/6MQvDyGjDyvV6SwZ5EdSH42dFss7fcAw=;
	b=YUEliZagU6JTLdIc2t5uXB1J2kDpSmntJa8IYb9CKgxqZfO4v48Ep3m0KbZFgc4dS+wxYg
	v6dqzHc0Q1pWkdy4tkH1FqjeLD0gxo1enMUiJM3c39JsCDjPkehrWM9/IWhBWZT9VAUZEB
	12U5yta2frmZWRF6n6zLkVnKAN8fg+M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-H4PASf3WM1Oqelb8aMqqrg-1; Wed, 22 Oct 2025 14:34:59 -0400
X-MC-Unique: H4PASf3WM1Oqelb8aMqqrg-1
X-Mimecast-MFC-AGG-ID: H4PASf3WM1Oqelb8aMqqrg_1761158098
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475c422fd70so8920055e9.2
        for <iommu@lists.linux.dev>; Wed, 22 Oct 2025 11:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761158098; x=1761762898;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YqHMSkF5T/6MQvDyGjDyvV6SwZ5EdSH42dFss7fcAw=;
        b=Fsw9Qj3xVQEXiJWI4nHMw+tH6brZjRu7CXmT6Wbn6m0M1qzvqwWcvSL7aJ1ls3Xl3X
         8RVSEh8A2YVDgJ1gkR0nDdyekWLfESKnyn/U3F+vWof3UTLQePQ+533cfi5tQf6AzEkW
         TAx37R5H2dTI/Ml/TlqisIcTrHUm6GstdxwbZq1WOnm7ozX3ptF2yCFRJV2aqJxxuHeQ
         1fkp7FLJj57YbYZk2FoUH+KjwknX0Inla5y+IW6nIlK2jeKNqGF6xo7samgeNEaoEaF1
         dUoqpXt0NzjpejW7eoaaDb+4CfGuAfTe1h9UM0p61gBzXSzqrNyfzsmlHHA7V+xp8mM/
         sQHg==
X-Gm-Message-State: AOJu0YxkmGFwVjly5c8xADjZkDPWCkRPLQdhQO50ndhh/naZL1ygRqmM
	OLsozpySSiTD7h+GTZa+RcxT0aKbt12QyGR8Xb0uRhR0u8d9minMgxcm2SP1D9hx8DkDp/utCkh
	uPBj1B8+96WfKGwK0xF+ohjKkdzm7RlzwQxnadjN3XdYbzyK/zSyuZP9O
X-Gm-Gg: ASbGnctDVtprcGJoL8BeAc4zh3ECRMjLht5sW2LJACqfrm5coI8Lwk5CBCN6yUmMiNs
	1Mm7d1pO8om4i6LU6cRudpZdbcMZOinpeYREr/CkF27/hn+X0sfX/JDNyrx4PB3F/ntkyKfvMHB
	QvTmsaK3IajV2ADlc2WTGuHAaShE5sd+gxi2XuBDjnyV4ra/nJ+jpL2jmmA4gucHcYz+poahG6D
	aKMtFi22clpMv7tE+ksx208+LHxMeC77xztEZ8aM3UkFpui6L9VByDphvRY+MRm92hXaJMoRN0+
	sIg/8sOsvx5sZgMsNN9XEFb96JHFJ3hhf1BBrCl0YV2HPRaxdmNsyqFZNmgDc7Zz8ySHz1PC3pb
	4y4u3MWE2Gtx/kYvHKtJYQ72l3Ka8/61pMquUZGTB4ST9DfIXtsqgzy3dqRP1txzUa0pjeFxkM4
	CUAIxlsiY1OGeTjx6z9VoVmEf1QQ8=
X-Received: by 2002:a05:600c:5026:b0:470:bcc4:b07c with SMTP id 5b1f17b1804b1-47117925d38mr175825995e9.37.1761158097755;
        Wed, 22 Oct 2025 11:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0oQ3lTCB2x2oM5MOeaEhX/tcQ15X6pp7tPbV7z1c7xivg9xS8IzzR5hA20GTIyMNevbuRow==
X-Received: by 2002:a05:600c:5026:b0:470:bcc4:b07c with SMTP id 5b1f17b1804b1-47117925d38mr175825825e9.37.1761158097325;
        Wed, 22 Oct 2025 11:34:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428e9b2sm56333455e9.5.2025.10.22.11.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 11:34:56 -0700 (PDT)
Message-ID: <dabf557c-d83b-4edb-8cf3-1ab8581e5406@redhat.com>
Date: Wed, 22 Oct 2025 20:34:53 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] mm: Introduce deferred freeing for kernel page
 tables
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
 <20251022082635.2462433-8-baolu.lu@linux.intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251022082635.2462433-8-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GdMf29UZkqlId4cxOAZwmAEFZAZWjr_-W50oA5NzZ44_1761158098
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.25 10:26, Lu Baolu wrote:
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
> ---
>   mm/Kconfig           |  3 +++
>   include/linux/mm.h   | 16 +++++++++++++---
>   mm/pgtable-generic.c | 37 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0e26f4fc8717..a83df9934acd 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -908,6 +908,9 @@ config PAGE_MAPCOUNT
>   config PGTABLE_HAS_HUGE_LEAVES
>   	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
>   
> +config ASYNC_KERNEL_PGTABLE_FREE
> +	def_bool n
> +
>   # TODO: Allow to be enabled without THP
>   config ARCH_SUPPORTS_HUGE_PFNMAP
>   	def_bool n
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 52ae551d0eb4..d521abd33164 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3031,6 +3031,14 @@ static inline void __pagetable_free(struct ptdesc *pt)
>   	__free_pages(page, compound_order(page));
>   }
>   
> +#ifdef CONFIG_ASYNC_KERNEL_PGTABLE_FREE
> +void pagetable_free_kernel(struct ptdesc *pt);
> +#else
> +static inline void pagetable_free_kernel(struct ptdesc *pt)
> +{
> +	__pagetable_free(pt);
> +}
> +#endif
>   /**
>    * pagetable_free - Free pagetables
>    * @pt:	The page table descriptor
> @@ -3040,10 +3048,12 @@ static inline void __pagetable_free(struct ptdesc *pt)
>    */
>   static inline void pagetable_free(struct ptdesc *pt)
>   {
> -	if (ptdesc_test_kernel(pt))
> +	if (ptdesc_test_kernel(pt)) {
>   		ptdesc_clear_kernel(pt);
> -
> -	__pagetable_free(pt);
> +		pagetable_free_kernel(pt);
> +	} else {
> +		__pagetable_free(pt);
> +	}
>   }
>   
>   #if defined(CONFIG_SPLIT_PTE_PTLOCKS)
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 567e2d084071..1c7caa8ef164 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -406,3 +406,40 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
>   	pte_unmap_unlock(pte, ptl);
>   	goto again;
>   }
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

Acked-by: David Hildenbrand <david@redhat.com>

I was briefly wondering whether the pages can get stuck in there 
sufficiently long that we would want to wire up the shrinker to say 
"OOM, hold your horses, we can still free something here".

But I'd assume the workqueue will get scheduled in a reasonable 
timeframe either so this is not a concern?

-- 
Cheers

David / dhildenb

