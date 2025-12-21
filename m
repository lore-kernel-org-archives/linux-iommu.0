Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCB1487E9
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766307828; cv=none; b=sGUf+M1zrwU10fpPnt+28lHVBzHKryqy1+NlpTUDsmLqKbuuehi2ZaySj12m4r/ms7rn4v+OyctdaWu5h7cIQ2nNUTqH/Slvvfy1d8I0j/d2wDPgM9EZEI1yTRrPcabVYB2xQ+1yuaJ22oyZ6xPcXHpqJXdonA1R6+EetZ0Iae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766307828; c=relaxed/simple;
	bh=9BSWHRhApKSoHFsCI4GrZkzuoqgL48a3Ou2ssr1r+rE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlJ4+lXpei0xZpXHvH5An7Qtge9FuB+iGSfwQLlArksFX+a+E6sxcf8mNhlft6XqkhVHMrGVZFhIeRgxU6K54tdhDIhWFf2giCfDlbpo0VB68Gg9IyNG0ZVTLHZxTTxTolofi209Ag1/B3UFoy7chUTU4xnSmStkpOKb7fjgeWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGgW/tuG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGgW/tuG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766307826; x=1797843826;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9BSWHRhApKSoHFsCI4GrZkzuoqgL48a3Ou2ssr1r+rE=;
  b=lGgW/tuGrCjNay/LQL8Zp2XjpGQBYL/iSKOelwbHJFEoAfClwO793d2w
   fYu0t0e/5Zv6n5IrxPgT+iR2wqntV3/qozz8C5k3JzWnPLo3ErIleUOos
   UFMGvapj6ri+zOv9h11dJMHzA3eX+gAxsp6LDGHfa+kRi4nTFlf1+RUl3
   Ow9UFhUkTjWwupfp8/zF0G8uKgkbg6KLoRtyXJ2F5TdWnkV+rBdtYA43Q
   a8r1/DJYWLtsSvnyMHIauF1HUO3pAwq+2+y/DOJpO5JPpk/upaKYN6QsX
   ptxO2RE35m/1EmULnZRC8Yh25AzyeQ56X+JnzHbFacUzq288s6QRqiWD9
   w==;
X-CSE-ConnectionGUID: OXyoqQvVQLmnl3hRuHZ8Yg==
X-CSE-MsgGUID: F7P6cFPOQAy0nhlADi2gKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="70772860"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="70772860"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 01:03:45 -0800
X-CSE-ConnectionGUID: 8J6Pqp7FQgyMdMmBwoCYnQ==
X-CSE-MsgGUID: LqRi/1QsR5ybF25hP8SepQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199233918"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 01:03:41 -0800
Message-ID: <e51dbe16-49a1-4925-8b2b-56beb66de520@linux.intel.com>
Date: Sun, 21 Dec 2025 17:04:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/vt-d: Ensure memory ordering in context entry
 updates
To: Dmytro Maluka <dmaluka@chromium.org>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Aashish Sharma <aashish@aashishsharma.net>,
 Grzegorz Jaszczyk <jaszczyk@chromium.org>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20251221014302.17738-1-dmaluka@chromium.org>
 <20251221014302.17738-2-dmaluka@chromium.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20251221014302.17738-2-dmaluka@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 09:43, Dmytro Maluka wrote:
> When updating context table entries, we do take care to set the present
> bit as the last step, i.e. in the following order:
> 
> 	context_clear_entry(context);
> 	<set other bits>
> 	context_set_present(context);
> 
> However, we don't actually ensure this order, i.e. don't prevent the
> compiler from reordering it. And since context entries may be updated at
> runtime when translation is already enabled, this may potentially allow
> a time window when a device can already do DMA while the translation is
> not properly set up yet (e.g. the context entry may point to an
> arbitrary page table).
> 
> To easily fix this, change context_set_*() and context_clear_*() helpers
> to use READ_ONCE/WRITE_ONCE, to ensure that the ordering between updates
> of individual bits in context entries matches the order of calling those
> helpers, just like we already do for PASID table entries.
> 
> Link: https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/
> Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
> ---
>   drivers/iommu/intel/iommu.h | 37 +++++++++++++++++++++----------------
>   drivers/iommu/intel/pasid.c |  3 ++-
>   2 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 25c5e22096d4..7f8f004fa756 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -869,7 +869,7 @@ static inline bool dma_pte_superpage(struct dma_pte *pte)
>   
>   static inline bool context_present(struct context_entry *context)
>   {
> -	return (context->lo & 1);
> +	return READ_ONCE(context->lo) & 1;
>   }
>   
>   #define LEVEL_STRIDE		(9)
> @@ -897,46 +897,51 @@ static inline int pfn_level_offset(u64 pfn, int level)
>   	return (pfn >> level_to_offset_bits(level)) & LEVEL_MASK;
>   }
>   
> +static inline void context_set_bits(u64 *ptr, u64 mask, u64 bits)
> +{
> +	u64 old;
> +
> +	old = READ_ONCE(*ptr);
> +	WRITE_ONCE(*ptr, (old & ~mask) | bits);
> +}

