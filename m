Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19090218AB9
	for <iommu@lists.linux.dev>; Sat, 11 Oct 2025 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760164233; cv=none; b=jgaM2IT7R8CVdRS0qNr/ih+dBQDU3xk/AvTxL0ZyEBgnRHnSYKQn6qeAI/t3P68wu9wMJd38f2b40S7w5pEHKESrWjXET1gDTkA3rkRVP5Y52OXRQ4zj3vuSqoLkJvlPZxLREjgPMOqdsDyHEqGP1qCnQDgN3nLHkR6KZF5GM2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760164233; c=relaxed/simple;
	bh=864487Lbses3g7FYfEk5gBAA1Q+2nTEqyXpo9mwJjwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFLeOOtG2xBrzttOfg84j8MCpblzwzRQ008aKLg3ctVHKJyGBkbJpPetpN80saVO81Xy9I0i9zBMXYyCTSAApF2CvDDW09BwqqNhWdk8/7Ze2ChNWdE+Np8XSDbeTpSLnedI+X7bvynDYQHc024fSy9KURx8N3yhdZMgl6exJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYKA2+ih; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYKA2+ih"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760164232; x=1791700232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=864487Lbses3g7FYfEk5gBAA1Q+2nTEqyXpo9mwJjwM=;
  b=lYKA2+ihJ6znCQFxkbDRkCch4QUn7V0ti3CA8+nYDrHI2sWZNYKQbx0n
   LS3Ac4RrgA/HF7d8BHJ40zGSQy5NkuPxsz4tgqC8Tq5Xk0FNVgYyiKXPH
   GtmvR6zOCYeun7LkkGHutDShBfq6z8kS1ccHyiQbp97RCS+pZsHUTRiu5
   vXN2F3r5FZaTSp3ofaRg/01wXLZJoqBVGsG6TP/AGERT2/2VWaW7Q6Ldn
   yHD70yW1NTflUUUFlkvDXiLtVnVgliJPs8n2pTVL6HMZ/azJjTTgc9qNt
   piOUnigfFEQMQdSLLvOY2JQtXjuu6imGZz2qFEr1QgkxEfps7jlFa7mVT
   A==;
X-CSE-ConnectionGUID: lJpd9Ii2TxWW1aRtgTcmXg==
X-CSE-MsgGUID: gSyq3ygFTcO5ENngOfbiDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62295791"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62295791"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 23:30:32 -0700
X-CSE-ConnectionGUID: lPvOecqbQc6xhQki/BPBGg==
X-CSE-MsgGUID: AgL/RN86S3CGZ7GQ+tjQxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="180389437"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 23:30:26 -0700
Message-ID: <ce126bc8-7672-4071-96b5-9652e736175b@linux.intel.com>
Date: Sat, 11 Oct 2025 14:26:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] x86/mm: Use 'ptdesc' when freeing PMD pages
To: Dave Hansen <dave.hansen@intel.com>, David Hildenbrand
 <david@redhat.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>
Cc: iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-4-baolu.lu@linux.intel.com>
 <9648e990-18e0-4aed-8110-b02f4b45aa47@redhat.com>
 <e4c0c578-50e9-4e65-8e7f-7a6d995b22e0@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <e4c0c578-50e9-4e65-8e7f-7a6d995b22e0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/25 03:31, Dave Hansen wrote:
> On 10/9/25 12:25, David Hildenbrand wrote:
>>>
>>> @@ -750,8 +750,8 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>>>          for (i = 0; i < PTRS_PER_PMD; i++) {
>>>            if (!pmd_none(pmd_sv[i])) {
>>> -            pte = (pte_t *)pmd_page_vaddr(pmd_sv[i]);
>>> -            pte_free_kernel(&init_mm, pte);
>>> +            pt = page_ptdesc(pmd_page(pmd_sv[i]));
>>> +            pagetable_dtor_free(pt);
>>
>> There is pmd_ptdesc() which does
>>
>>      page_ptdesc(pmd_pgtable_page(pmd));
>>
>> It's buried in a
>>
>>      #if defined(CONFIG_SPLIT_PMD_PTLOCKS)
>>
>> Can't we just make that always available so we can use it here?
> 
> Yes, that looks like a good idea. I never noticed pmd_ptdesc() when I
> was writing this for sure.

I updated the patch like this,

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6a0bb7fc3148..a0850dc6878e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3203,8 +3203,6 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct 
*mm, pmd_t *pmd,
         ((unlikely(pmd_none(*(pmd))) && __pte_alloc_kernel(pmd))? \
                 NULL: pte_offset_kernel(pmd, address))

-#if defined(CONFIG_SPLIT_PMD_PTLOCKS)
-
  static inline struct page *pmd_pgtable_page(pmd_t *pmd)
  {
         unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
@@ -3216,6 +3214,8 @@ static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
         return page_ptdesc(pmd_pgtable_page(pmd));
  }

+#if defined(CONFIG_SPLIT_PMD_PTLOCKS)
+
  static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
  {
         return ptlock_ptr(pmd_ptdesc(pmd));
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ddf248c3ee7d..c830ccbc2fd8 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -729,7 +729,7 @@ int pmd_clear_huge(pmd_t *pmd)
  int pud_free_pmd_page(pud_t *pud, unsigned long addr)
  {
         pmd_t *pmd, *pmd_sv;
-       pte_t *pte;
+       struct ptdesc *pt;
         int i;

         pmd = pud_pgtable(*pud);
@@ -750,8 +750,8 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)

         for (i = 0; i < PTRS_PER_PMD; i++) {
                 if (!pmd_none(pmd_sv[i])) {
-                       pte = (pte_t *)pmd_page_vaddr(pmd_sv[i]);
-                       pte_free_kernel(&init_mm, pte);
+                       pt = pmd_ptdesc(&pmd_sv[i]);
+                       pagetable_dtor_free(pt);
                 }
         }

@@ -772,15 +772,15 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
   */
  int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
  {
-       pte_t *pte;
+       struct ptdesc *pt;

-       pte = (pte_t *)pmd_page_vaddr(*pmd);
+       pt = pmd_ptdesc(pmd);
         pmd_clear(pmd);

         /* INVLPG to clear all paging-structure caches */
         flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);

-       pte_free_kernel(&init_mm, pte);
+       pagetable_dtor_free(pt);

         return 1;
  }

Thanks,
baolu
