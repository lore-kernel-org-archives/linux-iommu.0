From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH 3/7] Return info for device and its memory regions and
	interrupts
Date: Tue, 1 Oct 2013 11:35:41 +0200
Message-ID: <CAG8rG2yPXX9WtmhJqYMNE_3x4RNGkb1BDab8F3Pk8KUhntM9fg@mail.gmail.com>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-4-git-send-email-a.motakis@virtualopensystems.com>
	<1380562776.2674.177.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4490428788091361536=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380562776.2674.177.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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

--===============4490428788091361536==
Content-Type: multipart/alternative; boundary=047d7b6d85f219301204e7aaad64

--047d7b6d85f219301204e7aaad64
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Sep 30, 2013 at 7:39 PM, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> wrote:

> On Mon, 2013-09-30 at 17:28 +0200, Antonios Motakis wrote:
> > A VFIO userspace driver will start by opening the VFIO device
> > that corresponds to an IOMMU group, and will use the ioctl interface
> > to get the basic device info, such as number of memory regions and
> > interrupts, and their properties.
> >
> > This patch implements the IOCTLs:
> >  - VFIO_DEVICE_GET_INFO
> >  - VFIO_DEVICE_GET_REGION_INFO
> >  - VFIO_DEVICE_GET_IRQ_INFO
> >
> > Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> > ---
> >  drivers/vfio/vfio_platform.c | 60
> ++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 53 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio_platform.c b/drivers/vfio/vfio_platform.c
> > index b9686b0..a0abcfa 100644
> > --- a/drivers/vfio/vfio_platform.c
> > +++ b/drivers/vfio/vfio_platform.c
> > @@ -28,6 +28,10 @@
> >  #include <linux/types.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/vfio.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_platform.h>
> >
> >  #define DRIVER_VERSION  "0.1"
> >  #define DRIVER_AUTHOR   "Antonios Motakis <
> a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>"
> > @@ -54,10 +58,13 @@ static long vfio_platform_ioctl(void *device_data,
> >                          unsigned int cmd, unsigned long arg)
> >  {
> >       struct vfio_platform_device *vdev = device_data;
> > +     struct device_node *of_node = vdev->pdev->dev.of_node;
> >       unsigned long minsz;
> >
> >       if (cmd == VFIO_DEVICE_GET_INFO) {
> >               struct vfio_device_info info;
> > +             struct resource res;
> > +             int cnt = 0;
> >
> >               minsz = offsetofend(struct vfio_device_info, num_irqs);
> >
> > @@ -68,18 +75,57 @@ static long vfio_platform_ioctl(void *device_data,
> >                       return -EINVAL;
> >
> >               info.flags = VFIO_DEVICE_FLAGS_PLATFORM;
> > -             info.num_regions = 0;
> > -             info.num_irqs = 0;
> > +
> > +             while (!of_address_to_resource(of_node, cnt, &res))
> > +                     cnt++;
> > +
> > +             info.num_regions = cnt;
> > +
> > +             info.num_irqs = of_irq_count(of_node);
> >
> >               return copy_to_user((void __user *)arg, &info, minsz);
> >
> > -     } else if (cmd == VFIO_DEVICE_GET_REGION_INFO)
> > -             return -EINVAL;
> > +     } else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
> > +             struct vfio_region_info info;
> > +             struct resource res;
> >
> > -     else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
> > -             return -EINVAL;
> > +             minsz = offsetofend(struct vfio_region_info, offset);
> > +
> > +             if (copy_from_user(&info, (void __user *)arg, minsz))
> > +                     return -EFAULT;
> > +
> > +             if (info.argsz < minsz)
> > +                     return -EINVAL;
> > +
> > +             if(of_address_to_resource(of_node, info.index, &res))
> > +                     return -EINVAL;
> > +
> > +             info.offset = res.start;        /* map phys addr with
> offset */
> > +             info.size = resource_size(&res);
> > +             info.flags = 0;
> > +
> > +             return copy_to_user((void __user *)arg, &info, minsz);
> > +
> > +     } else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
> > +             struct vfio_irq_info info;
> > +             struct resource res;
> > +
> > +             minsz = offsetofend(struct vfio_irq_info, count);
> > +
> > +             if (copy_from_user(&info, (void __user *)arg, minsz))
> > +                     return -EFAULT;
> > +
> > +             if (info.argsz < minsz)
> > +                     return -EINVAL;
> > +
> > +             of_irq_to_resource(of_node, info.index, &res);
> > +
> > +             info.flags = 0;
> > +             info.count = 1;
> > +
> > +             return copy_to_user((void __user *)arg, &info, minsz);
> >
> > -     else if (cmd == VFIO_DEVICE_SET_IRQS)
> > +     } else if (cmd == VFIO_DEVICE_SET_IRQS)
> >               return -EINVAL;
> >
> >       else if (cmd == VFIO_DEVICE_RESET)
>
> I notice all the open firmware calls here and I'm curious, will all
> platform devices be making use of open firmware?  I don't know if this
> is synonymous with device tree or not.  Thanks,
>
> Alex
>
>
This VFIO driver will support only devices implemented on the device tree.
While there can be platform devices outside the device tree, I don't think
it makes sense to support them from the same driver. This is why I
originally called the driver VFIO_DT, however I renamed it to VFIO_PLATFORM
after feedback from the first RFC. However personally, I still think the
VFIO_DT name is more appropriate since we don't support all platform
devices, only those that use the device tree.

