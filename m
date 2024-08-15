Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730C81714A8
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729317; cv=none; b=RenUDNz8VXFXskY7rwPDFQBUhcGxhr8QZgAj+Bn6cDIlLj/wPufOhNqwO49e5AOGFm6/uY8/i7+P1rgd7Va9Pu8Z81C33T4TAq0SqUhMH0egxG+nBzWncUOPIeUICo2JVOlZ6vK9hC15XSu4shCfbzKNuU/Ez/kJzpUpvb6FxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729317; c=relaxed/simple;
	bh=GjZQ1hT/OPm1A53XVFOMboJ7JrKo1ngaSeiyyHVkxLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukzYjzpJUiS+JaFWvlzed2OdFUPdxbjl2FFLSwa5y0Xy1ensd2ZQgWJqgcWc0EKIg+YTHPGgPyytO68P+JI2aZxOZPmh9JxFhJG6Hv/c+ej5EI08Fkpi2sktYXSOJoONF19Huv51jkumiNxol34muQCVXxdrL1BhVuTv0FngbWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A122914BF;
	Thu, 15 Aug 2024 06:42:21 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58FC63F6A8;
	Thu, 15 Aug 2024 06:41:54 -0700 (PDT)
Message-ID: <43290d6c-004d-423c-822c-7b2558badcee@arm.com>
Date: Thu, 15 Aug 2024 14:41:52 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
To: Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, will@kernel.org, joro@8bytes.org,
 jean-philippe@linaro.org, nicolinc@nvidia.com, mshavit@google.com
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca> <Zr3m4YCY7Ape3R6y@google.com>
 <91d6574d-c67e-484c-ad96-91c9fd3d0c43@arm.com> <Zr30BjAcVDKJPv3B@google.com>
 <20240815125919.GH3468552@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240815125919.GH3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/08/2024 1:59 pm, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2024 at 12:26:46PM +0000, Mostafa Saleh wrote:
>> Hi Robin,
>>
>> On Thu, Aug 15, 2024 at 01:16:19PM +0100, Robin Murphy wrote:
>>> On 15/08/2024 12:30 pm, Mostafa Saleh wrote:
>>>> Hi Jason,
>>>>
>>>> On Wed, Aug 14, 2024 at 12:51:51PM -0300, Jason Gunthorpe wrote:
>>>>> On Wed, Aug 14, 2024 at 02:56:33PM +0000, Mostafa Saleh wrote:
>>>>>
>>>>>> Also described in the pseudocode “SteIllegal()”
>>>>>>       if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>>>>>>           // stall_model forcing stall, but S2S == 0
>>>>>>           return TRUE;
>>>>>
>>>>> This clips out an important bit:
>>>>>
>>>>> if STE.Config == '11x' then
>>>>>     [..]
>>>>>     if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>>>>>         // stall_model forcing stall, but S2S == 0
>>>>>         return TRUE;
>>>>>
>>>>> And here we are using STRTAB_STE_0_CFG_S1_TRANS which is 101 and won't
>>>>> match the STE.Config qualification.
>>>>>
>>>>> The plain text language said the S2S is only required if the S2 is
>>>>> translating, STRTAB_STE_0_CFG_S1_TRANS puts it in bypass.
>>>>
>>>> Yes, my bad, this should be for stage-2 only which is populated in
>>>> arm_smmu_make_s2_domain_ste()
>>>>
>>>>>
>>>>>> +	/*
>>>>>> +	 * S2S is ignored if stage-2 exists but not enabled.
>>>>>> +	 * S2S is not compatible with ATS.
>>>>>> +	 */
>>>>>> +	if (master->stall_enabled && !ats_enabled &&
>>>>>> +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
>>>>>> +		target->data[2] |= STRTAB_STE_2_S2S;
>>>>>
>>>>> We can't ignore ATS if it was requested here.
>>>
>>> I don't see much value in adding effectively-dead checks for something which
>>> is already forbidden by the architecture. The definition of STALL_MODEL
>>> explicitly states:
>>>
>>> "An SMMU associated with a PCI system must not have STALL_MODEL == 0b10".
>>>
>>
>> Ah, I was expecting that as otherwise it's contradiction, but couldn't
>> find it while searching. Thanks for pointing it out, I will drop all
>> references to ATS then.
> 
> I was thinking this was also protecting against buggy FW since
> stall_enable can be set by:
>      device_property_read_bool(dev, "dma-can-stall"))

If firmware goes out of its way to describe the system incorrectly then 
I'd consider that all bets are off, and there's little point in us 
trying to guess how to cope with a contradiction. For all we know, it 
could be that the stall property is in fact genuine and it's the ATS 
capability that was advertised erroneously.

> Alternatively we could directly prevent the clash even earlier:
> 
> @@ -3292,8 +3292,13 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>   
>          if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
>               device_property_read_bool(dev, "dma-can-stall")) ||
> -           smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> -               master->stall_enabled = true;
> +           smmu->features & ARM_SMMU_FEAT_STALL_FORCE) {
> +               if (!dev_is_pci(dev))
> +                       master->stall_enabled = true;
> +               else
> +                       dev_err(dev, FW_BUG
> +                               "A SMMUv3 is required to run in stall mode for a PCI device\n");

Unfortunately we can't do that, because there *are* RCiEP devices whose 
data interfaces are native AMBA, and thus for whom stalling is not 
actually a protocol violation as it would be on a real PCIe transport 
layer; correspondingly, it's *because* they are not true PCIe devices 
that they can't support ATS, and thus need stall support in order to do 
SVA, so things should still work out OK in practice.

> +           }
>   
>          if (dev_is_pci(dev)) {
> 
> Though I have no idea how the GPU driver that wants to use this
> works - it doesn't seem to be intree :\

It's not a GPU: drivers/crypto/hisilicon/zip/

Thanks,
Robin.
