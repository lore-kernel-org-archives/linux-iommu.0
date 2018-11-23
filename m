From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 8/8] vfio/type1: Handle different mdev isolation type
Date: Fri, 23 Nov 2018 15:23:21 +0100
Message-ID: <e9822321-fca3-29bc-f5a1-c6297d2161ae@redhat.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
	<20181105073408.21815-9-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181105073408.21815-9-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Lu,

On 11/5/18 8:34 AM, Lu Baolu wrote:
> This adds the support to determine the isolation type
> of a mediated device group by checking whether it has
> an iommu device. If an iommu device exists, an iommu
> domain will be allocated and then attached to the iommu
> device. Otherwise, keep the same behavior as it is.
> 
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 48 ++++++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 178264b330e7..eed26129f58c 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1427,13 +1427,40 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
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
> +	if (*old && *old != new)
if !new can't you return -EINVAL as well?
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
> @@ -1468,11 +1495,18 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
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
> +		if (ret)
> +			goto out_free;
> +
> +		if (!iommu_device) {
>  			if (!iommu->external_domain) {
>  				INIT_LIST_HEAD(&domain->group_list);
>  				iommu->external_domain = domain;
> @@ -1482,9 +1516,11 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  			list_add(&group->next,
>  				 &iommu->external_domain->group_list);
>  			mutex_unlock(&iommu->lock);
> +
extra new line
>  			return 0;
>  		}
> -		symbol_put(mdev_bus_type);
> +
> +		bus = iommu_device->bus;
>  	}
>  
>  	domain->domain = iommu_domain_alloc(bus);
> 
Thanks

Eric
