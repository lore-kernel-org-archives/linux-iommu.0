Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A721E1078A
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 10:26:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AADFE1042;
	Tue, 14 Feb 2023 02:26:37 -0800 (PST)
Received: from [10.57.89.147] (unknown [10.57.89.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AA173F703;
	Tue, 14 Feb 2023 02:25:54 -0800 (PST)
Message-ID: <2f1e67de-645d-2da9-d46c-d37d28ddc03b@arm.com>
Date: Tue, 14 Feb 2023 10:25:49 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] iommu: Fix potential concurrent free issue
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>, joro@8bytes.org,
 will@kernel.org
Cc: iommu@lists.linux.dev
References: <1676358214-25732-1-git-send-email-quic_zhenhuah@quicinc.com>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1676358214-25732-1-git-send-email-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-02-14 07:03, Zhenhua Huang wrote:
> Some cases in which probing with a non-iommu bind device,
> we saw dev_iommu_free() called in the same time. Add checking
> to avoid NULL dereference.
> 
> One path was with smmu driver probing:
> [    0.538555][  T165]  dev_iommu_free+0xa0/0x198
> [    0.538557][  T165]  __iommu_probe_device+0x244/0x2e4
> [    0.538559][  T165]  probe_iommu_group+0x38/0x54
> [    0.538561][  T165]  bus_iommu_probe+0x70/0x37c
> [    0.538563][  T165]  bus_set_iommu+0xcc/0x1b8
> [    0.538578][  T165]  arm_smmu_bus_init+0x38/0xd0 [arm_smmu]
> [    0.538592][  T165]  arm_smmu_device_probe+0x630/0x6d8 [arm_smmu]
> The other was with device itself probing:
> [    0.529488][    T9]  __iommu_probe_device+0x244/0x354
> [    0.529490][    T9]  iommu_probe_device+0x44/0x460
> [    0.529492][    T9]  iommu_bus_notifier+0x44/0x160
> [    0.529494][    T9]  device_add+0x9f0/0x12a0
> [    0.529497][    T9]  of_platform_device_create_pdata+0xc8/0x168
> [    0.529499][    T9]  of_platform_bus_create+0x1b0/0x254
> [    0.529500][    T9]  of_platform_populate+0x9c/0x114
> [    0.529502][    T9]  devm_of_platform_populate+0xb4/0x118
> [    0.529507][    T9]  pmic_spmi_probe+0x108/0x140 [qcom_spmi_pmic]
> [    0.529511][    T9]  spmi_drv_probe+0x70/0x140
> [    0.529514][    T9]  really_probe+0x3f0/0x8dc
> [    0.529515][    T9]  driver_probe_device+0x1b0/0x230
> ...

This looks like the same thing that commit 01657bc14a39 ("iommu: Avoid 
races around device probe") was supposed to have fixed. But then 
bus_set_iommu() no longer exists in mainline anyway, so I'm not sure 
what kernel you're using :/

Thanks,
Robin.

> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 42891e5..30f8d8f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -276,12 +276,18 @@ static void dev_iommu_free(struct device *dev)
>   {
>   	struct dev_iommu *param = dev->iommu;
>   
> -	dev->iommu = NULL;
> -	if (param->fwspec) {
> -		fwnode_handle_put(param->fwspec->iommu_fwnode);
> -		kfree(param->fwspec);
> +	if (!param)
> +		return;
> +
> +	if (param == cmpxchg(&dev->iommu, param, NULL)) {
> +		if (param->fwspec) {
> +			fwnode_handle_put(param->fwspec->iommu_fwnode);
> +			kfree(param->fwspec);
> +		}
> +		kfree(param);
> +	} else {
> +		return;
>   	}
> -	kfree(param);
>   }
>   
>   static u32 dev_iommu_get_max_pasids(struct device *dev)
