From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/6] iommu/tegra124: smmu: support more than 32 bit pa
Date: Wed, 8 Jan 2014 14:45:51 +0100
Message-ID: <20140108134550.GF1592@ulmo.nvidia.com>
References: <1386246319-17851-1-git-send-email-hdoyu@nvidia.com>
 <1386246319-17851-5-git-send-email-hdoyu@nvidia.com>
 <52CB8FD1.4070306@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52CB8FD1.4070306-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Zhang <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, Pavan Kunapuli <pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 01:25:37PM +0800, Mark Zhang wrote:
> On 12/05/2013 08:25 PM, Hiroshi Doyu wrote:
[...]
> > @@ -526,6 +530,21 @@ static int smmu_setup_regs(struct smmu_device *smm=
u)
> >  	return 0;
> >  }
> > =20
> > +static void flush_ptc_by_addr(struct smmu_device *smmu, unsigned long =
*pte,
> > +			      struct page *page)
> > +{
> > +	u32 val;
> > +
> > +	val =3D VA_PAGE_TO_PA_HI(pte, page);
> > +	if (val)
> > +		smmu_write(smmu, val, SMMU_PTC_FLUSH_1);
> > +
>=20
> This is not correct, according to my tests. We should write
> "SMMU_PTC_FLUSH_1" even when the "val" is zero.
>=20
> So I just copied Pavan's original work here, after applied this, the
> SMMU works correctly:
>=20
> -       val =3D VA_PAGE_TO_PA_HI(pte, page);
> -       if (val)
> +       if (!pte) {
> +               smmu_write(smmu, SMMU_PTC_FLUSH_TYPE_ALL, SMMU_PTC_FLUSH);
> +               return;
> +       }
> +
> +       if (of_machine_is_compatible("nvidia,tegra124")) {

This check should be replaced by some flag so we don't have to compare
strings every time the PTC is flushed.

Thierry

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzVaOAAoJEN0jrNd/PrOhyo4QALurMiStL2TTXVuXtJJiJByV
FSTk5i4e/yiXRHxxB5uVVlSJSPCYPO2e8o9Emhuvmy0es6YWwedSWKJ5oBZE1Nc2
y+0+ebq6Q9NoAYjmXNhriDjW8ausTGdiye1o7+HH7zhn2SbWJYHIQop1Vuai1wp6
RJvZGX32nwAsNOi2n42f8x/GlP6qaFxVCxnRRRnQnypqkegWbU3CpoiKFfbgidzg
/QklZqb2baNoIW18Ex6TduHzb3KtIHKxQt9Oq7SyM5+1I1lW2jEGYjMr8idM92De
omMgZssdMIpUAbCoqL0XWfD+Woq4p/hDK35jaI8bELX75IxQnEozP1EN2T89ZXTB
dXuF4+WDT+o/vhYPrBRFaxl7F0xJP8irFXEoBoRSoejBI1mJHKvCq1qVjbTXNuiR
lJy7a1N+o4pvU7GBTjR85Wh1FJRlUFYxUdxwMM6Ixqqpcz+JrgEU+NeaCehyW4xE
b/Q+uWikwkurNGvb9IqeM/XbC+5VUjmgytVck3+ga/8YTVgfbb3MuS5cHfnFzjYh
UnSiuzfj7LQVPw9Q/YJeEoAdqjiY8s1yv1+OdFbFNUVLRdnlkJz33yI1rzkfrMf2
rQngnYGT63D+++lkAGqOaOBZb8fTP0DHska60xIRqgB/e4QjURYNg52RHW42GwXO
6xJNzs/ZtxdAGsyNgDZf
=yIPB
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
