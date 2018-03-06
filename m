From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [RESEND PATCH v6 13/14] iommu/rockchip: Add runtime PM support
Date: Tue, 06 Mar 2018 09:57:50 +0800
Message-ID: <5A9DF59E.60900@rock-chips.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
	<20180301101837.27969-14-jeffy.chen@rock-chips.com>
	<CAAFQd5D2SY2RV9HLTeTQigfnVCkF9wDq74_+t3OV2YEb9wJtqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5D2SY2RV9HLTeTQigfnVCkF9wDq74_+t3OV2YEb9wJtqg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, open-Y9sIeH5OGRo@public.gmane.org, list-Y9sIeH5OGRo@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,

Thanks for your reply.

On 03/05/2018 09:49 PM, Tomasz Figa wrote:
>> >  struct rk_iommudata {
>> >+       struct device_link *link; /* runtime PM link from IOMMU to master */
> Kerneldoc comment for the struct could be added instead.
i saw this in the kerneldoc:

* An MMU device exists alongside a busmaster device, both are in the same
   power domain.  The MMU implements DMA address translation for the 
busmaster
   device and shall be runtime resumed and kept active whenever and as long
   as the busmaster device is active.  The busmaster device's driver shall
   not bind before the MMU is bound.  To achieve this, a device link with
   runtime PM integration is added from the busmaster device (consumer)
   to the MMU device (supplier).  The effect with regards to runtime PM
   is the same as if the MMU was the parent of the master device.


maybe we can use something like:
device link with runtime PM integration from the master (consumer) to 
the IOMMU (supplier).

>
>> >         struct rk_iommu *iommu;
>> >  };
>> >
>> >@@ -518,7 +520,12 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>> >         u32 int_status;
>> >         dma_addr_t iova;
>> >         irqreturn_t ret = IRQ_NONE;
>> >-       int i;
>> >+       int i, err, need_runtime_put;
> nit: need_runtime_put could be a bool.
ok

>
>> >+
>> >+       err = pm_runtime_get_if_in_use(iommu->dev);
>> >+       if (err <= 0 && err != -EINVAL)
>> >+               return ret;
>> >+       need_runtime_put = err > 0;
> Generally something must be really wrong if we end up with err == 0
> here, because the IOMMU must be powered on to signal an interrupt. The
> only case this could happen would be if the IRQ signal was shared with
> some device from another power domain. Is it possible on Rockchip
> SoCs? If not, perhaps we should have a WARN_ON() here for such case.
the irq could be shared between master and IOMMU, but always from the 
same power domain i think.

