Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC2143890
	for <iommu@lists.linux.dev>; Tue, 21 May 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304495; cv=none; b=KiXQk8a+LJLE7cG5PUhgsxwyDkhUdON9yWeJ2w6etIAEI/XrDUryhIuQj07yjKrDj2U1Fwf145FYHA3NmVFDp/OdSw1ersUnM2OOfkiD1OIdAFukfrO7W0TL5VeeKLs4EXgXOjal7gHT80G9Gycgn17CDyWBNSqCjVY1rCQkgB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304495; c=relaxed/simple;
	bh=tdOjwBB/EVqP4uS0K9ID2XC+ksP7U3GvDkuPvE6oHXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eogON8GLmx0rWIE9AdiRYhD3jtdwJKr8ggh9Q2eklhHChVqhXxXMdQTiWEGA3qH/pfqKbMsuLcTJ9VS1ZMeu1X/oAFuo7F227nzRqdLBI3hv3XNQpG0Lwcx42tfpu5WRp9ERy4gxzchty2wnPj5niVxJdZit5n+tUx/1h1U7jXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53BE3DA7;
	Tue, 21 May 2024 08:15:16 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 877BF3F641;
	Tue, 21 May 2024 08:14:51 -0700 (PDT)
Message-ID: <02ebbb90-84bc-4d8c-a7aa-94cd78e0a2a5@arm.com>
Date: Tue, 21 May 2024 16:14:50 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: Fix domain init
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, will@kernel.org,
 linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
References: <721fa6baebb0924aa40db0b8fb86bcb4538434af.1716232484.git.robin.murphy@arm.com>
 <jrzrf3vz2rhcrwazsxuljuyhru4mstyzuhjx4uawcfmjlmvipd@lu6usxz22ved>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <jrzrf3vz2rhcrwazsxuljuyhru4mstyzuhjx4uawcfmjlmvipd@lu6usxz22ved>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/05/2024 5:45 am, Jerry Snitselaar wrote:
> On Mon, May 20, 2024 at 08:14:44PM GMT, Robin Murphy wrote:
>> Despite carefully rewording the kerneldoc to describe the new direct
>> interaction with dma_range_map, it seems I managed to confuse myself in
>> removing the redundant force_aperture check and ended up making the code
>> not do that at all. This led to dma_range_maps inadvertently being able
>> to set iovad->start_pfn = 0, and all the nonsensical chaos which ensues
>> from there. Restore the correct behaviour of constraining base_pfn to
>> the domain aperture regardless of dma_range_map, and not trying to apply
>> dma_range_map constraints to the basic IOVA domain since they will be
>> properly handled with reserved regions later.
>>
>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> Fixes: e28a114243d1 ("iommu/dma: Make limit checks self-contained")
> 
> I'm seeing this upstream as ad4750b07d34 ("iommu/dma: Make limit checks self-contained") now.

What, you mean when Linus pulls some patches I wrote he *doesn't* also 
rebase my local development branch for me? /facepalm

Joerg, please shout if you'd like a resend for that.

>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
> 
> Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks!
Robin.

>>   drivers/iommu/dma-iommu.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 89a53c2f2cf9..1ec89ca75c59 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -685,15 +685,15 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
>>   
>>   	/* Check the domain allows at least some access to the device... */
>>   	if (map) {
>> -		dma_addr_t base = dma_range_map_min(map);
>> -		if (base > domain->geometry.aperture_end ||
>> +		if (dma_range_map_min(map) > domain->geometry.aperture_end ||
>>   		    dma_range_map_max(map) < domain->geometry.aperture_start) {
>>   			pr_warn("specified DMA range outside IOMMU capability\n");
>>   			return -EFAULT;
>>   		}
>> -		/* ...then finally give it a kicking to make sure it fits */
>> -		base_pfn = max(base, domain->geometry.aperture_start) >> order;
>>   	}
>> +	/* ...then finally give it a kicking to make sure it fits */
>> +	base_pfn = max_t(unsigned long, base_pfn,
>> +			 domain->geometry.aperture_start >> order);
>>   
>>   	/* start_pfn is always nonzero for an already-initialised domain */
>>   	mutex_lock(&cookie->mutex);
>> -- 
>> 2.39.2.101.g768bb238c484.dirty
>>
> 
