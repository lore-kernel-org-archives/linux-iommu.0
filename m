From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/7] iommu/arm-smmu: Introduce bus notifier block
Date: Thu, 10 Oct 2013 17:12:17 +0100
Message-ID: <20131010161217.GD8528@mudshark.cambridge.arm.com>
References: <1381358286-27065-1-git-send-email-andreas.herrmann@calxeda.com>
	<1381358286-27065-3-git-send-email-andreas.herrmann@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1381358286-27065-3-git-send-email-andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 09, 2013 at 11:38:01PM +0100, Andreas Herrmann wrote:
>  drivers/iommu/arm-smmu.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 478c8ad..87239e8 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -46,6 +46,7 @@
>  #include <linux/amba/bus.h>
>  
>  #include <asm/pgalloc.h>
> +#include <asm/dma-iommu.h>
>  
>  /* Driver options */
>  #define ARM_SMMU_OPT_ISOLATE_DEVICES		(1 << 0)
> @@ -1983,6 +1984,56 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int arm_smmu_device_notifier(struct notifier_block *nb,
> +				unsigned long action, void *data)
> +{
> +	struct device *dev = data;
> +	struct dma_iommu_mapping *mapping;
> +	struct arm_smmu_device *smmu;
> +	void __iomem *gr0_base;
> +	u32 cr0;
> +	int ret;
> +
> +	switch (action) {
> +	case BUS_NOTIFY_BIND_DRIVER:
> +
> +		arm_smmu_add_device(dev);
> +		smmu = dev->archdata.iommu;
> +		if (!smmu || !(smmu->options & ARM_SMMU_OPT_ISOLATE_DEVICES))
> +			break;
> +
> +		mapping = arm_iommu_create_mapping(&platform_bus_type,
> +						0, SZ_128M, 0);

We need to find a better way of doing this; I'm really not happy hardcoding
that size limit and hoping for the best.

> +		if (IS_ERR(mapping)) {
> +			ret = PTR_ERR(mapping);
> +			dev_info(dev, "arm_iommu_create_mapping failed\n");
> +			break;
> +		}
> +
> +		ret = arm_iommu_attach_device(dev, mapping);
> +		if (ret < 0) {
> +			dev_info(dev, "arm_iommu_attach_device failed\n");
> +			arm_iommu_release_mapping(mapping);
> +		}
> +
> +		gr0_base = ARM_SMMU_GR0_NS(smmu);
> +		cr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
> +		cr0 |= sCR0_USFCFG;
> +		writel(cr0, gr0_base + ARM_SMMU_GR0_sCR0);

Why do you need to enable this flag? If no mapping is found, that means *we*
screwed something up, so we should report that and not rely on the hardware
potentially raising a fault. I also prefer to allow passthrough for devices
that don't hit in the stream table, because it allows people to ignore the SMMU
in their DT if they want to.

Will
