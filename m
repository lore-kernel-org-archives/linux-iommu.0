Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465623A4F30
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964462; cv=none; b=SAa32Kj46P+g0kfHI0zJjDxlKHcmjSyQBYPULlXOu5C5HWhydcd6WTK9VdywrItHGn9nH01wPBgE144xUZSnQ5bYv44Eg8Ukmoky6S3ZfbFYUHgFa+ke6TFitvOqDPTQMLoZxC4wct+Z7XJGjlcMz147kQ9KjJzZFNUqDQqFi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964462; c=relaxed/simple;
	bh=6I0RUYpIm1S2IYch2bSU9bcVtz94N5mghp4kUJjkPBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZqQcuvFJO2va4efXCmcgCRzSIiuYj8qCjb0N/a9AuCReczxNZNNouswvzsWr71erO++mO9BDJobooPdrGsJ1iukVZJaJQ3ZLaUwrV1RETr/tgaWM/qvddf2y/Qc/D9SUK+bqyExby4B/TlmG6B9nFmeYUdOJpONNi4E+o7bvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fElDc5KO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fElDc5KO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAFAD43F7;
	Thu, 28 May 2026 03:34:14 -0700 (PDT)
Received: from [10.57.35.233] (unknown [10.57.35.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C1123F905;
	Thu, 28 May 2026 03:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779964459; bh=6I0RUYpIm1S2IYch2bSU9bcVtz94N5mghp4kUJjkPBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fElDc5KOCPdHu1JH6xL0iLFoL2GSUtcpQ5G7tZHxS+n6xgSwmPgDMoZju9bqm6xJL
	 nZLdKUmw5HuNLp7MC7K8rFye2kdV6qiqh56+Qv2qpFtcLdmx5TYE1qzRuNt6CPxSdZ
	 Gwoywn5rNPUO5jmEzjHQxH5DXc5vygZIQ1mTH32E=
Message-ID: <f25b769a-d89f-46c6-a3d2-9fa35882b848@arm.com>
Date: Thu, 28 May 2026 11:34:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/arm-smmu-v3: Detect Tegra264 erratum
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org, joro@8bytes.org,
 jgg@ziepe.ca, nicolinc@nvidia.com
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260528101617.4068249-1-amhetre@nvidia.com>
 <20260528101617.4068249-2-amhetre@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260528101617.4068249-2-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-28 11:16 am, Ashish Mhetre wrote:
> Tegra264 SMMU is affected by erratum where a TLB entry can survive an
> invalidation that races with concurrent traffic targeting the same
> entry. The hardware-recommended software workaround is to issue every
> CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue is
> guaranteed to evict the entry. ATC_INV is not affected and must not be
> doubled.
> 
> Add the ARM_SMMU_OPT_TLBI_TWICE option and set it on instances matching
> the existing "nvidia,tegra264-smmu" compatible. No callers consume the
> option yet, next patch wires the workaround into the CMDQ issue paths.

Can you not detect this implementation from IIDR like for our other 
workarounds? Otherwise what about ACPI?

Thanks,
Robin.

> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 8 ++++++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9be589d14a3b..88296c0a5337 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -5229,8 +5229,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>   	if (of_dma_is_coherent(dev->of_node))
>   		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>   
> -	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
> +	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu")) {
>   		tegra_cmdqv_dt_probe(dev->of_node, smmu);
> +		smmu->options |= ARM_SMMU_OPT_TLBI_TWICE;
> +	}
>   
>   	return ret;
>   }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 16353596e08a..08d1abaf31ae 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -928,6 +928,14 @@ struct arm_smmu_device {
>   #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
>   #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
>   #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
> +/*
> + * Tegra264 erratum: a TLB entry can survive an invalidation that races
> + * with concurrent traffic targeting the same entry. The software
> + * workaround is to issue every CFGI/TLBI command twice, each followed
> + * by CMD_SYNC. The second issue is guaranteed to evict the entry.
> + * ATC_INV commands are not affected and must not be doubled.
> + */
> +#define ARM_SMMU_OPT_TLBI_TWICE		(1 << 5)
>   	u32				options;
>   
>   	struct arm_smmu_cmdq		cmdq;

