From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [RFC PATCH v5 06/11] VFIO_PLATFORM: Return info for device and
	its memory mapped IO regions
Date: Fri, 2 May 2014 18:55:02 +0200
Message-ID: <CAG8rG2wvojOmjqqQkpcXW3EVrniv2BBc7oyig5ceRkFp0yb+YQ@mail.gmail.com>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
	<1398700371-20096-7-git-send-email-a.motakis@virtualopensystems.com>
	<1398705389.24318.279.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2881104422240603983=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1398705389.24318.279.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, KVM devel mailing list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, alvise rigo <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============2881104422240603983==
Content-Type: multipart/alternative; boundary=047d7b86f7eab9e9a504f86da502

--047d7b86f7eab9e9a504f86da502
Content-Type: text/plain; charset=UTF-8

On Mon, Apr 28, 2014 at 7:16 PM, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> wrote:

> On Mon, 2014-04-28 at 17:52 +0200, Antonios Motakis wrote:
> > A VFIO userspace driver will start by opening the VFIO device
> > that corresponds to an IOMMU group, and will use the ioctl interface
> > to get the basic device info, such as number of memory regions and
> > interrupts, and their properties.
> >
> > This patch enables the IOCTLs:
> >  - VFIO_DEVICE_GET_INFO
> >  - VFIO_DEVICE_GET_REGION_INFO
> >
> >  IRQ info is provided by one of the latter patches.
> >
> > Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> > ---
> >  drivers/vfio/platform/vfio_platform.c         | 77
> ++++++++++++++++++++++++---
> >  drivers/vfio/platform/vfio_platform_private.h | 17 ++++++
> >  2 files changed, 88 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/vfio/platform/vfio_platform.c
> b/drivers/vfio/platform/vfio_platform.c
> > index 1661746..5430cbe 100644
> > --- a/drivers/vfio/platform/vfio_platform.c
> > +++ b/drivers/vfio/platform/vfio_platform.c
> > @@ -34,15 +34,62 @@
> >  #define DRIVER_AUTHOR   "Antonios Motakis <
> a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>"
> >  #define DRIVER_DESC     "VFIO for platform devices - User Level
> meta-driver"
> >
> > +static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
> > +{
> > +     int cnt = 0, i;
> > +
> > +     while (platform_get_resource(vdev->pdev, IORESOURCE_MEM, cnt))
> > +             cnt++;
> > +
> > +     vdev->num_regions = cnt;
> > +
> > +     vdev->region = kzalloc(sizeof(struct vfio_platform_region) * cnt,
> > +                             GFP_KERNEL);
> > +     if (!vdev->region)
>
> Should vdev->num_regions be cleared here or set at the end to avoid
> possibly walking a null pointer later?
>
>
Ack.


> > +             return -ENOMEM;
> > +
> > +     for (i = 0; i < cnt;  i++) {
> > +             struct vfio_platform_region region;
> > +             struct resource *res =
> > +                     platform_get_resource(vdev->pdev, IORESOURCE_MEM,
> i);
> > +
> > +             region.addr = res->start;
> > +             region.size = resource_size(res);
> > +             region.flags = 0;
> > +
> > +             vdev->region[i] = region;
>
> nit, the local variable with copy at the end seems rather unnecessary
> here.
>
>
I'm doing it purely for readability reasons, the compiler should be able to
do the right thing anyway. But I am not married to the idea of course.


> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void vfio_platform_regions_cleanup(struct vfio_platform_device
> *vdev)
> > +{
> > +     kfree(vdev->region);
>
> Makes me nervous again that we have vdev->num_regions still set to a
> value.  Maybe just paranoia.
>

Definitely not paranoia, I will reset the num_regions here.


>
> > +}
> > +
> >  static void vfio_platform_release(void *device_data)
> >  {
> > +     struct vfio_platform_device *vdev = device_data;
> > +
> > +     vfio_platform_regions_cleanup(vdev);
> > +
> >       module_put(THIS_MODULE);
> >  }
> >
> >  static int vfio_platform_open(void *device_data)
> >  {
> > -     if (!try_module_get(THIS_MODULE))
> > +     struct vfio_platform_device *vdev = device_data;
> > +     int ret;
> > +
> > +     ret = vfio_platform_regions_init(vdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (!try_module_get(THIS_MODULE)) {
> > +             vfio_platform_regions_cleanup(vdev);
> >               return -ENODEV;
> > +     }
>
> Getting a reference to the module seems like it should be step 1 here.
> Thanks,
>
>
Ack.


> Alex
>
> >
> >       return 0;
> >  }
> > @@ -65,18 +112,36 @@ static long vfio_platform_ioctl(void *device_data,
> >                       return -EINVAL;
> >
> >               info.flags = VFIO_DEVICE_FLAGS_PLATFORM;
> > -             info.num_regions = 0;
> > +             info.num_regions = vdev->num_regions;
> >               info.num_irqs = 0;
> >
> >               return copy_to_user((void __user *)arg, &info, minsz);
> >
> > -     } else if (cmd == VFIO_DEVICE_GET_REGION_INFO)
> > -             return -EINVAL;
> > +     } else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
> > +             struct vfio_region_info info;
> > +
> > +             minsz = offsetofend(struct vfio_region_info, offset);
> > +
> > +             if (copy_from_user(&info, (void __user *)arg, minsz))
> > +                     return -EFAULT;
> > +
> > +             if (info.argsz < minsz)
> > +                     return -EINVAL;
> > +
> > +             if (info.index >= vdev->num_regions)
> > +                     return -EINVAL;
> > +
> > +             /* map offset to the physical address  */
> > +             info.offset = VFIO_PLATFORM_INDEX_TO_OFFSET(info.index);
> > +             info.size = vdev->region[info.index].size;
> > +             info.flags = vdev->region[info.index].flags;
> > +
> > +             return copy_to_user((void __user *)arg, &info, minsz);
> >
> > -     else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
> > +     } else if (cmd == VFIO_DEVICE_GET_IRQ_INFO) {
> >               return -EINVAL;
> >
> > -     else if (cmd == VFIO_DEVICE_SET_IRQS)
> > +     } else if (cmd == VFIO_DEVICE_SET_IRQS)
> >               return -EINVAL;
> >
> >       else if (cmd == VFIO_DEVICE_RESET)
> > diff --git a/drivers/vfio/platform/vfio_platform_private.h
> b/drivers/vfio/platform/vfio_platform_private.h
> > index 4ae88f8..3448f918 100644
> > --- a/drivers/vfio/platform/vfio_platform_private.h
> > +++ b/drivers/vfio/platform/vfio_platform_private.h
> > @@ -15,8 +15,25 @@
> >  #ifndef VFIO_PLATFORM_PRIVATE_H
> >  #define VFIO_PLATFORM_PRIVATE_H
> >
> > +#define VFIO_PLATFORM_OFFSET_SHIFT   40
> > +#define VFIO_PLATFORM_OFFSET_MASK (((u64)(1) <<
> VFIO_PLATFORM_OFFSET_SHIFT) - 1)
> > +
> > +#define VFIO_PLATFORM_OFFSET_TO_INDEX(off)   \
> > +     (off >> VFIO_PLATFORM_OFFSET_SHIFT)
> > +
> > +#define VFIO_PLATFORM_INDEX_TO_OFFSET(index) \
> > +     ((u64)(index) << VFIO_PLATFORM_OFFSET_SHIFT)
> > +
> > +struct vfio_platform_region {
> > +     u64                     addr;
> > +     resource_size_t         size;
> > +     u32                     flags;
> > +};
> > +
> >  struct vfio_platform_device {
> >       struct platform_device          *pdev;
> > +     struct vfio_platform_region     *region;
> > +     u32                             num_regions;
> >  };
> >
> >  #endif /* VFIO_PLATFORM_PRIVATE_H */
>
>
>
>


