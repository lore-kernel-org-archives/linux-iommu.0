Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A04284682
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768316576; cv=none; b=RaLSaJI37fk36+ZZ+SXuuax4Ns3kcqKIJWaJSWAi+PvTTazn1LCzwg3SqVnRvphAC8a3bmTNcLl451Tpg63WBx09886Xm6gWCB60zJ3p0zgNHeuRlJN6aNE+ZhrjDAcwpUkkmCy+vH9fFI2rXxkr9qrloGYBFCPW46SBROplfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768316576; c=relaxed/simple;
	bh=D5lDKMGmeaZUOUGtHvpc8lh5+brv8yEcIVWxZ87FScY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWQJirPjkM3hAjv/ByN40P+7D8GPLToxG+M0Od6gwRZ+r0ejNBw4N1mDAfrnaCEc3aYoqE4jJDlHSA0Fg12cPmuZT3Kt5Bf1qFHwvyfd6GVAvxnZ9sbT9Lo0SUZP/B+zveHB/15VodG/skulSg6ibJIaEdwjD2YlMnaXWZVNums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73D6A497;
	Tue, 13 Jan 2026 07:02:47 -0800 (PST)
Received: from [10.57.46.249] (unknown [10.57.46.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3A463F632;
	Tue, 13 Jan 2026 07:02:52 -0800 (PST)
Message-ID: <3a8f32c8-a5e5-4e6c-8af1-dbf0ff22b966@arm.com>
Date: Tue, 13 Jan 2026 15:02:44 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma/pool: respect __GFP_NOWARN in
 dma_alloc_from_pool()
To: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>, m.szyprowski@samsung.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: vigneshr@ti.com
References: <20260112104749.4132641-1-s-adivi@ti.com>
 <aa4565e7-af59-483a-a875-5bd970c9c923@arm.com>
 <d27d0a15-36a6-4399-a904-b0163804298d@ti.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <d27d0a15-36a6-4399-a904-b0163804298d@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-13 8:45 am, Adivi, Sai Sree Kartheek wrote:
> 
> 
> On 1/12/2026 7:43 PM, Robin Murphy wrote:
>> On 2026-01-12 10:47 am, Sai Sree Kartheek Adivi wrote:
>>> Currently, dma_alloc_from_pool() unconditionally warns and dumps a stack
>>> trace when an allocation fails.
>>>
>>> This prevents callers from using the __GFP_NOWARN flag to suppress error
>>> messages, breaking the expectation that this flag will silence
>>> allocation failure logs.
>>
>> This is not an "allocation failure" in that sense, though. It's not 
>> like the caller has opportunistically requested a large allocation, 
>> and is happy to try again with a smaller size - if someone has asked 
>> for an allocation in atomic context that can only be satisfied from an 
>> atomic pool, and there is no atomic pool at all, that points at 
>> something being more fundamentally wrong with the system, in a manner 
>> that the caller probably isn't expecting.
>>
>> Under what circumstances are you seeing the warning without things 
>> being totally broken anyway?
> 
> Hi Robin,
> 
> To clarify this specific circumstance: I am testing a dmaengine driver 
> using the in-kernel crypto test framework, which generates a synthetic 
> high load.
> 
> The driver attempts to allocate descriptors in an atomic context using 
> GFP_NOWAIT. When the atomic pool is exhausted under this stress, we want 
> to return NULL silently so the driver can gracefully handle the back 
> pressure by either:
> 1. Falling back to non-DMA (PIO) mode, or
> 2. Triggering dmaengine_synchronize() to allow async threads to actually 
> free up used descriptors.
> 
> Since the driver implements a valid fallback for this exhaustion, the 
> current unconditional WARN generates false alarms in the log.
> 
> This change would align dma_pool behavior with the core page allocator. 
> For example, warn_alloc() in mm/page_alloc.c explicitly checks for 
> __GFP_NOWARN to allow callers to suppress failure messages when they 
> have a recovery path.

Oof, apologies - looking again at the code in context, now I finally see 
what the bug really is: this warning still serves its original purpose, 
but due to the refactoring in 9420139f516d indeed it's *also* ended up 
in the path where the correct pool was found but was simply unable to 
satisfy the allocation. I agree that's not right - we never used to warn 
on an actual gen_pool_alloc() failure either way, so whether we have a 
suppressible (and more appropriately worded) warning for that condition 
I'm not too fussed. However, what I don't want to do is go too far the 
other way and lose the intended message when the requested allocation 
flags could *never* be satisfied by the current system configuration.

What distracted me is that I think the latter can be falsely reported 
for __GFP_DMA32 on a system where CONFIG_ZONE_DMA32 is enabled, but all 
the memory is in ZONE_DMA, so I was wondering whether your system was in 
that situation. The other series I sent should fix that.

> However if you feel the atomic pool should strictly not support silent 
> failures, the alternative would be for the driver to manually track its 
> own usage against the pool size and stop allocating before hitting the 
> limit. We prefer the __GFP_NOWARN approach as it avoids duplicating 
> resource tracking logic in the driver.

Eww, no, that would be far worse :) Just untangling the "failed to 
allocate from a valid pool" condition from the "failed to find an 
appropriate pool at all" one in this code is fine!

Thanks,
Robin.
