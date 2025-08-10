Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1E21B9C5
	for <iommu@lists.linux.dev>; Sun, 10 Aug 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754810412; cv=none; b=PZ/0nDh1D36n8rwiFCBQxGCT/x5JheDgR6mxxKndj4ZNRKX3RrOFCLZxosYW1SvFkjRaQyT8O9RerB2/jph/WiAyr2w/mv8DCvvj/55yk87PML9X7b48kdRiO6AhzLkPiMNrXW0xW8JMqy9iEfIZIdgdf3FwD6tAy3+OueBXang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754810412; c=relaxed/simple;
	bh=COJswfLh+C+wgDlpQkhGJEDr7gSl5xY9ZoHfsp8rhnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKWPf8TnVdaU4r2vouCKRfiEfsSrnu5BUyBsrhrXx8fZp1UcV5toE4H2523DXDJSE1XA4ypl2bCctXbgPXnIEDSkTpT21OyYPZjtB2N8wf4YYieo7HxpKMnghsccNM44bIoqs/GMj1gdavXDlJwUB8UHerGFJLxrAx+xsk52rs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDJHOXWF; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDJHOXWF"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-459ddada9b1so32121245e9.0
        for <iommu@lists.linux.dev>; Sun, 10 Aug 2025 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754810408; x=1755415208; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usiKZlBsNPpg98V431afWvqjVaCZGADXKOBURWPD0Fg=;
        b=iDJHOXWFWXliwYMWolvNH0fseOrTVOVpbev8DuhC2vbujGTsi7vM7QweKRKs8g7zcH
         jPxkKgMxjIqt97VWtdrF8m/61nwmXtKGD8jDzm+UxeLbtigNw7Ys1LTPk9gKaD6dWWpb
         rAi67pBjr9Itu2MTIWjZ0Wol0swW0oeetfA82csXMuZwnvGxkmNF7QtaG9UTTfpilVQf
         kXusPYztthrIf18bphT83Dk0ms6UMDj7O5yG1ArObPuLUucBeZtLGROAPqp8EduxyrCu
         +PHItw546pXq1UtzNa/wKgfnKZ6fAmGfPiZEZSQqYDlSipzBJGavmrbRM3DNESjsfWJp
         d0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754810408; x=1755415208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usiKZlBsNPpg98V431afWvqjVaCZGADXKOBURWPD0Fg=;
        b=OKLOeyAqSRKJcuEx/ivya35N2SosLG2z4OY3+n9vWF7Ut+1XGEwouUkDgQdxlmGhqT
         RdrPsgEKViXNfuk1dmjl7kXFnl4ygnK7DtXw2RTwW4wOVG4k1IJHOZSWrXu+b0V/3Zur
         4cxTgJuzCdH2XE3NNUvGOu3v6hHBE3ICEalm/SsDeEH7jkcqHn1jEeensmW0/WG9F81G
         TDPhsn3HusApNQFhF8Xa3M0evGujyet70MREldQ4oazvQmw5L8d/IG9BA+w0nvwnCVwI
         fcaHCjPuPEcHKbg7Fl9NrhT4yi275+GB9NcIqvKiTiUVifdo5LrW+ECSF14E8iEPHCBx
         Au9A==
X-Forwarded-Encrypted: i=1; AJvYcCX5l54WAYMzoyywUf98xVQWKLyFTioQVoRh+0TuAOwXzPI3fdnZFh0XVwpsEnFk1gr/g+z9Hg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwyC+87yDOz8cAERWjS5IiT8VX2XBzkT9w+eCegL/XwC8EstbSe
	bPBzWLWbr8dJg+0yZwHT+o4DyO7X8+BPxkcm8FB1ijUyaPPrgYq9zhnU