-- 
Antonios Motakis
Virtual Open Systems

--047d7b86f7eab9e9a504f86da502
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Mon, Apr 28, 2014 at 7:16 PM, Alex Williamson <span dir=3D"ltr">=
&lt;<a href=3D"mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">alex.wi=
lliamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On M=
on, 2014-04-28 at 17:52 +0200, Antonios Motakis wrote:<br>
&gt; A VFIO userspace driver will start by opening the VFIO device<br>
&gt; that corresponds to an IOMMU group, and will use the ioctl interface<b=
r>
&gt; to get the basic device info, such as number of memory regions and<br>
&gt; interrupts, and their properties.<br>
&gt;<br>
&gt; This patch enables the IOCTLs:<br>
&gt; =C2=A0- VFIO_DEVICE_GET_INFO<br>
&gt; =C2=A0- VFIO_DEVICE_GET_REGION_INFO<br>
&gt;<br>
&gt; =C2=A0IRQ info is provided by one of the latter patches.<br>
&gt;<br>
&gt; Signed-off-by: Antonios Motakis &lt;<a href=3D"mailto:a.motakis@virtua=
lopensystems.com">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0drivers/vfio/platform/vfio_platform.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 77 ++++++++++++++++++++++++---<br>
&gt; =C2=A0drivers/vfio/platform/vfio_platform_private.h | 17 ++++++<br>
&gt; =C2=A02 files changed, 88 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/plat=
form/vfio_platform.c<br>
&gt; index 1661746..5430cbe 100644<br>
&gt; --- a/drivers/vfio/platform/vfio_platform.c<br>
&gt; +++ b/drivers/vfio/platform/vfio_platform.c<br>
&gt; @@ -34,15 +34,62 @@<br>
&gt; =C2=A0#define DRIVER_AUTHOR =C2=A0 &quot;Antonios Motakis &lt;<a href=
=3D"mailto:a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org">a.motakis@virtualopensystems.c=
om</a>&gt;&quot;<br>
&gt; =C2=A0#define DRIVER_DESC =C2=A0 =C2=A0 &quot;VFIO for platform device=
s - User Level meta-driver&quot;<br>
&gt;<br>
&gt; +static int vfio_platform_regions_init(struct vfio_platform_device *vd=
ev)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 int cnt =3D 0, i;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 while (platform_get_resource(vdev-&gt;pdev, IORESOURCE=
_MEM, cnt))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cnt++;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 vdev-&gt;num_regions =3D cnt;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 vdev-&gt;region =3D kzalloc(sizeof(struct vfio_platfor=
m_region) * cnt,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GFP_KERNEL);<br>
&gt; + =C2=A0 =C2=A0 if (!vdev-&gt;region)<br>
<br>
</div></div>Should vdev-&gt;num_regions be cleared here or set at the end t=
o avoid<br>
possibly walking a null pointer later?<br>
<div class=3D""><br></div></blockquote><div><br></div><div>Ack.<br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"">
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 for (i =3D 0; i &lt; cnt; =C2=A0i++) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vfio_platform_regio=
n region;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct resource *res =3D<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 platform_get_resource(vdev-&gt;pdev, IORESOURCE_MEM, i);<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 region.addr =3D res-&gt;st=
art;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 region.size =3D resource_s=
ize(res);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 region.flags =3D 0;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vdev-&gt;region[i] =3D reg=
ion;<br>
<br>
</div>nit, the local variable with copy at the end seems rather unnecessary=
<br>
here.<br>
<div class=3D""><br></div></blockquote><div><br></div><div>I&#39;m doing it=
 purely for readability reasons, the compiler should be able to do the righ=
