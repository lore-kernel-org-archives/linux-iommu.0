From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 1/2] iommu/arm-smmu-v3: Remove bypass in
	arm_smmu_reset_device
Date: Mon, 23 Apr 2018 17:07:43 +0100
Message-ID: <9e2f8646-482a-e721-d1b6-e674de48e276@arm.com>
References: <1524483959-54940-1-git-send-email-xieyisheng1@huawei.com>
	<1524483959-54940-2-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1524483959-54940-2-git-send-email-xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 23/04/18 12:45, Yisheng Xie wrote:
> Add a bypass parameter in arm_smmu_device to keep whether smmu device
> should pypass or not, so parameter bypass in arm_smmu_reset_device can
> be removed.

Given that the GBPA configuration implied by the bypass argument here is 
only there to avoid initialising a full stream table when the firmware 
is terminally broken, I wonder if it would make sense to simply skip 
allocating a stream table at all in that case. Then we could just base 
the subsequent SMMUEN/GPBA decision on whether strtab_cfg.strtab is 
valid or not.

Robin.

> This should not have any functional change, but prepare for later patch.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d64710..044df6e 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -587,6 +587,8 @@ struct arm_smmu_device {
>   
>   	u32				sync_count;
>   
> +	bool				bypass;
> +
>   	/* IOMMU core code handle */
>   	struct iommu_device		iommu;
>   };
> @@ -2384,7 +2386,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
>   	return ret;
>   }
>   
> -static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
> +static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>   {
>   	int ret;
>   	u32 reg, enables;
> @@ -2487,7 +2489,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>   
>   
>   	/* Enable the SMMU interface, or ensure bypass */
> -	if (!bypass || disable_bypass) {
> +	if (!smmu->bypass || disable_bypass) {
>   		enables |= CR0_SMMUEN;
>   	} else {
>   		ret = arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
> @@ -2778,7 +2780,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	resource_size_t ioaddr;
>   	struct arm_smmu_device *smmu;
>   	struct device *dev = &pdev->dev;
> -	bool bypass;
>   
>   	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
>   	if (!smmu) {
> @@ -2796,7 +2797,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	}
>   
>   	/* Set bypass mode according to firmware probing result */
> -	bypass = !!ret;
> +	smmu->bypass = !!ret;
>   
>   	/* Base address */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -2842,7 +2843,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, smmu);
>   
>   	/* Reset the device */
> -	ret = arm_smmu_device_reset(smmu, bypass);
> +	ret = arm_smmu_device_reset(smmu);
>   	if (ret)
>   		return ret;
>   
> 
