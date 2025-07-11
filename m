Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B742AA95C
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202914; cv=none; b=T7pj87v7R+cWvKU4C5c/Uwg89bdJ/I4QcbyQEZ66xkAmFJCcAsCG72c0FqddUdjwqGil6MBliR6N6pSITFDFRIDOs9cs27XEATbU2VXZaxv1UkP3sUnmgIphAEZD22rUyRrordXouB4lh5/DT3J6kDzA8QoEtuNiJv5/4X2YV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202914; c=relaxed/simple;
	bh=cQORkvVOWfik0xqc/SpNS7djvhmAHsvAeJNcKseBWsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXW4PuBANXZjKuj1rJx595Ci0lxRKTrcW+9hHm8Zi+/rNlKBJVj7EzM3zy9wp6ooqxiUvtrVZ3PvHaLTE6PstTQnNkESO5YUBFDv90et0XsbwJP8UW9XfCsOMEb3bYn3EzK9YOhBf15O57nfl9lttEN2zQ39+mk5UR8ZkcbB8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVWMtFvn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVWMtFvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752202913; x=1783738913;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cQORkvVOWfik0xqc/SpNS7djvhmAHsvAeJNcKseBWsM=;
  b=LVWMtFvn8CRZ0fc1xgVWnxc7In+aHKp3V0z5CCodqns3+WEErknYpaR4
   FNUvXE2YrLIPaagFmv3CCugJ9Rwfdvm/lXbbM2m2cp9IX09PNs8yR20jP
   Ry4Xg2pkpC9knmhdrl5Nxln898F4kG5sgL6SsOnwwMKA/GB2pOWiajV07
   I7hdBkJFV38okBG1PvL6usTjuN2jt7Ex7H9uBs/EimhStQpr3HZrLvL1p
   IO3nZ8CuWeKiw1NAEiMCPQMYQW2u3ynpUTLTCLSIbgi+5EQKqPKDKnG/L
   qr81gj8Y0fdI5XVM+/dkCTftMOv8IrJ5H4b/HA+LDMrm4ayikIzjnAsxA
   g==;
X-CSE-ConnectionGUID: mnNymVjXSsywASIJxGexGg==
X-CSE-MsgGUID: HTXRlF1JQ+KnXJFvp8X7IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="71945044"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="71945044"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 20:01:53 -0700
X-CSE-ConnectionGUID: 4hrVOA+NQTu93mS7jPRSCQ==
X-CSE-MsgGUID: Z6e0dr+oRNSB+yaEyWr7Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156981240"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 20:01:48 -0700
Message-ID: <094fdad4-297b-44e9-a81c-0fe4da07e63f@linux.intel.com>
Date: Fri, 11 Jul 2025 11:00:06 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Peter Zijlstra <peterz@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Dave Hansen <dave.hansen@intel.com>,
 Alistair Popple <apopple@nvidia.com>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, "Tested-by : Yi Lai" <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250709062800.651521-1-baolu.lu@linux.intel.com>
 <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250710135432.GO1613376@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter Z,

On 7/10/25 21:54, Peter Zijlstra wrote:
> On Wed, Jul 09, 2025 at 02:28:00PM +0800, Lu Baolu wrote:
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
> 
> I must say I liked the kPTI based idea better. Having to iterate and
> invalidate an unspecified number of IOMMUs from non-preemptible context
> seems 'unfortunate'.

The cache invalidation path in IOMMU drivers is already critical and
operates within a non-preemptible context. This approach is, in fact,
already utilized for user-space page table updates since the beginning
of SVA support.

> 
> Why was this approach chosen over the kPTI one, where we keep a
> page-table root that simply does not include the kernel bits, and
> therefore the IOMMU will never see them (change) and we'll never have to
> invalidate?

The IOMMU subsystem started supporting the SVA feature in 2019, and it
has been broadly adopted in various production kernels. The issue
described here is fundamentally a software bug related to not
maintaining IOMMU cache coherence. Therefore, we need a quick and simple
fix to address it, and this patch can be easily backported to production
kernels.

