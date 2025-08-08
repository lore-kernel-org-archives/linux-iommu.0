Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B216DC28
	for <iommu@lists.linux.dev>; Fri,  8 Aug 2025 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754630232; cv=none; b=BkRilaNWAwZ3pdIls3hFSGauh18wut3Kk+JXkNlAGWcHOgD3Fb7QVnAISfEop/ynYINVuY4WDIMTzisax1MVC5C2y/l6KRYQQpm775NHfM3n1wrNOr2eaKs3KZ9dtsflaBObkkMoqq9NhFeb7Igfcoz91jNGEA/lXfq1uy1BViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754630232; c=relaxed/simple;
	bh=OV45XsrkcfFJCl91T0aANLhMqM1x4PJEUmvBK6Hky+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6xFr2g3CKGw55K328rCHaQo283DX1UsTBo4a7y43AgQci2p90BYH6eAj8awPJdZ8K6G/GvQF+oUCkaiQM2tE7oMiruhdApP8tYGhV92PLYKgEMcsnTowdTYd4ZkvolmnYGmjj7dKhNTkYgOQN3Hu6ruPZ2Sxw3507ClFpLjjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ep0hNWlb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ep0hNWlb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754630232; x=1786166232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OV45XsrkcfFJCl91T0aANLhMqM1x4PJEUmvBK6Hky+0=;
  b=Ep0hNWlbgthsFsvnHV93CAQvWRHXjzYaB+N5kwZ5m9Kf1Gs2QCEKVQR/
   j/u/HddLguDhKnNYA3hQdNYxgSp8hMMI88twRyx0tZ7s6Zb0SfQOKH8p8
   hJzYcGD74ITIYbbttbpJLvFJRowEVlmoJ7ZoJln4siNOo3V6c3IL0cboK
   jCt9x67jDbNYKwa7rDym8YYBbGhtNW+XpCq2ggAWEfWXYA+5XJihVCjow
   5FWjJZ23LdbFUtC9HqZ3vPgJa+EUKfG+YOfa9zLjVFA+39cNj/+pkOp3/
   OVt5z7LCCSEOlCs7FqqZH3G5TA2nP7oH9XZBSz+O7fxq1etcIZyFaw/dJ
   Q==;
