From: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v8 9/9] vfio/type1: Handle different mdev isolation type
Date: Tue, 26 Mar 2019 15:03:26 +0530
Message-ID: <82f373a8-27f0-d217-d87a-aa309acdbc29@nvidia.com>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
 <20190325013036.18400-10-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325013036.18400-10-baolu.lu@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: "ashok.raj@intel.com" <ashok.raj@intel.com>, "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>, "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "yi.y.sun@intel.com" <yi.y.sun@intel.com>, "peterx@redhat.com" <peterx@redhat.com>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Neo Jia <cjia@nvidia.com>
List-Id: iommu@lists.linux-foundation.org



On 3/25/2019 7:00 AM, Lu Baolu wrote:
> This adds the support to determine the isolation type
> of a mediated device group by checking whether it has
> an iommu device. If an iommu device exists, an iommu
> domain will be allocated and then attached to the iommu
> device. Otherwise, keep the same behavior as it is.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Reviewed-by: Kirti Wankhede <kwankhede@nvidia.com>

Thanks,
Kirti


> ---
>  drivers/vfio/vfio_iommu_type1.c | 55 +++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index ccc4165474aa..b91cafcd5181 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -559,7 +559,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>  	mutex_lock(&iommu->lock);
>  
>  	/* Fail if notifier list is empty */
> -	if ((!iommu->external_domain) || (!iommu->notifier.head)) {
> +	if (!iommu->notifier.head) {
>  		ret = -EINVAL;
>  		goto pin_done;
>  	}
> @@ -641,11 +641,6 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
>  
>  	mutex_lock(&iommu->lock);
>  
> -	if (!iommu->external_domain) {
> -		mutex_unlock(&iommu->lock);
> -		return -EINVAL;
> -	}
> -
>  	do_accounting = !IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu);
>  	for (i = 0; i < npage; i++) {
>  		struct vfio_dma *dma;
> @@ -1368,13 +1363,40 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
>  		iommu_detach_group(domain->domain, group->iommu_group);
>  }
>  
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
> @@ -1409,23 +1431,30 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
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
> 
