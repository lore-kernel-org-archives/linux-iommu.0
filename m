From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 01/19] vfio/platform: initial skeleton of VFIO support
	for platform devices
Date: Wed, 12 Nov 2014 11:05:18 +0100
Message-ID: <546330DE.5010002@linaro.org>
References: <1414433284-31719-1-git-send-email-a.motakis@virtualopensystems.com>
	<1414433284-31719-2-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414433284-31719-2-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
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

Hi Antonios,

On 10/27/2014 07:07 PM, Antonios Motakis wrote:
> This patch forms the common skeleton code for platform devices support
> with VFIO. This will include the core functionality of VFIO_PLATFORM,
> however binding to the device and discovering the device resources will
> be done with the help of a separate file where any Linux platform bus
> specific code will reside.
> 
> This will allow us to implement support for also discovering AMBA devices
> and their resources, but still reuse a large part of the VFIO_PLATFORM
> implementation.
> 
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> ---
>  drivers/vfio/platform/vfio_platform_common.c  | 126 ++++++++++++++++++++++++++
>  drivers/vfio/platform/vfio_platform_private.h |  36 ++++++++
>  2 files changed, 162 insertions(+)
>  create mode 100644 drivers/vfio/platform/vfio_platform_common.c
>  create mode 100644 drivers/vfio/platform/vfio_platform_private.h
> 
> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
> new file mode 100644
> index 0000000..e0fdbc8
> --- /dev/null
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -0,0 +1,126 @@
> +/*
> + * Copyright (C) 2013 - Virtual Open Systems
> + * Author: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/iommu.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +#include <linux/vfio.h>
> +#include <linux/io.h>
not sure at that state all the above includes are needed.
> +
> +#include "vfio_platform_private.h"
> +
> +static void vfio_platform_release(void *device_data)
> +{
> +	module_put(THIS_MODULE);
> +}
> +
> +static int vfio_platform_open(void *device_data)
> +{
> +	if (!try_module_get(THIS_MODULE))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static long vfio_platform_ioctl(void *device_data,
> +			   unsigned int cmd, unsigned long arg)
a minor style comment/question that applies on all the series. Shouldn't
subsequent argument lines rather be aligned with the first char after
"(", as done in PCI code?
> +{
> +	if (cmd == VFIO_DEVICE_GET_INFO)
> +		return -EINVAL;
> +
> +	else if (cmd == VFIO_DEVICE_GET_REGION_INFO)
> +		return -EINVAL;
> +
> +	else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
> +		return -EINVAL;
> +
> +	else if (cmd == VFIO_DEVICE_SET_IRQS)
> +		return -EINVAL;
> +
> +	else if (cmd == VFIO_DEVICE_RESET)
> +		return -EINVAL;
> +
> +	return -ENOTTY;
> +}
> +
> +static ssize_t vfio_platform_read(void *device_data, char __user *buf,
> +				  size_t count, loff_t *ppos)
> +{
> +	return -EINVAL;
> +}
> +
> +static ssize_t vfio_platform_write(void *device_data, const char __user *buf,
> +				   size_t count, loff_t *ppos)
> +{
> +	return -EINVAL;
> +}
> +
> +static int vfio_platform_mmap(void *device_data, struct vm_area_struct *vma)
> +{
> +	return -EINVAL;
> +}
> +
> +static const struct vfio_device_ops vfio_platform_ops = {
> +	.name		= "vfio-platform",
> +	.open		= vfio_platform_open,
> +	.release	= vfio_platform_release,
> +	.ioctl		= vfio_platform_ioctl,
> +	.read		= vfio_platform_read,
> +	.write		= vfio_platform_write,
> +	.mmap		= vfio_platform_mmap,
> +};
> +
> +int vfio_platform_probe_common(struct vfio_platform_device *vdev,
> +			       struct device *dev)
> +{
> +	struct iommu_group *group;
> +	int ret;
> +
> +	if (!vdev)
> +		return -EINVAL;
> +
> +	group = iommu_group_get(dev);
> +	if (!group) {
> +		pr_err("VFIO: No IOMMU group for device %s\n", vdev->name);
> +		return -EINVAL;
> +	}
I saw the above check also is done at beginning of vfio_add_group_dev.
Added value however is pr_err which is useful and PCI code does the
check too.

Eric
> +
> +	ret = vfio_add_group_dev(dev, &vfio_platform_ops, vdev);
> +	if (ret) {
> +		iommu_group_put(group);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(vfio_platform_probe_common);
> +
> +struct vfio_platform_device *vfio_platform_remove_common(struct device *dev)
> +{
> +	struct vfio_platform_device *vdev;
> +
> +	vdev = vfio_del_group_dev(dev);
> +	if (vdev)
> +		iommu_group_put(dev->iommu_group);
> +
> +	return vdev;
> +}
> +EXPORT_SYMBOL_GPL(vfio_platform_remove_common);
> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
> new file mode 100644
> index 0000000..062b92d
> --- /dev/null
> +++ b/drivers/vfio/platform/vfio_platform_private.h
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright (C) 2013 - Virtual Open Systems
> + * Author: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef VFIO_PLATFORM_PRIVATE_H
> +#define VFIO_PLATFORM_PRIVATE_H
> +
> +struct vfio_platform_device {
> +	/*
> +	 * These fields should be filled by the bus specific binder
> +	 */
> +	void		*opaque;
> +	const char	*name;
> +	uint32_t	flags;
> +	/* callbacks to discover device resources */
> +	struct resource*
> +		(*get_resource)(struct vfio_platform_device *vdev, int i);
> +	int	(*get_irq)(struct vfio_platform_device *vdev, int i);
> +};
> +
> +extern int vfio_platform_probe_common(struct vfio_platform_device *vdev,
> +				      struct device *dev);
> +extern struct vfio_platform_device *vfio_platform_remove_common
> +				     (struct device *dev);
> +
> +#endif /* VFIO_PLATFORM_PRIVATE_H */
> 
