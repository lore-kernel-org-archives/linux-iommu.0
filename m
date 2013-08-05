From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH 2/3] Initial skeleton of VFIO support for Device Tree
	based devices
Date: Mon, 5 Aug 2013 15:45:06 +0200
Message-ID: <CAG8rG2yCix04ZHq_rydRVfjfSh15U=LZ38mf_a4ECEUAgvRMbQ@mail.gmail.com>
References: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
	<1375708632-26356-3-git-send-email-a.motakis@virtualopensystems.com>
	<20130805133757.GF9910@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4502148137406985942=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130805133757.GF9910-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pawel.moll-5wv7dgnIgG8@public.gmane.org, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, "B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============4502148137406985942==
Content-Type: multipart/alternative; boundary=e89a8ff1c3721d421b04e33384fb

--e89a8ff1c3721d421b04e33384fb
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Aug 5, 2013 at 3:37 PM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:

> [adding DT maintainers to Cc]
>
> On Mon, Aug 05, 2013 at 02:17:11PM +0100, Antonios Motakis wrote:
> > Platform devices in the Linux kernel are usually managed by the DT
> > interface. This patch forms the base to support these kind of devices
> > with VFIO.
> >
> > Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> > ---
> >  drivers/vfio/Kconfig      |  10 +++
> >  drivers/vfio/Makefile     |   1 +
> >  drivers/vfio/vfio_dt.c    | 187
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h |   1 +
> >  4 files changed, 199 insertions(+)
> >  create mode 100644 drivers/vfio/vfio_dt.c
> >
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> > index 1f84eda..a77a2e4 100644
> > --- a/drivers/vfio/Kconfig
> > +++ b/drivers/vfio/Kconfig
> > @@ -13,4 +13,14 @@ menuconfig VFIO
> >
> >         If you don't know what to do here, say N.
> >
> > +config VFIO_DT
> > +     tristate "VFIO support for Device Tree devices"
> > +     depends on VFIO && EVENTFD
> > +     help
> > +       Support for the VFIO Device Tree driver.  This is required to
> make
> > +       use of platform devices present on Device Tree nodes using the
> VFIO
> > +       framework.
> > +
> > +       If you don't know what to do here, say N.
> > +
> >  source "drivers/vfio/pci/Kconfig"
> > diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> > index 2398d4a..d599a67 100644
> > --- a/drivers/vfio/Makefile
> > +++ b/drivers/vfio/Makefile
> > @@ -1,3 +1,4 @@
> >  obj-$(CONFIG_VFIO) += vfio.o
> >  obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
> >  obj-$(CONFIG_VFIO_PCI) += pci/
> > +obj-$(CONFIG_VFIO_DT) += vfio_dt.o
> > diff --git a/drivers/vfio/vfio_dt.c b/drivers/vfio/vfio_dt.c
> > new file mode 100644
> > index 0000000..ad4d31d
> > --- /dev/null
> > +++ b/drivers/vfio/vfio_dt.c
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
> > + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
> USA.
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
> > +#define DRIVER_AUTHOR   "Antonios Motakis <
> a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>"
> > +#define DRIVER_DESC     "VFIO Device Tree devices - User Level
> meta-driver"
> > +
> > +struct vfio_dt_device {
> > +     struct platform_device  *pdev;
> > +};
> > +
> > +static void vfio_dt_release(void *device_data)
> > +{
> > +     module_put(THIS_MODULE);
> > +}
> > +
> > +static int vfio_dt_open(void *device_data)
> > +{
> > +     if (!try_module_get(THIS_MODULE))
> > +             return -ENODEV;
> > +
> > +     return 0;
> > +}
> > +
> > +static long vfio_dt_ioctl(void *device_data,
> > +                        unsigned int cmd, unsigned long arg)
> > +{
> > +     struct vfio_dt_device *vdev = device_data;
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
> > +             info.flags = VFIO_DEVICE_FLAGS_DT;
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
> > +static ssize_t vfio_dt_read(void *device_data, char __user *buf,
> > +                          size_t count, loff_t *ppos)
> > +{
> > +     return 0;
> > +}
> > +
> > +static ssize_t vfio_dt_write(void *device_data, const char __user *buf,
> > +                           size_t count, loff_t *ppos)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int vfio_dt_mmap(void *device_data, struct vm_area_struct *vma)
> > +{
> > +     return -EINVAL;
> > +}
> > +
> > +static const struct vfio_device_ops vfio_dt_ops = {
> > +     .name           = "vfio-dts",
> > +     .open           = vfio_dt_open,
> > +     .release        = vfio_dt_release,
> > +     .ioctl          = vfio_dt_ioctl,
> > +     .read           = vfio_dt_read,
> > +     .write          = vfio_dt_write,
> > +     .mmap           = vfio_dt_mmap,
> > +};
> > +
> > +static int vfio_dt_probe(struct platform_device *pdev)
> > +{
> > +     struct vfio_dt_device *vdev;
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
> > +     ret = vfio_add_group_dev(&pdev->dev, &vfio_dt_ops, vdev);
> > +     if (ret) {
> > +             iommu_group_put(group);
> > +             kfree(vdev);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int vfio_dt_remove(struct platform_device *pdev)
> > +{
> > +     struct vfio_dt_device *vdev;
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
> > +static const struct of_device_id vfio_dt_match[] = {
> > +     /* In the future, we can implement a better mechanism to bind the
> > +      * module to any device. For now add the compatible property to the
> > +      * dtb of the devices we want to use.   */
> > +     {
> > +             .compatible = "vfio-dt",
> > +     },
> > +     {},
> > +};
>
> This definitely doesn't belong in the dt. It's purely a Linux
> abstraction and does not represent a piece of hardware or common
> interface.
>
> We need to think of a better mechanism for binding the module to these
> devices now.
>
>
I already make this remark in the cover letter; thanks for confirming it.

Antonios

Thanks,
> Mark.
>
> > +MODULE_DEVICE_TABLE(of, vfio_dt_match);
> > +
> > +static struct platform_driver vfio_dt_driver = {
> > +     .probe          = vfio_dt_probe,
> > +     .remove         = vfio_dt_remove,
> > +     .driver = {
> > +             .name   = "vfio-dt",
> > +             .owner  = THIS_MODULE,
> > +             .of_match_table = vfio_dt_match,
> > +     },
> > +};
> > +
> > +module_platform_driver(vfio_dt_driver);
> > +
> > +MODULE_VERSION(DRIVER_VERSION);
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR(DRIVER_AUTHOR);
> > +MODULE_DESCRIPTION(DRIVER_DESC);
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 284ff24..1e4bef2 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -147,6 +147,7 @@ struct vfio_device_info {
> >       __u32   flags;
> >  #define VFIO_DEVICE_FLAGS_RESET      (1 << 0)        /* Device supports
> reset */
> >  #define VFIO_DEVICE_FLAGS_PCI        (1 << 1)        /* vfio-pci device
> */
> > +#define VFIO_DEVICE_FLAGS_DT (1 << 2)        /* vfio-dt device */
> >       __u32   num_regions;    /* Max region index + 1 */
> >       __u32   num_irqs;       /* Max IRQ index + 1 */
> >  };
> > --
> > 1.8.1.2
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>

--e89a8ff1c3721d421b04e33384fb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 5, 2013 at 3:37 PM, Mark Rutland <span dir=3D"ltr">&lt;<a href=
=3D"mailto:mark.rutland-5wv7dgnIgG8@public.gmane.org" target=3D"_blank">mark.rutland-5wv7dgnIgG8@public.gmane.org</a>=
&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">[adding DT maintainers to Cc]<br>
<div><div class=3D"h5"><br>
On Mon, Aug 05, 2013 at 02:17:11PM +0100, Antonios Motakis wrote:<br>
&gt; Platform devices in the Linux kernel are usually managed by the DT<br>
&gt; interface. This patch forms the base to support these kind of devices<=
br>
&gt; with VFIO.<br>
&gt;<br>
&gt; Signed-off-by: Antonios Motakis &lt;<a href=3D"mailto:a.motakis@virtua=
lopensystems.com">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/vfio/Kconfig =A0 =A0 =A0| =A010 +++<br>
&gt; =A0drivers/vfio/Makefile =A0 =A0 | =A0 1 +<br>
&gt; =A0drivers/vfio/vfio_dt.c =A0 =A0| 187 +++++++++++++++++++++++++++++++=
+++++++++++++++<br>
&gt; =A0include/uapi/linux/vfio.h | =A0 1 +<br>
&gt; =A04 files changed, 199 insertions(+)<br>
&gt; =A0create mode 100644 drivers/vfio/vfio_dt.c<br>
&gt;<br>
&gt; diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig<br>
&gt; index 1f84eda..a77a2e4 100644<br>
&gt; --- a/drivers/vfio/Kconfig<br>
&gt; +++ b/drivers/vfio/Kconfig<br>
&gt; @@ -13,4 +13,14 @@ menuconfig VFIO<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 If you don&#39;t know what to do here, say N.<br>
&gt;<br>
&gt; +config VFIO_DT<br>
&gt; + =A0 =A0 tristate &quot;VFIO support for Device Tree devices&quot;<br=
>
&gt; + =A0 =A0 depends on VFIO &amp;&amp; EVENTFD<br>
&gt; + =A0 =A0 help<br>
&gt; + =A0 =A0 =A0 Support for the VFIO Device Tree driver. =A0This is requ=
ired to make<br>
&gt; + =A0 =A0 =A0 use of platform devices present on Device Tree nodes usi=
ng the VFIO<br>
&gt; + =A0 =A0 =A0 framework.<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 If you don&#39;t know what to do here, say N.<br>
&gt; +<br>
&gt; =A0source &quot;drivers/vfio/pci/Kconfig&quot;<br>
&gt; diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile<br>
&gt; index 2398d4a..d599a67 100644<br>
&gt; --- a/drivers/vfio/Makefile<br>
&gt; +++ b/drivers/vfio/Makefile<br>
&gt; @@ -1,3 +1,4 @@<br>
&gt; =A0obj-$(CONFIG_VFIO) +=3D vfio.o<br>
&gt; =A0obj-$(CONFIG_VFIO_IOMMU_TYPE1) +=3D vfio_iommu_type1.o<br>
&gt; =A0obj-$(CONFIG_VFIO_PCI) +=3D pci/<br>
&gt; +obj-$(CONFIG_VFIO_DT) +=3D vfio_dt.o<br>
&gt; diff --git a/drivers/vfio/vfio_dt.c b/drivers/vfio/vfio_dt.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..ad4d31d<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/vfio/vfio_dt.c<br>
&gt; @@ -0,0 +1,187 @@<br>
&gt; +/*<br>
&gt; + * Copyright (C) 2013 - Virtual Open Systems<br>
&gt; + * Author: Antonios Motakis &lt;<a href=3D"mailto:a.motakis@virtualop=
ensystems.com">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License, version 2, a=
s<br>
&gt; + * published by the Free Software Foundation.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the<br=
>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program; if not, write to the Free Software<br>
&gt; + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA =A002110-1=
301, USA.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/device.h&gt;<br>
&gt; +#include &lt;linux/eventfd.h&gt;<br>
&gt; +#include &lt;linux/interrupt.h&gt;<br>
&gt; +#include &lt;linux/iommu.h&gt;<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/mutex.h&gt;<br>
&gt; +#include &lt;linux/notifier.h&gt;<br>
&gt; +#include &lt;linux/pm_runtime.h&gt;<br>
&gt; +#include &lt;linux/slab.h&gt;<br>
&gt; +#include &lt;linux/types.h&gt;<br>
&gt; +#include &lt;linux/uaccess.h&gt;<br>
&gt; +#include &lt;linux/vfio.h&gt;<br>
&gt; +<br>
&gt; +#define DRIVER_VERSION =A0&quot;0.1&quot;<br>
&gt; +#define DRIVER_AUTHOR =A0 &quot;Antonios Motakis &lt;<a href=3D"mailt=
o:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt=
;&quot;<br>
&gt; +#define DRIVER_DESC =A0 =A0 &quot;VFIO Device Tree devices - User Lev=
el meta-driver&quot;<br>
&gt; +<br>
&gt; +struct vfio_dt_device {<br>
&gt; + =A0 =A0 struct platform_device =A0*pdev;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void vfio_dt_release(void *device_data)<br>
&gt; +{<br>
&gt; + =A0 =A0 module_put(THIS_MODULE);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vfio_dt_open(void *device_data)<br>
&gt; +{<br>
&gt; + =A0 =A0 if (!try_module_get(THIS_MODULE))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static long vfio_dt_ioctl(void *device_data,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int cmd, uns=
igned long arg)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct vfio_dt_device *vdev =3D device_data;<br>
&gt; + =A0 =A0 unsigned long minsz;<br>
&gt; +<br>
&gt; + =A0 =A0 if (cmd =3D=3D VFIO_DEVICE_GET_INFO) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 struct vfio_device_info info;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 minsz =3D offsetofend(struct vfio_device_inf=
o, num_irqs);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (copy_from_user(&amp;info, (void __user *=
)arg, minsz))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (info.argsz &lt; minsz)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 info.flags =3D VFIO_DEVICE_FLAGS_DT;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 info.num_regions =3D 0;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 info.num_irqs =3D 0;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return copy_to_user((void __user *)arg, &amp=
;info, minsz);<br>
&gt; +<br>
&gt; + =A0 =A0 } else if (cmd =3D=3D VFIO_DEVICE_GET_REGION_INFO)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 else if (cmd =3D=3D VFIO_DEVICE_GET_IRQ_INFO)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 else if (cmd =3D=3D VFIO_DEVICE_SET_IRQS)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 else if (cmd =3D=3D VFIO_DEVICE_RESET)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 return -ENOTTY;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t vfio_dt_read(void *device_data, char __user *buf,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t count, lof=
f_t *ppos)<br>
&gt; +{<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t vfio_dt_write(void *device_data, const char __user *bu=
f,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t count, lo=
ff_t *ppos)<br>
&gt; +{<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vfio_dt_mmap(void *device_data, struct vm_area_struct *vma=
)<br>
&gt; +{<br>
&gt; + =A0 =A0 return -EINVAL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct vfio_device_ops vfio_dt_ops =3D {<br>
&gt; + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D &quot;vfio-dts&quot;,<br>
&gt; + =A0 =A0 .open =A0 =A0 =A0 =A0 =A0 =3D vfio_dt_open,<br>
&gt; + =A0 =A0 .release =A0 =A0 =A0 =A0=3D vfio_dt_release,<br>
&gt; + =A0 =A0 .ioctl =A0 =A0 =A0 =A0 =A0=3D vfio_dt_ioctl,<br>
&gt; + =A0 =A0 .read =A0 =A0 =A0 =A0 =A0 =3D vfio_dt_read,<br>
&gt; + =A0 =A0 .write =A0 =A0 =A0 =A0 =A0=3D vfio_dt_write,<br>
&gt; + =A0 =A0 .mmap =A0 =A0 =A0 =A0 =A0 =3D vfio_dt_mmap,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int vfio_dt_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct vfio_dt_device *vdev;<br>
&gt; + =A0 =A0 struct iommu_group *group;<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 group =3D iommu_group_get(&amp;pdev-&gt;dev);<br>
&gt; + =A0 =A0 if (!group) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pr_err(&quot;VFIO: No IOMMU group for device=
 %s\n&quot;, pdev-&gt;name);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 vdev =3D kzalloc(sizeof(*vdev), GFP_KERNEL);<br>
&gt; + =A0 =A0 if (!vdev) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 iommu_group_put(group);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 vdev-&gt;pdev =3D pdev;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D vfio_add_group_dev(&amp;pdev-&gt;dev, &amp;vfio_dt_o=
ps, vdev);<br>
&gt; + =A0 =A0 if (ret) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 iommu_group_put(group);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 kfree(vdev);<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vfio_dt_remove(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct vfio_dt_device *vdev;<br>
&gt; +<br>
&gt; + =A0 =A0 vdev =3D vfio_del_group_dev(&amp;pdev-&gt;dev);<br>
&gt; + =A0 =A0 if (!vdev)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 iommu_group_put(pdev-&gt;dev.iommu_group);<br>
&gt; + =A0 =A0 kfree(vdev);<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct of_device_id vfio_dt_match[] =3D {<br>
&gt; + =A0 =A0 /* In the future, we can implement a better mechanism to bin=
d the<br>
&gt; + =A0 =A0 =A0* module to any device. For now add the compatible proper=
ty to the<br>
&gt; + =A0 =A0 =A0* dtb of the devices we want to use. =A0 */<br>
&gt; + =A0 =A0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .compatible =3D &quot;vfio-dt&quot;,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 {},<br>
&gt; +};<br>
<br>
</div></div>This definitely doesn&#39;t belong in the dt. It&#39;s purely a=
 Linux<br>
abstraction and does not represent a piece of hardware or common<br>
interface.<br>
<br>
We need to think of a better mechanism for binding the module to these<br>
devices now.<br>
<br></blockquote><div><br></div><div>I already make this remark in the cove=
r letter; thanks for confirming it.<br></div><div>=A0<br></div><div>Antonio=
s<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

Thanks,<br>
Mark.<br>
<div><div class=3D"h5"><br>
&gt; +MODULE_DEVICE_TABLE(of, vfio_dt_match);<br>
&gt; +<br>
&gt; +static struct platform_driver vfio_dt_driver =3D {<br>
&gt; + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D vfio_dt_probe,<br>
&gt; + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D vfio_dt_remove,<br>
&gt; + =A0 =A0 .driver =3D {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D &quot;vfio-dt&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D vfio_dt_match,<br>
&gt; + =A0 =A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +module_platform_driver(vfio_dt_driver);<br>
&gt; +<br>
&gt; +MODULE_VERSION(DRIVER_VERSION);<br>
&gt; +MODULE_LICENSE(&quot;GPL v2&quot;);<br>
&gt; +MODULE_AUTHOR(DRIVER_AUTHOR);<br>
&gt; +MODULE_DESCRIPTION(DRIVER_DESC);<br>
&gt; diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h<br>
&gt; index 284ff24..1e4bef2 100644<br>
&gt; --- a/include/uapi/linux/vfio.h<br>
&gt; +++ b/include/uapi/linux/vfio.h<br>
&gt; @@ -147,6 +147,7 @@ struct vfio_device_info {<br>
&gt; =A0 =A0 =A0 __u32 =A0 flags;<br>
&gt; =A0#define VFIO_DEVICE_FLAGS_RESET =A0 =A0 =A0(1 &lt;&lt; 0) =A0 =A0 =
=A0 =A0/* Device supports reset */<br>
&gt; =A0#define VFIO_DEVICE_FLAGS_PCI =A0 =A0 =A0 =A0(1 &lt;&lt; 1) =A0 =A0=
 =A0 =A0/* vfio-pci device */<br>
&gt; +#define VFIO_DEVICE_FLAGS_DT (1 &lt;&lt; 2) =A0 =A0 =A0 =A0/* vfio-dt=
 device */<br>
&gt; =A0 =A0 =A0 __u32 =A0 num_regions; =A0 =A0/* Max region index + 1 */<b=
r>
&gt; =A0 =A0 =A0 __u32 =A0 num_irqs; =A0 =A0 =A0 /* Max IRQ index + 1 */<br=
>
&gt; =A0};<br>
&gt; --<br>
&gt; 1.8.1.2<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; linux-arm-kernel mailing list<br>
&gt; <a href=3D"mailto:linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org">linux-arm-kern=
el-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org</a><br>
&gt; <a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kerne=
l" target=3D"_blank">http://lists.infradead.org/mailman/listinfo/linux-arm-=
kernel</a><br>
&gt;<br>
</blockquote></div><br></div></div>

--e89a8ff1c3721d421b04e33384fb--

--===============4502148137406985942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4502148137406985942==--
