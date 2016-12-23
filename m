From: Geetha Akula <geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC v4 15/16] vfio/type1: Check MSI remapping at irq domain level
Date: Fri, 23 Dec 2016 19:03:47 +0530
Message-ID: <CANHdaibH3GCFhM4nXh1KJoFhZCodtWo7KfP7AcSoVD0HwjDWfg@mail.gmail.com>
References: <1481661034-3088-1-git-send-email-eric.auger@redhat.com>
	<1481661034-3088-16-git-send-email-eric.auger@redhat.com>
	<HE1PR04MB13219CC90CE2BBE62356D94CFF920@HE1PR04MB1321.eurprd04.prod.outlook.com>
	<3ead0cc1-7798-3e39-da56-c18a5989c00c@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1863778894454842344=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3ead0cc1-7798-3e39-da56-c18a5989c00c-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org" <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "punit.agrawal-5wv7dgnIgG8@public.gmane.org" <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============1863778894454842344==
Content-Type: multipart/alternative; boundary=94eb2c18f22a9564570544536fdf

--94eb2c18f22a9564570544536fdf
Content-Type: text/plain; charset=UTF-8

Hi Eric,

Seeing same issue reported by Diana on ThunderX with you v4.9-reserved-v4
branch.
Vfio passthough work fine when allow_unsafe_interrupts is set.


Thank you,
Geetha.

