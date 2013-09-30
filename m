From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/7] VFIO_IOMMU_TYPE1 workaround to build for platform
	devices
Date: Mon, 30 Sep 2013 11:39:42 -0600
Message-ID: <1380562782.2674.178.camel@ul30vt.home>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-2-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380554923-17818-2-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2013-09-30 at 17:28 +0200, Antonios Motakis wrote:
> This is a workaround to make the VFIO_IOMMU_TYPE1 driver usable with
> platform devices instead of PCI. A future permanent fix should support
> both. This is required in order to use the Exynos SMMU, or ARM SMMU
> driver with VFIO.
> 
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> ---
>  drivers/vfio/Kconfig            |  2 +-
>  drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++++++++++----
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index 7cd5dec..1f84eda 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -6,7 +6,7 @@ config VFIO_IOMMU_TYPE1
>  menuconfig VFIO
>  	tristate "VFIO Non-Privileged userspace driver framework"
>  	depends on IOMMU_API
> -	select VFIO_IOMMU_TYPE1 if X86
> +	select VFIO_IOMMU_TYPE1 if X86 || ARM
>  	help
>  	  VFIO provides a framework for secure userspace device drivers.
>  	  See Documentation/vfio.txt for more details.
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 6f3fbc4..d7e6a12 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -30,7 +30,8 @@
>  #include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
> -#include <linux/pci.h>		/* pci_bus_type */
> +#include <linux/pci.h>			/* pci_bus_type */
> +#include <linux/platform_device.h>	/* platform_bus_type */
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> @@ -46,6 +47,8 @@ module_param_named(allow_unsafe_interrupts,
>  		   allow_unsafe_interrupts, bool, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(allow_unsafe_interrupts,
>  		 "Enable VFIO IOMMU support for on platforms without interrupt remapping support.");
> +static struct bus_type *iommu_bus_type = NULL;
> +static bool require_cap_intr_remap = false;
>  
>  struct vfio_iommu {
>  	struct iommu_domain	*domain;
> @@ -612,7 +615,8 @@ static void *vfio_iommu_type1_open(unsigned long arg)
>  	/*
>  	 * Wish we didn't have to know about bus_type here.
>  	 */
> -	iommu->domain = iommu_domain_alloc(&pci_bus_type);
> +	iommu->domain = iommu_domain_alloc(iommu_bus_type);
> +
>  	if (!iommu->domain) {
>  		kfree(iommu);
>  		return ERR_PTR(-EIO);
> @@ -624,7 +628,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
>  	 * the way.  Fortunately we know interrupt remapping is global for
>  	 * our iommus.
>  	 */
> -	if (!allow_unsafe_interrupts &&
> +	if (require_cap_intr_remap && !allow_unsafe_interrupts &&
>  	    !iommu_domain_has_cap(iommu->domain, IOMMU_CAP_INTR_REMAP)) {
>  		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
>  		       __func__);
> @@ -733,7 +737,17 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
>  
>  static int __init vfio_iommu_type1_init(void)
>  {
> -	if (!iommu_present(&pci_bus_type))
> +#ifdef CONFIG_PCI
> +	if (iommu_present(&pci_bus_type)) {
> +		iommu_bus_type = &pci_bus_type;
> +		/* For PCI targets, IOMMU_CAP_INTR_REMAP is required */
> +		require_cap_intr_remap = true;
> +	}
> +#endif
> +	if (!iommu_bus_type && iommu_present(&platform_bus_type))
> +		iommu_bus_type = &platform_bus_type;
> +
> +	if(!iommu_bus_type)
>  		return -ENODEV;
>  
>  	return vfio_register_iommu_driver(&vfio_iommu_driver_ops_type1);

Is it possible to have a system with both PCI and platform devices?  How
would you support that?  Thanks,

Alex