t thing anyway. But I am not married to the idea of course.<br></div><div>

=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div class=3D"">
&gt; + =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vfio_platform_regions_cleanup(struct vfio_platform_device=
 *vdev)<br>
&gt; +{<br>
&gt; + =C2=A0 =C2=A0 kfree(vdev-&gt;region);<br>
<br>
</div>Makes me nervous again that we have vdev-&gt;num_regions still set to=
 a<br>
value. =C2=A0Maybe just paranoia.<br></blockquote><div><br></div><div>Defin=
itely not paranoia, I will reset the num_regions here.<br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">


<div class=3D""><br>
&gt; +}<br>
&gt; +<br>
&gt; =C2=A0static void vfio_platform_release(void *device_data)<br>
&gt; =C2=A0{<br>
&gt; + =C2=A0 =C2=A0 struct vfio_platform_device *vdev =3D device_data;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 vfio_platform_regions_cleanup(vdev);<br>
&gt; +<br>
&gt; =C2=A0 =C2=A0 =C2=A0 module_put(THIS_MODULE);<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; =C2=A0static int vfio_platform_open(void *device_data)<br>
&gt; =C2=A0{<br>
&gt; - =C2=A0 =C2=A0 if (!try_module_get(THIS_MODULE))<br>
&gt; + =C2=A0 =C2=A0 struct vfio_platform_device *vdev =3D device_data;<br>
&gt; + =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 ret =3D vfio_platform_regions_init(vdev);<br>
&gt; + =C2=A0 =C2=A0 if (ret)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 if (!try_module_get(THIS_MODULE)) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vfio_platform_regions_clea=
nup(vdev);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
&gt; + =C2=A0 =C2=A0 }<br>
<br>
</div>Getting a reference to the module seems like it should be step 1 here=
.<br>
Thanks,<br>
<br></blockquote><div><br></div><div>Ack.<br>=C2=A0<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
Alex<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; =C2=A0}<br>
&gt; @@ -65,18 +112,36 @@ static long vfio_platform_ioctl(void *device_data=
,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 return -EINVAL;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info.flags =3D VFIO_D=
EVICE_FLAGS_PLATFORM;<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info.num_regions =3D 0;<br=
>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info.num_regions =3D vdev-=
&gt;num_regions;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info.num_irqs =3D 0;<=
br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return copy_to_user((=
void __user *)arg, &amp;info, minsz);<br>
&gt;<br>
&gt; - =C2=A0 =C2=A0 } else if (cmd =3D=3D VFIO_DEVICE_GET_REGION_INFO)<br>
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; + =C2=A0 =C2=A0 } else if (cmd =3D=3D VFIO_DEVICE_GET_REGION_INFO) {<b=
r>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vfio_region_info in=
fo;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 minsz =3D offsetofend(stru=
ct vfio_region_info, offset);<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (copy_from_user(&amp;in=
fo, (void __user *)arg, minsz))<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -EFAULT;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (info.argsz &lt; minsz)=
<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (info.index &gt;=3D vde=
v-&gt;num_regions)<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* map offset to the physi=
cal address =C2=A0*/<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info.offset =3D VFIO_PLATF=
ORM_INDEX_TO_OFFSET(info.index);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info.size =3D vdev-&gt;reg=
ion[info.index].size;<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info.flags =3D vdev-&gt;re=
gion[info.index].flags;<br>
&gt; +<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return copy_to_user((void =
__user *)arg, &amp;info, minsz);<br>
&gt;<br>
&gt; - =C2=A0 =C2=A0 else if (cmd =3D=3D VFIO_DEVICE_GET_IRQ_INFO)<br>
&gt; + =C2=A0 =C2=A0 } else if (cmd =3D=3D VFIO_DEVICE_GET_IRQ_INFO) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;<br>
&gt; - =C2=A0 =C2=A0 else if (cmd =3D=3D VFIO_DEVICE_SET_IRQS)<br>
&gt; + =C2=A0 =C2=A0 } else if (cmd =3D=3D VFIO_DEVICE_SET_IRQS)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 else if (cmd =3D=3D VFIO_DEVICE_RESET)<br>
&gt; diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/v=
fio/platform/vfio_platform_private.h<br>
&gt; index 4ae88f8..3448f918 100644<br>
&gt; --- a/drivers/vfio/platform/vfio_platform_private.h<br>
&gt; +++ b/drivers/vfio/platform/vfio_platform_private.h<br>
&gt; @@ -15,8 +15,25 @@<br>
&gt; =C2=A0#ifndef VFIO_PLATFORM_PRIVATE_H<br>
&gt; =C2=A0#define VFIO_PLATFORM_PRIVATE_H<br>
&gt;<br>
&gt; +#define VFIO_PLATFORM_OFFSET_SHIFT =C2=A0 40<br>
&gt; +#define VFIO_PLATFORM_OFFSET_MASK (((u64)(1) &lt;&lt; VFIO_PLATFORM_O=
FFSET_SHIFT) - 1)<br>
&gt; +<br>
&gt; +#define VFIO_PLATFORM_OFFSET_TO_INDEX(off) =C2=A0 \<br>
&gt; + =C2=A0 =C2=A0 (off &gt;&gt; VFIO_PLATFORM_OFFSET_SHIFT)<br>
&gt; +<br>
&gt; +#define VFIO_PLATFORM_INDEX_TO_OFFSET(index) \<br>
&gt; + =C2=A0 =C2=A0 ((u64)(index) &lt;&lt; VFIO_PLATFORM_OFFSET_SHIFT)<br>
&gt; +<br>
&gt; +struct vfio_platform_region {<br>
&gt; + =C2=A0 =C2=A0 u64 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 addr;<br>
&gt; + =C2=A0 =C2=A0 resource_size_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 size;<br>
&gt; + =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 flags;<br>
&gt; +};<br>
&gt; +<br>
&gt; =C2=A0struct vfio_platform_device {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 struct platform_device =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0*pdev;<br>
&gt; + =C2=A0 =C2=A0 struct vfio_platform_region =C2=A0 =C2=A0 *region;<br>
&gt; + =C2=A0 =C2=A0 u32 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_regions;<br>
&gt; =C2=A0};<br>
&gt;<br>
&gt; =C2=A0#endif /* VFIO_PLATFORM_PRIVATE_H */<br>
<br>
<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Antonios Mo=
takis<br>Virtual Open Systems
</div></div>

--047d7b86f7eab9e9a504f86da502--

--===============2881104422240603983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2881104422240603983==--