X-Gm-Gg: ASbGncuNjFxi8531fq3G3Igj/LIB2zAaBR6zraaOcIJKPuIfJodT6/GOyRbGJ/+novr
	HF5aVUUj51iKTdKvr2ZY89BGVVrxpHcHI9jBzMI1tn7dpP7aF3ffXd40H0GQ6hs3hs9s5HIySoY
	L6MpVABCId1pLtipMEsj4jet1zf5jadZ9ZXF5aYQ8P+lpQXVUetu7864PPz45dK9q65RGNKKsuf
	oo5JXRsb2Yt7VWSDJOdTqAo09Q/1oh4wQ7EQ9Rorpek40mIf2GUqa5sVWlZi4mj2PTuQoOMr5Cm
	JUMAjHA0tvzUY+agQ2Z9HR+O57mPsL3fDHebCu7riwi2Cg7Hm22zU5uUgo7G3F8f47aE3318tKn
	b4Wwf9NMYrZ3PbdbSgC/ifNo9Pl9uUUNXA9gi3Tkgg8/Zg7kRsBxe7gvqS3VWHty7g7yt35clEF
	QeIbXIkujMH5em8OhCWNGB
X-Google-Smtp-Source: AGHT+IFQNmeW5ocY8AhqhfJKQxl8wqmvU/MCXEjuQJK8w0HHDDuYkoExIyY4hLkvboPUpQkEdj+r6w==
X-Received: by 2002:a05:6000:26c8:b0:3b7:7898:6df5 with SMTP id ffacd0b85a97d-3b900b4da22mr6180905f8f.14.1754810408182;
        Sun, 10 Aug 2025 00:20:08 -0700 (PDT)
