From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 3/7] iommu/rockchip: support virtual iommu slave device
Date: Fri, 10 Jun 2016 15:22:24 +0900
Message-ID: <CAAFQd5DuAc-B17AqOg0mGcfLCGwztEOaukPL+c5jmL4a-AEeBA@mail.gmail.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
	<1465392392-2003-4-git-send-email-zhengsq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1465392392-2003-4-git-send-email-zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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

Hi,

On Wed, Jun 8, 2016 at 10:26 PM, Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> An virtual master device like DRM need to attach to iommu
> domain to share the domain with VOP(the one with actual
> iommu slave). We currently check the group is NULL to indicate
> a virtual master, which is not true since we decide to use
> the common iommu api to attach device in DRM.
>
> With this patch, we can probe a virtual iommu device and
> allow the DRM attaching to it. The virtual iommu is needed also
> because we want convert to use DMA API for map/unmap, cache flush,
> so that DRM buffer alloc still work even VOP is disabled.

I'm not really convinced that this is a good idea. This will require
creating fake devices in the system and generally looks really hacky.
Please see my alternative proposal inline.

>
> Signed-off-by: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>  drivers/iommu/rockchip-iommu.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 3c16ec3..d6c3051 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -75,6 +75,11 @@
>
>  #define IOMMU_REG_POLL_COUNT_FAST 1000
>
> +/* A virtual iommu in device-tree registered without reg or
> + * interrupts, so the num_mmu is zero.
> + */
> +#define RK_IOMMU_IS_VIRTUAL(iommu) (iommu->num_mmu == 0)
> +
>  struct rk_iommu_domain {
>         struct list_head iommus;
>         u32 *dt; /* page directory table */
> @@ -789,13 +794,13 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>         int ret, i;
>         phys_addr_t dte_addr;
>
> -       /*
> -        * Allow 'virtual devices' (e.g., drm) to attach to domain.
> -        * Such a device does not belong to an iommu group.
> -        */
>         iommu = rk_iommu_from_dev(dev);
> -       if (!iommu)

Could we instead allocate such virtual rk_iommu struct here (dev could
be used as iommu->dev for logging purposes and a fake group could be
allocated too)?

> +
> +       iommu->domain = domain;
> +       if (RK_IOMMU_IS_VIRTUAL(iommu)) {
> +               dev_dbg(dev, "Attach virtual device to iommu domain\n");
>                 return 0;
> +       }
>
>         ret = rk_iommu_enable_stall(iommu);
>         if (ret)
> @@ -805,7 +810,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>         if (ret)
>                 return ret;
>
> -       iommu->domain = domain;
>
>         ret = devm_request_irq(iommu->dev, iommu->irq, rk_iommu_irq,
>                                IRQF_SHARED, dev_name(dev), iommu);
> @@ -842,10 +846,13 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>         unsigned long flags;
>         int i;
>
> -       /* Allow 'virtual devices' (eg drm) to detach from domain */
>         iommu = rk_iommu_from_dev(dev);
> -       if (!iommu)
> +
> +       iommu->domain = NULL;

I don't think it's a good idea to set the domain to NULL before
disabling the real IOMMU. It might still trigger an interrupt at this
point and things won't behave correctly. I guess the original line
could be left as is and simply same assignment added under the if
below.

Best regards,
Tomasz
