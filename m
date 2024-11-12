Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6359E205125
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428715; cv=none; b=txbTOul7QeL/28N2FLNaPDczGTtEDzVZ4dk3xvuheXbXX6b1kK/JHVG63bQvFiboNUNsT0WOYwmxXM9i/OLYt6tNKE7qxLoKHC5ilhRVATOIuc7ZvCEj/3yzokYlGsfn4NHvPc1vXstagvS7WimyuIea/Aqd4sf300ICqQ3G4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428715; c=relaxed/simple;
	bh=jDrkrhKrkEqgxQ+M7dtmgEVC/gy7jAVVG7zAz4UKRpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jY3iOYZ9wWuLObOZeMk8tN01hfs7T11lNTtaWnNfBUXvKFiJwRasSPdYrehTaatPLd2WJhrooRq7lYwENFUsyVR/foVqUwQa4kmQLJfDX6odZvBrX4pcTXyA7pA/dpUR0AsmZBiU3i848oYnD5EUo2s54bppEiQ8rzyGCk/7LkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24A3E1516;
	Tue, 12 Nov 2024 08:25:41 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AE513F6A8;
	Tue, 12 Nov 2024 08:25:10 -0800 (PST)
Message-ID: <cf5745db-6523-49ea-b21e-7cf51ff47a67@arm.com>
Date: Tue, 12 Nov 2024 16:25:08 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2.5/3] iommu/arm-smmu-v3: Undo SMMU enable on probe
 failure
To: Will Deacon <will@kernel.org>
Cc: joro@8bytes.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <cover.1731088789.git.robin.murphy@arm.com>
 <0812e9f61234cbcdc5cab7de307e1c9a8e3c9498.1731422868.git.robin.murphy@arm.com>
 <20241112155750.GC21479@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241112155750.GC21479@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 3:57 pm, Will Deacon wrote:
> On Tue, Nov 12, 2024 at 02:49:59PM +0000, Robin Murphy wrote:
>> If SMMU probe fails afer arm_smmu_device_reset(), we leave the SMMU
>> enabled with an empty Stream Table, silently blocking all DMA. This
>> proves rather annoying for debugging said probe failure, so let's handle
>> it a bit better by putting the SMMU back into (more or less) the same
>> state as if it hadn't probed at all.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 7908fca962fe..566d66e9c91e 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -4640,6 +4640,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>   	iommu_device_sysfs_remove(&smmu->iommu);
>>   free_iopf:
>>   	iopf_queue_free(smmu->evtq.iopf);
>> +	arm_smmu_device_disable(smmu);
>>   	return ret;
>>   }
> 
> Heh, this is starting to look an awful lot like arm_smmu_device_remove()...

Indeed, functionally that's rather the point; implementation-wise, you 
know I'd branch straight into the middle of a different function if the 
language let me :)

Robin.