While a kPTI-based approach might appear more attractive, I believe some
extra work is still required to properly integrate it into the IOMMU
subsystem. For instance, kPTI is currently an optional mitigation,
enabled via CONFIG_MITIGATION_PAGE_TABLE_ISOLATION and bypassable with
the "nopti" kernel parameter. This optionality is not suitable for the
IOMMU subsystem, as software must always guarantee IOMMU cache coherence
for functional correctness and security.

So, in the short term, let's proceed with a straightforward solution to
resolve this issue and ensure the SVA feature functions correctly. For
the long term, we can explore optimizations and deeper integration
aligned with features like kPTI.

> 
>> @@ -132,8 +136,15 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
>>   	if (ret)
>>   		goto out_free_domain;
>>   	domain->users = 1;
>> -	list_add(&domain->next, &mm->iommu_mm->sva_domains);
>>   
>> +	if (list_empty(&iommu_mm->sva_domains)) {
>> +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
>> +			if (list_empty(&iommu_sva_mms))
>> +				static_branch_enable(&iommu_sva_present);
>> +			list_add(&iommu_mm->mm_list_elm, &iommu_sva_mms);
>> +		}
>> +	}
>> +	list_add(&domain->next, &iommu_mm->sva_domains);
>>   out:
>>   	refcount_set(&handle->users, 1);
>>   	mutex_unlock(&iommu_sva_lock);
>> @@ -175,6 +186,15 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>>   		list_del(&domain->next);
>>   		iommu_domain_free(domain);
>>   	}
>> +
>> +	if (list_empty(&iommu_mm->sva_domains)) {
>> +		scoped_guard(spinlock_irqsave, &iommu_mms_lock) {
>> +			list_del(&iommu_mm->mm_list_elm);
>> +			if (list_empty(&iommu_sva_mms))
>> +				static_branch_disable(&iommu_sva_present);
>> +		}
>> +	}
>> +
>>   	mutex_unlock(&iommu_sva_lock);
>>   	kfree(handle);
>>   }
> 
> This seems an odd coding style choice; why the extra unneeded
> indentation? That is, what's wrong with:
> 
> 	if (list_empty()) {
> 		guard(spinlock_irqsave)(&iommu_mms_lock);
> 		list_del();
> 		if (list_empty()
> 			static_branch_disable();
> 	}

Perhaps I overlooked or misunderstood something, but my understanding
is,

The lock order in this function is:

	mutex_lock(&iommu_sva_lock);
	spin_lock(&iommu_mms_lock);
	spin_unlock(&iommu_mms_lock);
	mutex_unlock(&iommu_sva_lock);

With above change, it is changed to:

	mutex_lock(&iommu_sva_lock);
	spin_lock(&iommu_mms_lock);
	mutex_unlock(&iommu_sva_lock);
	spin_unlock(&iommu_mms_lock);

> 
>> @@ -312,3 +332,15 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>>   
>>   	return domain;
>>   }
>> +
>> +void iommu_sva_invalidate_kva_range(unsigned long start, unsigned long end)
>> +{
>> +	struct iommu_mm_data *iommu_mm;
>> +
>> +	if (!static_branch_unlikely(&iommu_sva_present))
>> +		return;
>> +
>> +	guard(spinlock_irqsave)(&iommu_mms_lock);
>> +	list_for_each_entry(iommu_mm, &iommu_sva_mms, mm_list_elm)
>> +		mmu_notifier_arch_invalidate_secondary_tlbs(iommu_mm->mm, start, end);
>> +}
> 
> This is absolutely the wrong way to use static_branch. You want them in
> inline functions guarding the function call, not inside the function
> call.

I don't think a static branch is desirable here, as we have no idea how
often the condition will switch in real-world scenarios. I will remove
it in the next version if there are no objections.

Thanks,
baolu
