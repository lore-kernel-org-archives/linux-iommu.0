Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF62C2E6108
	for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435849; cv=none; b=J8ceGxpWNmhNvBdfelUElqDy+3NBWleNZx/zYbowxd6jIbSgNOiHMdi+3lySZ8fPjtdgSfdEruMnaCY2tHy0sC6QPmm5G0vAgF1+IwPq7id4Rff+RxinHPyOCpPlomw0f5dXZVA8QqDuTSGmfK8nJafBmb++O157GzLnOZqPM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435849; c=relaxed/simple;
	bh=VU2bZVSWS7Y7D+L7/7Dt5pIdIlosy1fuUbSFKypwv5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwSmdREqNd61xIJ1rcWz39UEmQK3C45lUhjZEYSRGuyOqd3nX391ml4VcEUZOV5+7Ip7rtGAxeZxKPENAtnBUf0GpEuJnwn663PonhOWW2tKeprpOIVD2Px5CEnoSe+dEaiPr2oI2BR+gBcqWlQz8AbFIGrubKl468HJZO7S4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A26016F2;
	Fri, 20 Jun 2025 09:10:27 -0700 (PDT)
Received: from [10.1.30.146] (XHFQ2J9959.cambridge.arm.com [10.1.30.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 207873F58B;
	Fri, 20 Jun 2025 09:10:42 -0700 (PDT)
Message-ID: <7105112f-b0bb-4191-b3c9-93522162319c@arm.com>
Date: Fri, 20 Jun 2025 17:10:41 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] arm64/mm: Elide tlbi in contpte_convert() under
 BBML2
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: yang@os.amperecomputing.com, will@kernel.org, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, maz@kernel.org,
 oliver.upton@linux.dev, joey.gouly@arm.com, james.morse@arm.com,
 broonie@kernel.org, ardb@kernel.org, baohua@kernel.org,
 suzuki.poulose@arm.com, david@redhat.com, jgg@ziepe.ca, nicolinc@nvidia.com,
 jsnitsel@redhat.com, mshavit@google.com, kevin.tian@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-5-miko.lenczewski@arm.com> <aFRlDSZ2PPnHixjc@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aFRlDSZ2PPnHixjc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/06/2025 20:29, Catalin Marinas wrote:
> On Tue, Jun 17, 2025 at 09:51:04AM +0000, Mikołaj Lenczewski wrote:
>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>> index bcac4f55f9c1..203357061d0a 100644
>> --- a/arch/arm64/mm/contpte.c
>> +++ b/arch/arm64/mm/contpte.c
>> @@ -68,7 +68,144 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
>>  			pte = pte_mkyoung(pte);
>>  	}
>>  
>> -	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>> +	/*
>> +	 * On eliding the __tlb_flush_range() under BBML2+noabort:
>> +	 *
>> +	 * NOTE: Instead of using N=16 as the contiguous block length, we use
>> +	 *       N=4 for clarity.
>> +	 *
>> +	 * NOTE: 'n' and 'c' are used to denote the "contiguous bit" being
>> +	 *       unset and set, respectively.
>> +	 *
>> +	 * We worry about two cases where contiguous bit is used:
>> +	 *  - When folding N smaller non-contiguous ptes as 1 contiguous block.
>> +	 *  - When unfolding a contiguous block into N smaller non-contiguous ptes.
>> +	 *
>> +	 * Currently, the BBML0 folding case looks as follows:
>> +	 *
>> +	 *  0) Initial page-table layout:
>> +	 *
>> +	 *   +----+----+----+----+
>> +	 *   |RO,n|RO,n|RO,n|RW,n| <--- last page being set as RO
>> +	 *   +----+----+----+----+
>> +	 *
>> +	 *  1) Aggregate AF + dirty flags using __ptep_get_and_clear():
>> +	 *
>> +	 *   +----+----+----+----+
>> +	 *   |  0 |  0 |  0 |  0 |
>> +	 *   +----+----+----+----+
>> +	 *
>> +	 *  2) __flush_tlb_range():
>> +	 *
>> +	 *   |____ tlbi + dsb ____|
>> +	 *
>> +	 *  3) __set_ptes() to repaint contiguous block:
>> +	 *
>> +	 *   +----+----+----+----+
>> +	 *   |RO,c|RO,c|RO,c|RO,c|
>> +	 *   +----+----+----+----+
> 
> From the initial layout to point (3), we are also changing the
> permission. Given the rules you mentioned in the Arm ARM, I think that's
> safe (hardware seeing either the old or the new attributes). The
> FEAT_BBM description, however, only talks about change between larger
> and smaller blocks but no mention of also changing the attributes at the
> same time. Hopefully the microarchitects claiming certain CPUs don't
> generate conflict aborts understood what Linux does.
> 
>> +	 *
>> +	 *  4) The kernel will eventually __flush_tlb() for changed page:
>> +	 *
>> +	 *                  |____| <--- tlbi + dsb
> [...]
>> +	 * It is also important to note that at the end of the BBML2 folding
>> +	 * case, we are still left with potentially all N TLB entries still
>> +	 * cached (the N-1 non-contiguous ptes, and the single contiguous
>> +	 * block). However, over time, natural TLB pressure will cause the
>> +	 * non-contiguous pte TLB entries to be flushed, leaving only the
>> +	 * contiguous block TLB entry. This means that omitting the tlbi+dsb is
>> +	 * not only correct, but also keeps our eventual performance benefits.
> 
> Step 4 above implies some TLB flushing from the core code eventually.
> What is the situation mentioned in the paragraph above? Is it only until
> we get the TLB flushing from the core code?

I think the point that Miko is making here is that at some point between step 3
and 4, we could end up with up to any 3 of the original small entries as well as
the large entry in the TLB. Then the flush at step 4 will only remove the small
entry at the last entry and the large entry - i.e. it will only remove the
entries that overlap the region that the tlbi targets, and up to 3 of the small
entries may be left in the TLB after step 4. Our rationale here was that this is
safe due to BBML2 and it will naturally sort itself out over time with natural
eviction.

> 
> [...]
>> +	if (!system_supports_bbml2_noabort())
>> +		__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>>  
>>  	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
> 
> Eliding the TLBI here is all good but looking at the overall set_ptes(),
> why do we bother with unfold+fold for BBML2? Can we not just change
> them in place without going through __ptep_get_and_clear()?

We need to collect the access and dirty bits so we can apply the aggregate
across all entries. We can only accurately collect the access and dirty bits if
we go via invalid, otherwise the HW could update after we have read the old
entry but before we have written the new entry.

Thanks,
Ryan

