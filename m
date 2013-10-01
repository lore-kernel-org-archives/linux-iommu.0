From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH 3/7] Return info for device and its memory regions and
	interrupts
Date: Tue, 1 Oct 2013 11:35:35 +0200
Message-ID: <CAG8rG2y_GRDnvpWAQeDKqJgxjE3pMpUv5CFUxBh6397X=iifUA@mail.gmail.com>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-4-git-send-email-a.motakis@virtualopensystems.com>
	<6A3DF150A5B70D4F9B66A25E3F7C888D0718A526@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7077554932050126145=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0718A526-RL0Hj/+nBVCMXPU/2EZmt64g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============7077554932050126145==
Content-Type: multipart/alternative; boundary=e89a8ff1c68ac4b78404e7aaac45

--e89a8ff1c68ac4b78404e7aaac45
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Sep 30, 2013 at 5:49 PM, Bhushan Bharat-R65777 <R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org
> wrote:

>
>
> > -----Original Message-----
> > From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> > bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Antonios Motakis
> > Sent: Monday, September 30, 2013 8:59 PM
> > To: kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> > Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> agraf-l3A5Bk7waGM@public.gmane.org; Yoder
> > Stuart-B08248; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Antonios Motakis;
> > tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org
> > Subject: [PATCH 3/7] Return info for device and its memory regions and
> > interrupts
> >
> > A VFIO userspace driver will start by opening the VFIO device that
> corresponds
> > to an IOMMU group, and will use the ioctl interface to get the basic
> device
> > info, such as number of memory regions and interrupts, and their
> properties.
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
> index
> > b9686b0..a0abcfa 100644
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
> >                          unsigned int cmd, unsigned long arg)  {
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
>
> Why are we calling the above function if not using res?
>

Good point, it is out of place now in this series. Though I will probably
reintroduce it when IRQ supports starts being implemented.


>
> > +
> > +             info.flags = 0;
> > +             info.count = 1;
>
> I believe count here is number of interrupts, and we can have devices with
> more than 1 interrupt.
>
>
Count here is not the number of interrupts of the device; if a device has
multiple interrupts, then we return multiple IRQ indexes. Count here is the
number of consecutive interrupts within the same index, which we don't use.
This is used for MSI-like interrupt blocks, but for platform devices we
simply use a distinct index per interrupt.


> -Bharat
>
> > +
> > +             return copy_to_user((void __user *)arg, &info, minsz);
> >
> > -     else if (cmd == VFIO_DEVICE_SET_IRQS)
> > +     } else if (cmd == VFIO_DEVICE_SET_IRQS)
> >               return -EINVAL;
> >
> >       else if (cmd == VFIO_DEVICE_RESET)
> > --
> > 1.8.1.2
> >
> > _______________________________________________
> > iommu mailing list
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
>
>

--e89a8ff1c68ac4b78404e7aaac45
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Mon, Sep 30, 2013 at 5:49 PM, Bhushan Bharat-R65777 <span dir=3D=
"ltr">&lt;<a href=3D"mailto:R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org" target=3D"_blank">R65777@=
freescale.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" targ=
et=3D"_blank">iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a> [mailto:<a href=
=3D"mailto:iommu-" target=3D"_blank">iommu-</a><br>
&gt; <a href=3D"mailto:bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" target=3D"_blank=
">bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a>] On Behalf Of Antonios Motakis<br>
&gt; Sent: Monday, September 30, 2013 8:59 PM<br>
&gt; To: <a href=3D"mailto:kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" target=3D"_blank">=
kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org</a>; <a href=3D"mailto:alex.williamson@redhat.=
com" target=3D"_blank">alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a><br>
&gt; Cc: <a href=3D"mailto:linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" target=3D"_bl=
ank">linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>; <a href=3D"mailto:kvm-u79uwXL29Tb/PtFMR13I2A@public.gmane.org=
el.org" target=3D"_blank">kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>; <a href=3D"mailto:agraf@=
suse.de" target=3D"_blank">agraf-l3A5Bk7waGM@public.gmane.org</a>; Yoder<br>


&gt; Stuart-B08248; <a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" tar=
get=3D"_blank">iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a>; Antonios Motakis;<br>
&gt; <a href=3D"mailto:tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" target=3D"_blank">tech@=
virtualopensystems.com</a><br>
&gt; Subject: [PATCH 3/7] Return info for device and its memory regions and=
<br>
&gt; interrupts<br>
&gt;<br>
&gt; A VFIO userspace driver will start by opening the VFIO device that cor=
responds<br>
&gt; to an IOMMU group, and will use the ioctl interface to get the basic d=
evice<br>
&gt; info, such as number of memory regions and interrupts, and their prope=
rties.<br>
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
.c index<br>
&gt; b9686b0..a0abcfa 100644<br>
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
nsigned long arg) =A0{<br>
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
<br>
</div></div>Why are we calling the above function if not using res?<br></bl=
ockquote><div><br></div><div>Good point, it is out of place now in this ser=
ies. Though I will probably reintroduce it when IRQ supports starts being i=
mplemented.<br>

</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div><br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 info.flags =3D 0;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 info.count =3D 1;<br>
<br>
</div>I believe count here is number of interrupts, and we can have devices=
 with more than 1 interrupt.<br>
<br></blockquote><div><br></div><div>Count here is not the number of interr=
upts of the device; if a device has multiple interrupts, then we return mul=
tiple IRQ indexes. Count here is the number of consecutive interrupts withi=
n the same index, which we don&#39;t use. This is used for MSI-like interru=
pt blocks, but for platform devices we simply use a distinct index per inte=
rrupt.<br>

</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
-Bharat<br>
<div><br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return copy_to_user((void __user *)arg, &amp=
;info, minsz);<br>
&gt;<br>
&gt; - =A0 =A0 else if (cmd =3D=3D VFIO_DEVICE_SET_IRQS)<br>
&gt; + =A0 =A0 } else if (cmd =3D=3D VFIO_DEVICE_SET_IRQS)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt;<br>
&gt; =A0 =A0 =A0 else if (cmd =3D=3D VFIO_DEVICE_RESET)<br>
&gt; --<br>
&gt; 1.8.1.2<br>
&gt;<br>
</div>&gt; _______________________________________________<br>
&gt; iommu mailing list<br>
&gt; <a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" target=3D"_blank">=
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/iommu" t=
arget=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/iommu</=
a><br>
<br>
<br>
</blockquote></div><br></div></div>

--e89a8ff1c68ac4b78404e7aaac45--

--===============7077554932050126145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7077554932050126145==--
