From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 4/4] iommu/arm-smmu: Add stub of_xlate() operation in
 SMMUv1/SMMUv2 driver
Date: Mon, 8 Feb 2016 11:18:29 +0000
Message-ID: <20160208111829.GA13498@leverpostej>
References: <1454908652-15317-1-git-send-email-anup.patel@broadcom.com>
 <1454908652-15317-5-git-send-email-anup.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1454908652-15317-5-git-send-email-anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Vikram Prakash <vikramp-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Feb 08, 2016 at 10:47:32AM +0530, Anup Patel wrote:
> To allow use of large memory (> 4Gb) with 32bit devices we need to use
> IOMMU based DMA mappings for such 32bit devices. The IOMMU dt-bindings
> allows us do this by specifying 'iommus' attribute in 32bit device DT
> node. Unfortunately, specifying 'iommus' attribute does not work with
> current SMMUv1/SMMUv2 driver because it requires of_xlate() operation
> to be implemented by the driver.
> 
> This patch adds a stub implementation of of_xlate() in SMMUv1/SMMUv2
> driver to allow usage of 'iommus' attribute in DT for 32bit devices.
> 
> Signed-off-by: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 02cd67d..8e090d8 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1398,6 +1398,16 @@ static int arm_smmu_init_platform_device(struct device *dev,
>  	return 0;
>  }
>  
> +int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
> +{
> +	/*
> +	 * Nothing to do here because SMMU is already aware of all
> +	 * MMU masters and their stream IDs using mmu-master attibute
> +	 * SMMU DT node.
> +	 */
> +	return 0;
> +}

NAK to this.

As previously mentioned by others [1], this is an abuse of the generic
iommu binding support code.

The SMMU binding currently does not define its implementation of the
generic IOMMU binding. This series did not define what an SMMU's
#iommu-cells would be nor what the contained values would represent.
Therefore it is not valid to use an SMMU node with an iommus property as
the SMMu doesn't follwo the generic IOMMU binding.

There is ongoing work to have generic iommu binding support for the
SMMU. In the absence of documentation for what this means for the
binding, I am worried that this hack harms that effort.

To use features of the generic IOMMU binding, we must properly implement
the generic IOMMU binding for the SMMU rather than bodging it onto the
side of the existing binding.

Thanks,
Mark.

> +
>  static int arm_smmu_add_device(struct device *dev)
>  {
>  	struct iommu_group *group;
> @@ -1495,6 +1505,7 @@ static struct iommu_ops arm_smmu_ops = {
>  	.unmap			= arm_smmu_unmap,
>  	.map_sg			= default_iommu_map_sg,
>  	.iova_to_phys		= arm_smmu_iova_to_phys,
> +	.of_xlate		= arm_smmu_of_xlate,
>  	.add_device		= arm_smmu_add_device,
>  	.remove_device		= arm_smmu_remove_device,
>  	.device_group		= arm_smmu_device_group,
> -- 
> 1.9.1
> 

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/402976.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
