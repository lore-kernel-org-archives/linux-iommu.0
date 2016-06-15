From: Tomasz Figa via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v3 5/6] iommu/rockchip: use DMA API to map, to flush cache
Date: Wed, 15 Jun 2016 23:31:49 +0900
Message-ID: <CAAFQd5AuHgJ=P3ZWcrOUyB_8Z_xAX23F26a-6+S6aMWF0KpCwQ@mail.gmail.com>
References: <1465992285-16187-1-git-send-email-zhengsq@rock-chips.com>
	<1465992285-16187-6-git-send-email-zhengsq@rock-chips.com>
Reply-To: Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1465992285-16187-6-git-send-email-zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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
> Use DMA API instead of architecture internal functions like
> __cpuc_flush_dcache_area() etc.
>
> To support the virtual device like DRM the virtual slave iommu
> added in the previous patch, attaching to which the DRM can use
> it own domain->dev for dma_map_*(), dma_sync_*() even VOP is disabled.
>
> With this patch, this driver is available for ARM64 like RK3399.
>
> Signed-off-by: Shunqian Zheng <zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>  drivers/iommu/rockchip-iommu.c | 113 +++++++++++++++++++++++++++--------------
>  1 file changed, 76 insertions(+), 37 deletions(-)

In general looks good to me, but still have some concern about
attaching and detaching. Please see inline.

> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 82ecc99..b60b29e 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
[snip]
> @@ -886,6 +901,22 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>                         return -ENOMEM;
>         }
>
> +       /* Set the domain dev to virtual one if exist */
> +       if (rk_iommu_is_virtual(iommu) || !rk_domain->dev)

Does it matter if the iommu is virtual or not? This condition will
always evaluate to true on first attach anyway, so there might be
times when rk_domain->dev points to a real device.

> +               rk_domain->dev = iommu->dev;
> +
[snip]
>  static void rk_iommu_detach_device(struct iommu_domain *domain,
> @@ -987,8 +1023,6 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>         if (!rk_domain->dt)
>                 goto err_dt;
>
> -       rk_table_flush(rk_domain->dt, NUM_DT_ENTRIES);
> -
>         spin_lock_init(&rk_domain->iommus_lock);
>         spin_lock_init(&rk_domain->dt_lock);
>         INIT_LIST_HEAD(&rk_domain->iommus);
> @@ -1012,10 +1046,15 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
>                 if (rk_dte_is_pt_valid(dte)) {
>                         phys_addr_t pt_phys = rk_dte_pt_address(dte);
>                         u32 *page_table = phys_to_virt(pt_phys);
> +                       dma_unmap_single(rk_domain->dev, pt_phys,
> +                                        SPAGE_SIZE, DMA_TO_DEVICE);
>                         free_page((unsigned long)page_table);
>                 }
>         }
>
> +       if (!rk_domain->dt_dma)
> +               dma_unmap_single(rk_domain->dev, rk_domain->dt_dma,
> +                                SPAGE_SIZE, DMA_TO_DEVICE);
>         free_page((unsigned long)rk_domain->dt);
>
>         iommu_put_dma_cookie(&rk_domain->domain);

If we detach here a device whose IOMMU is currently pointed by
rk_domain->dev, then the pointer will not point to anything valid
anymore. To be honest, I don't see any good solution for this. Maybe
we should keep all the IOMMUs in a list and set the ->dev pointer to
any from the list here?

Best regards,
Tomasz
