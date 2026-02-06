Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CF6231842
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399369; cv=none; b=PEeztd5234UjLx5M56Hmj0TcikWEgSz35fWzsIpiK0wxTomSrlLQP5BE6gZi2gFsC0xXO3Vp0iCG5jkae7IE0n1jzxSOH6F/OMInBffXrU9ANQK/T9+G/X9z1SUwD3s3BxOUd3ATP1TSZSl1/jvJLnYrR2OXulfLkWXFOYxd9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399369; c=relaxed/simple;
	bh=vfmXj24uN06y/FV/u4F7dOzRzFvyFmbgX5UlVHxmbYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrUUJAG0m1mjk4sAHnQ6ACcxgB9hCTMNcFdelTV3pEbb8XqADGTtO6vNtMufeUSRAqJnIjp0hnu3TDMGDc0U9LVxN6Pzrmh/E1Ja1qRErrehAFoiRYhehF5uyOIl0SCu/E8+mUBkLRnzdOPLVCt+tmigT9cYj+Oa5AECdF7HGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D352339;
	Fri,  6 Feb 2026 09:36:01 -0800 (PST)
Received: from [10.57.54.83] (unknown [10.57.54.83])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DB4E3F778;
	Fri,  6 Feb 2026 09:36:06 -0800 (PST)
Message-ID: <9c15f736-9737-400f-a757-2640d07ba551@arm.com>
Date: Fri, 6 Feb 2026 17:36:04 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Restrict MMU-700 errata 2268618 and
 2812531 to affected
To: Zhiyuan Dai <daizhiyuan@phytium.com.cn>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260206-smmuv3-v2-1-f381a2125392@phytium.com.cn>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260206-smmuv3-v2-1-f381a2125392@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-06 8:18 am, Zhiyuan Dai wrote:
> According to SDEN-1786925, Arm errata 2268618 and 2812531 are present in
> r0p0, r0p1, and r1p0, and fixed in r1p1.
> 
> Introduce this patch to avoid performance degradation caused by
> restricting features on unaffected revisions.
> 
> Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
> ---
> Changelog:
> - Change the revision threshold from < 0 to < 1 to correctly.
> - Link to v1: https://lore.kernel.org/linux-iommu/3f22f7b8-449c-40d9-b4c8-fff3e520d563@arm.com/raw
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d16d35c78c06..d5c35be5c858 100644
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
> +			if (variant <= 1 && revision < 1) {

This still breaks r0p1, and you've not addressed the other point I made...

I've now dug up the old branch where I started my own patch (back in May 
2024, yikes!), and gone through the newer errata for MMU-700 plus the 
newer MMU S3 and MMU L1 products that have also inherited some of its 
bugs - I'll finish writing up a cover letter for that and share it on 
Monday.

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
> 
> ---
> base-commit: b7ff7151e653aa296ab6c5495b2c1ab7c21eb250
> change-id: 20260206-smmuv3-a88772377c20
> 
> Best regards,

