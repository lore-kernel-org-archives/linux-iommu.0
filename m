Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD753624B5
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000631; cv=none; b=aHfMDYOkApFD6vNhgMo/ICicM7nELvcMkEAVYsAun7EpB1NPMVyy2sPlgGSxQRNXAjQxk+W73sV9MheSwwEXrYlU2vWMLIjjXIvDvocaBnQLnCXN1xMngI3PXLU4vwOQ4epXiZhhuGUEShcBmGd5uzCEvKVM5mimrNGCBAsxHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000631; c=relaxed/simple;
	bh=k2rj1EgzDeIpdCoIh+0JDtig4nD7ZEFVOoqVptB5uag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6vQ5zIZl2U46DCAqrtDyhVPndo1RavVHM1uWxdu0PAsZTM2ApDI7yeOeFLi+IdPQBXMsMXjLP8X8RT6WD3nz3A8i81XQzsy2fX6b4ftIzQQqpsVeEQBePE8LgGNuGkFcdVY94WWP+1cwxyAE6EhXvmERg/s3MRlfXj0kan8pC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F32811476;
	Wed, 21 Jan 2026 05:03:39 -0800 (PST)
Received: from [10.57.49.114] (unknown [10.57.49.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91C8B3F778;
	Wed, 21 Jan 2026 05:03:44 -0800 (PST)
Message-ID: <0c0d3707-9ea5-44f9-88a1-a65c62e3df8d@arm.com>
Date: Wed, 21 Jan 2026 13:03:42 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] driver core: enforce device_lock for
 driver_match_device()
To: Danilo Krummrich <dakr@kernel.org>, Wang Jiayue <akaieurus@gmail.com>,
 hanguidong02@gmail.com, gregkh@linuxfoundation.org, rafael@kernel.org
Cc: Aishwarya.TCV@arm.com, broonie@kernel.org, chenqiuji666@gmail.com,
 linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
 robin.clark@oss.qualcomm.com, will@kernel.org, joro@8bytes.org,
 iommu@lists.linux.dev
References: <CALbr=LYt-MqGM0ua78Rt7M679WR9hNnk0Or-WrB2myZ=KhaN0w@mail.gmail.com>
 <20260121085549.165428-1-akaieurus@gmail.com>
 <DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org>
 <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <DFU7SVI5SYE5.3MJP2ECGGZK5P@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-21 11:02 am, Danilo Krummrich wrote:
> On Wed Jan 21, 2026 at 11:40 AM CET, Danilo Krummrich wrote:
>> So, the problem is that in the callstack of the arm-smmu driver's (a platform
>> driver) probe() function, the QCOM specific code (through arm_smmu_impl_init())
>> registers another platform driver. Since we are still in probe() of arm-smmu the
>> call to platform_driver_register() happens with the device lock of the arm-smmu
>> platform device held.
>>
>> platform_driver_register() eventually results in driver_attach() which iterates
>> over all the devices of a bus. Since the device we are probing and the driver we
>> are registering are for the same bus (i.e. the platform bus) it can now happen
>> that by chance that we also match the exact same device that is currently probed
>> again. And since we take the device lock for matching now, we actually take the
>> same lock twice.
>>
>> Now, we could avoid this by not matching bound devices, but we check this
>> through dev->driver while holding the device lock, so that doesn't help.
>>
>> But on the other hand, I don't see any reason why a driver would call
>> platform_driver_register() from probe() in the first place. I think drivers
>> should not do that and instead just register the driver through a normal
>> initcall.
>>
>> (If, however, it turns out that registering drivers from probe() is something we
>> really need for some reason, it is probably best to drop the patch and don't
>> make any guarantees about whether match() is called with the device lock held or
>> not.
>>
>> Consequently, driver_override must be protected with a separate lock (which
>> would be the cleaner solution in any case).)
> 
> I assume that this should resolve the problem (unless there are more drivers
> that register drivers in probe()):
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 573085349df3..9bb793efc35f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -774,10 +774,6 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>   {
>          const struct device_node *np = smmu->dev->of_node;
>          const struct of_device_id *match;
> -       static u8 tbu_registered;
> -
> -       if (!tbu_registered++)
> -               platform_driver_register(&qcom_smmu_tbu_driver);
> 
>   #ifdef CONFIG_ACPI
>          if (np == NULL) {
> @@ -802,3 +798,5 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
> 
>          return smmu;
>   }
> +
> +builtin_platform_driver(qcom_smmu_tbu_driver);
> 
> @qcom maintainers: I'm aware of commit 0b4eeee2876f ("iommu/arm-smmu-qcom:
> Register the TBU driver in qcom_smmu_impl_init"), but I think the above patch
> should work fine as it is still *not only* registered when
> CONFIG_ARM_SMMU_QCOM_DEBUG?

In principle there should be nothing wrong with registering the driver 
unconditionally - that existing tbu_registered logic looks racy in the 
face of async_probe anyway - however I don't think the *_platform_driver 
macros will work here, as this all gets combined into arm_smmu.ko 
wherein ending up with multiple module_init declarations breaks the build.

(Please do double-check all the build permutations of ARM_SMMU, 
ARM_SMMU_QCOM and ARM_SMMU_QCOM_DEBUG)

Thanks,
Robin.
