From: Tomasz Figa via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v3 4/6] drm: rockchip: use common iommu api to attach iommu
Date: Wed, 15 Jun 2016 23:24:21 +0900
Message-ID: <CAAFQd5Ds=KC26i5k1Fpe78n8S40Q+PdNpn9hp8QQLgJhgnag7A@mail.gmail.com>
References: <1465992285-16187-1-git-send-email-zhengsq@rock-chips.com>
	<1465992285-16187-5-git-send-email-zhengsq@rock-chips.com>
Reply-To: Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1465992285-16187-5-git-send-email-zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, simon xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, =?UTF-8?B?5aea5pm65oOF?= <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Shunqian,

On Wed, Jun 15, 2016 at 9:04 PM, Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> Rockchip DRM used the arm special API, arm_iommu_*(), to attach
> iommu for ARM32 SoCs. This patch convert to common iommu API
> so it would support ARM64 like RK3399.
>
> The general idea is domain_alloc(), attach_device() and
> arch_setup_dma_ops() to set dma_ops manually for DRM at the last.
>
> Signed-off-by: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 112 +++++++++++++++++-----------
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   1 +
>  2 files changed, 71 insertions(+), 42 deletions(-)

Please see my comment inline.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index f5a68fc..b52c38d 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -14,16 +14,16 @@
>   * GNU General Public License for more details.
>   */
>
> -#include <asm/dma-iommu.h>
> -
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_fb_helper.h>
> +#include <linux/dma-iommu.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/module.h>
>  #include <linux/of_graph.h>
>  #include <linux/component.h>
> +#include <linux/iommu.h>
>
>  #include "rockchip_drm_drv.h"
>  #include "rockchip_drm_fb.h"
> @@ -46,7 +46,8 @@ static bool is_support_iommu = true;
>  int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
>                                    struct device *dev)
>  {
> -       struct dma_iommu_mapping *mapping = drm_dev->dev->archdata.mapping;
> +       struct rockchip_drm_private *private = drm_dev->dev_private;
> +       struct iommu_domain *domain = private->domain;
>         int ret;
>
>         if (!is_support_iommu)
> @@ -58,16 +59,25 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
>
>         dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
>
> -       return arm_iommu_attach_device(dev, mapping);
> +       ret = iommu_attach_device(domain, dev);
> +       if (ret) {
> +               dev_err(dev, "Failed to attach iommu device\n");
> +               return ret;
> +       }
> +
> +       /* TODO(djkurtz): fetch the mapping start/size from somewhere */
> +       arch_setup_dma_ops(dev, 0x00000000, SZ_2G, dev->bus->iommu_ops, false);
> +       return 0;
>  }
>
>  void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
>                                     struct device *dev)
>  {
> -       if (!is_support_iommu)
> -               return;
> +       struct rockchip_drm_private *private = drm_dev->dev_private;
> +       struct iommu_domain *domain = private->domain;
>
> -       arm_iommu_detach_device(dev);
> +       if (is_support_iommu)
> +               iommu_detach_device(domain, dev);
>  }
>
>  int rockchip_register_crtc_funcs(struct drm_crtc *crtc,
> @@ -132,10 +142,52 @@ static void rockchip_drm_crtc_disable_vblank(struct drm_device *dev,
>                 priv->crtc_funcs[pipe]->disable_vblank(crtc);
>  }
>
> +static int rockchip_drm_init_iommu(struct drm_device *drm_dev)
> +{
> +       struct rockchip_drm_private *private = drm_dev->dev_private;
> +       struct device *dev = drm_dev->dev;
> +       int ret;
> +
> +       dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
> +                                     GFP_KERNEL);
> +       if (!dev->dma_parms)
> +               return -ENOMEM;
> +
> +       private->domain = iommu_domain_alloc(&platform_bus_type);
> +       if (!private->domain)
> +               return -ENOMEM;
> +
> +       /* TODO(djkurtz): fetch the mapping start/size from somewhere */
> +       ret = iommu_dma_init_domain(private->domain, 0x00000000, SZ_2G);
> +       if (ret) {
> +               dev_err(dev, "Failed to init domain\n");
> +               goto err_free_domain;
> +       }
> +
> +       ret = rockchip_drm_dma_attach_device(drm_dev, dev);
> +       if (ret) {
> +               dev_err(dev, "Failed to attach device\n");
> +               goto err_free_domain;
> +       }
> +
> +       return 0;
> +
> +err_free_domain:
> +       iommu_domain_free(private->domain);
> +
> +       return ret;
> +}
> +
> +static void rockchip_iommu_cleanup(struct drm_device *drm_dev)
> +{
> +       struct rockchip_drm_private *private = drm_dev->dev_private;
> +

No need to call rockchip_drm_dma_detach_device() here?

> +       iommu_domain_free(private->domain);
> +}

Otherwise looks good, so after addressing the above, feel free to add
my Reviewed-by.

Best regards,
Tomasz
