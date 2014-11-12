From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 06/19] vfio/platform: return info for bound device
Date: Wed, 12 Nov 2014 11:32:28 +0100
Message-ID: <5463373C.2010202@linaro.org>
References: <1414433284-31719-1-git-send-email-a.motakis@virtualopensystems.com>
	<1414433284-31719-7-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414433284-31719-7-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
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
> A VFIO userspace driver will start by opening the VFIO device
> that corresponds to an IOMMU group, and will use the ioctl interface
> to get the basic device info, such as number of memory regions and
> interrupts, and their properties. This patch enables the
> VFIO_DEVICE_GET_INFO ioctl call.
> 
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> ---
>  drivers/vfio/platform/vfio_platform_common.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> index e0fdbc8..cb20526 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -43,10 +43,27 @@ static int vfio_platform_open(void *device_data)
>  static long vfio_platform_ioctl(void *device_data,
>  			   unsigned int cmd, unsigned long arg)
>  {
> -	if (cmd == VFIO_DEVICE_GET_INFO)
> -		return -EINVAL;
> +	struct vfio_platform_device *vdev = device_data;
> +	unsigned long minsz;
> +
> +	if (cmd == VFIO_DEVICE_GET_INFO) {
> +		struct vfio_device_info info;
> +
> +		minsz = offsetofend(struct vfio_device_info, num_irqs);
> +
> +		if (copy_from_user(&info, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (info.argsz < minsz)
> +			return -EINVAL;
> +
> +		info.flags = vdev->flags;
> +		info.num_regions = 0;
> +		info.num_irqs = 0;
Seems a bit weird to me to enable the modality but returning zeroed
values. Shouldn't we put that patch after VFIO_DEVICE_GET_REGION_INFO
and VFIO_DEVICE_GET_IRQ_INFO ones?

Best Regards

Eric
> +
> +		return copy_to_user((void __user *)arg, &info, minsz);
>  
> -	else if (cmd == VFIO_DEVICE_GET_REGION_INFO)
> +	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO)
>  		return -EINVAL;
>  
>  	else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
> 