On Thu, Dec 22, 2016 at 6:32 PM, Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Hi Diana,
>
> On 22/12/2016 13:41, Diana Madalina Craciun wrote:
> > Hi Eric,
> >
> > On 12/13/2016 10:32 PM, Eric Auger wrote:
> >> In case the IOMMU does not bypass MSI transactions (typical
> >> case on ARM), we check all MSI controllers are IRQ remapping
> >> capable. If not the IRQ assignment may be unsafe.
> >>
> >> At this stage the arm-smmu-(v3) still advertise the
> >> IOMMU_CAP_INTR_REMAP capability at IOMMU level. This will be
> >> removed in subsequent patches.
> >>
> >> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >> ---
> >>  drivers/vfio/vfio_iommu_type1.c | 9 ++++++---
> >>  1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_
> type1.c
> >> index d07fe73..a05648b 100644
> >> --- a/drivers/vfio/vfio_iommu_type1.c
> >> +++ b/drivers/vfio/vfio_iommu_type1.c
> >> @@ -37,6 +37,7 @@
> >>  #include <linux/vfio.h>
> >>  #include <linux/workqueue.h>
> >>  #include <linux/dma-iommu.h>
> >> +#include <linux/irqdomain.h>
> >>
> >>  #define DRIVER_VERSION  "0.2"
> >>  #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>"
> >> @@ -765,7 +766,7 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >>      struct vfio_domain *domain, *d;
> >>      struct bus_type *bus = NULL;
> >>      int ret;
> >> -    bool resv_msi;
> >> +    bool resv_msi, msi_remap;
> >>      phys_addr_t resv_msi_base;
> >>
> >>      mutex_lock(&iommu->lock);
> >> @@ -818,8 +819,10 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >>      INIT_LIST_HEAD(&domain->group_list);
> >>      list_add(&group->next, &domain->group_list);
> >>
> >> -    if (!allow_unsafe_interrupts &&
> >> -        !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
> >> +    msi_remap = resv_msi ? irq_domain_check_msi_remap() :
> >> +                           iommu_capable(bus, IOMMU_CAP_INTR_REMAP);
> >> +
> >> +    if (!allow_unsafe_interrupts && !msi_remap) {
> >>              pr_warn("%s: No interrupt remapping support.  Use the
> module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on
> this platform\n",
> >>                     __func__);
> >>              ret = -EPERM;
> >
> > I tested your v4.9-reserved-v4 branch on a ITS capable hardware (NXP
> > LS2080), so I did not set allow_unsafe_interrupts. It fails here
> > complaining that the there is no interrupt remapping support. The
> > irq_domain_check_msi_remap function returns false as none of the checked
> > domains has the IRQ_DOMAIN_FLAG_MSI_REMAP flag set. I think the reason
> > is that the flags are not propagated through the domain hierarchy when
> > the domain is created.
>
> Hum OK. Please apologize for the inconvenience, all the more so this is
> the second time you report the same issue for different cause :-( At the
> moment I can't test on a GICv3 ITS based system. I will try to fix that
> though.
>
> I would like to get the confirmation introducing this flag is the right
> direction though.
>
> Thanks
>
> Eric
> >
> > Thanks,
> >
> > Diana
> >
> >
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

--94eb2c18f22a9564570544536fdf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi Eric,<br><br></div>Seeing same issu=
e reported by Diana on ThunderX with you v4.9-reserved-v4 branch. <br></div=
>Vfio passthough work fine when allow_unsafe_interrupts is set.<br><br><br>=
</div>Thank you,<br></div>Geetha.<br></div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On Thu, Dec 22, 2016 at 6:32 PM, Auger Eric <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank"=
>eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">Hi Diana,<br>
<div><div class=3D"h5"><br>
On 22/12/2016 13:41, Diana Madalina Craciun wrote:<br>
&gt; Hi Eric,<br>
&gt;<br>
&gt; On 12/13/2016 10:32 PM, Eric Auger wrote:<br>
&gt;&gt; In case the IOMMU does not bypass MSI transactions (typical<br>
&gt;&gt; case on ARM), we check all MSI controllers are IRQ remapping<br>
&gt;&gt; capable. If not the IRQ assignment may be unsafe.<br>
&gt;&gt;<br>
&gt;&gt; At this stage the arm-smmu-(v3) still advertise the<br>
&gt;&gt; IOMMU_CAP_INTR_REMAP capability at IOMMU level. This will be<br>
&gt;&gt; removed in subsequent patches.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Eric Auger &lt;<a href=3D"mailto:eric.auger@redhat.=
com">eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 drivers/vfio/vfio_iommu_type1.<wbr>c | 9 ++++++---<br>
&gt;&gt;=C2=A0 1 file changed, 6 insertions(+), 3 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/vfio/vfio_iommu_<wbr>type1.c b/drivers/vfio/v=
fio_iommu_<wbr>type1.c<br>
&gt;&gt; index d07fe73..a05648b 100644<br>
&gt;&gt; --- a/drivers/vfio/vfio_iommu_<wbr>type1.c<br>
&gt;&gt; +++ b/drivers/vfio/vfio_iommu_<wbr>type1.c<br>
&gt;&gt; @@ -37,6 +37,7 @@<br>
&gt;&gt;=C2=A0 #include &lt;linux/vfio.h&gt;<br>
&gt;&gt;=C2=A0 #include &lt;linux/workqueue.h&gt;<br>
&gt;&gt;=C2=A0 #include &lt;linux/dma-iommu.h&gt;<br>
&gt;&gt; +#include &lt;linux/irqdomain.h&gt;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 #define DRIVER_VERSION=C2=A0 &quot;0.2&quot;<br>
&gt;&gt;=C2=A0 #define DRIVER_AUTHOR=C2=A0 =C2=A0&quot;Alex Williamson &lt;=
<a href=3D"mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org">alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a=
>&gt;&quot;<br>
&gt;&gt; @@ -765,7 +766,7 @@ static int vfio_iommu_type1_attach_group(<wbr>=
void *iommu_data,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 struct vfio_domain *domain, *d;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 struct bus_type *bus =3D NULL;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt;&gt; -=C2=A0 =C2=A0 bool resv_msi;<br>
&gt;&gt; +=C2=A0 =C2=A0 bool resv_msi, msi_remap;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 phys_addr_t resv_msi_base;<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;iommu-&gt;lock);<br>
&gt;&gt; @@ -818,8 +819,10 @@ static int vfio_iommu_type1_attach_group(<wbr=
>void *iommu_data,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&amp;domain-&gt;group_<wbr>list=
);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 list_add(&amp;group-&gt;next, &amp;domain-&gt;=
group_list);<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 if (!allow_unsafe_interrupts &amp;&amp;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 !iommu_capable(bus, IOMMU_CAP_INTR_RE=
MAP)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 msi_remap =3D resv_msi ? irq_domain_check_msi_remap=
() :<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_capable(bus, IOMMU_CAP_INTR_REMAP);=
<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 if (!allow_unsafe_interrupts &amp;&amp; !msi_remap)=
 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warn(&quot;%s: =
No interrupt remapping support.=C2=A0 Use the module param \&quot;allow_uns=
afe_interrupts\&quot; to enable VFIO IOMMU support on this platform\n&quot;=
,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0__func__);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D -EPERM;<br=
>
&gt;<br>
&gt; I tested your v4.9-reserved-v4 branch on a ITS capable hardware (NXP<b=
r>
&gt; LS2080), so I did not set allow_unsafe_interrupts. It fails here<br>
&gt; complaining that the there is no interrupt remapping support. The<br>
&gt; irq_domain_check_msi_remap function returns false as none of the check=
ed<br>
&gt; domains has the IRQ_DOMAIN_FLAG_MSI_REMAP flag set. I think the reason=
<br>
&gt; is that the flags are not propagated through the domain hierarchy when=
<br>
&gt; the domain is created.<br>
<br>
</div></div>Hum OK. Please apologize for the inconvenience, all the more so=
 this is<br>
the second time you report the same issue for different cause :-( At the<br=
>
moment I can&#39;t test on a GICv3 ITS based system. I will try to fix that=
<br>
though.<br>
<br>
I would like to get the confirmation introducing this flag is the right<br>
direction though.<br>
<br>
Thanks<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Eric<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Diana<br>
&gt;<br>
&gt;<br>
&gt;<br>
<br>
______________________________<wbr>_________________<br>
linux-arm-kernel mailing list<br>
<a href=3D"mailto:linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org">linux-arm-kernel@li=
sts.<wbr>infradead.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kernel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.infradead.org/<wbr>mailman/=
listinfo/linux-arm-<wbr>kernel</a><br>
</div></div></blockquote></div><br></div>

--94eb2c18f22a9564570544536fdf--

--===============1863778894454842344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1863778894454842344==--
