From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH] iommu/exynos: add devices attached to the System MMU to
	an IOMMU group
Date: Tue, 23 Jul 2013 12:58:46 +0200
Message-ID: <CAG8rG2w4400F-b1k+qTX6V_OjN7YhVOVGAryDPgYcGGzfmu2ng@mail.gmail.com>
References: <1374573694-30595-1-git-send-email-a.motakis@virtualopensystems.com>
	<00d701ce878f$da099fe0$8e1cdfa0$%dae@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7177655437647970423=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <00d701ce878f$da099fe0$8e1cdfa0$%dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============7177655437647970423==
Content-Type: multipart/alternative; boundary=e89a8f83ac2b5439f104e22bad02

--e89a8f83ac2b5439f104e22bad02
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jul 23, 2013 at 12:31 PM, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

>
>
> > -----Original Message-----
> > From: linux-samsung-soc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-samsung-soc-
> > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Antonios Motakis
> > Sent: Tuesday, July 23, 2013 7:02 PM
> > To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> > linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org; Antonios Motakis; Cho KyongHo; Joerg
> > Roedel; Sachin Kamat; Jiri Kosina; Wei Yongjun; open list
> > Subject: [PATCH] iommu/exynos: add devices attached to the System MMU to
> > an IOMMU group
> >
> > IOMMU groups are expected by certain users of the IOMMU API,
> > e.g. VFIO. Since each device is behind its own System MMU, we
> > can allocate a new IOMMU group for each device.
> >
> > This patch depends on Cho KyongHo's patch series titled "[PATCH v7 00/12]
> > iommu/exynos: Fixes and Enhancements of System MMU driver with DT",
> > applied on a Linux 3.10.1 kernel. It has been tested on the Arndale
> board.
> >
> > Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> > ---
> >  drivers/iommu/exynos-iommu.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index 51d43bb..9f39eaa 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -1134,6 +1134,28 @@ static phys_addr_t
> exynos_iommu_iova_to_phys(struct
> > iommu_domain *domain,
> >       return phys;
> >  }
> >
> > +static int exynos_iommu_add_device(struct device *dev)
> > +{
> > +     struct iommu_group *group;
> > +     int ret;
> > +
> > +     group = iommu_group_alloc();
>
> Is that correct? I don't see why you allocate a group object every time
> add_device callback is called. That doesn't have any meaning we have to use
> iommu group feature. I think the implementation should be one more devices
> per a group. So I guess a given device object should be wrapped by higher
> device object than the given device object. For a good example, you can
> refer to intel-iommu.c file.
>

With an Intel IOMMU it can be the case that 2 devices have to share the
same IOMMU mappings (i.e. you can't program them separately). With the
Exynos System MMU, there is always one System MMU per device, so there is
nothing stopping you from programming any 2 devices' mappings differently.
So yes, the right thing to do here is to have a one to one relationship
between devices and IOMMU groups.


>
> Thanks,
> Inki Dae
>
> > +     if (IS_ERR(group)) {
> > +             dev_err(dev, "Failed to allocate IOMMU group\n");
> > +             return PTR_ERR(group);
> > +     }
> > +
> > +     ret = iommu_group_add_device(group, dev);
> > +     iommu_group_put(group);
> > +
> > +     return ret;
> > +}
> > +
> > +static void exynos_iommu_remove_device(struct device *dev)
> > +{
> > +     iommu_group_remove_device(dev);
> > +}
> > +
> >  static struct iommu_ops exynos_iommu_ops = {
> >       .domain_init = &exynos_iommu_domain_init,
> >       .domain_destroy = &exynos_iommu_domain_destroy,
> > @@ -1142,6 +1164,8 @@ static struct iommu_ops exynos_iommu_ops = {
> >       .map = &exynos_iommu_map,
> >       .unmap = &exynos_iommu_unmap,
> >       .iova_to_phys = &exynos_iommu_iova_to_phys,
> > +     .add_device     = exynos_iommu_add_device,
> > +     .remove_device  = exynos_iommu_remove_device,
> >       .pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
> >  };
> >
> > --
> > 1.8.1.2
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-samsung-
> > soc" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--e89a8f83ac2b5439f104e22bad02
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jul 23, 2013 at 12:31 PM, Inki Dae <span dir=3D"ltr">&lt;<a href=3D=
"mailto:inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt=
;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: <a href=3D"mailto:linux-samsung-soc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">linux=
-samsung-soc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a> [mailto:<a href=3D"mailto:linux-sams=
ung-soc-">linux-samsung-soc-</a><br>
&gt; <a href=3D"mailto:owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>] On=
 Behalf Of Antonios Motakis<br>
&gt; Sent: Tuesday, July 23, 2013 7:02 PM<br>
&gt; To: <a href=3D"mailto:linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org">linux-arm-=
kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org</a>;<br>
<a href=3D"mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org">iommu-cunTk1MwBs9QetFLy7KEm2CgeU+1il2p@public.gmane.org=
ation.org</a>;<br>
&gt; <a href=3D"mailto:linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">linux-samsung-soc=
@vger.kernel.org</a><br>
&gt; Cc: <a href=3D"mailto:kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org">kvmarm-FPEHb7Xf0XXQFizaE/u3fw@public.gmane.org=
lumbia.edu</a>; Antonios Motakis; Cho KyongHo; Joerg<br>
&gt; Roedel; Sachin Kamat; Jiri Kosina; Wei Yongjun; open list<br>
&gt; Subject: [PATCH] iommu/exynos: add devices attached to the System MMU =
to<br>
&gt; an IOMMU group<br>
<div class=3D"im">&gt;<br>
&gt; IOMMU groups are expected by certain users of the IOMMU API,<br>
&gt; e.g. VFIO. Since each device is behind its own System MMU, we<br>
&gt; can allocate a new IOMMU group for each device.<br>
&gt;<br>
&gt; This patch depends on Cho KyongHo&#39;s patch series titled &quot;[PAT=
CH v7 00/12]<br>
&gt; iommu/exynos: Fixes and Enhancements of System MMU driver with DT&quot=
;,<br>
&gt; applied on a Linux 3.10.1 kernel. It has been tested on the Arndale bo=
ard.<br>
&gt;<br>
&gt; Signed-off-by: Antonios Motakis &lt;<a href=3D"mailto:a.motakis@virtua=
lopensystems.com">a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/iommu/exynos-iommu.c | 24 ++++++++++++++++++++++++<br>
&gt; =A01 file changed, 24 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu=
.c<br>
&gt; index 51d43bb..9f39eaa 100644<br>
&gt; --- a/drivers/iommu/exynos-iommu.c<br>
&gt; +++ b/drivers/iommu/exynos-iommu.c<br>
&gt; @@ -1134,6 +1134,28 @@ static phys_addr_t exynos_iommu_iova_to_phys(st=
ruct<br>
&gt; iommu_domain *domain,<br>
&gt; =A0 =A0 =A0 return phys;<br>
&gt; =A0}<br>
&gt;<br>
&gt; +static int exynos_iommu_add_device(struct device *dev)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct iommu_group *group;<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 group =3D iommu_group_alloc();<br>
<br>
</div>Is that correct? I don&#39;t see why you allocate a group object ever=
y time<br>
add_device callback is called. That doesn&#39;t have any meaning we have to=
 use<br>
iommu group feature. I think the implementation should be one more devices<=
br>
per a group. So I guess a given device object should be wrapped by higher<b=
r>
device object than the given device object. For a good example, you can<br>
refer to intel-iommu.c file.<br></blockquote><div><br></div><div>With an In=
tel IOMMU it can be the case that 2 devices have to share the same IOMMU ma=
ppings (i.e. you can&#39;t program them separately). With the Exynos System=
 MMU, there is always one System MMU per device, so there is nothing stoppi=
ng you from programming any 2 devices&#39; mappings differently. So yes, th=
e right thing to do here is to have a one to one relationship between devic=
es and IOMMU groups.<br>
</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks,<br>
Inki Dae<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; + =A0 =A0 if (IS_ERR(group)) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, &quot;Failed to allocate IOMMU =
group\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(group);<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D iommu_group_add_device(group, dev);<br>
&gt; + =A0 =A0 iommu_group_put(group);<br>
&gt; +<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void exynos_iommu_remove_device(struct device *dev)<br>
&gt; +{<br>
&gt; + =A0 =A0 iommu_group_remove_device(dev);<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0static struct iommu_ops exynos_iommu_ops =3D {<br>
&gt; =A0 =A0 =A0 .domain_init =3D &amp;exynos_iommu_domain_init,<br>
&gt; =A0 =A0 =A0 .domain_destroy =3D &amp;exynos_iommu_domain_destroy,<br>
&gt; @@ -1142,6 +1164,8 @@ static struct iommu_ops exynos_iommu_ops =3D {<b=
r>
&gt; =A0 =A0 =A0 .map =3D &amp;exynos_iommu_map,<br>
&gt; =A0 =A0 =A0 .unmap =3D &amp;exynos_iommu_unmap,<br>
&gt; =A0 =A0 =A0 .iova_to_phys =3D &amp;exynos_iommu_iova_to_phys,<br>
&gt; + =A0 =A0 .add_device =A0 =A0 =3D exynos_iommu_add_device,<br>
&gt; + =A0 =A0 .remove_device =A0=3D exynos_iommu_remove_device,<br>
&gt; =A0 =A0 =A0 .pgsize_bitmap =3D SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,<br=
>
&gt; =A0};<br>
&gt;<br>
&gt; --<br>
&gt; 1.8.1.2<br>
&gt;<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-s=
amsung-<br>
&gt; soc&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">=
majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-=
info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a>=
<br>
<br>
</font></span></blockquote></div><br></div></div>

--e89a8f83ac2b5439f104e22bad02--

--===============7177655437647970423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7177655437647970423==--