--047d7b6d85f219301204e7aaad64
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Mon, Sep 30, 2013 at 7:39 PM, Alex Williamson <span dir=3D"ltr">=
&lt;<a href=3D"mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">alex.wi=
lliamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div>On Mon, 2013-09-30 at 17:28 +0200,=
 Antonios Motakis wrote:<br>
&gt; A VFIO userspace driver will start by opening the VFIO device<br>
&gt; that corresponds to an IOMMU group, and will use the ioctl interface<b=
r>
&gt; to get the basic device info, such as number of memory regions and<br>
&gt; interrupts, and their properties.<br>
&gt;<br>
&gt; This patch implements the IOCTLs:<br>
&gt; =A0- VFIO_DEVICE_GET_INFO<br>
&gt; =A0- VFIO_DEVICE_GET_REGION_INFO<br>
&gt; =A0- VFIO_DEVICE_GET_IRQ_INFO<br>
&gt;<br>
&gt; Signed-off-by: Antonios Motakis &lt;<a href=3D"mailto:a.motakis@virtua=
lopensystems.com" target=3D"_blank">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt=
;<br>
&gt; ---<br>
&gt; =A0drivers/vfio/vfio_platform.c | 60 +++++++++++++++++++++++++++++++++=
+++++------<br>
&gt; =A01 file changed, 53 insertions(+), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/vfio/vfio_platform.c b/drivers/vfio/vfio_platform=
.c<br>
&gt; index b9686b0..a0abcfa 100644<br>
&gt; --- a/drivers/vfio/vfio_platform.c<br>
&gt; +++ b/drivers/vfio/vfio_platform.c<br>
&gt; @@ -28,6 +28,10 @@<br>
&gt; =A0#include &lt;linux/types.h&gt;<br>
&gt; =A0#include &lt;linux/uaccess.h&gt;<br>
&gt; =A0#include &lt;linux/vfio.h&gt;<br>
&gt; +#include &lt;linux/of.h&gt;<br>
&gt; +#include &lt;linux/of_address.h&gt;<br>
&gt; +#include &lt;linux/of_irq.h&gt;<br>
&gt; +#include &lt;linux/of_platform.h&gt;<br>
&gt;<br>
&gt; =A0#define DRIVER_VERSION =A0&quot;0.1&quot;<br>
&gt; =A0#define DRIVER_AUTHOR =A0 &quot;Antonios Motakis &lt;<a href=3D"mai=
lto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" target=3D"_blank">a.motakis@virtualop=
ensystems.com</a>&gt;&quot;<br>
&gt; @@ -54,10 +58,13 @@ static long vfio_platform_ioctl(void *device_data,=
<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int cmd, u=
nsigned long arg)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 struct vfio_platform_device *vdev =3D device_data;<br>
&gt; + =A0 =A0 struct device_node *of_node =3D vdev-&gt;pdev-&gt;dev.of_nod=
e;<br>
&gt; =A0 =A0 =A0 unsigned long minsz;<br>
&gt;<br>
&gt; =A0 =A0 =A0 if (cmd =3D=3D VFIO_DEVICE_GET_INFO) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct vfio_device_info info;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 struct resource res;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 int cnt =3D 0;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 minsz =3D offsetofend(struct vfio_device_i=
nfo, num_irqs);<br>
&gt;<br>
&gt; @@ -68,18 +75,57 @@ static long vfio_platform_ioctl(void *device_data,=
<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 info.flags =3D VFIO_DEVICE_FLAGS_PLATFORM;=
<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 info.num_regions =3D 0;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 info.num_irqs =3D 0;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 while (!of_address_to_resource(of_node, cnt,=
 &amp;res))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cnt++;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 info.num_regions =3D cnt;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 info.num_irqs =3D of_irq_count(of_node);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return copy_to_user((void __user *)arg, &a=
mp;info, minsz);<br>
&gt;<br>
&gt; - =A0 =A0 } else if (cmd =3D=3D VFIO_DEVICE_GET_REGION_INFO)<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; + =A0 =A0 } else if (cmd =3D=3D VFIO_DEVICE_GET_REGION_INFO) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 struct vfio_region_info info;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 struct resource res;<br>
&gt;<br>
&gt; - =A0 =A0 else if (cmd =3D=3D VFIO_DEVICE_GET_IRQ_INFO)<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 minsz =3D offsetofend(struct vfio_region_inf=
o, offset);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (copy_from_user(&amp;info, (void __user *=
)arg, minsz))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (info.argsz &lt; minsz)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if(of_address_to_resource(of_node, info.inde=
x, &amp;res))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 info.offset =3D res.start; =A0 =A0 =A0 =A0/*=
 map phys addr with offset */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 info.size =3D resource_size(&amp;res);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 info.flags =3D 0;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return copy_to_user((void __user *)arg, &amp=
;info, minsz);<br>
&gt; +<br>
&gt; + =A0 =A0 } else if (cmd =3D=3D VFIO_DEVICE_GET_IRQ_INFO) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 struct vfio_irq_info info;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 struct resource res;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 minsz =3D offsetofend(struct vfio_irq_info, =
count);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (copy_from_user(&amp;info, (void __user *=
)arg, minsz))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EFAULT;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (info.argsz &lt; minsz)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 of_irq_to_resource(of_node, info.index, &amp=
;res);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 info.flags =3D 0;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 info.count =3D 1;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return copy_to_user((void __user *)arg, &amp=
;info, minsz);<br>
&gt;<br>
&gt; - =A0 =A0 else if (cmd =3D=3D VFIO_DEVICE_SET_IRQS)<br>
&gt; + =A0 =A0 } else if (cmd =3D=3D VFIO_DEVICE_SET_IRQS)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt;<br>
&gt; =A0 =A0 =A0 else if (cmd =3D=3D VFIO_DEVICE_RESET)<br>
<br>
</div></div>I notice all the open firmware calls here and I&#39;m curious, =
will all<br>
platform devices be making use of open firmware? =A0I don&#39;t know if thi=
s<br>
is synonymous with device tree or not. =A0Thanks,<br>
<br>
Alex<br>
<br>
</blockquote></div><br></div><div class=3D"gmail_extra">This VFIO driver wi=
ll support only devices implemented on the device tree. While there can be =
platform devices outside the device tree, I don&#39;t think it makes sense =
to support them from the same driver. This is why I originally called the d=
river VFIO_DT, however I renamed it to VFIO_PLATFORM after feedback from th=
e first RFC. However personally, I still think the VFIO_DT name is more app=
ropriate since we don&#39;t support all platform devices, only those that u=
se the device tree.<br>

</div></div>

--047d7b6d85f219301204e7aaad64--

--===============4490428788091361536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4490428788091361536==--
