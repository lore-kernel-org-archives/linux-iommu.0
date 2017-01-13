From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 17/18] vfio/type1: Check MSI remapping at irq domain
	level
Date: Fri, 13 Jan 2017 16:04:59 -0700
Message-ID: <20170113160459.3d186d48@t450s.home>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
	<1484127714-3263-18-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484127714-3263-18-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 11 Jan 2017 09:41:53 +0000
Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> In case the IOMMU translates MSI transactions (typical case
> on ARM), we check MSI remapping capability at IRQ domain
> level. Otherwise it is checked at IOMMU level.
> 
> At this stage the arm-smmu-(v3) still advertise the
> IOMMU_CAP_INTR_REMAP capability at IOMMU level. This will be
> removed in subsequent patches.
> 
> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


Acked-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

 
> ---
> 
> v6: rewrite test
> ---
>  drivers/vfio/vfio_iommu_type1.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 5651faf..ec903a0 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -40,6 +40,7 @@
>  #include <linux/mdev.h>
>  #include <linux/notifier.h>
>  #include <linux/dma-iommu.h>
> +#include <linux/irqdomain.h>
>  
>  #define DRIVER_VERSION  "0.2"
>  #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>"
> @@ -1212,7 +1213,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	struct vfio_domain *domain, *d;
>  	struct bus_type *bus = NULL, *mdev_bus;
>  	int ret;
> -	bool resv_msi;
> +	bool resv_msi, msi_remap;
>  	phys_addr_t resv_msi_base;
>  
>  	mutex_lock(&iommu->lock);
> @@ -1288,8 +1289,10 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	INIT_LIST_HEAD(&domain->group_list);
>  	list_add(&group->next, &domain->group_list);
>  
> -	if (!allow_unsafe_interrupts &&
> -	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
> +	msi_remap = resv_msi ? irq_domain_check_msi_remap() :
> +				iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
> +
> +	if (!allow_unsafe_interrupts && !msi_remap) {
>  		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
>  		       __func__);
>  		ret = -EPERM;
