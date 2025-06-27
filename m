Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E972BD593
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024789; cv=none; b=KtuXdfM6E6cGnWAVgOX4iWiFBe0lB+jP21np5vpqk4bKb+kT/+AOVY/mnDczEMkQ28sdwJdJbF2hyAFzq99r9g/2e2kgNqZw4JISL6H9T9Xb+FTpYzLFTbEEUvkTwK/XZoWk88QIWFd+RU64MYK9qo2mlFxJo7ncldFy/idXobo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024789; c=relaxed/simple;
	bh=2d3eA8NOOmlrIUKCz8tahImDM0fhIk951AVN5hvROWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/Ger8bUe+F7n222bXSZVrADMrSMZ84Oqy0Fbz0VD/02qCXDOEwBWSIikt8xGVZXFmsy7bI4b+JfOOFcY94leX3XJ6Y86hMRwAm8ZJmbmqA1r1V8B8JiT4RplLTB8AY04TaWgCafYxsqzDWHxvJg+Fd4yim3GG/sBpVLEZ3OSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B141F1A00;
	Fri, 27 Jun 2025 04:46:09 -0700 (PDT)
Received: from [10.57.30.59] (unknown [10.57.30.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C02FD3F66E;
	Fri, 27 Jun 2025 04:46:25 -0700 (PDT)
Message-ID: <d0769d8c-a31f-412a-8a15-8bae3fa7deb4@arm.com>
Date: Fri, 27 Jun 2025 12:46:23 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: clear SME flag for mmio pages
To: Wencheng Yang <east.moutain.yang@gmail.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "will@kernel.org" <will@kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CALrP2iVs0AcmJYShyFDVBdnN-yvY3Zq7tENXdLF-SBqEcoYOBQ@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CALrP2iVs0AcmJYShyFDVBdnN-yvY3Zq7tENXdLF-SBqEcoYOBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-06-26 8:12 am, Wencheng Yang wrote:
> Hi, Robin
> 
> 
> 
>> Arguably it also doesn't make sense for callers to be mapping MMIO
> 
>> addresses without IOMMU_MMIO...
> 
> 
> 
> Do you mean that SME flag on pte  should depend on IOMMU_MMIO  flag?

I mean if you're sure that encrypted MMIO will never be a thing for 
peer-to-peer (the existence of ioremap_encrypted() suggests it might be 
in general), then from a design point of view it would make sense that 
if you see IOMMU_MMIO here then you know you shouldn't set the SME bit. 
Then it's just a case of making sure that callers can pass that 
appropriately (e.g. we do in iommu_dma_map_resource(), I guess maybe we 
should for PCI_P2PDMA_MAP_THRU_HOST_BRIDGE in iommu_dma_map_sg() too?)

However, what we should definitely avoid is overloading IOMMU_MMIO to be 
a de-facto encryption flag on x86 just because it happens not to have 
much other significance there. If you think that encryption status may 
end up wanting to be orthogonal to whether the target address represents 
something "MMIO" or "memory-like", and that callers may want the choice, 
then it would really want its own distinct flag (e.g. 
IOMMU_UNENCRYPTED). And we do need to think about this now, before we 
make a potential mess by creating opposing default behaviours for MMIO 
and not-MMIO.

Thanks,
Robin.

> 
> 
> 
>> As usual, pfn_valid() isn't really appropriate for this anyway, since
> 
>> all it means is "does a struct page exist?", and in general it is
> 
>> entirely possible for (reserved) pages to exist for non-RAM addresses.
> 
> 
> 
> You are right, pfn_valid() is not resonable, it can’t filter out reserved
> pages.
> 
> Refer to kvm module, kvm_is_mmio_pfn() uses e820__mapped_raw_any() to judge
> 
> Mmio pfn, I think it should be okay.
> 
> 
> 
> Thanks,
> 
> Wencheng.
> 
> 
> 
> On 2025/6/25, 20:29, "Robin Murphy" <robin.murphy@arm.com> wrote:
> 
> On 2025-06-25 7:48 am, YangWencheng wrote:
> 
>> If paddr is a mmio address, clear the SME flag. It makes no sense to
> 
>> set SME bit on MMIO address.
> 
> 
> 
> Arguably it also doesn't make sense for callers to be mapping MMIO
> 
> addresses without IOMMU_MMIO...
> 
> 
> 
>> ---
> 
>>    drivers/iommu/amd/io_pgtable.c    | 6 ++++--
> 
>>    drivers/iommu/amd/io_pgtable_v2.c | 6 +++++-
> 
>>    2 files changed, 9 insertions(+), 3 deletions(-)
> 
>>
> 
>> diff --git a/drivers/iommu/amd/io_pgtable.c
> b/drivers/iommu/amd/io_pgtable.c
> 
>> index 4d308c071134..88b204449c2c 100644
> 
>> --- a/drivers/iommu/amd/io_pgtable.c
> 
>> +++ b/drivers/iommu/amd/io_pgtable.c
> 
>> @@ -352,15 +352,17 @@ static int iommu_v1_map_pages(struct io_pgtable_ops
> *ops, unsigned long iova,
> 
>>                                              updated = true;
> 
>>
> 
>>                              if (count > 1) {
> 
>> -                                          __pte =
> PAGE_SIZE_PTE(__sme_set(paddr), pgsize);
> 
>> +                                         __pte = PAGE_SIZE_PTE(paddr,
> pgsize);
> 
>>                                              __pte |= PM_LEVEL_ENC(7) |
> IOMMU_PTE_PR | IOMMU_PTE_FC;
> 
>>                              } else
> 
>> -                                          __pte = __sme_set(paddr) |
> IOMMU_PTE_PR | IOMMU_PTE_FC;
> 
>> +                                         __pte = paddr | IOMMU_PTE_PR |
> IOMMU_PTE_FC;
> 
>>
> 
>>                              if (prot & IOMMU_PROT_IR)
> 
>>                                              __pte |= IOMMU_PTE_IR;
> 
>>                              if (prot & IOMMU_PROT_IW)
> 
>>                                              __pte |= IOMMU_PTE_IW;
> 
>> +                         if (pfn_valid(__phys_to_pfn(paddr)))
> 
> 
> 
> As usual, pfn_valid() isn't really appropriate for this anyway, since
> 
> all it means is "does a struct page exist?", and in general it is
> 
> entirely possible for (reserved) pages to exist for non-RAM addresses.
> 
> 
> 
> Thanks,
> 
> Robin.
> 
> 
> 
>> +                                         __pte = __sme_set(__pte);
> 
>>
> 
>>                              for (i = 0; i < count; ++i)
> 
>>                                              pte[i] = __pte;
> 
>> diff --git a/drivers/iommu/amd/io_pgtable_v2.c
> b/drivers/iommu/amd/io_pgtable_v2.c
> 
>> index b47941353ccb..b301fb8e58fa 100644
> 
>> --- a/drivers/iommu/amd/io_pgtable_v2.c
> 
>> +++ b/drivers/iommu/amd/io_pgtable_v2.c
> 
>> @@ -65,7 +65,11 @@ static u64 set_pte_attr(u64 paddr, u64 pg_size, int
> prot)
> 
>>    {
> 
>>              u64 pte;
> 
>>
> 
>> -          pte = __sme_set(paddr & PM_ADDR_MASK);
> 
>> +         if (pfn_valid(__phys_to_pfn(paddr)))
> 
>> +                         pte = __sme_set(paddr & PM_ADDR_MASK);
> 
>> +         else
> 
>> +                         pte = paddr & PM_ADDR_MASK;
> 
>> +
> 
>>              pte |= IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
> 
>>              pte |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
> 
>>
> 

