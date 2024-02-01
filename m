Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481AA5B669
	for <iommu@lists.linux.dev>; Thu,  1 Feb 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795636; cv=none; b=ic/4UiMWO5WIG0QHm34fGFwSJQtoKfVz7OGr+/RyelTD4uGZT3CMg+l/DoVTDic5IOQgJK4EsTHqnn5SReaac123Yx40nq0WaAoBojhgMZsP8H+J310YO3UL6yI44dKrpTA5bJGyZNqB8FaOvtJp6B2ek3Ck7eIElXHPb1N8TeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795636; c=relaxed/simple;
	bh=sZjQRuxLUHl+5AIYqAAouxmR7fxPsq7YLcy2TL46L64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ju35eOtI88pnThScH343ivlHwRfCfZndfa85Vnplh7+S8JkiqTmtfyEMjHeLMylO26fp5PX3LlMqU5IzoWc/ryWcwP7Nj6UTk2xMIdhuS9GrdiPJg5bv9BdVMMuoNoVT7XLilcsefr8g0TDQV7vsuOi12R7sOs6DrVsQkhe+mDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 564FDDA7;
	Thu,  1 Feb 2024 05:54:36 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7CB83F762;
	Thu,  1 Feb 2024 05:53:52 -0800 (PST)
Message-ID: <eeb06c3d-8f04-4b6c-9dd7-3cb4f4c1cc31@arm.com>
Date: Thu, 1 Feb 2024 13:53:51 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] swiotlb: Enforce page alignment in swiotlb_alloc()
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>,
 Dexuan Cui <decui@microsoft.com>
References: <20240131122543.14791-1-will@kernel.org>
 <20240131122543.14791-3-will@kernel.org>
 <b4045104-7ea4-47b2-ad74-a44bab76c796@arm.com>
 <20240201124816.GB15707@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240201124816.GB15707@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/02/2024 12:48 pm, Will Deacon wrote:
> On Wed, Jan 31, 2024 at 03:14:18PM +0000, Robin Murphy wrote:
>> On 31/01/2024 12:25 pm, Will Deacon wrote:
>>> When allocating pages from a restricted DMA pool in swiotlb_alloc(),
>>> the buffer address is blindly converted to a 'struct page *' that is
>>> returned to the caller. In the unlikely event of an allocation bug,
>>> page-unaligned addresses are not detected and slots can silently be
>>> double-allocated.
>>>
>>> Add a simple check of the buffer alignment in swiotlb_alloc() to make
>>> debugging a little easier if something has gone wonky.
>>>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>>> Cc: Dexuan Cui <decui@microsoft.com>
>>> Signed-off-by: Will Deacon <will@kernel.org>
>>> ---
>>>    kernel/dma/swiotlb.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>>> index 56cc08b1fbd6..4485f216e620 100644
>>> --- a/kernel/dma/swiotlb.c
>>> +++ b/kernel/dma/swiotlb.c
>>> @@ -1642,6 +1642,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
>>>    		return NULL;
>>>    	tlb_addr = slot_addr(pool->start, index);
>>> +	if (unlikely(!PAGE_ALIGNED(tlb_addr))) {
>>> +		dev_WARN_ONCE(dev, 1, "Cannot allocate pages from non page-aligned swiotlb addr 0x%pa.\n",
>>> +			      &tlb_addr);
>>
>> Nit: if there's cause for another respin, I'd be inclined to use a
>> straightforward "if (WARN_ON(...))" here - this condition should represent
>> SWIOTLB itself going badly wrong, which isn't really attributable to
>> whatever device happened to be involved in the call.
> 
> Well, there'll definitely be a v3 thanks to my idiotic dropping of the
> 'continue' statement when I reworked the searching loop for v2.
> 
> However, given that we're returning NULL, I think printing the device is
> helpful as we're likely to cause some horrible error (e.g. probe failure)
> in the caller and then it will be obvious why that happened from looking
> at the logs. So I'd prefer to keep it unless you insist.

No, helping to clarify any knock-on effects sounds like a reasonable 
justification to me - I hadn't really considered that angle. I'd still 
be inclined to condense it down to "if (dev_WARN_ONCE(...))" to minimise 
redundancy, but that's really just a matter of personal preference.

Cheers,
Robin.
