Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF752144C0
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431036; cv=none; b=EPcuSDiI52FWAj9HBPRPPFR3xkjt+ygjltXp/lO9+W+/3AazoNMNe86bL8hE8OsH9gp+ApBaV2If+6LrBW9i/hk5eGhat+8eLFR50OY1AI2JOmcbaD7w4BKn9s6ThroexleSrT8lHQ5f2Es1WNRHFzUapJ+9trZxtHRNJH5Ckus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431036; c=relaxed/simple;
	bh=KG9hCrrswnbwSh3ey83f9wGh+2/cSnvRs30Gg3krKZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFHw2Tr9Q+ppKxjLO0V1Y33MV+tbXLkt8YIrNOcRROwjZ6rmd41rtv7fbMfRp1z5VVJn3aWRsX5KYRC68e+yoldpjxEhzcOvG9vHstmbSVbpZBGX5MXkDh43LVRQE9blpsVIvqMPiC1BrNQVIv7lCAIt0H7FrSHIehugnrd0cpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1D025E0;
	Tue, 12 Nov 2024 09:04:23 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2C2A3F6A8;
	Tue, 12 Nov 2024 09:03:52 -0800 (PST)
Message-ID: <8cb6b8e2-3a01-49a1-b34a-67b4671356fe@arm.com>
Date: Tue, 12 Nov 2024 17:03:51 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iommu/arm-smmu-v3: Clean up iopf queue on probe
 failure
To: Will Deacon <will@kernel.org>
Cc: joro@8bytes.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <cover.1731088789.git.robin.murphy@arm.com>
 <161cf3bfde2993cc29e82589df947ff23fb82845.1731088789.git.robin.murphy@arm.com>
 <20241112155525.GB21479@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241112155525.GB21479@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 3:55 pm, Will Deacon wrote:
> On Fri, Nov 08, 2024 at 06:30:16PM +0000, Robin Murphy wrote:
>> kmemleak noticed that the iopf queue allocated deep down within
>> arm_smmu_init_structures() can be leaked by a subsequent error return
>> from arm_smmu_device_probe(). Hardly a big deal when probe failure
>> represents something much more seriously wrong in the first place,
>> but on principle, adopt a dedicated cleanup path for those.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index b7dcb1494aa4..7908fca962fe 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -4609,7 +4609,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>   	/* Initialise in-memory data structures */
>>   	ret = arm_smmu_init_structures(smmu);
>>   	if (ret)
>> -		return ret;
>> +		goto free_iopf;
>>   
>>   	/* Record our private device structure */
>>   	platform_set_drvdata(pdev, smmu);
>> @@ -4620,22 +4620,27 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>   	/* Reset the device */
>>   	ret = arm_smmu_device_reset(smmu);
>>   	if (ret)
>> -		return ret;
>> +		goto free_iopf;
>>   
>>   	/* And we're up. Go go go! */
>>   	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
>>   				     "smmu3.%pa", &ioaddr);
>>   	if (ret)
>> -		return ret;
>> +		goto free_iopf;
>>   
>>   	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
>>   	if (ret) {
>>   		dev_err(dev, "Failed to register iommu\n");
>> -		iommu_device_sysfs_remove(&smmu->iommu);
>> -		return ret;
>> +		goto free_sysfs;
>>   	}
>>   
>>   	return 0;
>> +
>> +free_sysfs:
>> +	iommu_device_sysfs_remove(&smmu->iommu);
>> +free_iopf:
>> +	iopf_queue_free(smmu->evtq.iopf);
>> +	return ret;
>>   }
> 
> Thanks. I think this is correct (and iopf_queue_free() checks for NULL,
> so we're good there) but I just wonder whether it would be more
> consistent to use devm_add_action_or_reset(), like we do for the MSIs.

Yeah, I did consider it, but in the end I had a hunch that we were 
liable to end up with more cleanup steps on this path anyway. Which then 
conveniently came true this morning when I realised why the box still 
wasn't seeing its disk even with the SATA probe un-deferred by patch #3.

(For reference I'm provoking an error from arm_smmu_probe_device() 
intentionally, by virtue of having a PCIe-to-PCI bridge aliasing two 
devices to the same StreamID - adding group support to make that 
actually work is still on the "maybe one day" list...)

Cheers,
Robin.
