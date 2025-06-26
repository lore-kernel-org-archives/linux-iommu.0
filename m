Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E741E008B
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750956329; cv=none; b=Z9XrLP/MHT2wL5cgZ3e43MFbPaBmw5FBMkvjNJyY1yC4yeX6xdyO/k9AfdzWEmaXDH5vFF2igqtBxHJZ6X2mLclFk0QlTSSBhjJ/8vX6Vk4rz1710tWJYpv8Gvuxb0gPHSKOqQQwiUKM2tZTQxTP9oexXB/sPQGVcbtQlQIXwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750956329; c=relaxed/simple;
	bh=Pxdh9QV5lAVnaM2iXn6GFDZxOod8efY6UTUkN/h/bT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUokY8RwhFVs8BhSSnTrjwTjeVA3e9rhtOupGihltzJ1PIaZA60rYC0UA07yHkUG1ZK9CFygVMBBqTJXtnQjTqyO4uHokORMzy+QoDDpTTUCcHafc01Z9U7+wUHR6yKwwXWSBiQ4gLsJMk1m9NIHU2Eq+ww/V5/Yyp4I1RSOmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 466FC1758;
	Thu, 26 Jun 2025 09:45:09 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 924AB3F66E;
	Thu, 26 Jun 2025 09:45:24 -0700 (PDT)
Message-ID: <0f95be6d-2e13-4281-98b5-6d4311a3b98f@arm.com>
Date: Thu, 26 Jun 2025 17:45:18 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] docs: dma-api: update streaming DMA API physical
 address constraints
To: Petr Tesarik <ptesarik@suse.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>, Leon Romanovsky
 <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
 John Garry <john.g.garry@oracle.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, iommu@lists.linux.dev
References: <20250624133923.1140421-1-ptesarik@suse.com>
 <20250624133923.1140421-8-ptesarik@suse.com> <aFynHWAYtKPFT55P@archie.me>
 <20250626070602.3d42b607@mordecai.tesarici.cz>
 <bdb3a37a-a9d3-44c1-8eb7-41912c976ad1@arm.com>
 <20250626154818.46b0cfb1@mordecai.tesarici.cz>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250626154818.46b0cfb1@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/06/2025 2:48 pm, Petr Tesarik wrote:
> On Thu, 26 Jun 2025 10:58:00 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 2025-06-26 6:06 am, Petr Tesarik wrote:
>>> On Thu, 26 Jun 2025 08:49:17 +0700
>>> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>>    
>>>> On Tue, Jun 24, 2025 at 03:39:22PM +0200, Petr Tesarik wrote:
>>>>> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
>>>>> index cd432996949c..65132ec88104 100644
>>>>> --- a/Documentation/core-api/dma-api.rst
>>>>> +++ b/Documentation/core-api/dma-api.rst
>>>>> @@ -210,18 +210,12 @@ DMA_BIDIRECTIONAL	direction isn't known
>>>>>    	this API should be obtained from sources which guarantee it to be
>>>>>    	physically contiguous (like kmalloc).
>>>>>    
>>>>> -	Further, the DMA address of the memory must be within the dma_mask of
>>>>> -	the device.  To ensure that the memory allocated by kmalloc is within
>>>>> -	the dma_mask, the driver may specify various platform-dependent flags
>>>>> -	to restrict the DMA address range of the allocation (e.g., on x86,
>>>>> -	GFP_DMA guarantees to be within the first 16MB of available DMA
>>>>> -	addresses, as required by ISA devices).
>>>>> -
>>>>> -	Note also that the above constraints on physical contiguity and
>>>>> -	dma_mask may not apply if the platform has an IOMMU (a device which
>>>>> -	maps an I/O DMA address to a physical memory address).  However, to be
>>>>> -	portable, device driver writers may *not* assume that such an IOMMU
>>>>> -	exists.
>>>>> +	Mapping may also fail if the memory is not within the DMA mask of the
>>>>> +	device.  However, this constraint does not apply if the platform has
>>>>> +	an IOMMU (a device which maps an I/O DMA address to a physical memory
>>>>> +	address), or the kernel is configured with SWIOTLB (bounce buffers).
>>>>> +	It is reasonable to assume that at least one of these mechanisms
>>>>> +	allows streaming DMA to any physical address.
>>>
>>> Now I realize this last sentence may be contentious...
>>
>> The whole paragraph is wrong as written, not least because it is
>> conflating two separate things: "any physical address" is objectively
>> untrue, since SWIOTLB can only bounce from buffers within by the
>> kernel's linear/direct map, i.e. not highmem, not random memory
>> carveouts, and and definitely not PAs which are not RAM at all.
> 
> I see, saying "any" was indeed too strong.
> 
>> Secondly, even if the source buffer *is* bounceable/mappable, there is
>> still no guarantee at all that it can actually be made to appear at a
>> DMA address within an arbitrary DMA mask. We aim for a general
>> expectation that 32-bit DMA masks should be well-supported (but still
>> not 100% guaranteed), but anything smaller can absolutely still have a
>> high chance of failing, e.g. due to the SWIOTLB buffer being allocated
>> too high or limited IOVA space.
> 
> Of course this cannot be guaranteed. The function may always fail and
> return DMA_MAPPING_ERROR. No doubts about it.
> 
>>> @Marek, @Robin Do you agree that device drivers should not be concerned
>>> about the physical address of a buffer passed to the streaming DMA API?
>>>
>>> I mean, are there any real-world systems with:
>>>     * some RAM that is not DMA-addressable,
>>>     * no IOMMU,
>>>     * CONFIG_SWIOTLB is not set?
>>
>> Yes, almost certainly, because "DMA-addressable" depends on individual
>> devices. You can't stop a user from sticking, say, a Broadcom 43xx WiFi
>> card into a PCI slot on an i.MX6 board with 2GB of RAM that *starts*
>> just above its 31-bit DMA capability. People are still using AMD Seattle
>> machines, where even though arm64 does have SWIOTLB it's essentially
>> useless since RAM starts up around 40 bits IIRC (and although they do
>> also have SMMUs for PCI, older firmware didn't advertise them).
> 
> Some of these scenarios can never work properly because of hardware
> limitations. There's nothing software can do about a bus master which
> cannot address any RAM in the machine. I'm not trying to claim that an
> operating system kernel can do magic and square the circle. If that's
> how it sounded, then my wording needs to be improved.
> 
> IIUC the expected audience of this document are device driver authors.
> They want a clear guidance on how they should allocate buffers for the
> streaming DMA API. Now, it is my understanding that device drivers
> should *not* have to care about the physical location of a buffer
> passed to the streaming DMA API.
> 
> Even if a bus master implements less than 32 address bits in hardware,
> I'm convinced that device drivers should not have to examine the system
> to check if an IOMMU is available and try to guess whether a buffer
> must be bounced, and how exactly the bounce buffer should be allocated.

It's never been suggested that drivers should do that; indeed trying to 
poke into and second-guess the DMA API implementation is generally even 
less OK than making blind assumptions about what it might do. The 
overall message here is essentially "if you want to do streaming DMA 
then you may need to be wary of where your memory comes from." We can't 
just throw that out and say "Yeah it's fine now, whatever you do the API 
will deal with it" because that simply isn't true as a general 
statement; drivers dealing with limited DMA masks *do* still need to be 
concerned with GFP_DMA (or even GFP_DMA32 might still be advisable in 
certain cases) if they want to have an appreciable chance of success. 
All that's different these days is that notion of "limited" generally 
meaning "32 bits or smaller".

> If we can agree on this, I can iron out the details for a v2 of this
> patch series.
> 
>>> FWIW if _I_ received a bug report that a device driver fails to submit
>>> I/O on such a system, I would politely explain the reporter that their
>>> kernel is misconfigured, and they should enable CONFIG_SWIOTLB.
>>
>> It's not really that simple. SWIOTLB, ZONE_DMA, etc. require platform
>> support, which end users can't just turn on if it's not there to begin with.
> 
> I know this very well. As you may not be aware, my ultimate goal is to
> get rid of ZONE_DMA and instead enhance the buddy allocator to allow
> allocations within an arbitrary physical address range, which will not
> rely on platform support. But that's another story; for now, let's just
> agree on how the DMA API is supposed to work.

Indeed that might actually end up pushing things in the opposite 
direction, at least in some cases. Right now, a driver with, say, a 
40-bit DMA mask is usually better off not special-casing DMA buffers, 
and just making plain GFP_KERNEL allocations for everything (on the 
assumption that 64-bit systems with masses of memory *should* have 
SWIOTLB to cover things in the worst case), vs. artificially 
constraining its DMA buffers to GFP_DMA32 and having to deal with 
allocation failure more often. However with a more precise and flexible 
allocator, there's then a much stronger incentive for such drivers to 
explicitly mark *every* allocation that may be used for DMA, in order to 
get the optimal behaviour.

Thanks,
Robin.
