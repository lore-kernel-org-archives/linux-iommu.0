From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 13/22] iommu/tegra: smmu: Create default IOVA maps
Date: Thu, 18 Jul 2013 14:10:29 -0600
Message-ID: <51E84BB5.9010303@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
	<1373021097-32420-14-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1373021097-32420-14-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/05/2013 04:44 AM, Hiroshi Doyu wrote:
> Create default IOVA maps at boot-up which can be attached to devices.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c

>  static int tegra_smmu_probe(struct platform_device *pdev)
>  {
>  	struct smmu_device *smmu;

> @@ -1160,13 +1182,15 @@ static int tegra_smmu_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(dev->of_node, "nvidia,#asids", &asids))
>  		return -ENODEV;
>  
> -	bytes = sizeof(*smmu) + asids * sizeof(*smmu->as);
> +	bytes = sizeof(*smmu) + asids * (sizeof(*smmu->as) +
> +					 sizeof(struct dma_iommu_mapping *));
>  	smmu = devm_kzalloc(dev, bytes, GFP_KERNEL);
>  	if (!smmu) {
>  		dev_err(dev, "failed to allocate smmu_device\n");
>  		return -ENOMEM;
>  	}
>  
> +	smmu->map = (struct dma_iommu_mapping **)(smmu->as + asids);

Shouldn't "+ asids" be "+ asids * sizeof(*smmu->as)" to match the
calculation of "bytes" above?
