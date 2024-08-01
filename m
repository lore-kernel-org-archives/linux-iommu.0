Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D041E507
	for <iommu@lists.linux.dev>; Thu,  1 Aug 2024 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515769; cv=none; b=j0VX4PpCbN+ETHoXQ+/M5BCXtj6i6L7C3xpubnwMZ+lW08A15pVD46Q9YqzjQXJIZVm6+aMQFEIUd3xAqfFHAFh52RLkffk1BQoAw5wLTWtc86Jq1n+ojI+ftvpXk0Ok4WPyGgtRiqOEb/uszaKIVR7gQqBU5XbUZjpuLmp7uvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515769; c=relaxed/simple;
	bh=f4lC5gxhSKoxDTsqkQzDrZ9yawilVopVur2OivHh7XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDHH/DF6b8TKQTjso18LACU2vMFlWSDGe7oftt665eXXztH0HOma3lFJoT1fdCbYqzpSJ9uyi2uLvzH8LG4UQjb1E8w5pBZj3Ue/iBELpaYTTTfbcCXuCvu1PfifbII75wKiQxxWT4bz9aSIEIJXC5nluOzL3nCKo4QA+15q+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BED6D1007;
	Thu,  1 Aug 2024 05:36:32 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73A863F766;
	Thu,  1 Aug 2024 05:36:06 -0700 (PDT)
Message-ID: <d54f486d-36ae-4668-b314-27137bc4d832@arm.com>
Date: Thu, 1 Aug 2024 13:36:01 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma-mapping: don't return errors from
 dma_set_seg_boundary
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240723000604.241443-1-hch@lst.de>
 <CGME20240723000611eucas1p10986fd51e848a1ee948e71608c26192b@eucas1p1.samsung.com>
 <20240723000604.241443-3-hch@lst.de>
 <5895603b-945f-4b05-991c-76b590094354@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <5895603b-945f-4b05-991c-76b590094354@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2024 1:00 pm, Marek Szyprowski wrote:
> On 23.07.2024 02:05, Christoph Hellwig wrote:
>> If dev->dma_parms is not allocate that indicates a grave bug in the
>> implementation of a DMA-capable bus.  There isn't much the driver can
>> do in terms of error handling, so just warn and continue as DMA
>> operations will fail anyway.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> What about devices on platform or usb bus and subsystems calling this
> unconditionally, like scsi_init_limits()? With today's linux-next I got
> a bunch of warnings from this call for various USB storage devices.
> Before this patch, the errors from dma_set_seg_boundary() were silently
> ignored.

Maybe we could suppress the warning if the value being set is equal to 
the default, but the real point is that DMA-capable buses should be 
providing dma_parms, while non-DMA-capable devices have no business 
being here at all - if the caller isn't going to get the 
restriction/relaxation they requested, and that's not a problem, then 
why are they requesting it in the first place?

I guess I assumed that the old block layer bodges in this area had been 
cleaned up already - perhaps it *is* high time for whatever's left to 
grow a proper understanding of whether a block device actually does its 
own DMA or not.

Thanks,
Robin.

>> ---
>>    include/linux/dma-mapping.h | 10 ++++------
>>    1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index cfd6bafec3f944..6bd1333dbacb9b 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -559,13 +559,11 @@ static inline unsigned long dma_get_seg_boundary_nr_pages(struct device *dev,
>>    	return (dma_get_seg_boundary(dev) >> page_shift) + 1;
>>    }
>>    
>> -static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
>> +static inline void dma_set_seg_boundary(struct device *dev, unsigned long mask)
>>    {
>> -	if (dev->dma_parms) {
>> -		dev->dma_parms->segment_boundary_mask = mask;
>> -		return 0;
>> -	}
>> -	return -EIO;
>> +	if (WARN_ON_ONCE(!dev->dma_parms))
>> +		return;
>> +	dev->dma_parms->segment_boundary_mask = mask;
>>    }
>>    
>>    static inline unsigned int dma_get_min_align_mask(struct device *dev)
> 
> Best regards
