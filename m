Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6A978C76
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240421; cv=none; b=pBea6Kt48REc+8F7OLSZMmQJsq1/2csPAvt5RccDF1ItqAcL7+Y/rjL5JJqCfONmAhoLO2zuHxfRk70/HPoDmRv9i746dZBmpMXsT5/JB0PAIyX0e39et5z1gomnjfVCav1LloThG1cTENQqQBkRxtil/wYvuIvQcqmNJ4XSChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240421; c=relaxed/simple;
	bh=S8C3TlY6FBYQ83qjSUa33k/bHW5OkxOu/hupsQ6oXJA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FrBXRPdW1lAtXj70jMkll4JffLL3vAO+n6xOfxhU8EQdoXdCHiEGXFqh3zv4O296HvISHGig1rO597DEvDC0q9FwLWueA2KN8bF93EOeSX4IWygZn/CjJn9tlOhtdSdU4/xNC4n0k6P0rKe8SS100cReMis63Bi0af2FMaKYsL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C23813D5;
	Fri, 13 Sep 2024 08:14:06 -0700 (PDT)
Received: from [10.57.76.33] (unknown [10.57.76.33])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5663C3F73B;
	Fri, 13 Sep 2024 08:13:36 -0700 (PDT)
Message-ID: <7c426dc0-4fde-4d1e-bb91-538984bd8b59@arm.com>
Date: Fri, 13 Sep 2024 16:13:29 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu: Clarify MMU-500 CPRE workaround
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org, joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <467590c40029ef0712b1fd38f2928fd4f08d09af.1726232138.git.robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <467590c40029ef0712b1fd38f2928fd4f08d09af.1726232138.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-13 1:55 pm, Robin Murphy wrote:
> CPRE workarounds are implicated in at least 5 MMU-500 errata, some of
> which remain unfixed. The comment and warning message have proven to be
> unhelpfully misleading about this scope, so reword them to get the point
> across with less risk of going out of date or confusing users.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> index 9dc772f2cbb2..2edb1c1658ad 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
> @@ -130,7 +130,7 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
>   
>   	/*
>   	 * Disable MMU-500's not-particularly-beneficial next-page
> -	 * prefetcher for the sake of errata #841119 and #826419.
> +	 * prefetcher for the sake of at least 5 known errata.
>   	 */
>   	for (i = 0; i < smmu->num_context_banks; ++i) {
>   		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
> @@ -138,7 +138,7 @@ int arm_mmu500_reset(struct arm_smmu_device *smmu)
>   		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, reg);
>   		reg = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
>   		if (reg & ARM_MMU500_ACTLR_CPRE)
> -			dev_warn_once(smmu->dev, "Failed to disable prefetcher [errata #841119 and #826419], check ACR.CACHE_LOCK\n");
> +			dev_warn_once(smmu->dev, "Failed to disable prefetcher for errata workarounds, check ACR.CACHE_LOCK\n");

Come to think of it, this should probably also refer to SACR rather than 
ACR, given that we already *have* attempted to program the Non-Secure 
side...

Robin.

>   	}
>   
>   	return 0;
