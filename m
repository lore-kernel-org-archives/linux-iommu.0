Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09751DC05D
	for <iommu@lists.linux.dev>; Thu, 21 Nov 2024 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200587; cv=none; b=lhUQxXCEp0X/Mywr9t6vrCVblue1Ib35hB9TzOrxmpapofoWW3lF+fsYmFaPvsWiKYpYd5yimHIEBakhIBww5hJZmysjLA7FFYog/RIEgAD5TVRJWdLJhnyVhWszJ6sqbEwQBNxtKam2GB/WmrNQNeIIM2QtuOY68/mZFlbMemU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200587; c=relaxed/simple;
	bh=HX6kL5Cp7xP9ixBQ+OnEw7ZCJCn5c6NB942vvpiUZnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDw7dYPuQxRd3luR8XEzhnRp9a0Nk5Bq8jTOaoWOlEkw/lH8Bh65ckfzkw+7D2kDLqyULby0fW7HEFN9vfWIx1X2fK87zjnrJi7OHBv+Wp7WALMJv/Tcuvv1LLSoMWyFrC2JQMPqq6jskSlj+LsdH9hcRxWfibYUS8KgKPGA6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F191C12FC;
	Thu, 21 Nov 2024 06:50:13 -0800 (PST)
Received: from [10.1.26.55] (010265703453.arm.com [10.1.26.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC0743F5A1;
	Thu, 21 Nov 2024 06:49:40 -0800 (PST)
Message-ID: <57477eba-ef6a-454b-85d1-d0244f6116d1@arm.com>
Date: Thu, 21 Nov 2024 14:49:39 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu: Defer probe of clients after smmu
 device bound
To: Pratyush Brahma <quic_pbrahma@quicinc.com>, Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, kernel-team@android.com, joro@8bytes.org,
 jgg@ziepe.ca, jsnitsel@redhat.com, robdclark@chromium.org,
 quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, quic_charante@quicinc.com,
 stable@vger.kernel.org, Prakash Gupta <quic_guptap@quicinc.com>
References: <20241004090428.2035-1-quic_pbrahma@quicinc.com>
 <173021496151.4097715.14758035881649445798.b4-ty@kernel.org>
 <0952ca36-c5d9-462a-ab7b-b97154c56919@arm.com>
 <1d3dcd91-d246-4db3-9717-9edfe405f431@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <1d3dcd91-d246-4db3-9717-9edfe405f431@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-19 7:10 pm, Pratyush Brahma wrote:
> 
> On 11/7/2024 8:31 PM, Robin Murphy wrote:
>> On 29/10/2024 4:15 pm, Will Deacon wrote:
>>> On Fri, 04 Oct 2024 14:34:28 +0530, Pratyush Brahma wrote:
>>>> Null pointer dereference occurs due to a race between smmu
>>>> driver probe and client driver probe, when of_dma_configure()
>>>> for client is called after the iommu_device_register() for smmu driver
>>>> probe has executed but before the driver_bound() for smmu driver
>>>> has been called.
>>>>
>>>> Following is how the race occurs:
>>>>
>>>> [...]
>>>
>>> Applied to will (for-joerg/arm-smmu/updates), thanks!
>>>
>>> [1/1] iommu/arm-smmu: Defer probe of clients after smmu device bound
>>>        https://git.kernel.org/will/c/229e6ee43d2a
>>
>> I've finally got to the point of proving to myself that this isn't the
>> right fix, since once we do get __iommu_probe_device() working properly
>> in the correct order, iommu_device_register() then runs into the same
>> condition itself. Diff below should make this issue go away - I'll write
>> up proper patches once I've tested it a little more.
>>
>> Thanks,
>> Robin.
>>
>> ----->8-----
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/ 
>> iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 737c5b882355..b7dcb1494aa4 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3171,8 +3171,8 @@ static struct platform_driver arm_smmu_driver;
>>  static
>>  struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle 
>> *fwnode)
>>  {
>> -    struct device *dev = 
>> driver_find_device_by_fwnode(&arm_smmu_driver.driver,
>> -                              fwnode);
>> +    struct device *dev = 
>> bus_find_device_by_fwnode(&platform_bus_type, fwnode);
>> +      put_device(dev);
>>      return dev ? dev_get_drvdata(dev) : NULL;
>>  }
>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/ 
>> arm/arm-smmu/arm-smmu.c
>> index 8321962b3714..aba315aa6848 100644
>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> @@ -1411,8 +1411,8 @@ static bool arm_smmu_capable(struct device *dev, 
>> enum iommu_cap cap)
>>  static
>>  struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle 
>> *fwnode)
>>  {
>> -    struct device *dev = 
>> driver_find_device_by_fwnode(&arm_smmu_driver.driver,
>> -                              fwnode);
>> +    struct device *dev = 
>> bus_find_device_by_fwnode(&platform_bus_type, fwnode);
> I think it would still follow this path:
> 
> bus_find_device_by_fwnode() -> bus_find_device() -> next_device()
> 
> next_device() would always return null until the driver is bound to the 
> device which

No, this is traversing the bus list, *not* the driver list, that's the 
whole point. The SMMU device must exist on the platform bus before the 
driver can bind, since the bus is responsible for matching the driver in 
the first place.

> happens much later in really_probe() after the iommu_device_register() 
> would be called
> even as per this patch. That way the race would still occur, wouldn't it?
> Can you please help me understand what I may be missing here?
> Are you saying that these additional patches are required along with the 
> fix I've
> posted?

I'm saying my change makes there be no race, i.e. the "if (!smmu)" case 
can never be true, and so no longer needs working around.

Thanks,
Robin.

>> +
>>      put_device(dev);
>>      return dev ? dev_get_drvdata(dev) : NULL;
>>  }
>> @@ -2232,21 +2232,6 @@ static int arm_smmu_device_probe(struct 
>> platform_device *pdev)
>>                      i, irq);
>>      }
>>
>> -    err = iommu_device_sysfs_add(&smmu->iommu, smmu->dev, NULL,
>> -                     "smmu.%pa", &smmu->ioaddr);
>> -    if (err) {
>> -        dev_err(dev, "Failed to register iommu in sysfs\n");
>> -        return err;
>> -    }
>> -
>> -    err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
>> -                    using_legacy_binding ? NULL : dev);
>> -    if (err) {
>> -        dev_err(dev, "Failed to register iommu\n");
>> -        iommu_device_sysfs_remove(&smmu->iommu);
>> -        return err;
>> -    }
>> -
>>      platform_set_drvdata(pdev, smmu);
>>
>>      /* Check for RMRs and install bypass SMRs if any */
>> @@ -2255,6 +2240,18 @@ static int arm_smmu_device_probe(struct 
>> platform_device *pdev)
>>      arm_smmu_device_reset(smmu);
>>      arm_smmu_test_smr_masks(smmu);
>>
>> +    err = iommu_device_sysfs_add(&smmu->iommu, smmu->dev, NULL,
>> +                     "smmu.%pa", &smmu->ioaddr);
>> +    if (err)
>> +        return dev_err_probe(dev, err, "Failed to register iommu in 
>> sysfs\n");
>> +
>> +    err = iommu_device_register(&smmu->iommu, &arm_smmu_ops,
>> +                    using_legacy_binding ? NULL : dev);
>> +    if (err) {
>> +        iommu_device_sysfs_remove(&smmu->iommu);
>> +        return dev_err_probe(dev, err, "Failed to register iommu\n");
>> +    }
>> +
>>      /*
>>       * We want to avoid touching dev->power.lock in fastpaths unless
>>       * it's really going to do something useful - pm_runtime_enabled()
> 

