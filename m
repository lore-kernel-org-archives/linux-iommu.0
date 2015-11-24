From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 0/6] MT8173 IOMMU SUPPORT
Date: Tue, 24 Nov 2015 11:38:21 +0100
Message-ID: <20151124103819.GE17658@ulmo.nvidia.com>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
 <20151014125620.GQ27420@8bytes.org>
 <1445488802.27202.67.camel@mhfsdcap03>
 <20151023092636.GX27420@8bytes.org>
 <1448344693.13079.6.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448344693.13079.6.camel@mhfsdcap03>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2015 at 01:58:13PM +0800, Yong Wu wrote:
> On Fri, 2015-10-23 at 11:26 +0200, Joerg Roedel wrote:
> > On Thu, Oct 22, 2015 at 12:40:02PM +0800, Yong Wu wrote:
> > >      But the mtk-iommu depend on the drivers/memory/mtk-smi.c(mtk-iom=
mu
> > > has called a function of the mtk-smi).
> > >      So if there is dependence here, How should we do to merge them?
> >=20
> > I can surely merge mtk-smi too, if it gets proper Reviewed-by and
> > Acked-by tags from the maintainer(s).
> >=20
> >=20
> > 	Joerg
> >=20
> Hi Joerg,
>=20
>    About the driver/memory/, We don't know who is his maintainer.
> MAINTAINERS file don't have drivers/memory maintainer.
> From the history in drivers/memory/ it looks like most of the
> drivers land with an ack from the architecture maintainer.
> And Matthias Brugger is our "ARM/Mediatek SoC support" maintainer.
>=20
> Then do you mean that we need Matthias's ACK or whom others?

Yes, I think the sub-architecture maintainer's ACK is probably going to
be as good as it gets. Historically drivers/memory hasn't had enough of
a common ground to instate a framework.

Thierry

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWVD4bAAoJEN0jrNd/PrOhBwoQAJGexJ6rJpgdiD9zXboXiLXA
fLx/1lLSKXdRUI4ydNnPiIn+AI/ZY+zZZPyt5PGu7f0JopfKj+cg93laYyHkTpJ4
YBIICNEnbgWEy1nETxovQj1sa662y8eR+CV/18eXDGAz4h2lNo51lVQG8N2RlIA3
xgPvzpfpAVHPliGxVS7YI87sVq2bs3JPqnWD4+ja52nuTjSuDAL1Ch+P8KcwbiW+
k6TPbEZ6qOWVnoImfpaDped7m924r4s+iw33wMAfHN8WjnPqtqdO1SmiEt+c9geW
rrT7QF4FH7We7heYiRK8lgb4wZH9td6e1tv4r/iuiWrlyOOzuSwag94RTkakB2sx
BkTwN+TnQ+b6ofycpJGZNVsSRTaTQeHfa7dFkt8E0BlzdTqgYMGAN6EYg6up/uxg
nDnq3WxiwvgJF1tsa+1DPmUf/IPp9YRx3BtGmhQrGAgiP4suT0ZXUwMp0iH+SUvi
VINzMZwa0K172iTZQYD6HMkNTdczqvLiuHNyPjJj/yyIJnPeM+k6Q8lTxrgAh5K6
aOl2oicQeiATbpwF2wY4J2l9L5Lw78+BN17w/zoNZuCU8ESsU0QdCZw3/bPzSJv2
w6w66VNemFB6Vnks8rZj1d4sVcgatNbMiHuDj3ajIetKo7/mjvETgGSnyqBnuUYL
dydJyvIuQVZUflXlejxm
=+/cW
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
