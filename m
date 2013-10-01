From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH 6/7] VFIO: Update documentation for VFIO_IOMMU_TYPE1 driver
Date: Tue, 1 Oct 2013 11:35:25 +0200
Message-ID: <CAG8rG2wpNXDMK-k5k=eQkF=THSqobxf2tftvLheqXafM9HqTSg@mail.gmail.com>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-7-git-send-email-a.motakis@virtualopensystems.com>
	<1380562766.2674.176.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7433667442348745643=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380562766.2674.176.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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

--===============7433667442348745643==
Content-Type: multipart/alternative; boundary=047d7b10cfc52d5b9404e7aaac01

--047d7b10cfc52d5b9404e7aaac01
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Sep 30, 2013 at 7:39 PM, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> wrote:

> On Mon, 2013-09-30 at 17:28 +0200, Antonios Motakis wrote:
> > The VFIO documentation is slightly out of date. This minor correction
> > replaces references to VFIO_IOMMU_X86 with the correct reference to
> > VFIO_IOMMU_TYPE1
> >
> > Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> > ---
> >  Documentation/vfio.txt | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> > index 8eda363..b4eafa6 100644
> > --- a/Documentation/vfio.txt
> > +++ b/Documentation/vfio.txt
> > @@ -167,8 +167,8 @@ group and can access them as follows:
> >       int container, group, device, i;
> >       struct vfio_group_status group_status =
> >                                       { .argsz = sizeof(group_status) };
> > -     struct vfio_iommu_x86_info iommu_info = { .argsz =
> sizeof(iommu_info) };
> > -     struct vfio_iommu_x86_dma_map dma_map = { .argsz = sizeof(dma_map)
> };
> > +     struct vfio_iommu_type1_info iommu_info = { .argsz =
> sizeof(iommu_info) };
> > +     struct vfio_iommu_type1_dma_map dma_map = { .argsz =
> sizeof(dma_map) };
> >       struct vfio_device_info device_info = { .argsz =
> sizeof(device_info) };
> >
> >       /* Create a new container */
> > @@ -177,7 +177,7 @@ group and can access them as follows:
> >       if (ioctl(container, VFIO_GET_API_VERSION) != VFIO_API_VERSION)
> >               /* Unknown API version */
> >
> > -     if (!ioctl(container, VFIO_CHECK_EXTENSION, VFIO_X86_IOMMU))
> > +     if (!ioctl(container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU))
> >               /* Doesn't support the IOMMU driver we want. */
> >
> >       /* Open the group */
> > @@ -193,7 +193,7 @@ group and can access them as follows:
> >       ioctl(group, VFIO_GROUP_SET_CONTAINER, &container);
> >
> >       /* Enable the IOMMU model we want */
> > -     ioctl(container, VFIO_SET_IOMMU, VFIO_X86_IOMMU)
> > +     ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU)
> >
> >       /* Get addition IOMMU info */
> >       ioctl(container, VFIO_IOMMU_GET_INFO, &iommu_info);
>
>
> Your tree seems out of date, we've already got these:
>
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/Documentation/vfio.txt?id=dac09b57c0ff57e55dd6fa5109076c8af0468a75
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/Documentation/vfio.txt?id=b0e59b85abd42f8a525ff032d5063457e1378808
>
>
And I was wondering what was up with that. Acknowledged, thanks!