Received: from [26.26.26.1] (95.112.207.35.bc.googleusercontent.com. [35.207.112.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f5ca8ab7sm15204757f8f.59.2025.08.10.00.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 00:20:07 -0700 (PDT)
Message-ID: <2611981e-3678-4619-b2ab-d9daace5a68a@gmail.com>
Date: Sun, 10 Aug 2025 15:19:58 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Baolu Lu <baolu.lu@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
 <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/8/2025 1:15 PM, Baolu Lu wrote:
> On 8/7/25 23:31, Dave Hansen wrote:
>>> +void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>>> +{
>>> +    struct page *page = virt_to_page(pte);
>>> +
>>> +    guard(spinlock)(&kernel_pte_work.lock);
>>> +    list_add(&page->lru, &kernel_pte_work.list);
>>> +    schedule_work(&kernel_pte_work.work);
>>> +}
>>> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/ 
>>> pgalloc.h
>>> index 3c8ec3bfea44..716ebab67636 100644
>>> --- a/include/asm-generic/pgalloc.h
>>> +++ b/include/asm-generic/pgalloc.h
>>> @@ -46,6 +46,7 @@ static inline pte_t
>>> *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>>>   #define pte_alloc_one_kernel(...)
>>> alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
>>>   #endif
>>>
>>> +#ifndef __HAVE_ARCH_PTE_FREE_KERNEL
>>>   /**
>>>    * pte_free_kernel - free PTE-level kernel page table memory
>>>    * @mm: the mm_struct of the current context
>>> @@ -55,6 +56,7 @@ static inline void pte_free_kernel(struct mm_struct
>>> *mm, pte_t *pte)
>>>   {
>>>       pagetable_dtor_free(virt_to_ptdesc(pte));
>>>   }
>>> +#endif
>>>
>>>   /**
>>>    * __pte_alloc_one - allocate memory for a PTE-level user page table
>> I'd much rather the arch-generic code looked like this:
>>
>> #ifdef CONFIG_ASYNC_PGTABLE_FREE
>> // code and struct here, or dump them over in some
>> // other file and do this in a header
>> #else
>> static void pte_free_kernel_async(struct page *page) {}
>> #endif
>>
>> void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>> {
>>      struct page *page = virt_to_page(pte);
>>
>>      if (IS_DEFINED(CONFIG_ASYNC_PGTABLE_FREE)) {
>>     pte_free_kernel_async(page);
>>      else
>>     pagetable_dtor_free(page_ptdesc(page));
>> }
>>
>> Then in Kconfig, you end up with something like:
>>
>> config ASYNC_PGTABLE_FREE
>>     def_bool y
>>     depends on INTEL_IOMMU_WHATEVER
>>
>> That very much tells much more of the whole story in code. It also gives
>> the x86 folks that compile out the IOMMU the exact same code as the
>> arch-generic folks. It_also_ makes it dirt simple and obvious for the
>> x86 folks to optimize out the async behavior if they don't like it in
>> the future by replacing the compile-time IOMMU check with a runtime one.
>>
>> Also, if another crazy IOMMU implementation comes along that happens to
>> do what the x86 IOMMUs do, then they have a single Kconfig switch to
>> flip. If they follow what this patch tries to do, they'll start by
>> copying and pasting the x86 implementation.
> 
> I'll do it like this.  Does that look good to you?
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 70d29b14d851..6f1113e024fa 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -160,6 +160,7 @@ config IOMMU_DMA
>   # Shared Virtual Addressing
>   config IOMMU_SVA
>       select IOMMU_MM_DATA
> +    select ASYNC_PGTABLE_FREE if X86
>       bool
> 
>   config IOMMU_IOPF
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 3c8ec3bfea44..dbddacdca2ce 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -46,6 +46,19 @@ static inline pte_t 
> *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>   #define pte_alloc_one_kernel(...) 
> alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
>   #endif
> 
> +#ifdef CONFIG_ASYNC_PGTABLE_FREE
> +struct pgtable_free_work {
> +    struct list_head list;
> +    spinlock_t lock;
> +    struct work_struct work;
> +};
> +extern struct pgtable_free_work kernel_pte_work;
> +
> +void pte_free_kernel_async(struct ptdesc *ptdesc);
> +#else
> +static inline void pte_free_kernel_async(struct ptdesc *ptdesc) {}
> +#endif
> +
>   /**
>    * pte_free_kernel - free PTE-level kernel page table memory
>    * @mm: the mm_struct of the current context
> @@ -53,7 +66,12 @@ static inline pte_t 
> *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>    */
>   static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>   {
> -    pagetable_dtor_free(virt_to_ptdesc(pte));
> +    struct ptdesc *ptdesc = virt_to_ptdesc(pte);
> +
> +    if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE))
> +        pte_free_kernel_async(ptdesc);
> +    else
> +        pagetable_dtor_free(ptdesc);
>   }
> 
>   /**
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e443fe8cd6cf..528550cfa7fe 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1346,6 +1346,13 @@ config LOCK_MM_AND_FIND_VMA
>   config IOMMU_MM_DATA
>       bool
> 
> +config ASYNC_PGTABLE_FREE
> +    bool "Asynchronous kernel page table freeing"
> +    help
> +      Perform kernel page table freeing asynchronously. This is required
> +      for systems with IOMMU Shared Virtual Address (SVA) to flush IOTLB
> +      paging structure caches.
> +
>   config EXECMEM
>       bool
> 
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 567e2d084071..6639ee6641d4 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -13,6 +13,7 @@
>   #include <linux/swap.h>
>   #include <linux/swapops.h>
>   #include <linux/mm_inline.h>
> +#include <linux/iommu.h>
>   #include <asm/pgalloc.h>
>   #include <asm/tlb.h>
> 
> @@ -406,3 +407,32 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, 
> pmd_t *pmd,
>       pte_unmap_unlock(pte, ptl);
>       goto again;
>   }
> +
> +#ifdef CONFIG_ASYNC_PGTABLE_FREE
> +static void kernel_pte_work_func(struct work_struct *work);
> +struct pgtable_free_work kernel_pte_work = {
> +    .list = LIST_HEAD_INIT(kernel_pte_work.list),
> +    .lock = __SPIN_LOCK_UNLOCKED(kernel_pte_work.lock),
> +    .work = __WORK_INITIALIZER(kernel_pte_work.work, 
> kernel_pte_work_func),
> +};
> +
> +static void kernel_pte_work_func(struct work_struct *work)
> +{
> +    struct ptdesc *ptdesc, *next;
> +
> +    iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
> +
> +    guard(spinlock)(&kernel_pte_work.lock);
> +    list_for_each_entry_safe(ptdesc, next, &kernel_pte_work.list, 
> pt_list) {
> +        list_del_init(&ptdesc->pt_list);
> +        pagetable_dtor_free(ptdesc);
> +    }
> +}
> +
> +void pte_free_kernel_async(struct ptdesc *ptdesc)
> +{
> +    guard(spinlock)(&kernel_pte_work.lock);
> +    list_add(&ptdesc->pt_list, &kernel_pte_work.list);
> +    schedule_work(&kernel_pte_work.work);
> +}
kernel_pte_work.list is global shared var, it would make the producer
pte_free_kernel() and the consumer kernel_pte_work_func() to operate in 
serialized timing. In a large system, I don't think you design this 
deliberately :)

Thanks,
Ethan
  > +#endif

