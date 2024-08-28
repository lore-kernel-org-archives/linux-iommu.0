Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E33D96A
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 04:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818503; cv=none; b=cGptf/FnOj/SlPj931SK76TsQPiqH3KnQ8dt3zPlxAbROAtajAjL52Am82XPU/M6kVYyoLsXwuiDtRDyEYHN9SpUpx/jW0nxfi+RUre4rU8kMqUIgI8rL6sUr47YwccVR5iA7bqvIjHjU07BnBfc3s9Q7yb4F82SPPrhl4zs2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818503; c=relaxed/simple;
	bh=HDk7c503UbfGOlzje5ZzCxaJMFZSS4/0pwfqqArE/9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VWLwJAs06XxkB/Q/vJ1eSf1UOH1TxiweBq6so86fzvn2UupzmljrAKy2UVbplC/5fnPr+euMMtfTHiKH4Ed79+O/aj/DUcue0rzVMULF/4XF4OBR0c3Iw/kO9O+ftlABnn0rwqxuTqscovdmNnAKEKsq+RPpcUVDthPmRyW4gLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=ArST6Ntb; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="ArST6Ntb"
Received: from localhost (unknown [10.0.8.3])
	by mail.tkos.co.il (Postfix) with ESMTP id A7195440F90;
	Wed, 28 Aug 2024 07:13:03 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1724818383;
	bh=HDk7c503UbfGOlzje5ZzCxaJMFZSS4/0pwfqqArE/9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ArST6NtbDOFjm4LykbnIQT39RmzOiJmByFAQjNooW5e+R//nJd6BzdQgdTZWq2Gz7
	 MUsAsGpoMBzc0KIqopaPcWmY8Et5CKqgrnnaFAisIlIUT/ZvcnILJnW3Z/StqiM3OY
	 aJdLs4YAjKFqEhTWE50sgdx7VlM8kB5nv+uzUya2/hkHqi7I0LDA2V3ZnChm4cKZj3
	 1lHFIb3w4h8s8ppaOgAk2EELgFqxXeASYYfwLk5atekiLdI0FvvAzz7gscLWjbyQ2j
	 mn4DMWKbqGGlFLR09qM/9XFu5try/KEdpwDVmX4TYD4aHYscXZl1yIiLduezho7Mol
	 ZQyuikyzxV30g==
From: Baruch Siach <baruch@tkos.co.il>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,  Marek Szyprowski
 <m.szyprowski@samsung.com>,  Catalin Marinas <catalin.marinas@arm.com>,
  Will Deacon <will@kernel.org>,  iommu@lists.linux.dev,
  linux-arm-kernel@lists.infradead.org,  Petr =?utf-8?B?VGVzYcWZw61r?=
 <petr@tesarici.cz>,
  Ramon Fried <ramon@neureality.ai>,  Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH] arm64: mm: fix DMA zone when dma-ranges is missing
In-Reply-To: <53679dda-178c-435b-81c5-42d139911cef@arm.com> (Robin Murphy's
	message of "Tue, 27 Aug 2024 11:22:28 +0100")
References: <731d204f5f556ad61bbaf004b1d984f83c90b4f5.1724748249.git.baruch@tkos.co.il>
	<53679dda-178c-435b-81c5-42d139911cef@arm.com>
Date: Wed, 28 Aug 2024 07:14:56 +0300
Message-ID: <87ed69uvun.fsf@tarshish>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi Robin,

On Tue, Aug 27 2024, Robin Murphy wrote:
> On 2024-08-27 9:44 am, Baruch Siach wrote:
>> Some platforms, like Rockchip RK3568 based Odroid M1, do not provide DMA
>> limits information in device-tree dma-ranges property. Still some device
>> drivers set DMA limit that relies on DMA zone at low 4GB memory area.
>> Until commit ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by
>> zone_dma_limit"), zone_sizes_init() restricted DMA zone to low 32-bit
>> when there is RAM there.
>> Restore DMA zone 32-bit limit for platforms that have RAM in this area.
>> Fixes: ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by zone_dma_limit")
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> ---
>> This should go via the dma-mapping tree that contains the fixed commit.
>> ---
>>   arch/arm64/mm/init.c | 3 +++
>>   1 file changed, 3 insertions(+)
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index bfb10969cbf0..7fcd0aaa9bb6 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -116,6 +116,9 @@ static void __init arch_reserve_crashkernel(void)
>>     static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>>   {
>> +	if (memblock_start_of_DRAM() < U32_MAX)
>> +		zone_limit = min(zone_limit, U32_MAX);
>
> This seems like a bit of a bodge, since it now means we either get the old or
> the new behaviour depending on where DRAM is, so if, say, RAM starts at 3GB
> but all devices have a 3GB DMA offset, we still can't have a properly-sized
> DMA zone.

I'm not following your example here. What is "3GB DMA offset"? Is it
relative to 0? Relative to start of RAM?

> Really it comes down to this change:
>
> -       zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
> +       zone_dma_limit = min(dt_zone_dma_limit, acpi_zone_dma_limit);
>
> where although the "32" represented the assumption of RAM starting at 0, it
> also implicitly removed the handling of the case where no DMA ranges are
> specified. Per the commit message, it's that which we want to account for, not
> the placement of RAM.
>
> I think the more correct version should be:
>
> 	if (zone_limit == PHYS_ADDR_MAX)
> 		zone_limit = U32_MAX;

I like your proposal. The condition of no dma-ranges data is explicit.

I'll post v2 later today.

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