--047d7b10cfc52d5b9404e7aaac01
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Mon, Sep 30, 2013 at 7:39 PM, Alex Williamson <span dir=3D"ltr">=
&lt;<a href=3D"mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">alex.wi=
lliamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On M=
on, 2013-09-30 at 17:28 +0200, Antonios Motakis wrote:<br>
&gt; The VFIO documentation is slightly out of date. This minor correction<=
br>
&gt; replaces references to VFIO_IOMMU_X86 with the correct reference to<br=
>
&gt; VFIO_IOMMU_TYPE1<br>
&gt;<br>
&gt; Signed-off-by: Antonios Motakis &lt;<a href=3D"mailto:a.motakis@virtua=
lopensystems.com">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0Documentation/vfio.txt | 8 ++++----<br>
&gt; =A01 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt<br>
&gt; index 8eda363..b4eafa6 100644<br>
&gt; --- a/Documentation/vfio.txt<br>
&gt; +++ b/Documentation/vfio.txt<br>
&gt; @@ -167,8 +167,8 @@ group and can access them as follows:<br>
&gt; =A0 =A0 =A0 int container, group, device, i;<br>
&gt; =A0 =A0 =A0 struct vfio_group_status group_status =3D<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 { .argsz =3D sizeof(group_status) };<br>
&gt; - =A0 =A0 struct vfio_iommu_x86_info iommu_info =3D { .argsz =3D sizeo=
f(iommu_info) };<br>
&gt; - =A0 =A0 struct vfio_iommu_x86_dma_map dma_map =3D { .argsz =3D sizeo=
f(dma_map) };<br>
&gt; + =A0 =A0 struct vfio_iommu_type1_info iommu_info =3D { .argsz =3D siz=
eof(iommu_info) };<br>
&gt; + =A0 =A0 struct vfio_iommu_type1_dma_map dma_map =3D { .argsz =3D siz=
eof(dma_map) };<br>
&gt; =A0 =A0 =A0 struct vfio_device_info device_info =3D { .argsz =3D sizeo=
f(device_info) };<br>
&gt;<br>
&gt; =A0 =A0 =A0 /* Create a new container */<br>
&gt; @@ -177,7 +177,7 @@ group and can access them as follows:<br>
&gt; =A0 =A0 =A0 if (ioctl(container, VFIO_GET_API_VERSION) !=3D VFIO_API_V=
ERSION)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Unknown API version */<br>
&gt;<br>
&gt; - =A0 =A0 if (!ioctl(container, VFIO_CHECK_EXTENSION, VFIO_X86_IOMMU))=
<br>
&gt; + =A0 =A0 if (!ioctl(container, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU=
))<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Doesn&#39;t support the IOMMU driver we=
 want. */<br>
&gt;<br>
&gt; =A0 =A0 =A0 /* Open the group */<br>
&gt; @@ -193,7 +193,7 @@ group and can access them as follows:<br>
&gt; =A0 =A0 =A0 ioctl(group, VFIO_GROUP_SET_CONTAINER, &amp;container);<br=
>
&gt;<br>
&gt; =A0 =A0 =A0 /* Enable the IOMMU model we want */<br>
&gt; - =A0 =A0 ioctl(container, VFIO_SET_IOMMU, VFIO_X86_IOMMU)<br>
&gt; + =A0 =A0 ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU)<br>
&gt;<br>
&gt; =A0 =A0 =A0 /* Get addition IOMMU info */<br>
&gt; =A0 =A0 =A0 ioctl(container, VFIO_IOMMU_GET_INFO, &amp;iommu_info);<br=
>
<br>
<br>
</div></div>Your tree seems out of date, we&#39;ve already got these:<br>
<br>
<a href=3D"https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/=
commit/Documentation/vfio.txt?id=3Ddac09b57c0ff57e55dd6fa5109076c8af0468a75=
" target=3D"_blank">https://git.kernel.org/cgit/linux/kernel/git/torvalds/l=
inux.git/commit/Documentation/vfio.txt?id=3Ddac09b57c0ff57e55dd6fa5109076c8=
af0468a75</a><br>

<a href=3D"https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/=
commit/Documentation/vfio.txt?id=3Db0e59b85abd42f8a525ff032d5063457e1378808=
" target=3D"_blank">https://git.kernel.org/cgit/linux/kernel/git/torvalds/l=
inux.git/commit/Documentation/vfio.txt?id=3Db0e59b85abd42f8a525ff032d506345=
7e1378808</a><br>

<br>
</blockquote></div><br></div><div class=3D"gmail_extra">And I was wondering=
 what was up with that. Acknowledged, thanks!<br></div></div>

--047d7b10cfc52d5b9404e7aaac01--

--===============7433667442348745643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7433667442348745643==--