X-CSE-ConnectionGUID: ZKRAlQclR4OJTEZo5OL2jA==
X-CSE-MsgGUID: TsRVDlEEQHuGKN9dMkcIdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57054745"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="57054745"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 22:17:11 -0700
X-CSE-ConnectionGUID: m9u5htjUSgamqgHN3ylsbg==
X-CSE-MsgGUID: 84kYWOcgQYSPTUbd0j0Cig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169453259"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 22:17:06 -0700
Message-ID: <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
Date: Fri, 8 Aug 2025 13:15:12 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Dave Hansen <dave.hansen@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/25 23:31, Dave Hansen wrote:
>> +void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>> +{
>> +    struct page *page = virt_to_page(pte);
>> +
>> +    guard(spinlock)(&kernel_pte_work.lock);
>> +    list_add(&page->lru, &kernel_pte_work.list);
>> +    schedule_work(&kernel_pte_work.work);
>> +}
>> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
>> index 3c8ec3bfea44..716ebab67636 100644
>> --- a/include/asm-generic/pgalloc.h
>> +++ b/include/asm-generic/pgalloc.h
>> @@ -46,6 +46,7 @@ static inline pte_t
>> *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>>   #define pte_alloc_one_kernel(...)
>> alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
>>   #endif
>>
>> +#ifndef __HAVE_ARCH_PTE_FREE_KERNEL
>>   /**
>>    * pte_free_kernel - free PTE-level kernel page table memory
>>    * @mm: the mm_struct of the current context
>> @@ -55,6 +56,7 @@ static inline void pte_free_kernel(struct mm_struct
>> *mm, pte_t *pte)
>>   {
>>       pagetable_dtor_free(virt_to_ptdesc(pte));
>>   }
>> +#endif
>>
>>   /**
>>    * __pte_alloc_one - allocate memory for a PTE-level user page table
> I'd much rather the arch-generic code looked like this:
> 
> #ifdef CONFIG_ASYNC_PGTABLE_FREE
> // code and struct here, or dump them over in some
> // other file and do this in a header
> #else
> static void pte_free_kernel_async(struct page *page) {}
> #endif
> 
> void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> {
>      struct page *page = virt_to_page(pte);
> 
>      if (IS_DEFINED(CONFIG_ASYNC_PGTABLE_FREE)) {
> 	pte_free_kernel_async(page);
>      else
> 	pagetable_dtor_free(page_ptdesc(page));
> }
> 
> Then in Kconfig, you end up with something like:
> 
> config ASYNC_PGTABLE_FREE
> 	def_bool y
> 	depends on INTEL_IOMMU_WHATEVER
> 
> That very much tells much more of the whole story in code. It also gives
> the x86 folks that compile out the IOMMU the exact same code as the
> arch-generic folks. It_also_ makes it dirt simple and obvious for the
> x86 folks to optimize out the async behavior if they don't like it in
> the future by replacing the compile-time IOMMU check with a runtime one.
> 
> Also, if another crazy IOMMU implementation comes along that happens to
> do what the x86 IOMMUs do, then they have a single Kconfig switch to
> flip. If they follow what this patch tries to do, they'll start by
> copying and pasting the x86 implementation.

I'll do it like this.  Does that look good to you?

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..6f1113e024fa 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -160,6 +160,7 @@ config IOMMU_DMA
  # Shared Virtual Addressing
  config IOMMU_SVA
  	select IOMMU_MM_DATA
+	select ASYNC_PGTABLE_FREE if X86
  	bool

  config IOMMU_IOPF
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 3c8ec3bfea44..dbddacdca2ce 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -46,6 +46,19 @@ static inline pte_t 
*pte_alloc_one_kernel_noprof(struct mm_struct *mm)
  #define pte_alloc_one_kernel(...) 
alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
  #endif

+#ifdef CONFIG_ASYNC_PGTABLE_FREE
+struct pgtable_free_work {
+	struct list_head list;
+	spinlock_t lock;
+	struct work_struct work;
+};
+extern struct pgtable_free_work kernel_pte_work;
+
+void pte_free_kernel_async(struct ptdesc *ptdesc);
+#else
+static inline void pte_free_kernel_async(struct ptdesc *ptdesc) {}
+#endif
+
  /**
   * pte_free_kernel - free PTE-level kernel page table memory
   * @mm: the mm_struct of the current context
@@ -53,7 +66,12 @@ static inline pte_t 
*pte_alloc_one_kernel_noprof(struct mm_struct *mm)
   */
  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
  {
-	pagetable_dtor_free(virt_to_ptdesc(pte));
+	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
+
+	if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE))
+		pte_free_kernel_async(ptdesc);
+	else
+		pagetable_dtor_free(ptdesc);
  }

  /**
diff --git a/mm/Kconfig b/mm/Kconfig
index e443fe8cd6cf..528550cfa7fe 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1346,6 +1346,13 @@ config LOCK_MM_AND_FIND_VMA
  config IOMMU_MM_DATA
  	bool

+config ASYNC_PGTABLE_FREE
+	bool "Asynchronous kernel page table freeing"
+	help
+	  Perform kernel page table freeing asynchronously. This is required
+	  for systems with IOMMU Shared Virtual Address (SVA) to flush IOTLB
+	  paging structure caches.
+
  config EXECMEM
  	bool

diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 567e2d084071..6639ee6641d4 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -13,6 +13,7 @@
  #include <linux/swap.h>
  #include <linux/swapops.h>
  #include <linux/mm_inline.h>
+#include <linux/iommu.h>
  #include <asm/pgalloc.h>
  #include <asm/tlb.h>

@@ -406,3 +407,32 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, 
pmd_t *pmd,
  	pte_unmap_unlock(pte, ptl);
  	goto again;
  }
+
+#ifdef CONFIG_ASYNC_PGTABLE_FREE
+static void kernel_pte_work_func(struct work_struct *work);
+struct pgtable_free_work kernel_pte_work = {
+	.list = LIST_HEAD_INIT(kernel_pte_work.list),
+	.lock = __SPIN_LOCK_UNLOCKED(kernel_pte_work.lock),
+	.work = __WORK_INITIALIZER(kernel_pte_work.work, kernel_pte_work_func),
+};
+
+static void kernel_pte_work_func(struct work_struct *work)
+{
+	struct ptdesc *ptdesc, *next;
+
+	iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
+
+	guard(spinlock)(&kernel_pte_work.lock);
+	list_for_each_entry_safe(ptdesc, next, &kernel_pte_work.list, pt_list) {
+		list_del_init(&ptdesc->pt_list);
+		pagetable_dtor_free(ptdesc);
+	}
+}
+
+void pte_free_kernel_async(struct ptdesc *ptdesc)
+{
+	guard(spinlock)(&kernel_pte_work.lock);
+	list_add(&ptdesc->pt_list, &kernel_pte_work.list);
+	schedule_work(&kernel_pte_work.work);
+}
+#endif
-- 
2.43.0

