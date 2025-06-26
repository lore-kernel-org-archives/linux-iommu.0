Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418762BEFFE
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750931887; cv=none; b=hN1JCz5RWWDr8YAzl2iWNbxHtI5WrvN0SyIVnpfgdvEpjva5d/Q2zJFiM1W6bfaAmf/YEAOVQG9WFmTndIhminNDMtJDfbBJnYPejfd1lXLOUjub8IudgqJ39JzYEMYOZlaCyC2dDoryq6tp72SykanUcLuWpa2hffn19Y4M0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750931887; c=relaxed/simple;
	bh=6nEYBtoZ0vNY5kStOseLHhnbLGBP+qWZ1cihVHuZjiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l14Q6xPU12xjzo1IRNdT+goyEKKon+7e29oUHouIJbFaI2JCaoHsMSLetPfRNpxzowfhOSRld0C3bGgx7yo2YAxALvbJNye7ldiv0q9p1aYfknW9lx77bQn8kdDbZP6tSEfOmEhrNq9a6MdydxMf75PxUqgILhyUnvz/SP7PWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 908DB1063;
	Thu, 26 Jun 2025 02:57:47 -0700 (PDT)
Received: from [10.57.29.201] (unknown [10.57.29.201])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF4B43F58B;
	Thu, 26 Jun 2025 02:58:02 -0700 (PDT)
Message-ID: <bdb3a37a-a9d3-44c1-8eb7-41912c976ad1@arm.com>
Date: Thu, 26 Jun 2025 10:58:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] docs: dma-api: update streaming DMA API physical
 address constraints
To: Petr Tesarik <ptesarik@suse.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250626070602.3d42b607@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-26 6:06 am, Petr Tesarik wrote:
> On Thu, 26 Jun 2025 08:49:17 +0700
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
>> On Tue, Jun 24, 2025 at 03:39:22PM +0200, Petr Tesarik wrote:
>>> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/dma-api.rst
>>> index cd432996949c..65132ec88104 100644
>>> --- a/Documentation/core-api/dma-api.rst
>>> +++ b/Documentation/core-api/dma-api.rst
>>> @@ -210,18 +210,12 @@ DMA_BIDIRECTIONAL	direction isn't known
>>>   	this API should be obtained from sources which guarantee it to be
>>>   	physically contiguous (like kmalloc).
>>>   
>>> -	Further, the DMA address of the memory must be within the dma_mask of
>>> -	the device.  To ensure that the memory allocated by kmalloc is within
>>> -	the dma_mask, the driver may specify various platform-dependent flags
>>> -	to restrict the DMA address range of the allocation (e.g., on x86,
>>> -	GFP_DMA guarantees to be within the first 16MB of available DMA
>>> -	addresses, as required by ISA devices).
>>> -
>>> -	Note also that the above constraints on physical contiguity and
>>> -	dma_mask may not apply if the platform has an IOMMU (a device which
>>> -	maps an I/O DMA address to a physical memory address).  However, to be
>>> -	portable, device driver writers may *not* assume that such an IOMMU
>>> -	exists.
>>> +	Mapping may also fail if the memory is not within the DMA mask of the
>>> +	device.  However, this constraint does not apply if the platform has
>>> +	an IOMMU (a device which maps an I/O DMA address to a physical memory
>>> +	address), or the kernel is configured with SWIOTLB (bounce buffers).
>>> +	It is reasonable to assume that at least one of these mechanisms
>>> +	allows streaming DMA to any physical address.
> 
> Now I realize this last sentence may be contentious...

The whole paragraph is wrong as written, not least because it is 
conflating two separate things: "any physical address" is objectively 
untrue, since SWIOTLB can only bounce from buffers within by the 
kernel's linear/direct map, i.e. not highmem, not random memory 
carveouts, and and definitely not PAs which are not RAM at all. 
Secondly, even if the source buffer *is* bounceable/mappable, there is 
still no guarantee at all that it can actually be made to appear at a 
DMA address within an arbitrary DMA mask. We aim for a general 
expectation that 32-bit DMA masks should be well-supported (but still 
not 100% guaranteed), but anything smaller can absolutely still have a 
high chance of failing, e.g. due to the SWIOTLB buffer being allocated 
too high or limited IOVA space.

> @Marek, @Robin Do you agree that device drivers should not be concerned
> about the physical address of a buffer passed to the streaming DMA API?
> 
> I mean, are there any real-world systems with:
>    * some RAM that is not DMA-addressable,
>    * no IOMMU,
>    * CONFIG_SWIOTLB is not set?

Yes, almost certainly, because "DMA-addressable" depends on individual 
devices. You can't stop a user from sticking, say, a Broadcom 43xx WiFi 
card into a PCI slot on an i.MX6 board with 2GB of RAM that *starts* 
just above its 31-bit DMA capability. People are still using AMD Seattle 
machines, where even though arm64 does have SWIOTLB it's essentially 
useless since RAM starts up around 40 bits IIRC (and although they do 
also have SMMUs for PCI, older firmware didn't advertise them).

> FWIW if _I_ received a bug report that a device driver fails to submit
> I/O on such a system, I would politely explain the reporter that their
> kernel is misconfigured, and they should enable CONFIG_SWIOTLB.

It's not really that simple. SWIOTLB, ZONE_DMA, etc. require platform 
support, which end users can't just turn on if it's not there to begin with.

Thanks,
Robin.
