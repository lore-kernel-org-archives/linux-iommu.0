Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EC52E371A
	for <iommu@lists.linux.dev>; Sat,  5 Jul 2025 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751687458; cv=none; b=eht45AEIA+ur8Py0QxXVjitpdT9ls5kwoPZBAqK2MKjU2L9QxfInaeGey+FiML8LFprQ3fag1VP5jm+7K/+diFzBcnO1WOORgo2AHmI8IGR5vdUcJmMit9TSz6YayucuPgIRmkaJkSswL93nNGP/WVwRIRAzuALXNbgU+bd/sNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751687458; c=relaxed/simple;
	bh=u1p+7Tq0EsziaC7h2LNkIn8gXPK7kCtdvqwdiRxAecc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a4qf34alpWIDXnn7tGETeblPLvcl48KsHWL0XIdyAQufZEN2dUzOitHzfc9kMRReBMHu5tdFQlMjGWmjL+m8QsiX1JaLResgAXkXisvvYzo6sQW6nty9lRzTIdEzh0sjSrXfR/Ef7oaqtdZQMO/I2RaoiAm6i9XWddwk2XH9S78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1cbAbDF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1cbAbDF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751687456; x=1783223456;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u1p+7Tq0EsziaC7h2LNkIn8gXPK7kCtdvqwdiRxAecc=;
  b=b1cbAbDFnkkJahnTvrD67CBCXvLvUwi30TygOSAr2g7yK6IPdHal1ReF
   Ejqqrf8TbEDifG/CHzoT/QYwVIF7J6gqOyyYb1mOsW46aRp4OXIPyEGyS
   VMQ6HwDbUWfsHLIegfkY1HzpmtIlgAcBf1gTj6T1wmjRP4cvsijAEneVu
   RqP5LM8ch/E8R6hMzct6iVVnRNzwA/rp4fZc1JRp9M8f5tNXE/65ihXOs
   wsj6d1FdSCTbeU5gOKOOf9gRxo5TL74JdfHDKsTOwaLbKDBDMMZI7s0Ys
   3aH+KVC1Si86QsvF0/C13NDdOT7DKWR9bNE0OTLWfJQsJu0ymXoDvw6GQ
   w==;
X-CSE-ConnectionGUID: NZp5hOfzQPmH++H8EgCY3w==
X-CSE-MsgGUID: zhVygKidQgOswS/HUZ/4Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="54122276"
X-IronPort-AV: E=Sophos;i="6.16,289,1744095600"; 
   d="scan'208";a="54122276"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 20:50:56 -0700
X-CSE-ConnectionGUID: 9KAahA5mTQKfVyiQC1NkVg==
X-CSE-MsgGUID: +3U+73bmQgqJTvx8DSWbeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,289,1744095600"; 
   d="scan'208";a="154506658"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.252]) ([10.124.243.252])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 20:50:52 -0700
Message-ID: <79ea9027-179a-460b-8a91-86e38feba986@linux.intel.com>
Date: Sat, 5 Jul 2025 11:50:49 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, iommu@lists.linux.dev,
 security@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/sva: Invalidate KVA range on kernel TLB flush
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20250704133056.4023816-1-baolu.lu@linux.intel.com>
 <20250704133807.GB1410929@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250704133807.GB1410929@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/2025 9:38 PM, Jason Gunthorpe wrote:
> On Fri, Jul 04, 2025 at 09:30:56PM +0800, Lu Baolu wrote:
>> The vmalloc() and vfree() functions manage virtually contiguous, but not
>> necessarily physically contiguous, kernel memory regions. When vfree()
>> unmaps such a region, it tears down the associated kernel page table
>> entries and frees the physical pages.
>>
>> In the IOMMU Shared Virtual Addressing (SVA) context, the IOMMU hardware
>> shares and walks the CPU's page tables. Architectures like x86 share
>> static kernel address mappings across all user page tables, allowing the
>> IOMMU to access the kernel portion of these tables.
>>
>> Modern IOMMUs often cache page table entries to optimize walk performance,
>> even for intermediate page table levels. If kernel page table mappings are
>> changed (e.g., by vfree()), but the IOMMU's internal caches retain stale
>> entries, Use-After-Free (UAF) vulnerability condition arises. If these
>> freed page table pages are reallocated for a different purpose, potentially
>> by an attacker, the IOMMU could misinterpret the new data as valid page
>> table entries. This allows the IOMMU to walk into attacker-controlled
>> memory, leading to arbitrary physical memory DMA access or privilege
>> escalation.
>>
>> To mitigate this, introduce a new iommu interface to flush IOMMU caches
>> and fence pending page table walks when kernel page mappings are updated.
>> This interface should be invoked from architecture-specific code that
>> manages combined user and kernel page tables.
>>
>> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
>> Cc:stable@vger.kernel.org
>> Co-developed-by: Jason Gunthorpe<jgg@nvidia.com>
>> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   arch/x86/mm/tlb.c         |  2 ++
>>   drivers/iommu/iommu-sva.c | 32 +++++++++++++++++++++++++++++++-
>>   include/linux/iommu.h     |  4 ++++
>>   3 files changed, 37 insertions(+), 1 deletion(-)
> Reported-by: Jann Horn<jannh@google.com>
> 
>> @@ -1540,6 +1541,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>>   		kernel_tlb_flush_range(info);
>>   
>>   	put_flush_tlb_info();
>> +	iommu_sva_invalidate_kva_range(start, end);
>>   }
> This is much less call sites than I guessed!
> 
>> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
>> +{
>> +	struct iommu_mm_data *iommu_mm;
>> +
>> +	might_sleep();
>> +
>> +	if (!static_branch_unlikely(&iommu_sva_present))
>> +		return;
>> +
>> +	guard(mutex)(&iommu_sva_lock);
>> +	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
>> +		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_sva_invalidate_kva_range);
> I don't think it needs to be exported it only arch code is calling it?

Yes. Done.

> 
> Looks Ok to me:
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>

Thanks,
baolu
