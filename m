From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v13 13/15] vfio/type1: Check doorbell safety
Date: Thu, 6 Oct 2016 14:19:52 -0600
Message-ID: <20161006141952.375f98fd@t450s.home>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
	<1475743531-4780-14-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1475743531-4780-14-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu,  6 Oct 2016 08:45:29 +0000
Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On x86 IRQ remapping is abstracted by the IOMMU. On ARM this is abstracted
> by the msi controller.
> 
> Since we currently have no way to detect whether the MSI controller is
> upstream or downstream to the IOMMU we rely on the MSI doorbell information
> registered by the interrupt controllers. In case at least one doorbell
> does not implement proper isolation, we state the assignment is unsafe
> with regard to interrupts. This is a coase assessment but should allow to
> wait for a better system description.

s/coase/coarse/

> 
> At this point ARM sMMU still advertises IOMMU_CAP_INTR_REMAP. This is
> removed in next patch.
> 
> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> ---
> 
> v9 -> v10:
> - coarse safety assessment based on MSI doorbell info
> 
> v3 -> v4:
> - rename vfio_msi_parent_irq_remapping_capable into vfio_safe_irq_domain
>   and irq_remapping into safe_irq_domains
> 
> v2 -> v3:
> - protect vfio_msi_parent_irq_remapping_capable with
>   CONFIG_GENERIC_MSI_IRQ_DOMAIN
> ---
>  drivers/vfio/vfio_iommu_type1.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c2f8bd9..dc3ee5d 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -37,6 +37,7 @@
>  #include <linux/vfio.h>
>  #include <linux/workqueue.h>
>  #include <linux/dma-iommu.h>
> +#include <linux/msi-doorbell.h>
>  
>  #define DRIVER_VERSION  "0.2"
>  #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>"
> @@ -921,8 +922,13 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	INIT_LIST_HEAD(&domain->group_list);
>  	list_add(&group->next, &domain->group_list);
>  
> +	/*
> +	 * to advertise safe interrupts either the IOMMU or the MSI controllers
> +	 * must support IRQ remapping (aka. interrupt translation)
> +	 */
>  	if (!allow_unsafe_interrupts &&
> -	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
> +	    (!iommu_capable(bus, IOMMU_CAP_INTR_REMAP) &&
> +		!msi_doorbell_safe())) {

I assume this is why you want msi_doorbell_safe() to return true when
!CONFIG_MSI_DOORBELL but don't we really want to look at the iommu
geometry to see if MSI mapping is supported and then, once we know the
iommu is participating in MSI mapping, whether it's safe?

>  		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
>  		       __func__);
>  		ret = -EPERM;
