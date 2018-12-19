From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
Date: Wed, 19 Dec 2018 10:54:18 +0100
Message-ID: <30d86186-e0a2-2be1-2295-20510fbd74ba@samsung.com>
References: <20181211150513.15161-1-joro@8bytes.org>
        <CGME20181211150640epcas5p4ffdd63a1900ebfe4a04eea24d2c86de6@epcas5p4.samsung.com>
        <20181211150513.15161-4-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211150513.15161-4-joro@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, jroedel@suse.de, Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

This patch landed in today's linux-next and causes a regression.

On 2018-12-11 16:05, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> Make sure to invoke this call-back through the proper
> function of the IOMMU-API.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/of_iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index c5dd63072529..4d4847de727e 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -218,10 +218,10 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  		ops = dev->iommu_fwspec->ops;
>  	/*
>  	 * If we have reason to believe the IOMMU driver missed the initial
> -	 * add_device callback for dev, replay it to get things in order.
> +	 * probe for dev, replay it to get things in order.
>  	 */
> -	if (ops && ops->add_device && dev->bus && !dev->iommu_group)
> -		err = ops->add_device(dev);
> +	if (dev->bus && !dev->iommu_group)
> +		err = iommu_probe_device(dev);

This change removes a check for NULL ops, what causes NULL pointer
exception on first device without IOMMU.

I'm also not sure if this is a good idea to call iommu_probe_device(),
which comes from dev->bus->iommu_ops, which might be different from ops
from local variable.

>  
>  	/* Ignore all other errors apart from EPROBE_DEFER */
>  	if (err == -EPROBE_DEFER) {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
