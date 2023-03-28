Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5148465
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 14:10:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50A2BC14;
	Tue, 28 Mar 2023 07:11:07 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4D733F73F;
	Tue, 28 Mar 2023 07:10:21 -0700 (PDT)
Message-ID: <e637a9a5-051a-7157-7973-adc2c0839598@arm.com>
Date: Tue, 28 Mar 2023 15:10:17 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 01/10] iommu/arm-smmu: Drop if with an always false
 condition
Content-Language: en-GB
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
 Jon Nettleton <jon@solid-run.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 kernel@pengutronix.de
References: <20230321084125.337021-1-u.kleine-koenig@pengutronix.de>
 <20230321084125.337021-2-u.kleine-koenig@pengutronix.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230321084125.337021-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/03/2023 8:41 am, Uwe Kleine-König wrote:
> The remove and shutdown callback are only called after probe completed
> successfully. In this case platform_set_drvdata() was called with a
> non-NULL argument and so smmu is never NULL. Other functions in this
> driver also don't check for smmu being non-NULL before using it.

Indeed, it seems this impossible condition has been here since day 1; 
shame on me for not paying more attention when Vladimir dutifully 
refactored it :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Also note that returning an error code from a remove callback doesn't
> result in the device staying bound. It's still removed and devm allocated
> resources are freed (among others *smmu and the register mapping). So
> after an early exit to iommu device stayed around and using it probably
> oopses.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 2ff7a72cf377..f4a36533ae47 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2195,9 +2195,6 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
>   {
>   	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
>   
> -	if (!smmu)
> -		return;
> -
>   	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
>   		dev_notice(&pdev->dev, "disabling translation\n");
>   
> @@ -2218,9 +2215,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>   {
>   	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
>   
> -	if (!smmu)
> -		return -ENODEV;
> -
>   	iommu_device_unregister(&smmu->iommu);
>   	iommu_device_sysfs_remove(&smmu->iommu);
>   
