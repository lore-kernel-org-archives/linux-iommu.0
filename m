From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Implement shutdown method
Date: Thu, 29 Jun 2017 18:34:05 -0400
Message-ID: <f341a982-9ef3-d907-7254-f1e39ae3b1da@codeaurora.org>
References: <1498774696-16037-1-git-send-email-nwatters@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1498774696-16037-1-git-send-email-nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I should have removed the '-v3' since this revision of the patch adds
shutdown to arm-smmu.c as well. I'll fix that in a subsequent version
after waiting to see if there are additional changes that need to be
made.

On 6/29/2017 6:18 PM, Nate Watterson wrote:
> The shutdown method disables the SMMU to avoid corrupting a new kernel
> started with kexec.
> 
> Signed-off-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 7 +++++++
>   drivers/iommu/arm-smmu.c    | 6 ++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 380969a..3d8ac29 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2765,9 +2765,15 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>   	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
>   
>   	arm_smmu_device_disable(smmu);
> +
>   	return 0;
>   }
>   
> +static void arm_smmu_device_shutdown(struct platform_device *pdev)
> +{
> +	arm_smmu_device_remove(pdev);
> +}
> +
>   static struct of_device_id arm_smmu_of_match[] = {
>   	{ .compatible = "arm,smmu-v3", },
>   	{ },
> @@ -2781,6 +2787,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>   	},
>   	.probe	= arm_smmu_device_probe,
>   	.remove	= arm_smmu_device_remove,
> +	.shutdown = arm_smmu_device_shutdown,
>   };
>   module_platform_driver(arm_smmu_driver);
>   
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 7ec30b0..af50bab 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -2319,6 +2319,11 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static void arm_smmu_device_shutdown(struct platform_device *pdev)
> +{
> +	arm_smmu_device_remove(pdev);
> +}
> +
>   static struct platform_driver arm_smmu_driver = {
>   	.driver	= {
>   		.name		= "arm-smmu",
> @@ -2326,6 +2331,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>   	},
>   	.probe	= arm_smmu_device_probe,
>   	.remove	= arm_smmu_device_remove,
> +	.shutdown = arm_smmu_device_shutdown,
>   };
>   module_platform_driver(arm_smmu_driver);
>   
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
