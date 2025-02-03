Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6436715383A;
	Mon,  3 Feb 2025 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608557; cv=none; b=tUeKlQGd4QO8cWCmAis3eAIRD4ZupthTInOSWQyJFu/WAMDl9b1qvdDs386Vftr4lJoNdvMLDglqaMJOqcwlwB8uzDFM0u0Lj6hynvXBT48M3C1lGweuGKWy0/S5FfUmBLBTf3WFw0tAyiiP1od4B2FXjBmKrL49WfnlqqklOXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608557; c=relaxed/simple;
	bh=bYXQKeq3XdpG0sJo28bSQO+rIVabOocexbxhmwQgQRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MN4B97IE8tmtYf3r4uWu6kybqya/dDkG68m9Xh4nRHHncEhPc55d5XKYbh4mYW2eX0qBXuzU90QSnEY2wgARSRZMwAIWAcLEyu9CxjUb+zPiy8OnEcTYOHF8joDeAkCEppATiH3+Q3Kz6n64wYtu/ie8E3Bghen7awYc515eb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE09811FB;
	Mon,  3 Feb 2025 10:49:37 -0800 (PST)
Received: from [10.57.37.14] (unknown [10.57.37.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A8513F58B;
	Mon,  3 Feb 2025 10:49:11 -0800 (PST)
Message-ID: <a0f776ba-bfd2-41fd-8370-14818b86bfbe@arm.com>
Date: Mon, 3 Feb 2025 18:49:07 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Invalid gather when using Tegra210 media engines
To: Jason Gunthorpe <jgg@ziepe.ca>, Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, joro@8bytes.org,
 will@kernel.org, jonathanh@nvidia.com, baolu.lu@linux.intel.com,
 jsnitsel@redhat.com, jroedel@suse.de, regressions@lists.linux.dev,
 linux-tegra@vger.kernel.org, iommu@lists.linux.dev
References: <c6a6f114-3acd-4d56-a13b-b88978e927dc@tecnico.ulisboa.pt>
 <20250203170617.GE2296753@ziepe.ca>
 <4ea1a48c-9020-4793-ac9b-b51fc289e442@tecnico.ulisboa.pt>
 <20250203174331.GF2296753@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250203174331.GF2296753@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-03 5:43 pm, Jason Gunthorpe wrote:
>>> How about this:
>>>
>>> diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
>>> index be2ad7203d7b96..090b1fc97a7309 100644
>>> --- a/drivers/gpu/host1x/dev.c
>>> +++ b/drivers/gpu/host1x/dev.c
>>> @@ -361,6 +361,10 @@ static bool host1x_wants_iommu(struct host1x *host1x)
>>>    	return true;
>>>    }
>>> +/*
>>> + * Returns ERR_PTR on failure, NULL if the translation is IDENTITY, otherwise a
>>> + * valid paging domain.
>>> + */
>>>    static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
>>>    {
>>>    	struct iommu_domain *domain = iommu_get_domain_for_dev(host->dev);
>>> @@ -385,6 +389,8 @@ static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
>>>    	 * Similarly, if host1x is already attached to an IOMMU (via the DMA
>>>    	 * API), don't try to attach again.
>>>    	 */
>>> +	if (domain && domain->type == IOMMU_DOMAIN_IDENTITY)
>>> +		domain = NULL;
>>>    	if (!host1x_wants_iommu(host) || domain)
>>>    		return domain;
>>>
>>> (if not can you investigate this function's flow compared to a good
>>> kernel?)
>>
>> Yes, this worked! Does this mean that with this change we go through the
>> path of using the shared Tegra domain (for example in the driver I
>> attached client->group == true), and if that is the case would it be
>> beneficial for us to try and change tegra_smmu_def_domain_type() from
>> returning IOMMU_DOMAIN_IDENTITY into IOMMU_DOMAIN_DMA so that the
>> dma_alloc_* functions are called directly?

FWIW that would be better thought of as simply making the entire 
existence of tegra_smmu_def_domain_type() conditional on CONFIG_ARM. 
Definitely worth trying, at least.

> I do not know the answer those questions.. The whole rational around
> this host 1x domain stuff is mysterious to me.

This change (i.e. ignoring identity domains) should indeed lead to 
host1x allocating and using its own paging domain, which is indeed what 
you want in that case because otherwise the non-IOMMU DMA ops aren't 
going to be much use on their own for allocating/importing great big 
media buffers.

> It does sound quite appealing for the implementation to use the dma
> api instead of attaching its own special domain.

I'd hope the historical reasons for not supporting IOMMU_DOMAIN_DMA in 
tegra-smmu no longer apply, given that all the default domain stuff has 
now been integrated into host1x for the newer arm-smmu based Tegras. And 
I guess it also shows that nobody's been running those newer SoCs with 
IOMMU_DEFAULT_PASSTHROUGH either, or they presumably would have run in 
to this same issue...

Thanks,
Robin.
