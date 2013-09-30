From: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: RE: [PATCH 2/7] Initial skeleton of VFIO support for Device Tree
 based	devices
Date: Mon, 30 Sep 2013 15:37:02 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0718A4AC@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
 <1380554923-17818-3-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1380554923-17818-3-git-send-email-a.motakis@virtualopensystems.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>, Yoder Stuart-B08248 <B08248@freescale.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "tech@virtualopensystems.com" <tech@virtualopensystems.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Antonios Motakis
> Sent: Monday, September 30, 2013 8:59 PM
> To: kvmarm@lists.cs.columbia.edu; alex.williamson@redhat.com
> Cc: linux-samsung-soc@vger.kernel.org; kvm@vger.kernel.org; agraf@suse.de; Yoder
> Stuart-B08248; iommu@lists.linux-foundation.org; Antonios Motakis;
> tech@virtualopensystems.com
> Subject: [PATCH 2/7] Initial skeleton of VFIO support for Device Tree based
> devices
> 
> Platform devices in the Linux kernel are usually managed by the DT interface.
> This patch forms the base to support these kind of devices with VFIO.
> 
> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> ---
>  drivers/vfio/Kconfig         |  11 +++
>  drivers/vfio/Makefile        |   1 +
>  drivers/vfio/vfio_platform.c | 187 +++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h    |   1 +
>  4 files changed, 200 insertions(+)
>  create mode 100644 drivers/vfio/vfio_platform.c
> 
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig index 1f84eda..35254b7
> 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -13,4 +13,15 @@ menuconfig VFIO
> 
>  	  If you don't know what to do here, say N.
> 
> +config VFIO_PLATFORM
> +	tristate "VFIO support for device tree based platform devices"
> +	depends on VFIO && EVENTFD && OF
> +	help
> +	  Support for platform devices with VFIO. This is required to make
> +	  use of platform devices present on device tree nodes using the VFIO
> +	  framework. Devices that are not described in the device tree cannot
> +	  be used by this driver.
> +
> +	  If you don't know what to do here, say N.
> +
>  source "drivers/vfio/pci/Kconfig"
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile index
> 2398d4a..575c8dd 100644
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_VFIO) += vfio.o
>  obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
>  obj-$(CONFIG_VFIO_PCI) += pci/
> +obj-$(CONFIG_VFIO_PLATFORM) += vfio_platform.o
> diff --git a/drivers/vfio/vfio_platform.c b/drivers/vfio/vfio_platform.c new

We can make this parallel to PCI, something like drivers/vfio/platform/platform.c

-Bharat

> file mode 100644 index 0000000..b9686b0
> --- /dev/null
> +++ b/drivers/vfio/vfio_platform.c
> @@ -0,0 +1,187 @@
> +/*
> + * Copyright (C) 2013 - Virtual Open Systems
> + * Author: Antonios Motakis <a.motakis@virtualopensystems.com>
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
> +#define DRIVER_AUTHOR   "Antonios Motakis <a.motakis@virtualopensystems.com>"
> +#define DRIVER_DESC     "VFIO Device Tree devices - User Level meta-driver"
> +
> +struct vfio_platform_device {
> +	struct platform_device	*pdev;
> +};
> +
> +static void vfio_platform_release(void *device_data) {
> +	module_put(THIS_MODULE);
> +}
> +
> +static int vfio_platform_open(void *device_data) {
> +	if (!try_module_get(THIS_MODULE))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static long vfio_platform_ioctl(void *device_data,
> +			   unsigned int cmd, unsigned long arg) {
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
> +		info.flags = VFIO_DEVICE_FLAGS_PLATFORM;
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
> +static ssize_t vfio_platform_read(void *device_data, char __user *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	return 0;
> +}
> +
> +static ssize_t vfio_platform_write(void *device_data, const char __user *buf,
> +			      size_t count, loff_t *ppos)
> +{
> +	return 0;
> +}
> +
> +static int vfio_platform_mmap(void *device_data, struct vm_area_struct
> +*vma) {
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
> +static int vfio_platform_probe(struct platform_device *pdev) {
> +	struct vfio_platform_device *vdev;
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
> +	ret = vfio_add_group_dev(&pdev->dev, &vfio_platform_ops, vdev);
> +	if (ret) {
> +		iommu_group_put(group);
> +		kfree(vdev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int vfio_platform_remove(struct platform_device *pdev) {
> +	struct vfio_platform_device *vdev;
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
> +static const struct of_device_id vfio_platform_match[] = {
> +	/* Before this series can be applied, we shall implement a better
> +	 * mechanism to bind the module to any device. For now add the
> +	 * compatible property to the dtb of the devices we want to use. */
> +	{
> +		.compatible = "vfio",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, vfio_platform_match);
> +
> +static struct platform_driver vfio_platform_driver = {
> +	.probe		= vfio_platform_probe,
> +	.remove		= vfio_platform_remove,
> +	.driver	= {
> +		.name	= "vfio-platform",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = vfio_platform_match,
> +	},
> +};
> +
> +module_platform_driver(vfio_platform_driver);
> +
> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h index
> 284ff24..8d7434d 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -147,6 +147,7 @@ struct vfio_device_info {
>  	__u32	flags;
>  #define VFIO_DEVICE_FLAGS_RESET	(1 << 0)	/* Device supports reset */
>  #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
> +#define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  };
> --
> 1.8.1.2
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu


