From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v4 12/13] iommu/rockchip: Add runtime PM support
Date: Fri, 19 Jan 2018 13:01:33 +0900
Message-ID: <CAAFQd5A71m5jFD8NaXWyi3g7ssg=nETRhtn2wYp8p_6qJcWu4w@mail.gmail.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
	<20180118115251.5542-13-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180118115251.5542-13-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 18, 2018 at 8:52 PM, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
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
> Changes in v4: None
> Changes in v3:
> Only call startup() and shutdown() when iommu attached.
> Remove pm_mutex.
> Check runtime PM disabled.
> Check pm_runtime in rk_iommu_irq().
>
> Changes in v2: None
>
>  drivers/iommu/rockchip-iommu.c | 180 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 141 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 2c095f96c033..e2e7acc3039d 100644
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
> @@ -99,6 +100,7 @@ struct rk_iommu {
>  };
>
>  struct rk_iommudata {
> +       struct device_link *link; /* runtime PM link from IOMMU to master */
>         struct rk_iommu *iommu;
>  };
>
> @@ -583,7 +585,11 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>         u32 int_status;
>         dma_addr_t iova;
>         irqreturn_t ret = IRQ_NONE;
> -       int i;
> +       int i, err;
> +
> +       err = pm_runtime_get_if_in_use(iommu->dev);
> +       if (err <= 0 && err != -EINVAL)
> +               return ret;
>
>         WARN_ON(rk_iommu_enable_clocks(iommu));
>
> @@ -635,6 +641,9 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>
>         rk_iommu_disable_clocks(iommu);
>
> +       if (pm_runtime_enabled(iommu->dev))
> +               pm_runtime_put(iommu->dev);

I think this might be racy. There are some places where
pm_runtime_enable/disable() are called on devices implicitly and I'm
not sure if we're guaranteed that they don't happen between our
pm_runtime_get_if_in_use() and pm_runtime_enabled() calls.

An example of a race-free solution would be to save the
pm_runtime_get_if_in_use() result to a local variable (e.g. bool
need_runtime_put) and then call pm_runtime_put() based on that.

> +
>         return ret;
>  }
>
> @@ -676,10 +685,20 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
>         spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>         list_for_each(pos, &rk_domain->iommus) {
>                 struct rk_iommu *iommu;
> +               int ret;
> +
>                 iommu = list_entry(pos, struct rk_iommu, node);
> -               rk_iommu_enable_clocks(iommu);
> -               rk_iommu_zap_lines(iommu, iova, size);
> -               rk_iommu_disable_clocks(iommu);
> +
> +               /* Only zap TLBs of IOMMUs that are powered on. */
> +               ret = pm_runtime_get_if_in_use(iommu->dev);
> +               if (ret > 0 || ret == -EINVAL) {
> +                       rk_iommu_enable_clocks(iommu);
> +                       rk_iommu_zap_lines(iommu, iova, size);
> +                       rk_iommu_disable_clocks(iommu);
> +               }
> +
> +               if (ret > 0)
> +                       pm_runtime_put(iommu->dev);

This one nicely avoids the race I mentioned above. :)

>         }
>         spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>  }
> @@ -882,22 +901,30 @@ static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
>         return data ? data->iommu : NULL;
>  }
>
[snip]
> +       spin_lock_irqsave(&rk_domain->iommus_lock, flags);
> +       list_add_tail(&iommu->node, &rk_domain->iommus);
> +       spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>
> -       dev_dbg(dev, "Detached from iommu domain\n");
> +       ret = pm_runtime_get_if_in_use(iommu->dev);
> +       if (ret <= 0 && ret != -EINVAL)
> +               return 0;
> +
> +       ret = rk_iommu_startup(iommu);
> +       if (ret)
> +               rk_iommu_detach_device(iommu->domain, dev);
> +
> +       if (pm_runtime_enabled(iommu->dev))
> +               pm_runtime_put(iommu->dev);

Here we should also probably act based on what
pm_runtime_get_if_in_use() returned rather than asking
pm_runtime_enabled().

Best regards,
Tomasz
