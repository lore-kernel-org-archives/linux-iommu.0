From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH 2/7] Initial skeleton of VFIO support for Device Tree
	based devices
Date: Tue, 1 Oct 2013 11:36:43 +0200
Message-ID: <CAG8rG2wrG5ZtnxiGTzeNkhdiFVFfVRJ7K1zChcR8K-mFbLyKAw@mail.gmail.com>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-3-git-send-email-a.motakis@virtualopensystems.com>
	<1380570100.2674.207.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380570100.2674.207.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, KVM devel mailing list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 30, 2013 at 9:41 PM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
> On Mon, 2013-09-30 at 17:28 +0200, Antonios Motakis wrote:
> > Platform devices in the Linux kernel are usually managed by the DT
> > interface. This patch forms the base to support these kind of devices
> > with VFIO.
> >
> > Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> > ---
> >  drivers/vfio/Kconfig         |  11 +++
> >  drivers/vfio/Makefile        |   1 +
> >  drivers/vfio/vfio_platform.c | 187 +++++++++++++++++++++++++++++++++++++++++++
>
> I agree with Bharat, I'd probably make a platform sub-directory.  Like
> pci, you'll probably have several support files by the end and it seems
> like platform devices may need device specific handling in places, which
> would also be cleaner to have in the directory.
>
> >  include/uapi/linux/vfio.h    |   1 +
> >  4 files changed, 200 insertions(+)
> >  create mode 100644 drivers/vfio/vfio_platform.c
> >
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > index 1f84eda..35254b7 100644
> > --- a/drivers/vfio/Kconfig
> > +++ b/drivers/vfio/Kconfig
> > @@ -13,4 +13,15 @@ menuconfig VFIO
> >
> >         If you don't know what to do here, say N.
> >
> > +config VFIO_PLATFORM
> > +     tristate "VFIO support for device tree based platform devices"
> > +     depends on VFIO && EVENTFD && OF
> > +     help
> > +       Support for platform devices with VFIO. This is required to make
> > +       use of platform devices present on device tree nodes using the VFIO
> > +       framework. Devices that are not described in the device tree cannot
> > +       be used by this driver.
> > +
> > +       If you don't know what to do here, say N.
> > +
> >  source "drivers/vfio/pci/Kconfig"
> > diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> > index 2398d4a..575c8dd 100644
> > --- a/drivers/vfio/Makefile
> > +++ b/drivers/vfio/Makefile
> > @@ -1,3 +1,4 @@
> >  obj-$(CONFIG_VFIO) += vfio.o
> >  obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
> >  obj-$(CONFIG_VFIO_PCI) += pci/
> > +obj-$(CONFIG_VFIO_PLATFORM) += vfio_platform.o
> > diff --git a/drivers/vfio/vfio_platform.c b/drivers/vfio/vfio_platform.c
> > new file mode 100644
> > index 0000000..b9686b0
> > --- /dev/null
> > +++ b/drivers/vfio/vfio_platform.c
> > @@ -0,0 +1,187 @@
> > +/*
> > + * Copyright (C) 2013 - Virtual Open Systems
> > + * Author: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License, version 2, as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/eventfd.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iommu.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/notifier.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/vfio.h>
> > +
> > +#define DRIVER_VERSION  "0.1"
> > +#define DRIVER_AUTHOR   "Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>"
> > +#define DRIVER_DESC     "VFIO Device Tree devices - User Level meta-driver"
> > +
> > +struct vfio_platform_device {
> > +     struct platform_device  *pdev;
> > +};
> > +
> > +static void vfio_platform_release(void *device_data)
> > +{
> > +     module_put(THIS_MODULE);
> > +}
> > +
> > +static int vfio_platform_open(void *device_data)
> > +{
> > +     if (!try_module_get(THIS_MODULE))
> > +             return -ENODEV;
> > +
> > +     return 0;
> > +}
> > +
> > +static long vfio_platform_ioctl(void *device_data,
> > +                        unsigned int cmd, unsigned long arg)
> > +{
> > +     struct vfio_platform_device *vdev = device_data;
> > +     unsigned long minsz;
> > +
> > +     if (cmd == VFIO_DEVICE_GET_INFO) {
> > +             struct vfio_device_info info;
> > +
> > +             minsz = offsetofend(struct vfio_device_info, num_irqs);
> > +
> > +             if (copy_from_user(&info, (void __user *)arg, minsz))
> > +                     return -EFAULT;
> > +
> > +             if (info.argsz < minsz)
> > +                     return -EINVAL;
> > +
> > +             info.flags = VFIO_DEVICE_FLAGS_PLATFORM;
> > +             info.num_regions = 0;
> > +             info.num_irqs = 0;
> > +
> > +             return copy_to_user((void __user *)arg, &info, minsz);
> > +
> > +     } else if (cmd == VFIO_DEVICE_GET_REGION_INFO)
> > +             return -EINVAL;
> > +
> > +     else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
> > +             return -EINVAL;
> > +
> > +     else if (cmd == VFIO_DEVICE_SET_IRQS)
> > +             return -EINVAL;
> > +
> > +     else if (cmd == VFIO_DEVICE_RESET)
> > +             return -EINVAL;
> > +
> > +     return -ENOTTY;
> > +}
> > +
> > +static ssize_t vfio_platform_read(void *device_data, char __user *buf,
> > +                          size_t count, loff_t *ppos)
> > +{
> > +     return 0;
> > +}
> > +
> > +static ssize_t vfio_platform_write(void *device_data, const char __user *buf,
> > +                           size_t count, loff_t *ppos)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int vfio_platform_mmap(void *device_data, struct vm_area_struct *vma)
> > +{
> > +     return -EINVAL;
> > +}
> > +
> > +static const struct vfio_device_ops vfio_platform_ops = {
> > +     .name           = "vfio-platform",
> > +     .open           = vfio_platform_open,
> > +     .release        = vfio_platform_release,
> > +     .ioctl          = vfio_platform_ioctl,
> > +     .read           = vfio_platform_read,
> > +     .write          = vfio_platform_write,
> > +     .mmap           = vfio_platform_mmap,
> > +};
> > +
> > +static int vfio_platform_probe(struct platform_device *pdev)
> > +{
> > +     struct vfio_platform_device *vdev;
> > +     struct iommu_group *group;
> > +     int ret;
> > +
> > +     group = iommu_group_get(&pdev->dev);
> > +     if (!group) {
> > +             pr_err("VFIO: No IOMMU group for device %s\n", pdev->name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
> > +     if (!vdev) {
> > +             iommu_group_put(group);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     vdev->pdev = pdev;
> > +
> > +     ret = vfio_add_group_dev(&pdev->dev, &vfio_platform_ops, vdev);
> > +     if (ret) {
> > +             iommu_group_put(group);
> > +             kfree(vdev);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int vfio_platform_remove(struct platform_device *pdev)
> > +{
> > +     struct vfio_platform_device *vdev;
> > +
> > +     vdev = vfio_del_group_dev(&pdev->dev);
> > +     if (!vdev)
> > +             return -EINVAL;
> > +
> > +     iommu_group_put(pdev->dev.iommu_group);
> > +     kfree(vdev);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id vfio_platform_match[] = {
> > +     /* Before this series can be applied, we shall implement a better
> > +      * mechanism to bind the module to any device. For now add the
> > +      * compatible property to the dtb of the devices we want to use. */
> > +     {
> > +             .compatible = "vfio",
> > +     },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, vfio_platform_match);
> > +
> > +static struct platform_driver vfio_platform_driver = {
> > +     .probe          = vfio_platform_probe,
> > +     .remove         = vfio_platform_remove,
> > +     .driver = {
> > +             .name   = "vfio-platform",
> > +             .owner  = THIS_MODULE,
> > +             .of_match_table = vfio_platform_match,
> > +     },
> > +};
> > +
> > +module_platform_driver(vfio_platform_driver);
> > +
> > +MODULE_VERSION(DRIVER_VERSION);
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR(DRIVER_AUTHOR);
> > +MODULE_DESCRIPTION(DRIVER_DESC);
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 284ff24..8d7434d 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -147,6 +147,7 @@ struct vfio_device_info {
> >       __u32   flags;
> >  #define VFIO_DEVICE_FLAGS_RESET      (1 << 0)        /* Device supports reset */
> >  #define VFIO_DEVICE_FLAGS_PCI        (1 << 1)        /* vfio-pci device */
> > +#define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)  /* vfio-platform device */
> >       __u32   num_regions;    /* Max region index + 1 */
> >       __u32   num_irqs;       /* Max IRQ index + 1 */
> >  };
>
>
>

Ack, thanks.
