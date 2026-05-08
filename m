Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEF8344DAD
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778238113; cv=none; b=ru4tl3Cz/qVAuwf/u1AqaE+Jr7fPnEhgxZtouoHKQZQtje/H4rALbfNUPYZAEbSYBrOFOXXKKsKHAZqd+irD4zTvXGMLFF6Ov8GMY1CfuXGrZSLDZtC+Vn6KAwzqmmjiJ5xQEZTGHmBQ1tgYklbc6e7OJw8s2I03qAb9q1fsuzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778238113; c=relaxed/simple;
	bh=mqK+2YeESJaV7QV6CYDbc34GQT+5UVZCH1ggHivoFU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwwmY9K7YHkFb0nRDPtA1g66UItozT7PaTXqK1kWF+VPaUA9HxRmNvbEZaJBAvmnb3t1qrPApkxeo8JYM0q2yw6Wb2IyxrAgzp82Cm6tJbofRu41unHV/tTBthfbg4a62mZDrFC4Ve4GvnG3tphnDdJEo6GOT90q6bRcibhREi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lQ4iQgkp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lQ4iQgkp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3437E1BCA;
	Fri,  8 May 2026 04:01:44 -0700 (PDT)
Received: from [10.57.63.248] (unknown [10.57.63.248])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F0FA3F763;
	Fri,  8 May 2026 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778238109; bh=mqK+2YeESJaV7QV6CYDbc34GQT+5UVZCH1ggHivoFU8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lQ4iQgkpS5ezS7c4f00lDSFmSEvhs+mspN0EmqGsx5if4FCwdrzbHpdT7mnfOkyk8
	 dJTni/hnNWwcrLgw/p2GP7ZB2BYC71vQBRK+9D7NLF7VD9a8LhTQC0qKrTUgtm4ffy
	 vInVgGd10H0aWhQD0xqoa1/PQtE3/RcWIol2KOT4=
Message-ID: <ad90b0cd-a5d2-4953-af7d-753aed60354f@arm.com>
Date: Fri, 8 May 2026 12:01:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>, m.szyprowski@samsung.com
Cc: leon@kernel.org, kbusch@kernel.org, jgg@ziepe.ca, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
 <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
 <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-05-08 11:01 am, Jianpeng Chang wrote:
> 
> 
> 在 2026/5/7 下午9:18, Robin Murphy 写道:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender 
>> and know the content is safe.
>>
>> On 07/05/2026 4:21 am, Jianpeng Chang wrote:
>>> dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
>>> However, pfn_valid() only checks for availability of the memory map 
>>> for a
>>> PFN but it does not ensure that the PFN is actually backed by RAM. On
>>> ARM64 with SPARSEMEM (128MB section granularity), MMIO addresses that
>>> share a section with RAM will falsely trigger the WARN_ON_ONCE.
>>>
>>> This causes a WARNING on Raspberry Pi 4 during spi_bcm2835 probe because
>>> the SPI FIFO register (0xfe204004) falls in the same sparsemem 
>>> section as
>>> the end of RAM (0xf8000000-0xfbffffff), both in section 31
>>> (0xf8000000-0xffffffff).
>>>
>>> The pfn_valid() check was originally removed by commit a9c38c5d267c
>>> ("dma-mapping: remove bogus test for pfn_valid from dma_map_resource")
>>> but was accidentally re-introduced by commit f7326196a781
>>> ("dma-mapping: export new dma_*map_phys() interface") during the
>>> refactoring of dma_map_resource() into a wrapper around dma_map_phys().
>>>
>>> Drop the pfn_valid() test from dma_map_resource() again.
>>
>> As I said last time, I think pfn_valid() && !PageReserved(pfn_to_page())
>> would be enough for what we want here, although now it's strictly under
>> CONFIG_DMA_API_DEBUG, perhaps the overhead of memblock_is_map_memory()
>> might be less of an issue. Either way though, now that it's all
>> channelled through the single dma_map_phys() path, it would probably
>> make sense to consolidate any MMIO sanity-checking into
>> dma_debug_map_phys() anyway :/
> Thanks for the suggestion. Move the check into debug_dma_map_phys() is 
> indeed better, and I will replace pfn_valid() with pfn_valid() && ! 
> PageReserved() as you suggested.

Oh, and just to clarify on the points DavidH raised last time, indeed 
PageReserved isn't 100% accurate for this, and there may well be 
reserved pages which shouldn't be DMA-mapped either, but that's a 
reasonable false-negative (especially compared to having no check at 
all!) - the main thing is any *non*-reserved page represents "kernel 
memory" to enough of a degree that using DMA_ATTR_MMIO is almost 
certainly wrong and liable to break coherency.

Cheers,
Robin.
