From: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 02/13] soc/fsl/bman: map FBPR area in the iommu
Date: Fri, 29 Mar 2019 16:16:20 -0500
Message-ID: <CADRPPNTPZ1xhYr_YKZvrXVJhVqhV9RNAu6ekVHDeOudXTZx3=g@mail.gmail.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com> <20190329140014.8126-3-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329140014.8126-3-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Netdev <netdev@vger.kernel.org>, madalin.bucur@nxp.com, Roy Pledge <roy.pledge@nxp.com>, camelia.groza@nxp.com, David Miller <davem@davemloft.net>, Linux IOMMU <iommu@lists.linux-foundation.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 29, 2019 at 9:03 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Add a one-to-one iommu mapping for bman private data memory (FBPR).
> This is required for BMAN to work without faults behind an iommu.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/soc/fsl/qbman/bman_ccsr.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
> index 7c3cc968053c..b209c79511bb 100644
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> @@ -29,6 +29,7 @@
>   */
>
>  #include "bman_priv.h"
> +#include <linux/iommu.h>
>
>  u16 bman_ip_rev;
>  EXPORT_SYMBOL(bman_ip_rev);
> @@ -178,6 +179,7 @@ static int fsl_bman_probe(struct platform_device *pdev)
>         int ret, err_irq;
>         struct device *dev = &pdev->dev;
>         struct device_node *node = dev->of_node;
> +       struct iommu_domain *domain;
>         struct resource *res;
>         u16 id, bm_pool_cnt;
>         u8 major, minor;
> @@ -225,6 +227,15 @@ static int fsl_bman_probe(struct platform_device *pdev)
>
>         dev_dbg(dev, "Allocated FBPR 0x%llx 0x%zx\n", fbpr_a, fbpr_sz);
>
> +       /* Create an 1-to-1 iommu mapping for FBPR area */
> +       domain = iommu_get_domain_for_dev(dev);
> +       if (domain) {
> +               ret = iommu_map(domain, fbpr_a, fbpr_a, fbpr_sz,
> +                               IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
> +               if (ret)
> +                       dev_warn(dev, "failed to iommu_map() %d\n", ret);
> +       }

Like Robin has pointed out, could you explain why the mapping in this
patch and other similar patches cannot be dealt with the dma APIs
automatically?  If the current bqman driver doesn't use the dma APIs
correctly, we need to fix that instead of doing the mapping
explicitly.

> +
>         bm_set_memory(fbpr_a, fbpr_sz);
>
>         err_irq = platform_get_irq(pdev, 0);
> --
> 2.17.1
>