will add a WARN_ON()
>
>> >
>> >         WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
>> >
>> >@@ -570,6 +577,9 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>> >
>> >         clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>> >
>> >+       if (need_runtime_put)
>> >+               pm_runtime_put(iommu->dev);
>> >+
>> >         return ret;
>> >  }
>> >
>> >@@ -611,10 +621,20 @@ static void rk_iommu_zap_iova(struct rk_iommu_domain *rk_domain,
>> >         spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>> >         list_for_each(pos, &rk_domain->iommus) {
>> >                 struct rk_iommu *iommu;
>> >+               int ret;
>> >+
>> >                 iommu = list_entry(pos, struct rk_iommu, node);
>> >-               WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
>> >-               rk_iommu_zap_lines(iommu, iova, size);
>> >-               clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>> >+
>> >+               /* Only zap TLBs of IOMMUs that are powered on. */
>> >+               ret = pm_runtime_get_if_in_use(iommu->dev);
>> >+               if (ret > 0 || ret == -EINVAL) {
>> >+                       WARN_ON(clk_bulk_enable(iommu->num_clocks,
>> >+                                               iommu->clocks));
>> >+                       rk_iommu_zap_lines(iommu, iova, size);
>> >+                       clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>> >+               }
>> >+               if (ret > 0)
>> >+                       pm_runtime_put(iommu->dev);
>> >         }
>> >         spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>> >  }
>> >@@ -817,22 +837,30 @@ static struct rk_iommu *rk_iommu_from_dev(struct device *dev)
>> >         return data ? data->iommu : NULL;
>> >  }
>> >
>> >-static int rk_iommu_attach_device(struct iommu_domain *domain,
>> >-                                 struct device *dev)
>> >+/* Must be called with iommu powered on and attached */
>> >+static void rk_iommu_shutdown(struct rk_iommu *iommu)
>> >  {
>> >-       struct rk_iommu *iommu;
>> >+       int i;
>> >+
>> >+       /* Ignore error while disabling, just keep going */
>> >+       WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
>> >+       rk_iommu_enable_stall(iommu);
>> >+       rk_iommu_disable_paging(iommu);
>> >+       for (i = 0; i < iommu->num_mmu; i++) {
>> >+               rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 0);
>> >+               rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
>> >+       }
>> >+       rk_iommu_disable_stall(iommu);
>> >+       clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>> >+}
>> >+
>> >+/* Must be called with iommu powered on and attached */
>> >+static int rk_iommu_startup(struct rk_iommu *iommu)
>> >+{
>> >+       struct iommu_domain *domain = iommu->domain;
>> >         struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
>> >-       unsigned long flags;
>> >         int ret, i;
>> >
>> >-       /*
>> >-        * Allow 'virtual devices' (e.g., drm) to attach to domain.
>> >-        * Such a device does not belong to an iommu group.
>> >-        */
>> >-       iommu = rk_iommu_from_dev(dev);
>> >-       if (!iommu)
>> >-               return 0;
>> >-
>> >         ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
>> >         if (ret)
>> >                 return ret;
>> >@@ -845,8 +873,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>> >         if (ret)
>> >                 goto out_disable_stall;
>> >
>> >-       iommu->domain = domain;
>> >-
>> >         for (i = 0; i < iommu->num_mmu; i++) {
>> >                 rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
>> >                                rk_domain->dt_dma);
>> >@@ -855,14 +881,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>> >         }
>> >
>> >         ret = rk_iommu_enable_paging(iommu);
>> >-       if (ret)
>> >-               goto out_disable_stall;
>> >-
>> >-       spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>> >-       list_add_tail(&iommu->node, &rk_domain->iommus);
>> >-       spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>> >-
>> >-       dev_dbg(dev, "Attached to iommu domain\n");
>> >
>> >  out_disable_stall:
>> >         rk_iommu_disable_stall(iommu);
>> >@@ -877,31 +895,76 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>> >         struct rk_iommu *iommu;
>> >         struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
>> >         unsigned long flags;
>> >-       int i;
>> >+       int ret;
>> >
>> >         /* Allow 'virtual devices' (eg drm) to detach from domain */
>> >         iommu = rk_iommu_from_dev(dev);
>> >         if (!iommu)
>> >                 return;
>> >
>> >+       dev_dbg(dev, "Detaching from iommu domain\n");
>> >+
>> >+       /* iommu already detached */
>> >+       if (iommu->domain != domain)
>> >+               return;
>> >+
>> >+       iommu->domain = NULL;
>> >+
>> >         spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>> >         list_del_init(&iommu->node);
>> >         spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
>> >
>> >-       /* Ignore error while disabling, just keep going */
>> >-       WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks));
>> >-       rk_iommu_enable_stall(iommu);
>> >-       rk_iommu_disable_paging(iommu);
>> >-       for (i = 0; i < iommu->num_mmu; i++) {
>> >-               rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, 0);
>> >-               rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, 0);
>> >-       }
>> >-       rk_iommu_disable_stall(iommu);
>> >-       clk_bulk_disable(iommu->num_clocks, iommu->clocks);
>> >+       ret = pm_runtime_get_if_in_use(iommu->dev);
>> >+       if (ret > 0 || ret == -EINVAL)
>> >+               rk_iommu_shutdown(iommu);
>> >+       if (ret > 0)
>> >+               pm_runtime_put(iommu->dev);
>> >+}
>> >
>> >-       iommu->domain = NULL;
>> >+static int rk_iommu_attach_device(struct iommu_domain *domain,
>> >+               struct device *dev)
>> >+{
>> >+       struct rk_iommu *iommu;
>> >+       struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
>> >+       unsigned long flags;
>> >+       int ret, need_runtime_put;
> nit: need_runtime_put could be bool
ok
>
> Best regards,
> Tomasz
>
>
>
