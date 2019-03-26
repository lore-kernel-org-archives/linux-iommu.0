From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 8/9] vfio/type1: Add domain at(de)taching group helpers
Date: Tue, 26 Mar 2019 11:42:33 -0600
Message-ID: <20190326114233.2ec4334a@x1.home>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
	<20190325013036.18400-9-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190325013036.18400-9-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 25 Mar 2019 09:30:35 +0800
Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> This adds helpers to attach or detach a domain to a
> group. This will replace iommu_attach_group() which
> only works for non-mdev devices.
> 
> If a domain is attaching to a group which includes the
> mediated devices, it should attach to the iommu device
> (a pci device which represents the mdev in iommu scope)
> instead. The added helper supports attaching domain to
> groups for both pci and mdev devices.
> 
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 84 ++++++++++++++++++++++++++++++---
>  1 file changed, 77 insertions(+), 7 deletions(-)


Acked-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 73652e21efec..ccc4165474aa 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -91,6 +91,7 @@ struct vfio_dma {
>  struct vfio_group {
>  	struct iommu_group	*iommu_group;
>  	struct list_head	next;
> +	bool			mdev_group;	/* An mdev group */
>  };
>  
>  /*
> @@ -1298,6 +1299,75 @@ static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
>  	return ret;
>  }
>  
> +static struct device *vfio_mdev_get_iommu_device(struct device *dev)
> +{
> +	struct device *(*fn)(struct device *dev);
> +	struct device *iommu_device;
> +
> +	fn = symbol_get(mdev_get_iommu_device);
> +	if (fn) {
> +		iommu_device = fn(dev);
> +		symbol_put(mdev_get_iommu_device);
> +
> +		return iommu_device;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int vfio_mdev_attach_domain(struct device *dev, void *data)
> +{
> +	struct iommu_domain *domain = data;
> +	struct device *iommu_device;
> +
> +	iommu_device = vfio_mdev_get_iommu_device(dev);
> +	if (iommu_device) {
> +		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
> +			return iommu_aux_attach_device(domain, iommu_device);
> +		else
> +			return iommu_attach_device(domain, iommu_device);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int vfio_mdev_detach_domain(struct device *dev, void *data)
> +{
> +	struct iommu_domain *domain = data;
> +	struct device *iommu_device;
> +
> +	iommu_device = vfio_mdev_get_iommu_device(dev);
> +	if (iommu_device) {
> +		if (iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
> +			iommu_aux_detach_device(domain, iommu_device);
> +		else
> +			iommu_detach_device(domain, iommu_device);
> +	}
> +
> +	return 0;
> +}
> +
> +static int vfio_iommu_attach_group(struct vfio_domain *domain,
> +				   struct vfio_group *group)
> +{
> +	if (group->mdev_group)
> +		return iommu_group_for_each_dev(group->iommu_group,
> +						domain->domain,
> +						vfio_mdev_attach_domain);
> +	else
> +		return iommu_attach_group(domain->domain, group->iommu_group);
> +}
> +
> +static void vfio_iommu_detach_group(struct vfio_domain *domain,
> +				    struct vfio_group *group)
> +{
> +	if (group->mdev_group)
> +		iommu_group_for_each_dev(group->iommu_group, domain->domain,
> +					 vfio_mdev_detach_domain);
> +	else
> +		iommu_detach_group(domain->domain, group->iommu_group);
> +}
> +
>  static int vfio_iommu_type1_attach_group(void *iommu_data,
>  					 struct iommu_group *iommu_group)
>  {
> @@ -1373,7 +1443,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  			goto out_domain;
>  	}
>  
> -	ret = iommu_attach_group(domain->domain, iommu_group);
> +	ret = vfio_iommu_attach_group(domain, group);
>  	if (ret)
>  		goto out_domain;
>  
> @@ -1405,8 +1475,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	list_for_each_entry(d, &iommu->domain_list, next) {
>  		if (d->domain->ops == domain->domain->ops &&
>  		    d->prot == domain->prot) {
> -			iommu_detach_group(domain->domain, iommu_group);
> -			if (!iommu_attach_group(d->domain, iommu_group)) {
> +			vfio_iommu_detach_group(domain, group);
> +			if (!vfio_iommu_attach_group(d, group)) {
>  				list_add(&group->next, &d->group_list);
>  				iommu_domain_free(domain->domain);
>  				kfree(domain);
> @@ -1414,7 +1484,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  				return 0;
>  			}
>  
> -			ret = iommu_attach_group(domain->domain, iommu_group);
> +			ret = vfio_iommu_attach_group(domain, group);
>  			if (ret)
>  				goto out_domain;
>  		}
> @@ -1440,7 +1510,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	return 0;
>  
>  out_detach:
> -	iommu_detach_group(domain->domain, iommu_group);
> +	vfio_iommu_detach_group(domain, group);
>  out_domain:
>  	iommu_domain_free(domain->domain);
>  out_free:
> @@ -1531,7 +1601,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  		if (!group)
>  			continue;
>  
> -		iommu_detach_group(domain->domain, iommu_group);
> +		vfio_iommu_detach_group(domain, group);
>  		list_del(&group->next);
>  		kfree(group);
>  		/*
> @@ -1596,7 +1666,7 @@ static void vfio_release_domain(struct vfio_domain *domain, bool external)
>  	list_for_each_entry_safe(group, group_tmp,
>  				 &domain->group_list, next) {
>  		if (!external)
> -			iommu_detach_group(domain->domain, group->iommu_group);
> +			vfio_iommu_detach_group(domain, group);
>  		list_del(&group->next);
>  		kfree(group);
>  	}