Add a line to ensures that the input "bits" cannot overflow the assigned
"mask".

static inline void context_set_bits(u64 *ptr, u64 mask, u64 bits)
{
	u64 val;

	val = READ_ONCE(*ptr);
	val &= ~mask;
	val |= (bits & mask);
	WRITE_ONCE(*ptr, val);
}

>   
>   static inline void context_set_present(struct context_entry *context)
>   {
> -	context->lo |= 1;
> +	context_set_bits(&context->lo, 1 << 0, 1);
>   }

How about adding a smp_wmb() before setting the present bit? Maybe it's
unnecessary for x86 architecture, but at least it's harmless and more
readable. Or not?

static inline void context_set_present(struct context_entry *context)
{
	smp_wmb();
	context_set_bits(&context->lo, 1ULL << 0, 1ULL);
}

>   
>   static inline void context_set_fault_enable(struct context_entry *context)
>   {
> -	context->lo &= (((u64)-1) << 2) | 1;
> +	context_set_bits(&context->lo, 1 << 1, 0);
>   }
>   
>   static inline void context_set_translation_type(struct context_entry *context,
>   						unsigned long value)
>   {
> -	context->lo &= (((u64)-1) << 4) | 3;
> -	context->lo |= (value & 3) << 2;
> +	context_set_bits(&context->lo, GENMASK_ULL(3, 2), value << 2);
>   }
>   
>   static inline void context_set_address_root(struct context_entry *context,
>   					    unsigned long value)
>   {
> -	context->lo &= ~VTD_PAGE_MASK;
> -	context->lo |= value & VTD_PAGE_MASK;
> +	context_set_bits(&context->lo, VTD_PAGE_MASK, value);
>   }
>   
>   static inline void context_set_address_width(struct context_entry *context,
>   					     unsigned long value)
>   {
> -	context->hi |= value & 7;
> +	context_set_bits(&context->hi, GENMASK_ULL(2, 0), value);
>   }
>   
>   static inline void context_set_domain_id(struct context_entry *context,
>   					 unsigned long value)
>   {
> -	context->hi |= (value & ((1 << 16) - 1)) << 8;
> +	context_set_bits(&context->hi, GENMASK_ULL(23, 8), value << 8);
>   }
>   
>   static inline void context_set_pasid(struct context_entry *context)
>   {
> -	context->lo |= CONTEXT_PASIDE;
> +	context_set_bits(&context->lo, CONTEXT_PASIDE, CONTEXT_PASIDE);
>   }
>   
>   static inline int context_domain_id(struct context_entry *c)
> @@ -946,8 +951,8 @@ static inline int context_domain_id(struct context_entry *c)
>   
>   static inline void context_clear_entry(struct context_entry *context)
>   {
> -	context->lo = 0;
> -	context->hi = 0;
> +	WRITE_ONCE(context->lo, 0);
> +	WRITE_ONCE(context->hi, 0);
>   }
>   
>   #ifdef CONFIG_INTEL_IOMMU
> @@ -980,7 +985,7 @@ clear_context_copied(struct intel_iommu *iommu, u8 bus, u8 devfn)
>   static inline void
>   context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
>   {
> -	context->hi |= pasid & ((1 << 20) - 1);
> +	context_set_bits(&context->hi, GENMASK_ULL(19, 0), pasid);
>   }
>   
>   /*
> @@ -989,7 +994,7 @@ context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
>    */
>   static inline void context_set_sm_dte(struct context_entry *context)
>   {
> -	context->lo |= BIT_ULL(2);
> +	context_set_bits(&context->lo, BIT_ULL(2), BIT_ULL(2));
>   }
>   
>   /*
> @@ -998,7 +1003,7 @@ static inline void context_set_sm_dte(struct context_entry *context)
>    */
>   static inline void context_set_sm_pre(struct context_entry *context)
>   {
> -	context->lo |= BIT_ULL(4);
> +	context_set_bits(&context->lo, BIT_ULL(4), BIT_ULL(4));
>   }
>   
>   /*
> @@ -1007,7 +1012,7 @@ static inline void context_set_sm_pre(struct context_entry *context)
>    */
>   static inline void context_clear_sm_pre(struct context_entry *context)
>   {
> -	context->lo &= ~BIT_ULL(4);
> +	context_set_bits(&context->lo, BIT_ULL(4), 0);
>   }
>   
>   /* Returns a number of VTD pages, but aligned to MM page size */
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 77b9b147ab50..7e2b75bcecd4 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -984,7 +984,8 @@ static int context_entry_set_pasid_table(struct context_entry *context,
>   	context_clear_entry(context);
>   
>   	pds = context_get_sm_pds(table);
> -	context->lo = (u64)virt_to_phys(table->table) | context_pdts(pds);
> +	WRITE_ONCE(context->lo,
> +		   (u64)virt_to_phys(table->table) | context_pdts(pds));
>   	context_set_sm_rid2pasid(context, IOMMU_NO_PASID);
>   
>   	if (info->ats_supported)

Thanks,
baolu
