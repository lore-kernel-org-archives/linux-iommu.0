From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH v2] iommu/amd: Set AMD iommu callbacks for platform bus driver
Date: Tue, 14 Jun 2016 11:13:55 +0800
Message-ID: <CAKT61h_hV43NT6PKQG6hbDj6n-VHkADVz_F-88GjfQJhe_5BoA@mail.gmail.com>
References: <1462886461-3149-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462886461-3149-1-git-send-email-vincent.wan@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <vincent.wan@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, vw@iommu.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

2016-05-10 21:21 GMT+08:00 Wan Zongshun <vincent.wan@amd.com>:
> From: Wan Zongshun <Vincent.Wan@amd.com>
>
> AMD has more drivers will use ACPI to platform bus driver later,
> all those devices need iommu support, for example: eMMC driver.
>
> For latest AMD eMMC controller, it will utilize sdhci-acpi.c driver,
> which will rely on platform bus to match device and driver, where we
> will set 'dev' of struct platform_device as map_sg parameter passing
> to iommu driver for DMA request, so the iommu-ops are needed on the
> platform bus.

Joerg,

How about this patch? it will impact our new eMMC controller driver bringup.


Thanks.

>
> Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
>
> ---
> changes from v1: Add comment why the iommu-ops are needed on platform bus.
> ---
>  drivers/iommu/amd_iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index c430c10..547cdd4 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -21,6 +21,7 @@
>  #include <linux/pci.h>
>  #include <linux/acpi.h>
>  #include <linux/amba/bus.h>
> +#include <linux/platform_device.h>
>  #include <linux/pci-ats.h>
>  #include <linux/bitmap.h>
>  #include <linux/slab.h>
> @@ -2980,6 +2981,9 @@ int __init amd_iommu_init_api(void)
>         if (err)
>                 return err;
>  #endif
> +       err = bus_set_iommu(&platform_bus_type, &amd_iommu_ops);
> +       if (err)
> +               return err;
>         return 0;
>  }
>
> --
> 1.9.1
>



-- 
---
Vincent Wan(Zongshun)
www.mcuos.com
