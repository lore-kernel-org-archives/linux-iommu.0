From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Set AMD iommu callbacks for platform bus
 driver
Date: Mon, 9 May 2016 12:20:41 +0200
Message-ID: <20160509102041.GA13275@8bytes.org>
References: <1460640533-3025-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460640533-3025-1-git-send-email-vincent.wan@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <vincent.wan@amd.com>
Cc: iommu@lists.linux-foundation.org, vw@iommu.org, mcuos.com@gmail.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 14, 2016 at 09:28:53AM -0400, Wan Zongshun wrote:
> From: Wan Zongshun <Vincent.Wan@amd.com>
> 
> AMD has more drivers will use ACPI to platform bus driver later,
> all those devices need iommu support, such as eMMC acpi driver.
> 
> Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
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
>  	if (err)
>  		return err;
>  #endif
> +	err = bus_set_iommu(&platform_bus_type, &amd_iommu_ops);
> +	if (err)
> +		return err;

Is the platform_bus_type always defined or does this code needs to be
guarded by another ifdef?



	Joerg
