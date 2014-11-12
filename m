From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 07/19] vfio/platform: return info for device memory
	mapped IO regions
Date: Wed, 12 Nov 2014 11:58:35 +0100
Message-ID: <54633D5B.4040204@linaro.org>
References: <1414433284-31719-1-git-send-email-a.motakis@virtualopensystems.com>
	<1414433284-31719-8-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414433284-31719-8-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: VFIO DRIVER <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/27/2014 07:07 PM, Antonios Motakis wrote:
> This patch enables the IOCTLs VFIO_DEVICE_GET_REGION_INFO ioctl call,
> which allows the user to learn about the available MMIO resources of
> a device.
> 
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> ---
>  drivers/vfio/platform/vfio_platform_common.c  | 110 +++++++++++++++++++++++++-
>  drivers/vfio/platform/vfio_platform_private.h |  22 ++++++
>  2 files changed, 128 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index cb20526..82de752 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -27,17 +27,97 @@
>  
>  #include "vfio_platform_private.h"
>  
> +static DEFINE_MUTEX(driver_lock);
> +
> +static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
> +{
> +	int cnt = 0, i;
> +
> +	while (vdev->get_resource(vdev, cnt))
> +		cnt++;
> +
> +	vdev->regions = kcalloc(cnt, sizeof(struct vfio_platform_region),
> +				GFP_KERNEL);
> +	if (!vdev->regions)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < cnt;  i++) {
> +		struct resource *res =
> +			vdev->get_resource(vdev, i);
> +
> +		if (!res)
> +			goto err;
> +
> +		vdev->regions[i].addr = res->start;
> +		vdev->regions[i].size = resource_size(res);
> +		vdev->regions[i].flags = 0;
> +
> +		switch (resource_type(res)) {
> +		case IORESOURCE_MEM:
> +			vdev->regions[i].type = VFIO_PLATFORM_REGION_TYPE_MMIO;
> +			break;
> +		case IORESOURCE_IO:
> +			vdev->regions[i].type = VFIO_PLATFORM_REGION_TYPE_PIO;
> +			break;
> +		default:
> +			goto err;
> +		}
> +	}
> +
> +	vdev->num_regions = cnt;
> +
> +	return 0;
> +err:
Isn't it safer to reset vdev->num_regions here?
I think in a next patch you will iounmap the num_regions in
vfio_platform_regions_cleanup.
-- Eric
> +	kfree(vdev->regions);
> +	return -EINVAL;
> +}
> +
> +static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
> +{
> +	vdev->num_regions = 0;
> +	kfree(vdev->regions);
> +}
> +
>  static void vfio_platform_release(void *device_data)
>  {
> +	struct vfio_platform_device *vdev = device_data;
> +
> +	mutex_lock(&driver_lock);
> +
> +	if (!(--vdev->refcnt)) {
> +		vfio_platform_regions_cleanup(vdev);
> +	}
> +
> +	mutex_unlock(&driver_lock);
> +
>  	module_put(THIS_MODULE);
>  }
>  
>  static int vfio_platform_open(void *device_data)
>  {
> +	struct vfio_platform_device *vdev = device_data;
> +	int ret;
> +
>  	if (!try_module_get(THIS_MODULE))
>  		return -ENODEV;
>  
> +	mutex_lock(&driver_lock);
> +
> +	if (!vdev->refcnt) {
> +		ret = vfio_platform_regions_init(vdev);
> +		if (ret)
> +			goto err_reg;
> +	}
> +
> +	vdev->refcnt++;
> +
> +	mutex_unlock(&driver_lock);
>  	return 0;
> +
> +err_reg:
> +	mutex_unlock(&driver_lock);
> +	module_put(THIS_MODULE);
> +	return ret;
>  }
>  
>  static long vfio_platform_ioctl(void *device_data,
> @@ -58,15 +138,33 @@ static long vfio_platform_ioctl(void *device_data,
>  			return -EINVAL;
>  
>  		info.flags = vdev->flags;
> -		info.num_regions = 0;
> +		info.num_regions = vdev->num_regions;
>  		info.num_irqs = 0;
>  
>  		return copy_to_user((void __user *)arg, &info, minsz);
>  
> -	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO)
> -		return -EINVAL;
> +	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
> +		struct vfio_region_info info;
> +
> +		minsz = offsetofend(struct vfio_region_info, offset);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
>  
> -	else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
> +		if (info.argsz < minsz)
> +			return -EINVAL;
> +
> +		if (info.index >= vdev->num_regions)
> +			return -EINVAL;
> +
> +		/* map offset to the physical address  */
> +		info.offset = VFIO_PLATFORM_INDEX_TO_OFFSET(info.index);
> +		info.size = vdev->regions[info.index].size;
> +		info.flags = vdev->regions[info.index].flags;
> +
> +		return copy_to_user((void __user *)arg, &info, minsz);
> +
> +	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
>  		return -EINVAL;
>  
>  	else if (cmd == VFIO_DEVICE_SET_IRQS)
> @@ -134,10 +232,14 @@ struct vfio_platform_device *vfio_platform_remove_common(struct device *dev)
>  {
>  	struct vfio_platform_device *vdev;
>  
> +	mutex_lock(&driver_lock);
> +
>  	vdev = vfio_del_group_dev(dev);
>  	if (vdev)
>  		iommu_group_put(dev->iommu_group);
>  
> +	mutex_unlock(&driver_lock);
> +
>  	return vdev;
>  }
>  EXPORT_SYMBOL_GPL(vfio_platform_remove_common);
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> index 062b92d..b24729f 100644
> --- a/drivers/vfio/platform/vfio_platform_private.h
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -15,7 +15,29 @@
>  #ifndef VFIO_PLATFORM_PRIVATE_H
>  #define VFIO_PLATFORM_PRIVATE_H
>  
> +#define VFIO_PLATFORM_OFFSET_SHIFT   40
> +#define VFIO_PLATFORM_OFFSET_MASK (((u64)(1) << VFIO_PLATFORM_OFFSET_SHIFT) - 1)
> +
> +#define VFIO_PLATFORM_OFFSET_TO_INDEX(off)	\
> +	(off >> VFIO_PLATFORM_OFFSET_SHIFT)
> +
> +#define VFIO_PLATFORM_INDEX_TO_OFFSET(index)	\
> +	((u64)(index) << VFIO_PLATFORM_OFFSET_SHIFT)
> +
> +struct vfio_platform_region {
> +	u64			addr;
> +	resource_size_t		size;
> +	u32			flags;
> +	u32			type;
> +#define VFIO_PLATFORM_REGION_TYPE_MMIO	1
> +#define VFIO_PLATFORM_REGION_TYPE_PIO	2
> +};
> +
>  struct vfio_platform_device {
> +	struct vfio_platform_region	*regions;
> +	u32				num_regions;
> +	int				refcnt;
> +
>  	/*
>  	 * These fields should be filled by the bus specific binder
>  	 */
> 
