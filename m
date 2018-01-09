From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/msm: Claim bus ops on probe
Date: Tue, 9 Jan 2018 11:34:36 +0530
Message-ID: <f839cc47-7c3a-d509-6cae-7d0897f53f61@codeaurora.org>
References: <f1a506337bf602c54f4d6d417c14ca556a5f3674.1515436860.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f1a506337bf602c54f4d6d417c14ca556a5f3674.1515436860.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 1/9/2018 12:12 AM, Robin Murphy wrote:
> Since the MSM IOMMU driver now probes via DT exclusively rather than
> platform data, dependent masters should be deferred until the IOMMU
> itself is ready. Thus we can do away with the early initialisation
> hook to unconditionally claim the bus ops, and instead do that only
> once an IOMMU is actually probed. Furthermore, this should also make
> the driver safe for multiplatform kernels on non-MSM SoCs.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/msm_iommu.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 04f4d51ffacb..dda1ce87a070 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -823,6 +823,8 @@ static int msm_iommu_probe(struct platform_device *pdev)
>  		goto fail;
>  	}
>  
> +	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
> +
>  	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
>  		iommu->base, iommu->irq, iommu->ncb);
>  
> @@ -875,19 +877,7 @@ static void __exit msm_iommu_driver_exit(void)
>  subsys_initcall(msm_iommu_driver_init);
>  module_exit(msm_iommu_driver_exit);
>  
> -static int __init msm_iommu_init(void)
> -{
> -	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
> -	return 0;
> -}
> -
> -static int __init msm_iommu_of_setup(struct device_node *np)
> -{
> -	msm_iommu_init();
> -	return 0;
> -}
> -
> -IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu", msm_iommu_of_setup);
> +IOMMU_OF_DECLARE(msm_iommu_of, "qcom,apq8064-iommu", NULL);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Stepan Moskovchenko <stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>");
> 

Reviewed-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Regards,
 Sricharan
-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
