Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E515C23C4FA
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006030; cv=none; b=YNStzUgyCOhgAbEzuJ0f69u6IVXq7SQMZvc6yCzpemBXb3y7hhxcfD43mQaSLinal5Iu0yXCvEbzDvlj/DyFRBxE4xq8W7H/9JdibqKe6D7qMrADYuP8DKqOz/y4Jwt/W13YHGwwaX/6sXD0fkhl90uRfAmOxF7hS5pJ37oDJiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006030; c=relaxed/simple;
	bh=BDB2cqeHqPwKjG3ryPJDUTgMkInG2F42LthsZM5l+EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKShjJYk3+pi3sa8oeV630iODPg4PlxIllyAgxH05ya2kNRxJIZS/yqAgWPrbk3rwfuM8aEmWii2o+5mc/UQcgcb+Hg7hXIpq5sIcvr5WVPXru9GwXG70u28Jia9RT9dfHbyVfWHKfGSxJUjIQyfQS0enHBg5/vqcI3RFw2o5fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7D3E1477;
	Mon, 24 Nov 2025 09:40:19 -0800 (PST)
Received: from [10.1.30.67] (unknown [10.1.30.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 064833F73B;
	Mon, 24 Nov 2025 09:40:25 -0800 (PST)
Message-ID: <fed2bf95-4edd-4517-9e00-4252595d0eb9@arm.com>
Date: Mon, 24 Nov 2025 17:40:24 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: add missing support for DMA_ATTR_MMIO for
 dma_iova_unlink()
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <CGME20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951@eucas1p2.samsung.com>
 <20251124170955.3884351-1-m.szyprowski@samsung.com>
 <0b214028-299b-46aa-8d98-0f789153c612@arm.com>
 <20251124172038.GD12483@unreal>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251124172038.GD12483@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-24 5:20 pm, Leon Romanovsky wrote:
> On Mon, Nov 24, 2025 at 05:15:48PM +0000, Robin Murphy wrote:
>> On 2025-11-24 5:09 pm, Marek Szyprowski wrote:
>>> Commit c288d657dd51 added support for DMA_ATTR_MMIO attribute in the
>>> dma_iova_link() code path, but missed that the CPU cache is being also
>>> touched in the dma_iova_unlink() path. Fix this.
>>>
>>> Fixes: c288d657dd51 ("iommu/dma: implement DMA_ATTR_MMIO for dma_iova_link().")
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>    drivers/iommu/dma-iommu.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index e52d19d2e833..c92088855450 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -2008,7 +2008,7 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
>>>    			end - addr, iovad->granule - iova_start_pad);
>>>    		if (!dev_is_dma_coherent(dev) &&
>>> -		    !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>>> +		    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
>>>    			arch_sync_dma_for_cpu(phys, len, dir);
>>>    		swiotlb_tbl_unmap_single(dev, phys, len, dir, attrs);
>>> @@ -2032,7 +2032,8 @@ static void __iommu_dma_iova_unlink(struct device *dev,
>>>    	size_t unmapped;
>>>    	if ((state->__size & DMA_IOVA_USE_SWIOTLB) ||
>>> -	    (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)))
>>> +	    (!dev_is_dma_coherent(dev) &&
>>> +	     !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))))
>>
>> This isn't needed, since there's no way an MMIO mapping could have used
>> SWIOTLB.
> 
> This "if" is taken even for non-SWIOTLB path, because of "||" operator
> in line above.

Oof, clearly it's already time to stop trying to read code and go home... :)

Thanks,
Robin.
