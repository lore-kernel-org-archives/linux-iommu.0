Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E54C4414
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296729; cv=none; b=gPi7Y3rHdVCZi8eeQPf0qQG7E0q3hQnIm6M2ZSm/4sm2FvVnp4+GddHu3+o/yGDWkJq3Ctk2TMbVah9CauIzUINlZoszuWE19ev6W+zvrRaxW3IQBH+muTvJt3+Pe581HXvUkJVhQw2kEWIGyWbvj10txsAx/hzA9kjW81e5tGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296729; c=relaxed/simple;
	bh=/szC6wM1aBy7BZ3w1y4J06ChwF+L2TbPiaAbVGSKvUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WycQxMquXjbh4f4dCFCTsnXAf/XA+ElLCjuZG4JEYl8uf490MdV+dMFa7bYwMHQFin9bHpV7fVHnrQpsyU4oLm4fyCMqEu89pMhT8pOBDCsbQUospPWh45iZAkMVrjjP09cFcuEDtANFz8VjH8+bbWOPNoF4DiGoVF4WYKViWwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9112339;
	Thu,  5 Feb 2026 05:05:21 -0800 (PST)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FC983F778;
	Thu,  5 Feb 2026 05:05:26 -0800 (PST)
Message-ID: <3f22f7b8-449c-40d9-b4c8-fff3e520d563@arm.com>
Date: Thu, 5 Feb 2026 13:05:24 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Restrict MMU-700 errata 2268618 and
 2812531 to affected
To: Zhiyuan Dai <daizhiyuan@phytium.com.cn>, will@kernel.org, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260205093356.4328-1-daizhiyuan@phytium.com.cn>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260205093356.4328-1-daizhiyuan@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/02/2026 9:33 am, Zhiyuan Dai wrote:
> According to SDEN-1786925, Arm errata 2268618 and 2812531 are present in
> r0p0, r0p1, and r1p0, and fixed in r1p1.

This is a bit fiddly, since these workarounds also overlap some other 
errata that IIRC were *not* fixed in r1p1 - it's been on my to-do list 
to figure this out for a while now, sorry I haven't had a chance to get 
to it.

> Introduce this patch to avoid performance degradation caused by
> restricting features on unaffected revisions.

I'm curious, can you clarify the performance impact? At the time I was 
pretty sure that the ARM_SMMU_OPT_CMDQ_FORCE_SYNC was just for safety 
and never likely to be hit in practice, since with range invalidations 
any unmap should never end up with anywhere near 16 TLBIs in a single 
batch anyway. Is that no longer the case?

> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d16d35c78c06..7eadb27eb9be 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4272,11 +4272,13 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
>   				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
>   			break;
>   		case IIDR_PRODUCTID_ARM_MMU_700:
> -			/* Arm erratum 2812531 */
> -			smmu->features &= ~ARM_SMMU_FEAT_BTM;
> -			smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
> -			/* Arm errata 2268618, 2812531 */
> -			smmu->features &= ~ARM_SMMU_FEAT_NESTING;
> +			if (variant <= 1 && revision < 0) {

revision is unsigned, it cannot be < 0. This just breaks the workarounds 
entirely.

Thanks,
Robin.

> +				/* Arm erratum 2812531 */
> +				smmu->features &= ~ARM_SMMU_FEAT_BTM;
> +				smmu->options |= ARM_SMMU_OPT_CMDQ_FORCE_SYNC;
> +				/* Arm errata 2268618, 2812531 */
> +				smmu->features &= ~ARM_SMMU_FEAT_NESTING;
> +			}
>   			break;
>   		}
>   		break;

