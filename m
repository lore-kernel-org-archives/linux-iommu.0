Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14B44C67E
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986271; cv=none; b=Wi9fquvXV1dt6QT7IB64PoUJApuFm428+NCeoEG8rVmuI11NOAg8aPv72KA1JjFXHOO2D1r3sOJ0OAPoRyzjMu9dJDUmhC7O27KXu842ehIagrGupbuaXlvVGDwsvIsfg4IULfys33la2S+++/qTBxdL8fF5pZ8PSoMWc7+Bmsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986271; c=relaxed/simple;
	bh=WwW3V4TMuE/pvFjy27YhAVXW50q82C9U1UO8+sDJCII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlSve29toJGHUMzHoexctNkFXILa3/kZHvLtpd4aC8J33uLVqFlMq9TdejXv1dQh7WBbZUh/r/2q8ZwNbRrhgPcUMAdK2rvlEOYj7nPak4tfdXUIA+ylGyEIbbIousAkc5HmOgWizNVQzuKnq4pwQbBXDrA8LhhICRKsqK6BbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QeIkDyHW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QeIkDyHW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20CD61655;
	Mon, 17 Aug 2026 10:04:23 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F27A83F673;
	Mon, 17 Aug 2026 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786986267; bh=WwW3V4TMuE/pvFjy27YhAVXW50q82C9U1UO8+sDJCII=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QeIkDyHWPZXIR5a5D54DOt0cXsS9HlN67HT5K8IyHeiL8l0UvaTFRQI2XmMvmJz2h
	 6Z/ILoecouit7do9PzKQEAY+ruFx6BKZnsqTJFzHAw5FDmEAKixfAMMa/8jv8YUJPu
	 hdFYOiIzxw6y9w4otrm/sEkl6Rh4yFuSPIayxcFE=
Message-ID: <3ac5346a-485f-4c1a-8c3a-ad649f2c76f0@arm.com>
Date: Mon, 17 Aug 2026 18:04:24 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dma_opt_mapping_size returns way too low sizes when using IOMMU
To: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20260817083654.GA23414@lst.de>
 <86f7fbdc-3c7f-4d84-871e-52ed3cfe8d58@oracle.com>
 <20260817091840.GA26843@lst.de>
 <8b7e86a7-6cb1-4007-bd99-1c4be8e6828e@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <8b7e86a7-6cb1-4007-bd99-1c4be8e6828e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/08/2026 11:11 am, John Garry wrote:
> On 17/08/2026 10:18, Christoph Hellwig wrote:
>> On Mon, Aug 17, 2026 at 10:12:25AM +0100, John Garry wrote:
>>> On 17/08/2026 09:36, Christoph Hellwig wrote:
>>>> Hi all,
>>>>
>>>> I got reports that NVMe devices were arbitrarily limited to 128kiB
>>>> transfers in recent kernel. 
>>>
>>> How recent a kernel? This NVMe and DMA mapping code has not changed 
>>> in years as far as I know.
>>
>> This was hardware QA moving from an old distro kernel to a "recent" (aka
>> still old) one.   But I've actually reproduced it locally on an
>> upstream kernel.  I guess most kernel developers or power users simply
>> do not run with IOMMU enabled.
> 
> Yeah, they don't like any performance hit.
> 
>>
>>>> Both the NVMe performance numbers and common sense suggest that this
>>>> is NOT the optimal DMA mapping granularity.  Can we pick a saner value
>>>> for iommu_dma_opt_mapping_size that does not restrict common I/O sizes?
>>>
>>> Note that SCSI does not use iommu_dma_opt_mapping_size() for clamping 
>>> max HW sectors, but instead sets opt size / max sectors from this 
>>> value (so it is not a hard limit there). Could we consider similar 
>>> for NVMe?
>>
>> We could consider that, but it would still reduce performane..
>  > >> The reason for which we have iommu_dma_opt_mapping_size() is that
>>> performance can go through the floor we can't use the rcache for 
>>> getting the IOVA, i.e. we need to always alloc and dealloc an IOVA 
>>> from the RB tree for each mapping, and this can greatly reduce 
>>> performance when the IOVA space fills.
>>>
>>> If we increase IOVA_RANGE_CACHE_MAX_SIZE, then we just get caching of 
>>> larger IOVAs and I am not sure that is a great idea.
>>
>> At least on the four different nvme devices I tested, the larger I/O
>> sizes made up for this.  But maybe the details depend on other
>> factors as well.
> Are you saying that you tried increasing IOVA_RANGE_CACHE_MAX_SIZE and 
> got better performance?
> 
> As I remember, I was told that the value of 6 for 
> IOVA_RANGE_CACHE_MAX_SIZE was originally chosen from the value then in 
> max page order, i.e. the idea was that we should not be getting 
> streaming IOs larger than that value. But in looking at lore, 8 was very 
> originally proposed, but I can't see any discussion on why that changed 
> or any relation to page max order.

 From a quick skim I can't spot any specific mention in the original 
threads or accompanying paper, but I have a feeling it was as much about 
just balancing memory consumption with observable performance 
improvement, and larger sizes weren't significantly impactful to the 
original testing, which did seem to be focused on networking rather than 
storage.

Since these days we have the flexibly-sized depot, and now even 
lazy-allocation of the CPU magazines, we might be in a better position 
to consider scaling IOVA_RANGE_CACHE_MAX_SIZE up without too much 
inherent overhead (I guess the base cost per level will just be 
2*NR_CPUS + 1 pointers now). The larger sizes we cache, though, the more 
it's also going to blow up IOVA consumption if freeing/reallocation 
isn't well balanced across CPUs, so for devices/systems with limited 
IOVA space, at some point the flush_rcache case is liable to start 
adding more overhead than the caching itself saves...

FWIW, my understanding of the idea we settled on for opt_mapping_size 
was that it was never meant to be an absolute target, just a boundary 
between where callers can expect "ideal" mapping performance, and where 
it may start scaling with size/contention/etc., and thus it's for the 
callers to judge whether larger sizes are still worth it for their 
particular use-case.

Thanks,
Robin.

> Some time ago I did try some work to allow IOVA_RANGE_CACHE_MAX_SIZE be 
> set per IOMMU domain, but it was not merged. We went with 
> dma_opt_mapping_size() solution instead.
> 
> https://lore.kernel.org/linux-scsi/1620656249-68890-1-git-send-email- 
> john.garry@huawei.com/
> 
> 

