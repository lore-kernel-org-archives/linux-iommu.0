From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/7] Return info for device and its memory regions and
	interrupts
Date: Mon, 30 Sep 2013 11:39:36 -0600
Message-ID: <1380562776.2674.177.camel@ul30vt.home>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-4-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380554923-17818-4-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
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
> A VFIO userspace driver will start by opening the VFIO device
> that corresponds to an IOMMU group, and will use the ioctl interface
> to get the basic device info, such as number of memory regions and
> interrupts, and their properties.
> 
> This patch implements the IOCTLs:
>  - VFIO_DEVICE_GET_INFO
>  - VFIO_DEVICE_GET_REGION_INFO
>  - VFIO_DEVICE_GET_IRQ_INFO
> 
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> ---
>  drivers/vfio/vfio_platform.c | 60 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_platform.c b/drivers/vfio/vfio_platform.c
> index b9686b0..a0abcfa 100644
> --- a/drivers/vfio/vfio_platform.c
> +++ b/drivers/vfio/vfio_platform.c
> @@ -28,6 +28,10 @@
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  #include <linux/vfio.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
>  
>  #define DRIVER_VERSION  "0.1"
>  #define DRIVER_AUTHOR   "Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>"
> @@ -54,10 +58,13 @@ static long vfio_platform_ioctl(void *device_data,
>  			   unsigned int cmd, unsigned long arg)
>  {
>  	struct vfio_platform_device *vdev = device_data;
> +	struct device_node *of_node = vdev->pdev->dev.of_node;
>  	unsigned long minsz;
>  
>  	if (cmd == VFIO_DEVICE_GET_INFO) {
>  		struct vfio_device_info info;
> +		struct resource res;
> +		int cnt = 0;
>  
>  		minsz = offsetofend(struct vfio_device_info, num_irqs);
>  
> @@ -68,18 +75,57 @@ static long vfio_platform_ioctl(void *device_data,
>  			return -EINVAL;
>  
>  		info.flags = VFIO_DEVICE_FLAGS_PLATFORM;
> -		info.num_regions = 0;
> -		info.num_irqs = 0;
> +
> +		while (!of_address_to_resource(of_node, cnt, &res))
> +			cnt++;
> +
> +		info.num_regions = cnt;
> +
> +		info.num_irqs = of_irq_count(of_node);
>  
>  		return copy_to_user((void __user *)arg, &info, minsz);
>  
> -	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO)
> -		return -EINVAL;
> +	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
> +		struct vfio_region_info info;
> +		struct resource res;
>  
> -	else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
> -		return -EINVAL;
> +		minsz = offsetofend(struct vfio_region_info, offset);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz)
> +			return -EINVAL;
> +
> +		if(of_address_to_resource(of_node, info.index, &res))
> +			return -EINVAL;
> +
> +		info.offset = res.start;	/* map phys addr with offset */
> +		info.size = resource_size(&res);
> +		info.flags = 0;
> +
> +		return copy_to_user((void __user *)arg, &info, minsz);
> +
> +	} else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
> +		struct vfio_irq_info info;
> +		struct resource res;
> +
> +		minsz = offsetofend(struct vfio_irq_info, count);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz)
> +			return -EINVAL;
> +
> +		of_irq_to_resource(of_node, info.index, &res);
> +
> +		info.flags = 0;
> +		info.count = 1;
> +
> +		return copy_to_user((void __user *)arg, &info, minsz);
>  
> -	else if (cmd == VFIO_DEVICE_SET_IRQS)
> +	} else if (cmd == VFIO_DEVICE_SET_IRQS)
>  		return -EINVAL;
>  
>  	else if (cmd == VFIO_DEVICE_RESET)

I notice all the open firmware calls here and I'm curious, will all
platform devices be making use of open firmware?  I don't know if this
is synonymous with device tree or not.  Thanks,

Alex 
