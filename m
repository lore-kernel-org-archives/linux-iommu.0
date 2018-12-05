From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 2/5] iommu/of: Use device_iommu_mapped()
Date: Wed, 5 Dec 2018 17:17:54 +0000
Message-ID: <44c82503-bc36-e8de-6932-7c4fd2b597f8@arm.com>
References: <20181204172504.19708-1-joro@8bytes.org>
 <20181204172504.19708-3-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204172504.19708-3-joro@8bytes.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 04/12/2018 17:25, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use Use device_iommu_mapped() to check if the device is
> already mapped by an IOMMU.

FWIW, this check (and its ACPI equivalent in patch #3) is specifically 
asking "has .add_device() already been called?", rather than the more 
general "is this device managed by an IOMMU?" (to which the exact answer 
at this point is "yes, provided we return successfully from here").

I have no objection to the change as-is - especially if that usage is 
within the intended scope of this API - I just wanted to call it out in 
case you're also planning to introduce something else which would be 
even more appropriate for that.

Robin.

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>   drivers/iommu/of_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index c5dd63072529..bfcf139503f0 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -220,7 +220,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   	 * If we have reason to believe the IOMMU driver missed the initial
>   	 * add_device callback for dev, replay it to get things in order.
>   	 */
> -	if (ops && ops->add_device && dev->bus && !dev->iommu_group)
> +	if (ops && ops->add_device && dev->bus && !device_iommu_mapped(dev))
>   		err = ops->add_device(dev);
>   
>   	/* Ignore all other errors apart from EPROBE_DEFER */
> 
