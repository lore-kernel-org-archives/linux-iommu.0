Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15F312E1DC
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201107; cv=none; b=ZX4gNV/EV4hJ5OWxzSpERAsoXShxlodNEg29MDseqBZklMJRSu9RJxr90muJQcDioysGlCOTfJvp2buZjSvU8D+q6mBKQGB/UXyf9SxN9hTBXWxzcpVn9FWKqJl7QQE7OvUDrbwSftHNQ85WqUTicquCZww05m7zYZOvggw/9Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201107; c=relaxed/simple;
	bh=s/z7xAAXncvwUSOTtRLOIOjAzsl8T/73uPy1pjdoxQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMDAdEdzAuAuGjdMCp30npouN3Ryhg9uRAkDjPtkJYO2v5+pmiz/BryVaYDszmimbLyUYP9k7YerQUtQgnl70qokg9CIlQh2yTjwFqInarhdjptpOJG6fKwFeJo6+QMpYdcDowQDYcJj5XUQHBIgDgeI/26GTjOk/31AblVzOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA3EA14BF;
	Fri, 27 Feb 2026 06:04:58 -0800 (PST)
Received: from [10.57.55.4] (unknown [10.57.55.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B70FC3F62B;
	Fri, 27 Feb 2026 06:05:03 -0800 (PST)
Message-ID: <da6db3e2-4d42-41af-b6b5-efa7532ecb7c@arm.com>
Date: Fri, 27 Feb 2026 14:05:01 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] iommu/dma: Validate page before accessing P2PDMA
 state
To: Ashish Mhetre <amhetre@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Pranjal Shrivastava <praan@google.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-mm@kvack.org
References: <20260224104257.1641429-1-amhetre@nvidia.com>
 <20260224123221.GM10607@unreal> <aZ4Q1HA9q1ojsVYY@google.com>
 <9d01b4e3-be5b-4c9c-8088-1d10f67f1fd8@nvidia.com>
 <20260225075609.GB9541@unreal> <aZ9Xccnn7JOikudb@google.com>
 <20260226075806.GE12611@unreal>
 <58634d52-5d44-4ec9-b1f6-273b5c32b525@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <58634d52-5d44-4ec9-b1f6-273b5c32b525@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-02-27 5:46 am, Ashish Mhetre wrote:
> 
> 
> On 2/26/2026 1:28 PM, Leon Romanovsky wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Wed, Feb 25, 2026 at 08:11:29PM +0000, Pranjal Shrivastava wrote:
>>> On Wed, Feb 25, 2026 at 09:56:09AM +0200, Leon Romanovsky wrote:
>>>> On Wed, Feb 25, 2026 at 10:19:41AM +0530, Ashish Mhetre wrote:
>>>>>
>>>>> On 2/25/2026 2:27 AM, Pranjal Shrivastava wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> On Tue, Feb 24, 2026 at 02:32:21PM +0200, Leon Romanovsky wrote:
>>>>>>> On Tue, Feb 24, 2026 at 10:42:57AM +0000, Ashish Mhetre wrote:
>>>>>>>> When mapping scatter-gather entries that reference reserved
>>>>>>>> memory regions without struct page backing (e.g., bootloader 
>>>>>>>> created
>>>>>>>> carveouts), is_pci_p2pdma_page() dereferences the page pointer
>>>>>>>> returned by sg_page() without first verifying its validity.
>>>>>>> I believe this behavior started after commit 88df6ab2f34b
>>>>>>> ("mm: add folio_is_pci_p2pdma()"). Prior to that change, the
>>>>>>> is_zone_device_page(page) check would return false when given a
>>>>>>> non‑existent page pointer.
>>>>>>>
>>>>> Thanks Leon for the review. This crash started after commit 
>>>>> 30280eee2db1
>>>>> ("iommu/dma: support PCI P2PDMA pages in dma-iommu map_sg").
>>>>>
>>>>>> Doesn't folio_is_pci_p2pdma() also check for zone device?
>>>>>> I see[1] that it does:
>>>>>>
>>>>>> static inline bool folio_is_pci_p2pdma(const struct folio *folio)
>>>>>> {
>>>>>>           return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
>>>>>>                   folio_is_zone_device(folio) &&
>>>>>>                   folio->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
>>>>>> }
>>>>>>
>>>>>> I believe the problem arises due to the page_folio() call in
>>>>>> folio_is_pci_p2pdma(page_folio(page)); within is_pci_p2pdma_page().
>>>>>> page_folio() assumes it has a valid struct page to work with. For 
>>>>>> these
>>>>>> carveouts, that isn't true.
>>>>>>
>>>>>> Potentially something like the following would stop the crash:
>>>>>>
>>>>>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>>>>>> index e3c2ccf872a8..e47876021afa 100644
>>>>>> --- a/include/linux/memremap.h
>>>>>> +++ b/include/linux/memremap.h
>>>>>> @@ -197,7 +197,8 @@ static inline void 
>>>>>> folio_set_zone_device_data(struct folio *folio, void *data)
>>>>>>
>>>>>>    static inline bool is_pci_p2pdma_page(const struct page *page)
>>>>>>    {
>>>>>> -       return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
>>>>>> +       return IS_ENABLED(CONFIG_PCI_P2PDMA) && page &&
>>>>>> +               pfn_valid(page_to_pfn(page)) &&
>>>>>>                   folio_is_pci_p2pdma(page_folio(page));
>>>>>>    }
>>>>>>
>>>>> Yes, this will also fix the crash.
>>>>>
>>>>>> But my broader question is: why are we calling a page-based API like
>>>>>> is_pci_p2pdma_page() on non-struct-page memory in the first place?
>>>>>> Could we instead add a helper to verify if the sg_page() return value
>>>>>> is actually backed by a struct page? If it isn't, we should arguably
>>>>>> skip the P2PDMA logic entirely and fall back to a dma_map_phys style
>>>>>> path. Isn't handling these "pageless" physical ranges the primary 
>>>>>> reason
>>>>>> dma_map_phys exists?
>>>>> Thanks for the feedback, Pranjal.
>>>>>
>>>>> To clarify: are you suggesting we handle non-page-backed mappings 
>>>>> inside
>>>>> iommu_dma_map_sg (within dma-iommu), or that callers should detect
>>>>> non-page-backed memory and use dma_map_phys instead of dma_map_sg?
>>>> The latter one.
>>>>
>>> Yup, I meant the latter.
>>>
>>>>> Former approach sounds better so that existing iommu_dma_map_sg 
>>>>> callers
>>>>> don't need changes, but I'd like to confirm your preference.
>>>> The bug is in callers which used wrong API, they need to be adapted.
>>> Yes, the thing is, if the caller already knows that the region to be
>>> mapped is NOT struct page-backed, then why does it use dma_map_sg
>>> variants?
>> Before dma_map_phys() was added, there was no reliable way to DMA‑map
>> such memory, and using dma_map_sg() was a workaround that happened to
>> work. I'm not sure whether it worked by design or by accident, but the
>> correct approach now is to use dma_map_phys().
> 
> Thanks Leon and Pranjal for the detailed feedback. I'll update our 
> callers to use
> dma_map_phys() for non-page-backed buffers.
> 
> One question: would it make sense to add a check in iommu_dma_map_sg to
> fail gracefully when non-page-backed buffers are passed, instead of 
> crashing
> the kernel?

No, it is the responsibility of drivers not to abuse kernel APIs 
inappropriately. Checking for misuse adds overhead that penalises 
correct users. dma_map_page/sg on non-page-backed memory has never been 
valid, and it would only have been system-configuration-dependent luck 
that it wasn't already blowing up before. I guess dma-debug could add 
additional checks on these APIs similarly to debug_dma_map_single(), but 
the fact that we've never even considered checking for made-up bogus 
struct page pointers only goes to show just how wrong a thing to do it is.

Thanks,
Robin.
