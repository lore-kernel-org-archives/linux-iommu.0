From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] fsl-mc: Added header file to provide fsl-mc bus
	iommu group creation
Date: Thu, 30 Jun 2016 11:55:58 +0100
Message-ID: <5774FABE.5070707@arm.com>
References: <1467220448-16764-1-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1467220448-16764-1-git-send-email-nipun.gupta-3arQi8VN3Tc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, stuart.yoder-3arQi8VN3Tc@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 29/06/16 18:14, Nipun Gupta wrote:
> Added a header file fsl_mc_smmu.h to provide basic support of creating
> an IOMMU group for a fsl-mc type device and also provide helper macro
> to get the stream ID of fsl-mc tyoe device.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
> ---
>  drivers/staging/fsl-mc/include/fsl_mc_smmu.h | 45 ++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 drivers/staging/fsl-mc/include/fsl_mc_smmu.h
> 
> diff --git a/drivers/staging/fsl-mc/include/fsl_mc_smmu.h b/drivers/staging/fsl-mc/include/fsl_mc_smmu.h
> new file mode 100644
> index 0000000..9dff5ba
> --- /dev/null
> +++ b/drivers/staging/fsl-mc/include/fsl_mc_smmu.h
> @@ -0,0 +1,45 @@
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Author: Nipun Gupta <nipun.gupta-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef _FSL_MC_SMMU_H_
> +#define _FSL_MC_SMMU_H_
> +
> +#include <../drivers/staging/fsl-mc/include/mc.h>
> +
> +/* Macro to get the MC device ICID (Stream ID) */
> +#define fslmc_dev_streamid(_dev) (to_fsl_mc_device(_dev)->icid)

Is the the full 15-bit ICID from the MC's point of view, just the 7 bits
that are actually routed to the SMMU, or the actual stream ID seen by
the SMMU? None of those three are necessarily the same, and unless it's
the third then I don't see the point of patches adding incomplete code
which isn't going to work.

> +/* Macro to get the container device of a MC device */
> +#define fslmc_cont_dev(_dev) ((to_fsl_mc_device(dev)->flags & \
> +	FSL_MC_IS_DPRC) ? (_dev) : (_dev->parent))
> +
> +/* Macro to check if a device is a container device */
> +#define is_cont_dev(_dev) (to_fsl_mc_device(_dev)->flags & FSL_MC_IS_DPRC)
> +
> +static struct iommu_group *fslmc_device_group(struct device *dev)
> +{
> +	struct device *cont_dev = fslmc_cont_dev(dev);
> +	struct iommu_group *group;
> +
> +	/* Container device is responsible for creating the iommu group */
> +	if (is_cont_dev(dev)) {
> +		group = iommu_group_alloc();
> +
> +		if (IS_ERR(group))
> +			return NULL;
> +	} else {
> +		get_device(cont_dev);
> +		group = iommu_group_get(cont_dev);
> +		put_device(cont_dev);
> +	}
> +
> +	return group;
> +}

In isolation, though, this part seems perfectly reasonable.

Robin.

> +
> +#endif /* _FSL_MC_SMMU_H_ */
> 
