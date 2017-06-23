From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Suppress IO_PAGE_FAULTs in kdump kernel
Date: Fri, 23 Jun 2017 16:57:19 +0800
Message-ID: <20170623085719.GD20618@x1>
References: <1497600901-8993-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1497600901-8993-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi dear Joerg,

On 06/16/17 at 10:15am, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> When booting into a kdump kernel, suppress IO_PAGE_FAULTs by
> default for all devices. But allow the faults again when a
> domain is assigned to a device.

I have two bugs at hand reported by customer, saying their system hang
with amd iommu on. I remember I borrowed the system and found it hang very
early so that no one knew what's happened. One time it printed several lines
of boot message and I found it's amd iommu system, adding amd_iommu=off
to make the system boot normally.

And with the kdump fix of amd iommu patchset applied, kdump kernel boots
well. So maybe suppressing the fault message is not enough.

Thanks
Baoquan

> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c       | 3 ++-
>  drivers/iommu/amd_iommu_init.c  | 9 +++++++++
>  drivers/iommu/amd_iommu_types.h | 1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 80efa72..623ab53 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2050,7 +2050,8 @@ static void set_dte_entry(u16 devid, struct protection_domain *domain, bool ats)
>  		flags    |= tmp;
>  	}
>  
> -	flags &= ~(0xffffUL);
> +
> +	flags &= ~(DTE_FLAG_SA | 0xffffULL);
>  	flags |= domain->id;
>  
>  	amd_iommu_dev_table[devid].data[1]  = flags;
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 5a11328..d9f5ddd 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -29,6 +29,7 @@
>  #include <linux/export.h>
>  #include <linux/iommu.h>
>  #include <linux/kmemleak.h>
> +#include <linux/crash_dump.h>
>  #include <asm/pci-direct.h>
>  #include <asm/iommu.h>
>  #include <asm/gart.h>
> @@ -1898,6 +1899,14 @@ static void init_device_table_dma(void)
>  	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
>  		set_dev_entry_bit(devid, DEV_ENTRY_VALID);
>  		set_dev_entry_bit(devid, DEV_ENTRY_TRANSLATION);
> +		/*
> +		 * In kdump kernels in-flight DMA from the old kernel might
> +		 * cause IO_PAGE_FAULTs. There are no reports that a kdump
> +		 * actually failed because of that, so just disable fault
> +		 * reporting in the hardware to get rid of the messages
> +		 */
> +		if (is_kdump_kernel())
> +			set_dev_entry_bit(devid, DEV_ENTRY_NO_PAGE_FAULT);
>  	}
>  }
>  
> diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
> index 4de8f41..4cad9b3 100644
> --- a/drivers/iommu/amd_iommu_types.h
> +++ b/drivers/iommu/amd_iommu_types.h
> @@ -322,6 +322,7 @@
>  #define IOMMU_PTE_IW (1ULL << 62)
>  
>  #define DTE_FLAG_IOTLB	(1ULL << 32)
> +#define DTE_FLAG_SA	(1ULL << 34)
>  #define DTE_FLAG_GV	(1ULL << 55)
>  #define DTE_FLAG_MASK	(0x3ffULL << 32)
>  #define DTE_GLX_SHIFT	(56)
> -- 
> 2.7.4
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
