Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D761F93E
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774278; cv=none; b=HuSyMtOkHf/+xpRNXjda2er4KuP6KCFW3EhY7SoBe5zj3KHgfY8LaKi9N1OelcWV0zEyOsTbolsvdHM6f9Sw4URqa9lVBa1KIICNXtZ+JsmaakoWvAnRVbzRshoooHHLxstN4rycAFEEaK12v5arpAwRfMVaeyjstAsbcKNdaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774278; c=relaxed/simple;
	bh=Hv5EEocGMjGU1RLGkQFcoi/uMmMZh5Os9cCyNijklnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omhm4IcFrhm3p7t9ck529+AtbYvpw9m+NmQ3lP9hSl8/9QGzVePEynon47dtE8W/i2P1F2tQGXCNtyOOiIc+oSWQ8yjgy/Wl2YlypgT5AlCtmwjdefbiZGtSc4d2wCRITP32G1HFam8sWaYg+WpbJM0b/WdHUCetn23y8eH+ErA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 211F8DA7;
	Tue, 27 Aug 2024 08:58:22 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0B283F762;
	Tue, 27 Aug 2024 08:57:54 -0700 (PDT)
Message-ID: <3256d9ce-2c10-4cdd-b4c4-358f2c30a9a3@arm.com>
Date: Tue, 27 Aug 2024 16:57:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 06/10] iommu/arm-smmu-v3: Add
 acpi_smmu_acpi_probe_model for impl
To: Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Cc: joro@8bytes.org, jgg@nvidia.com, thierry.reding@gmail.com,
 vdumpa@nvidia.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org
References: <cover.1724453781.git.nicolinc@nvidia.com>
 <8a2629bb98cabb1be72b32c120bb5ed0114b21bc.1724453781.git.nicolinc@nvidia.com>
 <20240827130233.GF4772@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240827130233.GF4772@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/08/2024 2:02 pm, Will Deacon wrote:
> On Fri, Aug 23, 2024 at 05:10:40PM -0700, Nicolin Chen wrote:
>> For model-specific implementation, repurpose the acpi_smmu_get_options()
>> to a wider acpi_smmu_acpi_probe_model(). A new model can add to the list
>> in this new function.
>>
>> Suggested-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++-----
>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index afdb8a76a72a..ceb31d63f79b 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -4341,18 +4341,28 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>>   }
>>   
>>   #ifdef CONFIG_ACPI
>> -static void acpi_smmu_get_options(u32 model, struct arm_smmu_device *smmu)
>> +static int acpi_smmu_iort_probe_model(struct acpi_iort_node *node,
>> +				      struct arm_smmu_device *smmu)
>>   {
>> -	switch (model) {
>> +	struct acpi_iort_smmu_v3 *iort_smmu =
>> +		(struct acpi_iort_smmu_v3 *)node->node_data;
>> +
>> +	switch (iort_smmu->model) {
>>   	case ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:
>>   		smmu->options |= ARM_SMMU_OPT_PAGE0_REGS_ONLY;
>>   		break;
>>   	case ACPI_IORT_SMMU_V3_HISILICON_HI161X:
>>   		smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
>>   		break;
>> +	case ACPI_IORT_SMMU_V3_GENERIC:
>> +		break;
>> +	default:
>> +		dev_err(smmu->dev, "Unknown/unsupported IORT model!\n");
>> +		return -ENXIO;
> 
> We probably don't want this 'default' case, otherwise the driver will
> need to be updated every time there's a new model.

...although the intent is very strongly that there should never be any 
new models, because by now hardware should really not be failing to 
implement SMMU_IIDR correctly. In some ways, having this might help 
further discourage people from abusing the mechanism and making random 
stuff up in their firmware :/

Cheers,
Robin.
