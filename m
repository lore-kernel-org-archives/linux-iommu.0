Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB2350A37;
	Tue, 20 Jan 2026 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929094; cv=none; b=LEyLvSjsXwwq+kb+veW/lrQEAgfEwI/aLXUInjMQ3CLTCA8iRSET1jl4JQQ9KicAK6H96JNnir2Oe/2kmjRw7HeJNMVGmlY7AwYeuyGctX/GLsR8ov/d8cOSPSONobpRHnmzJnAfno/TFA9HT3qub9im1dbyi/lfkbbaNtf81rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929094; c=relaxed/simple;
	bh=+7A45g6nCXGJghJD5eSlgmjk2vVDlzcQ1kIWsxRemzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZGfiYyatkmj2+IolPWUCOd8aE1yT8u4FcuNxnSLXKtrb3kDXKUUM5mW7gf4RGVqh33EBRvfVqAnVHKa9Ibq+v2D3dAw7J1Gi1KdoPUpp3Kc5xMl1xiRMXdodYFtQQwqiCxEKGYnc/FBBmBTKYa+gh7VuKfat9xggbxyvJ3FjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50DA71476;
	Tue, 20 Jan 2026 09:11:24 -0800 (PST)
Received: from [10.57.49.114] (unknown [10.57.49.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8645B3F632;
	Tue, 20 Jan 2026 09:11:29 -0800 (PST)
Message-ID: <a89e8fcc-29f0-4a6a-85f8-ca8ca41c53ce@arm.com>
Date: Tue, 20 Jan 2026 17:11:27 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA
 addresses
To: Jason Gunthorpe <jgg@ziepe.ca>, Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 will@kernel.org, steven.price@arm.com,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
 <2a0b6d1b-875a-4075-8fc9-a8534afc9168@arm.com> <yq5atswgjrkp.fsf@kernel.org>
 <0da8b73c-5bec-44c3-9902-221a11142c34@arm.com>
 <20260120151127.GP961572@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260120151127.GP961572@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-20 3:11 pm, Jason Gunthorpe wrote:
> On Tue, Jan 20, 2026 at 02:39:14PM +0000, Suzuki K Poulose wrote:
>>>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>>>> index 8e04f72baaa3..a5639e9415f5 100644
>>>>> --- a/kernel/dma/direct.c
>>>>> +++ b/kernel/dma/direct.c
>>>>> @@ -580,12 +580,12 @@ int dma_direct_supported(struct device *dev, u64 mask)
>>>>>     	/*
>>>>>     	 * This check needs to be against the actual bit mask value, so use
>>>>> -	 * phys_to_dma_unencrypted() here so that the SME encryption mask isn't
>>>>> +	 * __phys_to_dma() here so that the arch specific encryption mask isn't
>>>>>     	 * part of the check.
>>>>>     	 */
>>>>>     	if (IS_ENABLED(CONFIG_ZONE_DMA))
>>>>>     		min_mask = min_t(u64, min_mask, zone_dma_limit);
>>>>> -	return mask >= phys_to_dma_unencrypted(dev, min_mask);
>>>>> +	return mask >= __phys_to_dma(dev, min_mask);
>>>>
>>>> This is wrong, isn't it ? For e.g., for CCA, even though the "Flag" is
>>>> added to the PA, it is really part of the actual "PA" and thus must be
>>>> checked against the full PA ?
>>>>
>>>
>>> That is true only when the device is operating in untrusted mode?. For a
>>> trusted device that mask is valid mask right?
>>
>> Irrespective of the mode in which the device is operating, the DMA
>> address must include the fully qualified "{I}PA" address, right ?
>> i.e., "the Unencrypted" bit is only a software construct and the full
>> PA must be used, irrespective of the mode of the device.
> 
> But you could make an argument that a trusted device won't DMA to
> shared memory, ie it would SWIOTLB to private memory if that is
> required.

I don't think we can assume that any arbitrary trusted device is *never* 
going to want to access shared memory in the Realm IPA space, and while 
it might technically be possible for a private SWIOTLB buffer to handle 
that, we currently only have infrastructure that assumes the opposite 
(i.e. that SWIOTLB buffers are shared for bouncing untrusted DMA to/from 
private memory). Thus for now, saying we can only promise to support DMA 
if the device can access the whole IPA space itself is accurate.

> Otherwise these two limitations will exclude huge numbers of real
> devices from working with ARM CCA at all.

Pretty sure the dependency on TDISP wins in that regard ;)

However, assuming that Realms and RMMs might eventually come up with 
their own attestation mechanisms for on-chip non-PCIe devices (and such 
devices continue to have crippled DMA capabilities) then the fact is 
still that DA requires an SMMU for S2, so at worst there should always 
be the possibility for an RMM to offer S1 SMMU support to the Realm, 
we're just not there yet.

Thanks,
Robin.
