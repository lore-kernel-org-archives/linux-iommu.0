Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA2A155753
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556935; cv=none; b=UTh06DiBuPf9MUBImu1v7qEiK+uQstdS1Q5PQl0DMQoT7ntJcWYKWYv7cvEumfGh7A0SqCAfY2sg+4mlEV/gAuaAkOxyas9L0K1GdOSYAtJmF/zsb8I+3tYvY83o/N7B1MIT0XtsxmqGb+4OnY+kVP5WKyLUAc/BHfP7ihEQTmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556935; c=relaxed/simple;
	bh=/O7Oe6bR2N6vLHzEY4fmLhRAwUUrxHksP6vO8FhuCoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAw35JKkagqtEauKJOKlSnNLjnPf9tiHBxcgWBa6Jaf5UYy43VooNWn+zzUC7p9yDMUAtELnxWQPoZHSaA813kuzYv09Vbrm1hc8X2wWeoSH1dlYj2mq/7y/pOyMIsSEwkW0GH1VH4FnKuXaQW7PRTMLCKyoNUpkRq0F42VWBoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2800D106F;
	Fri, 21 Mar 2025 04:35:40 -0700 (PDT)
Received: from [10.57.40.79] (unknown [10.57.40.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CF453F673;
	Fri, 21 Mar 2025 04:35:31 -0700 (PDT)
Message-ID: <fe800f66-ed99-49ed-8010-67702ab4542d@arm.com>
Date: Fri, 21 Mar 2025 11:35:30 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Split out and tidy up Arm Kconfig
To: Pranjal Shrivastava <praan@google.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <a614ec86ba78c09cd16e348f633f6bb38793391f.1742480488.git.robin.murphy@arm.com>
 <Z90St0D6hyphtOID@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z90St0D6hyphtOID@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-21 7:18 am, Pranjal Shrivastava wrote:
> On Thu, Mar 20, 2025 at 02:21:28PM +0000, Robin Murphy wrote:
>> There are quite a lot of options for the Arm drivers, still all buried
>> in the top-level Kconfig. For ease of use and consistency with all the
>> other subdirectories, break these out into drivers/arm. For similar
>> clarity and self-consistency, also tweak the ARM_SMMU sub-options to use
>> "if" instead of "depends", to match ARM_SMMU_V3. Lastly also clean up
>> the slightly messy description of ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT as
>> highlighted by Geert - by now we really shouldn't need commentary on
>> v4.x kernel behaviour anyway - and downgrade it to EXPERT as the first
>> step in the 6-year-old threat to remove it entirely.
>>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/Kconfig     | 157 +-------------------------------------
>>   drivers/iommu/arm/Kconfig | 144 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 145 insertions(+), 156 deletions(-)
>>   create mode 100644 drivers/iommu/arm/Kconfig
>>
> 
> Thanks for this! It looks good.
> I was able to toggle configs and build for arm64.
> 
>> +
>> +config QCOM_IOMMUa
> Nit: I don't have much context but:
> 
> 1. Shall this be in .../arm/Kconfig?

Yes, it represents arm/arm-smmu/qcom-iommu.c

> Is this an custom
> implementation of some arm-smmu version? If yes, then maybe we can
> update the help string while at it?

It's based on driving preconfigured SMMU S1 contexts individually, but 
with Qualcomm-specific bindings and usage flavour, hence why it lives 
next to arm-smmu to share code, but remains its own distinct thing.

>> +	# Note: iommu drivers cannot (yet?) be built as modules
> 
> 2. I don't think this is true now? Shall we remove this comment?

Indeed it's out of date now, but I see that in itself still serving some 
purpose as an indicator that nobody's yet looked to see if this driver 
*could* be made modular, so I chose to leave it as-is.

>> +	bool "Qualcomm IOMMU Support"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
>> +	select QCOM_SCM
>> +	select IOMMU_API
>> +	select IOMMU_IO_PGTABLE_LPAE
>> +	select ARM_DMA_USE_IOMMU
>> +	help
>> +	  Support for IOMMU on certain Qualcomm SoCs.
>>
> 
> With the above nits:
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks!

Robin.
