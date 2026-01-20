Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AE147886F;
	Tue, 20 Jan 2026 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936928; cv=none; b=ORAB7IoWvcy3TJPL3p9FOPl4DIu03jVC6WVGrRyg0wr5Nc7N6rNOJkF8yY8Vlwca7XBJQQ89UKQYmRzt29un5yP/7/WH1bUchznb6gg1+HiVbXifIS04Ynn+DCO2Uq1j0k0S1LjCuPh7PwAfmrO+o9hi/0DiZ63xN7xClPWHJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936928; c=relaxed/simple;
	bh=fHz2YOLDMN3k9zSXfasCjgbpvcHgmmzt+EZjwtKQk28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtmytsaKxeWyG4uEAPv1arfyLfUq4NVoNerPqra3qtg/qFpeLzUyxrGQW2KRTkP38KvVuhMNdOLXmF9Z0xG5cfm5DkmrLF2DD5O/+bm4zHHGrrSOA5YbvPiBcir+XZ+frh3iRm2+ZXkN3MPwJUV/tUujyphNHbFnjWrHiGvD8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55A0F1517;
	Tue, 20 Jan 2026 11:21:58 -0800 (PST)
Received: from [10.57.49.114] (unknown [10.57.49.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 813923F632;
	Tue, 20 Jan 2026 11:22:03 -0800 (PST)
Message-ID: <b662e137-5d2a-4ee7-b1f7-b4545388d4fe@arm.com>
Date: Tue, 20 Jan 2026 19:22:01 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA
 addresses
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org, jgg@ziepe.ca,
 steven.price@arm.com, Marek Szyprowski <m.szyprowski@samsung.com>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
 <2a0b6d1b-875a-4075-8fc9-a8534afc9168@arm.com>
 <893a6503-d33f-41d8-8966-19b9f251d9da@arm.com> <yq5aqzrkjr9e.fsf@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <yq5aqzrkjr9e.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-01-20 2:25 pm, Aneesh Kumar K.V wrote:
> Robin Murphy <robin.murphy@arm.com> writes:
> 
>> On 2026-01-20 9:59 am, Suzuki K Poulose wrote:
>>> On 20/01/2026 06:42, Aneesh Kumar K.V (Arm) wrote:
>>>> On systems that apply an address encryption tag or mask to DMA addresses,
>>>> DMA mask validation must be performed against the canonical DMA address.
>>>> Using a non-canonical (e.g. encrypted or unencrypted) DMA address
>>>> can incorrectly fail capability checks, since architecture-specific
>>>> encryption bits are not part of the device’s actual DMA addressing
>>>> capability. For example, arm64 adds PROT_NS_SHARED to unencrypted DMA
>>>> addresses.
>>>>
>>>> Fix this by validating device DMA masks against __phys_to_dma(), ensuring
>>>> that the architecture encryption mask does not influence the check.
>>>>
>>>> Fixes: b66e2ee7b6c8 ("dma: Introduce generic dma_addr_*crypted helpers")
>>>
>>>
>>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>>>> ---
>>>>    kernel/dma/direct.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>>> index 8e04f72baaa3..a5639e9415f5 100644
>>>> --- a/kernel/dma/direct.c
>>>> +++ b/kernel/dma/direct.c
>>>> @@ -580,12 +580,12 @@ int dma_direct_supported(struct device *dev, u64
>>>> mask)
>>>>        /*
>>>>         * This check needs to be against the actual bit mask value, so use
>>>> -     * phys_to_dma_unencrypted() here so that the SME encryption mask
>>>> isn't
>>>> +     * __phys_to_dma() here so that the arch specific encryption mask
>>>> isn't
>>>>         * part of the check.
>>>>         */
>>>>        if (IS_ENABLED(CONFIG_ZONE_DMA))
>>>>            min_mask = min_t(u64, min_mask, zone_dma_limit);
>>>> -    return mask >= phys_to_dma_unencrypted(dev, min_mask);
>>>> +    return mask >= __phys_to_dma(dev, min_mask);
>>>
>>> This is wrong, isn't it ? For e.g., for CCA, even though the "Flag" is
>>> added to the PA, it is really part of the actual "PA" and thus must be
>>> checked against the full PA ?
>>
>> Yes, it's much the same as for AMD SEV (albeit the other way round) -
>> the encryption/decryption bit is part of the DMA address because it
>> needs to be driven by the device, so it is crucial that the device's DMA
>> mask is capable of expressing that.
>>
> 
> Commit c92a54cfa0257e8ffd66b2a17d49e9c0bd4b769f explains these details.

See x86's force_dma_unencrypted() implementation - the reason dma-direct 
doesn't need to be so strict for that is because things are the right 
way round that it can always fall back to shared/untrusted DMA as the 
general case, and a device can only access an encrypted page directly if 
it *can* drive the SME bit in the input address to trigger the inline 
encryption engine.

For CCA we have rather the opposite, where dma-direct requires a device 
to be able to address any IPA directly to be sure of working at all, but 
if we do happen to have a stage 1 IOMMU then we could rely on that to 
map smaller IOVAs to the upper IPA space.

> I was wondering whether the DMA-enable operation should live outside the
> set_mask operation. Conceptually, set_mask should be derived purely from
> max_pfn, while the DMA enablement path could additionally verify whether
> the device requires access to an alias address, depending on whether it
> is operating in trusted or untrusted mode?

No, the point of the set_mask check is "is this mask big enough to 
accommodate any *DMA address* we might need to give the device?" - that 
includes offsets, magic bits, magic bits encoded as fake offsets (yes 
you, Raspberry Pi...) and whatever else might comprise an actual DMA 
address as handed off to the hardware. It is *not* directly a "can this 
device DMA to all RAM we know about?" check - that is in the assumption 
that if necessary the SWIOTLB buffer will be reachable at a <=32-bit DMA 
address, and thus we should not *need* to give >32-bit addresses to 
devices. It is only that assumption which fundamentally falls apart for 
CCA (with more than 2GB of IPA space, at least).

Thanks,
Robin.
