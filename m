From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v7 13/14] iommu/rockchip: Add runtime PM support
Date: Tue, 6 Mar 2018 19:07:30 +0900
Message-ID: <CAAFQd5DPewKda7ThqMGKRvnArZ0X8ChD10E06nLZaNa-SBNdwA@mail.gmail.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
	<20180306032759.29069-1-jeffy.chen@rock-chips.com>
	<20180306032759.29069-4-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180306032759.29069-4-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jeffy,

It looks like I missed some details of how runtime PM enable works
before, so we might be able to simplify things. Sorry for not getting
things right earlier.

On Tue, Mar 6, 2018 at 12:27 PM, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> When the power domain is powered off, the IOMMU cannot be accessed and
> register programming must be deferred until the power domain becomes
> enabled.
>
> Add runtime PM support, and use runtime PM device link from IOMMU to
> master to startup and shutdown IOMMU.
>
> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>
> Changes in v7:
> Add WARN_ON in irq isr, and modify iommu archdata comment.
>
> Changes in v6: None
> Changes in v5:
> Avoid race about pm_runtime_get_if_in_use() and pm_runtime_enabled().
>
> Changes in v4: None
> Changes in v3:
> Only call startup() and shutdown() when iommu attached.
> Remove pm_mutex.
> Check runtime PM disabled.
> Check pm_runtime in rk_iommu_irq().
>
> Changes in v2: None
>
>  drivers/iommu/rockchip-iommu.c | 189 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 148 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 2448a0528e39..db08978203f7 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_iommu.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>
> @@ -105,7 +106,14 @@ struct rk_iommu {
>         struct iommu_domain *domain; /* domain to which iommu is attached */
>  };
>
> +/**
> + * struct rk_iommudata - iommu archdata of master device.
> + * @link:      device link with runtime PM integration from the master
> + *             (consumer) to the IOMMU (supplier).
> + * @iommu:     IOMMU of the master device.
> + */
>  struct rk_iommudata {
> +       struct device_link *link;
>         struct rk_iommu *iommu;
>  };
>
> @@ -518,7 +526,13 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>         u32 int_status;
>         dma_addr_t iova;
>         irqreturn_t ret = IRQ_NONE;
> -       int i;
> +       bool need_runtime_put;
> +       int i, err;
> +
> +       err = pm_runtime_get_if_in_use(iommu->dev);
> +       if (WARN_ON(err <= 0 && err != -EINVAL))
> +               return ret;
> +       need_runtime_put = err > 0;

Actually, for our purposes, we can assume that runtime PM enable
status can be only changed by the driver itself. Looking at the LXR,
PM core also calls __pm_runtime_disable() before calling
.suspend_late() callback and pm_runtime_enable() after calling
.resume_early() callback, but we should be able to ignore this,
because we handle things in .suspend() callback in this driver.

With this assumption in mind, all we need to do here is:

if (WARN_ON(!pm_runtime_get_if_in_use(iommu->dev)))
    return 0;

>
>         WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
>
> @@ -570,6 +584,9 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>
>         clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>
> +       if (need_runtime_put)
> +               pm_runtime_put(iommu->dev);

if (pm_runtime_enabled())
        pm_runtime_put(iommu->dev);

> +
>         return ret;
>  }
>
> @@ -611,10 +628,20 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
>         spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>         list_for_each(pos, &rk_domain->iommus) {
>                 struct rk_iommu *iommu;
> +               int ret;
> +
>                 iommu = list_entry(pos, struct rk_iommu, node);
> -               WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
> -               rk_iommu_zap_lines(iommu, iova, size);
> -               clk_bulk_disable(iommu->num_clocks, iommu->clocks);
> +
> +               /* Only zap TLBs of IOMMUs that are powered on. */
> +               ret = pm_runtime_get_if_in_use(iommu->dev);
> +               if (ret > 0 || ret == -EINVAL) {

if (pm_runtime_get_if_in_use(iommu->dev)) {

> +                       WARN_ON(clk_bulk_enable(iommu->num_clocks,
> +                                               iommu->clocks));
> +                       rk_iommu_zap_lines(iommu, iova, size);
> +                       clk_bulk_disable(iommu->num_clocks, iommu->clocks);

        if (pm_runtime_enabled(iommu->dev))
                pm_runtime_put(iommu->dev);

And so on, in other places.

Really sorry for the confusion before.

Best regards,
Tomasz
