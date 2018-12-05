From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] iommu/of: Don't call iommu_ops->add_device directly
Date: Wed, 5 Dec 2018 18:49:26 +0000
Message-ID: <41d06767-fe6e-a746-d76a-557259af3034@arm.com>
References: <20181205143646.4876-1-joro@8bytes.org>
 <20181205143646.4876-4-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205143646.4876-4-joro@8bytes.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On 05/12/2018 14:36, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make sure to invoke this call-back through the proper
> function of the IOMMU-API.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/of_iommu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index c5dd63072529..4d4847de727e 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -218,10 +218,10 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   		ops = dev->iommu_fwspec->ops;
>   	/*
>   	 * If we have reason to believe the IOMMU driver missed the initial
> -	 * add_device callback for dev, replay it to get things in order.
> +	 * probe for dev, replay it to get things in order.
>   	 */
> -	if (ops && ops->add_device && dev->bus && !dev->iommu_group)

Ugh, code I wrote...

I think that first ops test is serving double-duty - it's not just an 
"is ops->add_device safe to call?" check, but also the specific "do we 
need to try doing this at all?" check, since ops is only (potentially) 
set in the !err case at the top of this context.

> -		err = ops->add_device(dev);
> +	if (dev->bus && !dev->iommu_group)

Thus to avoid calling add_device erroneously in either of the "no valid 
IOMMU" cases (since dev->bus->iommu_ops may well be non-NULL), this 
still needs to be at least:

	if (ops && dev->bus && !dev->iommu_group)

What I can't quite remember just now is whether it's actually valid to 
get here with err == 0 but dev->iommu_fwspec->ops == NULL, so it *might* 
be OK to use "!err" instead of "ops" to make things slightly more 
obvious - I'll work through the flow tomorrow to double-check.

Robin.

> +		err = iommu_probe_device(dev);
>   
>   	/* Ignore all other errors apart from EPROBE_DEFER */
>   	if (err == -EPROBE_DEFER) {
> 
