Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4403B2D47E4
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765571797; cv=none; b=LZzLPgNOGH05LZnlNVAjRewoSLV0gbeUIPnkE2LLhjZxoaiZe16fNlkx4eTia2Kc0Gq7rPHseKY+7Cjk5VHrp8g5zTe3Pq3KEVeOcv0tRMrlmSEcfcgm46qtue0beyjuDF9O4LculNt4mDcsC5HERSTTEoheuHnJRzrk+rZNvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765571797; c=relaxed/simple;
	bh=Wr5l93HxK6yATXbDCP7Hf/rUCIiHc/qT9612u4YlCsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhMIylvTDs5IAv8ZkY/SAAFPXvcPNGpZ/7/VPW6FwIGHGPAbjHKbOdy0Yms6UIPhckW9cGcQN9MbfYxPrJexYss7qyjpYyi5Ii/1JmVQGZdVcbPIr34E/FjvoA5NNgAzVTrS/aLHKwf171xUwcidg+BHKVYlMM3utMZnVd4BQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3014B1063;
	Fri, 12 Dec 2025 12:36:27 -0800 (PST)
Received: from [10.1.196.95] (e121345-lin.cambridge.arm.com [10.1.196.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA0FD3F740;
	Fri, 12 Dec 2025 12:36:31 -0800 (PST)
Message-ID: <104441bd-1284-4147-873a-f94c91788609@arm.com>
Date: Fri, 12 Dec 2025 20:36:25 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/4] iommu/tegra241-cmdqv: Decouple driver from ACPI
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org, joro@8bytes.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, vdumpa@nvidia.com,
 jgg@ziepe.ca, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251212060803.1712637-1-amhetre@nvidia.com>
 <20251212060803.1712637-2-amhetre@nvidia.com>
 <54fce1f8-7675-4351-b292-0009b2e8c599@arm.com> <aTxxBdcY4hODXcdu@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aTxxBdcY4hODXcdu@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/2025 7:46 pm, Nicolin Chen wrote:
> On Fri, Dec 12, 2025 at 12:01:41PM +0000, Robin Murphy wrote:
>>> @@ -4542,7 +4542,7 @@ static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
>>>    	adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
>>>    	if (adev) {
>>>    		/* Tegra241 CMDQV driver is responsible for put_device() */
>>
>> Don't we need to bring the put_device(adev) out to this level, since
>> impl_dev is now something else that AFAICS we are *not* taking a new
>> reference on (and thus should not be putting either)?
> 
> Ah, right! We are using the platform device now.
> 
>>> -		smmu->impl_dev = &adev->dev;
>>> +		smmu->impl_dev = acpi_get_first_physical_node(adev);
>>>    		smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>>>    		dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>>>    			 dev_name(smmu->impl_dev));
> 
> I think we should squash this:

Ack, it occurred to me shortly after sending that in fact it's good to 
still hold our own reference on impl_dev itself, as we're not relying on 
a bound driver to hold one for us.

Cheers,
Robin.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 0c98be3135c63..88625e3c27a65 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5280,10 +5280,11 @@ static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
>   	adev = acpi_dev_get_first_match_dev("NVDA200C", uid, -1);
>   	if (adev) {
>   		/* Tegra241 CMDQV driver is responsible for put_device() */
> -		smmu->impl_dev = acpi_get_first_physical_node(adev);
> +		smmu->impl_dev = get_device(acpi_get_first_physical_node(adev));
>   		smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
>   		dev_info(smmu->dev, "found companion CMDQV device: %s\n",
>   			 dev_name(smmu->impl_dev));
> +		acpi_dev_put(adev);
>   	}
>   	kfree(uid);
>   }
> 
> Thanks
> Nicolin

