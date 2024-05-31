Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9258D18645;
	Fri, 31 May 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153226; cv=none; b=tElgPIR66e/ETuD+pvysJWsOf/nsVf44vnVhkmhYEadM94Y4GwQMMrk+LVTxH1oXesNrLFwG8JxePy2+QmBdhBmLf6Fh93AdwuCmN5gT4/DQ7wFVPzusy46PI5e1HblHmlO/RQMs4hu2aPP1aEneFawlzTzD/yc+E2nsbdsK2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153226; c=relaxed/simple;
	bh=VVIA86U9f8HFRni8vCep8eKQmRd5Kj819/BFYRPQxU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIerQOs6JqRaiPzdJ2FQhHSDphsAnXudsMYqXfdYEccVk1edG4J0ABMstJtWcpEZ1vHymiitAr7oV80yV6bxAMYEbdn2I833jOG3Iq8RgGQAMVlpPFxwyDQyyyFbhenjlD+Tqcl6//LBuR1beHG0ydouo6cjc0EGQkd2gRY5Tos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 271591424;
	Fri, 31 May 2024 04:00:48 -0700 (PDT)
Received: from [10.57.67.251] (unknown [10.57.67.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90D5E3F792;
	Fri, 31 May 2024 04:00:21 -0700 (PDT)
Message-ID: <2bdd8966-5f25-4f2c-9aa9-7bd523b19edc@arm.com>
Date: Fri, 31 May 2024 12:00:20 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] iommu: sun50i: allocate page tables from below 4 GiB
To: Andre Przywara <andre.przywara@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240530233800.27705-1-andre.przywara@arm.com>
 <20240530233800.27705-3-andre.przywara@arm.com>
 <ecdc4d9f-a7b4-45e1-a870-e97cf4922539@arm.com>
 <20240531110241.6b26d072@donnerap.manchester.arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240531110241.6b26d072@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-31 11:02 am, Andre Przywara wrote:
> On Fri, 31 May 2024 09:37:02 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
> Hi Robin,
> 
>> On 2024-05-31 12:37 am, Andre Przywara wrote:
>>> The Allwinner IOMMU is a strict 32-bit device, with the page table root
>>> pointer as well as both level's page tables and also the target addresses
>>> all required to be below 4GB.
>>> The Allwinner H6 SoC only supports 32-bit worth of physical addresses
>>> anyway, so this isn't a problem so far, but the H616 and later SoCs extend
>>> the PA space beyond 32 bit to accommodate more DRAM.
>>> To make sure we stay within the 32-bit PA range required by the IOMMU,
>>> force the memory for the page tables to come from below 4GB. by using
>>> allocations with the DMA32 flag.
>>
>> Uh-oh... what about the output addresses in sun50i_mk_pte()? Limiting
>> its own accesses is OK, but if the IOMMU isn't capable of *mapping* any
>> valid PA for its clients, we can't easily support that.
> 
> Right, that's indeed a problem. I was hoping that the DMA32 address limit
> would somehow be enforced by the IOMMU master devices, so they would never
> issue addresses above 4GB to the IOMMU in the first place.
> Would this work if all those devices use a 32-bit DMA mask? Some of those
> devices might have that limit anyways, but those video devices are not
> my expertise, so I don't know much details.

It's fine to have a 32-bit *input* to the IOMMU - that only affects the 
IOVA allocation, wherein iommu-dma already considers both the IOMMU 
domain geometry and the client device's DMA mask to ensure it gives back 
a usable DMA address. Indeed, plumbing 32-bit devices into a system with 
a >32-bit PA space is one of the common reasons to have an IOMMU, but it 
assumes that IOMMU translations are capable of targeting the entire 
larger PA range.

> IIUC, atm the incoming PA would be masked down to 32-bit, I guess we should have a
> WARN_ONCE() there when this happens?
> The 32-bit limit would only affect boards with exactly 4GB of DRAM (the
> DRAM controller limit), and it only affects the last GB then, so using
> DMA32 wouldn't be a terrible limitation, I think.

The problem is when a client driver does, say, a dma_map_single() of 
some kmalloced buffer which it doesn't control, and which already 
happens to be at a >32-bit PA; iommu-dma can't make that work for you. 
At best we'd hope the iommu_map() returns an error and terminally fails 
the whole DMA mapping operation, at worst the IOMMU driver silently 
truncates the PA, maps the wrong memory, and all hell breaks loose :(

Thanks,
Robin.

> TBH, I picked this up from Jernej, so have to refer to him for further
> details.
> 
> Cheers,
> Andre
> 
> P.S. I agree that a 32-bit only IOMMU sounds somewhat stup^Wweird, but
> that's what we have. Maybe we would use it just for the VE only then, where
> it's really helpful to provide the illusion of large physically contiguous
> buffers.
> 
>> Thanks,
>> Robin.
>>
>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>> ---
>>>    drivers/iommu/sun50i-iommu.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
>>> index dd3f07384624c..c3244db5ac02f 100644
>>> --- a/drivers/iommu/sun50i-iommu.c
>>> +++ b/drivers/iommu/sun50i-iommu.c
>>> @@ -682,7 +682,8 @@ sun50i_iommu_domain_alloc_paging(struct device *dev)
>>>    	if (!sun50i_domain)
>>>    		return NULL;
>>>    
>>> -	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL, get_order(DT_SIZE));
>>> +	sun50i_domain->dt = iommu_alloc_pages(GFP_KERNEL | GFP_DMA32,
>>> +					      get_order(DT_SIZE));
>>>    	if (!sun50i_domain->dt)
>>>    		goto err_free_domain;
>>>    
>>> @@ -997,7 +998,7 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
>>>    
>>>    	iommu->pt_pool = kmem_cache_create(dev_name(&pdev->dev),
>>>    					   PT_SIZE, PT_SIZE,
>>> -					   SLAB_HWCACHE_ALIGN,
>>> +					   SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA32,
>>>    					   NULL);
>>>    	if (!iommu->pt_pool)
>>>    		return -ENOMEM;
> 
