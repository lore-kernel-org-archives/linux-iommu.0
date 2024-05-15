Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0078156248
	for <iommu@lists.linux.dev>; Wed, 15 May 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786990; cv=none; b=LRWUvzy/kVlI+jZCQw0Mw6RIWaw5mFezlainhw0aiaMO6SC0oeyUedKY1nRdQgP9UEb672jii0sCdXobRoJz3ZoxHT44hrPPy8cnpGelaQIf4pB9lavFsiQ7q4P5IhJWJxRRWCjB/hVonLRP127AA7r3aOFEf411cQ+i9eiIAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786990; c=relaxed/simple;
	bh=AORFTAhz4PzXJsL3IFqjxymuWeVh9qReMV49AS838a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feCya/l6y7GiKyIRazu0PSx2Jp4EGk941I0BBJnSX49ia5UfTzuxPl6wQJ73u3/OcREljYgliKAw7mxjyU18yG9Aqnhhrg2M3ojw64ejX6sxOJSJXTuxxyj2KuVSk9/omJMPtIPnoLI9EZoY5b7xiQR6ANfigGDXpkxcNpaJCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C9A11042;
	Wed, 15 May 2024 08:30:11 -0700 (PDT)
Received: from [10.57.5.6] (unknown [10.57.5.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4E003F7A6;
	Wed, 15 May 2024 08:29:45 -0700 (PDT)
Message-ID: <b348ee57-c461-4546-94dc-1cbdbaf33145@arm.com>
Date: Wed, 15 May 2024 16:29:45 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Skip prefetch cmd for MMU-600, MMU-700
To: Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Cc: Nicolin Chen <nicolinc@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>
References: <20240513215420.408374-1-danielmentz@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240513215420.408374-1-danielmentz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 2024-05-13 10:54 pm, Daniel Mentz wrote:
> Arm CoreLink MMU-600 and MMU-700 both silently ignore the
> CMD_PREFETCH_CONFIG command. Let's not waste cycles adding this command to
> the command queue if it is ignored anyway.

It is true that our implementations don't do anything with prefetch 
commands so far, however this is a valid architectural behaviour, and 
the intent of the quirk is really for buggy implementations where the 
commands erroneously fault.

TBH if saving cycles in arm_smmu_attach_dev() matters to you, then 
you're probably not going to like what's now queued in next that makes 
it absurdly overcomplicated with loads of indirect function calls...

Thanks,
Robin.

> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index aa62f0ecd053..98f1c4b44ef3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3684,6 +3684,8 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
>   	case IIDR_IMPLEMENTER_ARM:
>   		switch (productid) {
>   		case IIDR_PRODUCTID_ARM_MMU_600:
> +			/* MMU-600 silently ignores CMD_PREFETCH_CONFIG */
> +			smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
>   			/* Arm erratum 1076982 */
>   			if (variant == 0 && revision <= 2)
>   				smmu->features &= ~ARM_SMMU_FEAT_SEV;
> @@ -3692,6 +3694,8 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
>   				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
>   			break;
>   		case IIDR_PRODUCTID_ARM_MMU_700:
> +			/* MMU-700 silently ignores CMD_PREFETCH_CONFIG */
> +			smmu->options |= ARM_SMMU_OPT_SKIP_PREFETCH;
>   			/* Arm erratum 2812531 */
>   			smmu->features &= ~ARM_SMMU_FEAT_BTM;
>   			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
