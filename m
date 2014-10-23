From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/3] Rockchip IOMMU driver and devicetree bindings
Date: Fri, 24 Oct 2014 00:11:06 +0800
Message-ID: <CAGS+omB+si1J-gjyvyjJF0x=QBTyPyNKbqyV0QM=sKNo9zecDw@mail.gmail.com>
References: <1412158843-8115-1-git-send-email-djkurtz@chromium.org>
	<20141022152019.GK10074@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4416192821699340330=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20141022152019.GK10074-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Simon Xue <xxm-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============4416192821699340330==
Content-Type: multipart/alternative; boundary=90e6ba6e8ca4037b7e0506195132

--90e6ba6e8ca4037b7e0506195132
Content-Type: text/plain; charset=UTF-8

On Wed, Oct 22, 2014 at 11:20 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Wed, Oct 01, 2014 at 06:20:40PM +0800, Daniel Kurtz wrote:
> > Add a driver and devicetree bindings for the IOMMU found in Rockchip
> RK3288
> > SoCs.
> >
> > Daniel Kurtz (3):
> >   iommu/rockchip: rk3288 iommu driver
> >   dt-bindings: iommu: Add documentation for rockchip iommu
> >   ARM: dts: rk3288: add VOP iommu nodes
> >
> >  .../devicetree/bindings/iommu/rockchip,iommu.txt   |  26 +
> >  arch/arm/boot/dts/rk3288.dtsi                      |  18 +
> >  drivers/iommu/Kconfig                              |  11 +
> >  drivers/iommu/Makefile                             |   1 +
> >  drivers/iommu/rockchip-iommu.c                     | 924
> +++++++++++++++++++++
> >  5 files changed, 980 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> >  create mode 100644 drivers/iommu/rockchip-iommu.c
>
> Please make sure you also get Acks for the DT bindings. With that and
> the issue I mentioned in the other email fixed, I will apply these
> patches?
>

Hi Joerg,

Thanks for your reviews.
Can you help me get these DT bindings Acked?
AFAICT, the DT maintainers are CC'ed on this patch, I'm not sure what else
to do.

Thanks,
-Daniel


>
>
>         Joerg
>
>

--90e6ba6e8ca4037b7e0506195132
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Oct 22, 2014 at 11:20 PM, Joerg Roedel <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" target=3D"_blank">joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div =
class=3D"h5">On Wed, Oct 01, 2014 at 06:20:40PM +0800, Daniel Kurtz wrote:<=
br>
&gt; Add a driver and devicetree bindings for the IOMMU found in Rockchip R=
K3288<br>
&gt; SoCs.<br>
&gt;<br>
&gt; Daniel Kurtz (3):<br>
&gt;=C2=A0 =C2=A0iommu/rockchip: rk3288 iommu driver<br>
&gt;=C2=A0 =C2=A0dt-bindings: iommu: Add documentation for rockchip iommu<b=
r>
&gt;=C2=A0 =C2=A0ARM: dts: rk3288: add VOP iommu nodes<br>
&gt;<br>
&gt;=C2=A0 .../devicetree/bindings/iommu/rockchip,iommu.txt=C2=A0 =C2=A0|=
=C2=A0 26 +<br>
&gt;=C2=A0 arch/arm/boot/dts/rk3288.dtsi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +<br>
&gt;=C2=A0 drivers/iommu/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +=
<br>
&gt;=C2=A0 drivers/iommu/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
&gt;=C2=A0 drivers/iommu/rockchip-iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 924 +++++++++++++++++++++<br>
&gt;=C2=A0 5 files changed, 980 insertions(+)<br>
&gt;=C2=A0 create mode 100644 Documentation/devicetree/bindings/iommu/rockc=
hip,iommu.txt<br>
&gt;=C2=A0 create mode 100644 drivers/iommu/rockchip-iommu.c<br>
<br>
</div></div>Please make sure you also get Acks for the DT bindings. With th=
at and<br>
the issue I mentioned in the other email fixed, I will apply these<br>
patches?<br></blockquote><div><br></div><div>Hi Joerg,</div><div><br></div>=
<div>Thanks for your reviews.</div><div>Can you help me get these DT bindin=
gs Acked?</div><div>AFAICT, the DT maintainers are CC&#39;ed on this patch,=
 I&#39;m not sure what else to do.</div><div><br></div><div>Thanks,</div><d=
iv>-Daniel</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Joerg<br>
<br>
</font></span></blockquote></div><br></div></div>

--90e6ba6e8ca4037b7e0506195132--

--===============4416192821699340330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4416192821699340330==--
