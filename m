Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3101F151E
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865950; cv=none; b=YxmUITgy0iUhOc7DKQispMwDekOlZl5cGFGM6hZyTudm1IZlj7U3a9HEJwwqNZNskzsRkHdX+BjypVu2LlHYBSMNlu92MKAvUmCE4f85N7gHu0MTv94b/ptwsLyTIHF2XCOkVRr/8w5DWvujlu7c1Mu5o3so5wTJDhg3Sk/CNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865950; c=relaxed/simple;
	bh=lazMAEs4AUA7A2gPWgWo4ogZfmQ9zGu6hGcN2wilfWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IAKzdwobGJny+cG4OciMg3Zt3Lw4mj4khzfGvLa29i7HHL6qO2PIlIRN0acFl+OlFXV+Aub+YMZ0HNu3WFIMNfK+rkkKdxDnJ4xC1PWYTw5fDfGyQPVyN0o9bye2x6mhScGCUaG9U3DpOiT2mJB0fI62tlH9dst09lO4BXJ6+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F20581C00;
	Thu, 13 Mar 2025 04:39:17 -0700 (PDT)
Received: from [10.57.40.246] (unknown [10.57.40.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95B703F673;
	Thu, 13 Mar 2025 04:39:02 -0700 (PDT)
Message-ID: <880d8d7d-cd83-4e39-a0de-e278187b7a36@arm.com>
Date: Thu, 13 Mar 2025 11:39:00 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iommu/arm: Add BBM Level 2 smmu feature
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 ryan.roberts@arm.com, suzuki.poulose@arm.com, yang@os.amperecomputing.com,
 corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
 jean-philippe@linaro.org, joro@8bytes.org, akpm@linux-foundation.org,
 mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
 james.morse@arm.com, broonie@kernel.org, anshuman.khandual@arm.com,
 oliver.upton@linux.dev, ioworker0@gmail.com, baohua@kernel.org,
 david@redhat.com, jgg@ziepe.ca, shameerali.kolothum.thodi@huawei.com,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
 <20250313104111.24196-4-miko.lenczewski@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250313104111.24196-4-miko.lenczewski@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-03-13 10:41 am, Mikołaj Lenczewski wrote:
> For supporting BBM Level 2 for userspace mappings, we want to ensure
> that the smmu also supports its own version of BBM Level 2. Luckily, the
> smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (DDI
> 0487K.a D8.16.2), so already guarantees that no aborts are raised when
> BBM level 2 is claimed.
> 
> Add the feature and testing for it under arm_smmu_sva_supported().

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 4 ++++
>   3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 9ba596430e7c..6ba182572788 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -222,6 +222,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>   		feat_mask |= ARM_SMMU_FEAT_VAX;
>   	}
>   
> +	if (system_supports_bbml2_noabort())
> +		feat_mask |= ARM_SMMU_FEAT_BBML2;
> +
>   	if ((smmu->features & feat_mask) != feat_mask)
>   		return false;
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 358072b4e293..dcee0bdec924 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4406,6 +4406,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	if (FIELD_GET(IDR3_RIL, reg))
>   		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
>   
> +	if (FIELD_GET(IDR3_BBML, reg) == IDR3_BBML2)
> +		smmu->features |= ARM_SMMU_FEAT_BBML2;
> +
>   	/* IDR5 */
>   	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR5);
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index bd9d7c85576a..85eaf3ab88c2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -60,6 +60,9 @@ struct arm_smmu_device;
>   #define ARM_SMMU_IDR3			0xc
>   #define IDR3_FWB			(1 << 8)
>   #define IDR3_RIL			(1 << 10)
> +#define IDR3_BBML			GENMASK(12, 11)
> +#define IDR3_BBML1			(1 << 11)
> +#define IDR3_BBML2			(2 << 11)
>   
>   #define ARM_SMMU_IDR5			0x14
>   #define IDR5_STALL_MAX			GENMASK(31, 16)
> @@ -754,6 +757,7 @@ struct arm_smmu_device {
>   #define ARM_SMMU_FEAT_HA		(1 << 21)
>   #define ARM_SMMU_FEAT_HD		(1 << 22)
>   #define ARM_SMMU_FEAT_S2FWB		(1 << 23)
> +#define ARM_SMMU_FEAT_BBML2		(1 << 24)
>   	u32				features;
>   
>   #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)

