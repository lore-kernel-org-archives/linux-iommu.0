From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/5] dt-bindings: mediatek: Add smi dts binding
Date: Tue, 14 Apr 2015 14:56:47 +0100
Message-ID: <20150414135647.GG28709@leverpostej>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-4-git-send-email-yong.wu@mediatek.com>
 <20150306111338.GD8700@leverpostej>
 <1429002474.14855.7.camel@mhfsdcap03>
 <20150414100657.GB28709@leverpostej>
 <1429019389.16264.5.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429019389.16264.5.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <Robin.Murphy@arm.com>, Will Deacon <Will.Deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Sasha Hauer <kernel@pengutronix.de>, "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

> > >       smi_common:smi@14022000 {
> > >                  compatible =3D =E2=80=9Cmediate, mt8173-smi=E2=80=
=9D;
> > >                  reg =3D <0 0x14022000 0 0x1000>;
> > >                  clocks =3D <&mmsys MM_SMI_COMMON>;
> > >                  clocks-names =3D =E2=80=9Csmi_common=E2=80=9D;
> > >       };
> > >=20
> > >       larb0: larb@14021000 {
> > >                  compatible =3D =E2=80=9Cmediate, mt8173-smi-larb=
=E2=80=9D;
> > >                  reg =3D <0 0x14021000 0 0x1000>;
> > >                  smi =3D <&smi_common>;
> > >                  clocks =3D <&mmsys MM_SMI_LARB0>,=20
> > > 		 	<&mmsys MM_SMI_LARB0>;
> > >                  clocks-names =3D =E2=80=9Capb_clk=E2=80=9D, =E2=80=
=9Csmi_clk=E2=80=9D;
> > >      };
> > >=20
> > >      larb1: larb@16010000 {
> > >                  compatible =3D =E2=80=9Cmediate, mt8173-smi-larb=
=E2=80=9D;
> > >                  reg =3D <0 0x16010000 0 0x1000>;
> > >                  smi =3D <&smi_common>;
> > >                  clocks =3D <&vdecsys VDEC_CKEN>,=20
> > > 			 <&mmsys VDEC_LARB_CKEN>;
> > >                  clocks-names =3D =E2=80=9Capb_clk=E2=80=9D, =E2=80=
=9Csmi_clk=E2=80=9D;
> > >       };
> > >       =E2=80=A6=20
> > >      In some local arbiter, the source clock of the APB clock and=
 the
> > > SMI clock may be the same, like larb0. so the two clocks are the =
same.
> > > And they may be different in other local arbiteres, like larb1.  =
   =20
> > >=20
> > >      If it is designed like this, is it ok?
> >=20
> > That looks pretty good; the clocks and names on the larb nodes seem
> > sensible.
> >=20
> > The naming of the "smi_common" clock on the smi_common node looks a=
 bit
> > odd though. Is that really what the clock input is called?
> >=20
> > Mark.
>      After check with DE, the smi_common clock also have its APB cloc=
k
> and the smi clock(they have the same clock source).
>     And I prepare to delete "_clk" in all the clock-names.
>     So it may be like this:
>          smi_common:smi@14022000 {
>                  compatible =3D =E2=80=9Cmediate, mt8173-smi=E2=80=9D=
;
>                     reg =3D <0 0x14022000 0 0x1000>;
>                   clocks =3D <&mmsys MM_SMI_COMMON>,=20
> 			   <&mmsys MM_SMI_COMMON>;
>                   clocks-names =3D =E2=80=9Capk=E2=80=9D,"smi";
>         };
>      How about this?

That looks fine to me. I assume "apk" should be "apb" in the last
example.

Mark.
