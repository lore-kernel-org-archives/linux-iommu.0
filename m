From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 16/18] vfio/type1: Allow transparent MSI IOVA allocation
Date: Fri, 13 Jan 2017 16:04:56 -0700
Message-ID: <20170113160456.61a744d8@t450s.home>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
	<1484127714-3263-17-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484127714-3263-17-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

On Wed, 11 Jan 2017 09:41:52 +0000
Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> When attaching a group to the container, check the group's
> reserved regions and test whether the IOMMU translates MSI
> transactions. If yes, we initialize an IOVA allocator through
> the iommu_get_msi_cookie API. This will allow the MSI IOVAs
> to be transparently allocated on MSI controller's compose().
> 
> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


Acked-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


> ---
> 
> v3 -> v4:
> - test region's type: IOMMU_RESV_MSI
> - restructure the code to prepare for safety assessment
> - reword title
> ---
>  drivers/vfio/vfio_iommu_type1.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 9266271..5651faf 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -39,6 +39,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/mdev.h>
>  #include <linux/notifier.h>
> +#include <linux/dma-iommu.h>
>  
>  #define DRIVER_VERSION  "0.2"
>  #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>"
> @@ -1181,6 +1182,28 @@ static struct vfio_group *find_iommu_group(struct vfio_domain *domain,
>  	return NULL;
>  }
>  
> +static bool vfio_iommu_has_resv_msi(struct iommu_group *group,
> +				    phys_addr_t *base)
> +{
> +	struct list_head group_resv_regions;
> +	struct iommu_resv_region *region, *next;
> +	bool ret = false;
> +
> +	INIT_LIST_HEAD(&group_resv_regions);
> +	iommu_get_group_resv_regions(group, &group_resv_regions);
> +	list_for_each_entry(region, &group_resv_regions, list) {
> +		if (region->type & IOMMU_RESV_MSI) {
> +			*base = region->start;
> +			ret = true;
> +			goto out;
> +		}
> +	}
> +out:
> +	list_for_each_entry_safe(region, next, &group_resv_regions, list)
> +		kfree(region);
> +	return ret;
> +}
> +
>  static int vfio_iommu_type1_attach_group(void *iommu_data,
>  					 struct iommu_group *iommu_group)
>  {
> @@ -1189,6 +1212,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	struct vfio_domain *domain, *d;
>  	struct bus_type *bus = NULL, *mdev_bus;
>  	int ret;
> +	bool resv_msi;
> +	phys_addr_t resv_msi_base;
>  
>  	mutex_lock(&iommu->lock);
>  
> @@ -1258,6 +1283,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	if (ret)
>  		goto out_domain;
>  
> +	resv_msi = vfio_iommu_has_resv_msi(iommu_group, &resv_msi_base);
> +
>  	INIT_LIST_HEAD(&domain->group_list);
>  	list_add(&group->next, &domain->group_list);
>  
> @@ -1304,6 +1331,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	if (ret)
>  		goto out_detach;
>  
> +	if (resv_msi && iommu_get_msi_cookie(domain->domain, resv_msi_base))
> +		goto out_detach;
> +
>  	list_add(&domain->next, &iommu->domain_list);
>  
>  	mutex_unlock(&iommu->lock);
