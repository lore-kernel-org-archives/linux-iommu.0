From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/5] dt-bindings: mediatek: Add smi dts binding
Date: Tue, 14 Apr 2015 17:07:54 +0800
Message-ID: <1429002474.14855.7.camel@mhfsdcap03>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
	 <1425638900-24989-4-git-send-email-yong.wu@mediatek.com>
	 <20150306111338.GD8700@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150306111338.GD8700@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Mark,
    Thanks very much for review.=20
    About the clock name should be the PoV of _this_ device. Could you
help check below?

On Fri, 2015-03-06 at 11:13 +0000, Mark Rutland wrote:
> On Fri, Mar 06, 2015 at 10:48:18AM +0000, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >=20
> > This patch add smi binding document.
>=20
> Please move binding documents to the start of the series. It makes
> things far easier to review.
>=20
> >=20
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.t=
xt
> > @@ -0,0 +1,17 @@
> > +SMI hardware block diagram please help check <bindings/iommu/media=
tek,iommu.txt>
> > +
> > +Required properties:
> > +- compatible : must be "mediatek,mediatek,mt8173-smi-larb"
>=20
> Double vendor prefix?
>=20
> What does "larb" mean? It would be nice for the intorductory paragrap=
h
> in this file to explain.
>=20
> > +- reg : the register of each local arbiter
> > +- clocks : the clocks of each local arbiter
> > +- clock-name: larb_sub*(3 clockes at most)
>=20
> The names required _must_ be specified here, or clock-names is
> pointless.
>=20
> The clock names should be from the PoV of _this_ device (i.e. they
> should be the names of the inputs) not from the PoV of the provider
> (i.e. they should not be the names of the outputs from the provider).
>=20
> Mark.
>=20
     After we check with our SMI Designer. Every SMI local arbiter need
two clocks, which is called  APB clocks and SMI clock.
     APB clock : Advanced Peripheral Bus Clock. It is the clock for
setting the register of local arbiter.
     SMI clock : Smart Multimedia Interface Clock, It is the clock for
transfering the data and command.=20

     And all the local arbiters need the smi common clock, so we
separate it.=20

     Then I prepare to design the smi the dtsi like this:=20

      smi_common:smi@14022000 {
                 compatible =3D =E2=80=9Cmediate, mt8173-smi=E2=80=9D;
                 reg =3D <0 0x14022000 0 0x1000>;
                 clocks =3D <&mmsys MM_SMI_COMMON>;
                 clocks-names =3D =E2=80=9Csmi_common=E2=80=9D;
      };

      larb0: larb@14021000 {
                 compatible =3D =E2=80=9Cmediate, mt8173-smi-larb=E2=80=
=9D;
                 reg =3D <0 0x14021000 0 0x1000>;
                 smi =3D <&smi_common>;
                 clocks =3D <&mmsys MM_SMI_LARB0>,=20
		 	<&mmsys MM_SMI_LARB0>;
                 clocks-names =3D =E2=80=9Capb_clk=E2=80=9D, =E2=80=9Cs=
mi_clk=E2=80=9D;
     };

     larb1: larb@16010000 {
                 compatible =3D =E2=80=9Cmediate, mt8173-smi-larb=E2=80=
=9D;
                 reg =3D <0 0x16010000 0 0x1000>;
                 smi =3D <&smi_common>;
                 clocks =3D <&vdecsys VDEC_CKEN>,=20
			 <&mmsys VDEC_LARB_CKEN>;
                 clocks-names =3D =E2=80=9Capb_clk=E2=80=9D, =E2=80=9Cs=
mi_clk=E2=80=9D;
      };
      =E2=80=A6=20
     In some local arbiter, the source clock of the APB clock and the
SMI clock may be the same, like larb0. so the two clocks are the same.
And they may be different in other local arbiteres, like larb1.     =20

     If it is designed like this, is it ok?

> > +
> > +Example:
> > +	larb1:larb@16010000 {
> > +	        compatible =3D "mediatek,mt8173-smi-larb";
> > +		reg =3D <0 0x16010000 0 0x1000>;
> > +		clocks =3D <&mmsys MM_SMI_COMMON>,
> > +		        <&vdecsys VDEC_CKEN>,
> > +                        <&vdecsys VDEC_LARB_CKEN>;
> > +		clock-names =3D "larb_sub0", "larb_sub1", "larb_sub2";
> > +	};
> > --=20
> > 1.8.1.1.dirty
> >=20
> >=20


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
