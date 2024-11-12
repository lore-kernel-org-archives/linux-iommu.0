Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492A6202F84
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427531; cv=none; b=A5aEo+VfCLFP12KJhvygmQDP6fODcLevIWicLUgT5JBaqAHm9ZS/6SWBGpebs583hj3myBRzu7kolgq0AbXtxSRxCd8WdeytEWZtrJ7NRBLLziaIf63E7S5ZIzQWPhEYedjZJu7gg8fYRVWkqWaZ5hIKZOfQKzQesvjBNpj4a9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427531; c=relaxed/simple;
	bh=7MBZtf2MAPib7DDKBMZ7gsTYV82i2MmBUgZbTM+5nJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSMRb6GcNp/UYdz0vD/2Xhl8TYaXBEopuCnZWsgmM1T+tZBZZjwR9ZYCGixfPvGMNtpx/P76KP1DI7X21XLpyS8TK3PnZWsxCZFX3mfE87/Sz6nvnNh7LfPTNqA8PJJ1wbZcDpgJuqv5zczD4pwkY2aYX14FKINbLWzAH6rvpeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5EE21516;
	Tue, 12 Nov 2024 08:05:57 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFF4D3F6A8;
	Tue, 12 Nov 2024 08:05:26 -0800 (PST)
Message-ID: <46ccf0f1-58f8-4861-85f1-7cb562af23f6@arm.com>
Date: Tue, 12 Nov 2024 16:05:25 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommu/arm-smmu: Make instance lookup robust
To: Will Deacon <will@kernel.org>
Cc: joro@8bytes.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <cover.1731088789.git.robin.murphy@arm.com>
 <9d2ec624a640c421e97334deff537a2e899356c7.1731088789.git.robin.murphy@arm.com>
 <20241112154358.GA21479@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241112154358.GA21479@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 3:43 pm, Will Deacon wrote:
> On Fri, Nov 08, 2024 at 06:30:15PM +0000, Robin Murphy wrote:
>> Relying on the driver list was a cute idea for minimising the scope of
>> our SMMU device lookups, however it turns out to have a subtle flaw. The
>> SMMU device only gets added to that list after arm_smmu_device_probe()
>> returns success, so there's actually no way the iommu_device_register()
>> call from there could ever work as intended, even if it wasn't already
>> hampered by the fwspec setup not happening early enough.
>>
>> Switch both arm_smmu_get_by_fwnode() implementations to use a platform
>> bus lookup instead, which *will* reliably work. Also make sure that we
>> don't register SMMUv2 instances until we've fully initialised them, to
>> avoid similar consequences of the lookup now finding a device with no
>> drvdata. Moving that code is also a perfect excuse to give it a little
>> dev_err_probe() tidyup as well.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> This should in theory replace 229e6ee43d2a ("iommu/arm-smmu: Defer
>> probe of clients after smmu device bound"), or at least allow it to be
>> reverted going forward.
> 
> Let's revert that as part of this series, then?

Sure, at time of posting I wasn't entirely sure where we'd stand on 
replace vs. revert (TBH I'd lost track and didn't even realise we're at 
rc7 already...)

>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 +--
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 31 ++++++++++-----------
>>   2 files changed, 16 insertions(+), 19 deletions(-)
> 
> [...]
> 
>> @@ -2255,6 +2240,18 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>   	arm_smmu_device_reset(smmu);
>>   	arm_smmu_test_smr_masks(smmu);
>>   
>> +	err = iommu_device_sysfs_add(&smmu->iommu, smmu->dev, NULL,
>> +				     "smmu.%pa", &smmu->ioaddr);
>> +	if (err)
>> +		return dev_err_probe(dev, err, "Failed to register iommu in sysfs\n");
>> +
>> +	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
>> +				    using_legacy_binding ? NULL : dev);
>> +	if (err) {
>> +		iommu_device_sysfs_remove(&smmu->iommu);
>> +		return dev_err_probe(dev, err, "Failed to register iommu\n");
> 
> Why is dev_err_probe() better here? I've not seen it before, so I was
> trying to figure out what it does. It mainly looks to be handling
> the EPROBE_DEFER case, but after your other changes to use
> bus_find_device_by_fwnode() I'm wondering whether we actually hit that
> (particularly in iommu_device_sysfs_add())?
> 
> I'm not saying there's a problem, just that I'm not sure why
> dev_err_probe() is tidier than dev_err().

Just that it's more concise and convenient, and as such becoming an 
established pattern for returning errors from driver probe routines, 
even in cases which don't defer.

Cheers,
Robin.
