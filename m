From: Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: set AMD iommu-callbacks for the amba bus
Date: Tue, 19 Jan 2016 09:49:08 +0800
Message-ID: <CAKT61h8AWzChE7eqiYwDMYPSoHM9HM2EvpWiD0kjkKtR+1-TRQ@mail.gmail.com>
References: <1451408093-2802-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1451408093-2802-1-git-send-email-vincent.wan-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, vw-6ukY98dZOFrYtjvyW6yDsg@public.gmane.org
Cc: Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ken.xue-5C7GfCeVMHo@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

2015-12-30 0:54 GMT+08:00 Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>:
> From: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
>
> Since uart dma is using AMD iommu, and it bases on amba bus.
> So we need set callbacks for amba bus type firstly.
>
> Signed-off-by: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>

Joerg,
How about this patch?
It is a separating patch to our acpihid device support patches.

> ---
>  drivers/iommu/amd_iommu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 8b2be1e..9097b11 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -35,6 +35,7 @@
>  #include <linux/msi.h>
>  #include <linux/dma-contiguous.h>
>  #include <linux/irqdomain.h>
> +#include <linux/amba/bus.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/io_apic.h>
>  #include <asm/apic.h>
> @@ -2758,7 +2759,17 @@ static struct dma_map_ops amd_iommu_dma_ops = {
>
>  int __init amd_iommu_init_api(void)
>  {
> -       return bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
> +       int err = 0;
> +
> +       err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
> +       if (err)
> +               return err;
> +#ifdef CONFIG_ARM_AMBA
> +       err = bus_set_iommu(&amba_bustype, &amd_iommu_ops);
> +       if (err)
> +               return err;
> +#endif
> +       return 0;
>  }
>
>  int __init amd_iommu_init_dma_ops(void)
> --
> 1.9.1
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



-- 
---
Vincent Wan(Zongshun)
www.mcuos.com
