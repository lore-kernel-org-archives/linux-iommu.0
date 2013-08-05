From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] Initial skeleton of VFIO support for Device Tree
	based devices
Date: Mon, 05 Aug 2013 08:57:20 -0600
Message-ID: <1375714640.31262.364.camel@ul30vt.home>
References: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
	<1375708632-26356-3-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1375708632-26356-3-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
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
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2013-08-05 at 15:17 +0200, Antonios Motakis wrote:
> Platform devices in the Linux kernel are usually managed by the DT
> interface. This patch forms the base to support these kind of devices
> with VFIO.
> 
> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> ---
>  drivers/vfio/Kconfig      |  10 +++
>  drivers/vfio/Makefile     |   1 +
>  drivers/vfio/vfio_dt.c    | 187 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h |   1 +
>  4 files changed, 199 insertions(+)
>  create mode 100644 drivers/vfio/vfio_dt.c
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index 1f84eda..a77a2e4 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -13,4 +13,14 @@ menuconfig VFIO
>  
>  	  If you don't know what to do here, say N.
>  
> +config VFIO_DT
> +	tristate "VFIO support for Device Tree devices"
> +	depends on VFIO && EVENTFD

I think there needs to be another depends item here, this would allow
configuration even on architectures that have no concept of device tree.
Also, do we want to put this in a subdirectory like we've done for pci?
The rest looks like a reasonable start.  Thanks,

Alex

> +	help
> +	  Support for the VFIO Device Tree driver.  This is required to make
> +	  use of platform devices present on Device Tree nodes using the VFIO
> +	  framework.
> +
> +	  If you don't know what to do here, say N.
> +
>  source "drivers/vfio/pci/Kconfig"
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> index 2398d4a..d599a67 100644
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_VFIO) += vfio.o
>  obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
>  obj-$(CONFIG_VFIO_PCI) += pci/
> +obj-$(CONFIG_VFIO_DT) += vfio_dt.o
> diff --git a/drivers/vfio/vfio_dt.c b/drivers/vfio/vfio_dt.c
> new file mode 100644
> index 0000000..ad4d31d
> --- /dev/null
> +++ b/drivers/vfio/vfio_dt.c
> @@ -0,0 +1,187 @@
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/eventfd.h>
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
> +
> +#define DRIVER_VERSION  "0.1"
> +#define DRIVER_AUTHOR   "Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>"
> +#define DRIVER_DESC     "VFIO Device Tree devices - User Level meta-driver"
> +
> +struct vfio_dt_device {
> +	struct platform_device	*pdev;
> +};
> +
> +static void vfio_dt_release(void *device_data)
> +{
> +	module_put(THIS_MODULE);
> +}
> +
> +static int vfio_dt_open(void *device_data)
> +{
> +	if (!try_module_get(THIS_MODULE))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static long vfio_dt_ioctl(void *device_data,
> +			   unsigned int cmd, unsigned long arg)
> +{
> +	struct vfio_dt_device *vdev = device_data;
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
> +		info.flags = VFIO_DEVICE_FLAGS_DT;
> +		info.num_regions = 0;
> +		info.num_irqs = 0;
> +
> +		return copy_to_user((void __user *)arg, &info, minsz);
> +
> +	} else if (cmd == VFIO_DEVICE_GET_REGION_INFO)
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
> +static ssize_t vfio_dt_read(void *device_data, char __user *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	return 0;
> +}
> +
> +static ssize_t vfio_dt_write(void *device_data, const char __user *buf,
> +			      size_t count, loff_t *ppos)
> +{
> +	return 0;
> +}
> +
> +static int vfio_dt_mmap(void *device_data, struct vm_area_struct *vma)
> +{
> +	return -EINVAL;
> +}
> +
> +static const struct vfio_device_ops vfio_dt_ops = {
> +	.name		= "vfio-dts",
> +	.open		= vfio_dt_open,
> +	.release	= vfio_dt_release,
> +	.ioctl		= vfio_dt_ioctl,
> +	.read		= vfio_dt_read,
> +	.write		= vfio_dt_write,
> +	.mmap		= vfio_dt_mmap,
> +};
> +
> +static int vfio_dt_probe(struct platform_device *pdev)
> +{
> +	struct vfio_dt_device *vdev;
> +	struct iommu_group *group;
> +	int ret;
> +
> +	group = iommu_group_get(&pdev->dev);
> +	if (!group) {
> +		pr_err("VFIO: No IOMMU group for device %s\n", pdev->name);
> +		return -EINVAL;
> +	}
> +
> +	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
> +	if (!vdev) {
> +		iommu_group_put(group);
> +		return -ENOMEM;
> +	}
> +
> +	vdev->pdev = pdev;
> +
> +	ret = vfio_add_group_dev(&pdev->dev, &vfio_dt_ops, vdev);
> +	if (ret) {
> +		iommu_group_put(group);
> +		kfree(vdev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int vfio_dt_remove(struct platform_device *pdev)
> +{
> +	struct vfio_dt_device *vdev;
> +
> +	vdev = vfio_del_group_dev(&pdev->dev);
> +	if (!vdev)
> +		return -EINVAL;
> +
> +	iommu_group_put(pdev->dev.iommu_group);
> +	kfree(vdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id vfio_dt_match[] = {
> +	/* In the future, we can implement a better mechanism to bind the
> +	 * module to any device. For now add the compatible property to the
> +	 * dtb of the devices we want to use.	*/
> +	{
> +		.compatible = "vfio-dt",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, vfio_dt_match);
> +
> +static struct platform_driver vfio_dt_driver = {
> +	.probe		= vfio_dt_probe,
> +	.remove		= vfio_dt_remove,
> +	.driver	= {
> +		.name	= "vfio-dt",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = vfio_dt_match,
> +	},
> +};
> +
> +module_platform_driver(vfio_dt_driver);
> +
> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 284ff24..1e4bef2 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -147,6 +147,7 @@ struct vfio_device_info {
>  	__u32	flags;
>  #define VFIO_DEVICE_FLAGS_RESET	(1 << 0)	/* Device supports reset */
>  #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
> +#define VFIO_DEVICE_FLAGS_DT	(1 << 2)	/* vfio-dt device */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  };
