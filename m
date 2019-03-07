From: Neo Jia <cjia-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 9/9] vfio/type1: Handle different mdev isolation type
Date: Thu, 7 Mar 2019 00:44:54 -0800
Message-ID: <20190307084453.GA9288@nvidia.com>
References: <20190222021927.13132-1-baolu.lu@linux.intel.com>
	<20190222021927.13132-10-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190222021927.13132-10-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 22, 2019 at 10:19:27AM +0800, Lu Baolu wrote:
> This adds the support to determine the isolation type
> of a mediated device group by checking whether it has
> an iommu device. If an iommu device exists, an iommu
> domain will be allocated and then attached to the iommu
> device. Otherwise, keep the same behavior as it is.
> 
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 48 ++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index ccc4165474aa..f1392c582a3c 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1368,13 +1368,40 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
>  		iommu_detach_group(domain->domain, group->iommu_group);
>  }
>  

Hi Baolu,

To allow IOMMU-awared mdev, I think you need to modify the
vfio_iommu_type1_pin_pages and vfio_iommu_type1_unpin_pages to remove the
iommu->external_domain check.

Could you please include that in your patch? If not, I can send out a separate
patch to address that issue.

Thanks,
Neo

> +static bool vfio_bus_is_mdev(struct bus_type *bus)
> +{
> +	struct bus_type *mdev_bus;
> +	bool ret = false;
> +
> +	mdev_bus = symbol_get(mdev_bus_type);
> +	if (mdev_bus) {
> +		ret = (bus == mdev_bus);
> +		symbol_put(mdev_bus_type);
> +	}
> +
> +	return ret;
> +}
> +
> +static int vfio_mdev_iommu_device(struct device *dev, void *data)
> +{
> +	struct device **old = data, *new;
> +
> +	new = vfio_mdev_get_iommu_device(dev);
> +	if (!new || (*old && *old != new))
> +		return -EINVAL;
> +
> +	*old = new;
> +
> +	return 0;
> +}
> +
>  static int vfio_iommu_type1_attach_group(void *iommu_data,
>  					 struct iommu_group *iommu_group)
>  {
>  	struct vfio_iommu *iommu = iommu_data;
>  	struct vfio_group *group;
>  	struct vfio_domain *domain, *d;
> -	struct bus_type *bus = NULL, *mdev_bus;
> +	struct bus_type *bus = NULL;
>  	int ret;
>  	bool resv_msi, msi_remap;
>  	phys_addr_t resv_msi_base;
> @@ -1409,23 +1436,30 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	if (ret)
>  		goto out_free;
>  
> -	mdev_bus = symbol_get(mdev_bus_type);
> +	if (vfio_bus_is_mdev(bus)) {
> +		struct device *iommu_device = NULL;
>  
> -	if (mdev_bus) {
> -		if ((bus == mdev_bus) && !iommu_present(bus)) {
> -			symbol_put(mdev_bus_type);
> +		group->mdev_group = true;
> +
> +		/* Determine the isolation type */
> +		ret = iommu_group_for_each_dev(iommu_group, &iommu_device,
> +					       vfio_mdev_iommu_device);
> +		if (ret || !iommu_device) {
>  			if (!iommu->external_domain) {
>  				INIT_LIST_HEAD(&domain->group_list);
>  				iommu->external_domain = domain;
> -			} else
> +			} else {
>  				kfree(domain);
> +			}
>  
>  			list_add(&group->next,
>  				 &iommu->external_domain->group_list);
>  			mutex_unlock(&iommu->lock);
> +
>  			return 0;
>  		}
> -		symbol_put(mdev_bus_type);
> +
> +		bus = iommu_device->bus;
>  	}
>  
>  	domain->domain = iommu_domain_alloc(bus);
> -- 
> 2.17.1
> 
