From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH -next] iommu/tegra-smmu: Fix return value check in
 tegra_smmu_group_get()
Date: Wed, 20 Dec 2017 18:41:46 +0100
Message-ID: <20171220174146.GA8780@ulmo>
References: <1513739169-122341-1-git-send-email-weiyongjun1@huawei.com>
 <20171220094400.5b95004f@t450s.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171220094400.5b95004f-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 09:44:00AM -0700, Alex Williamson wrote:
> On Wed, 20 Dec 2017 03:06:09 +0000
> Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
>=20
> > In case of error, the function iommu_group_alloc() returns ERR_PTR() and
> > never returns NULL. The NULL test in the return value check should be
> > replaced with IS_ERR().
> >=20
> > Fixes: 7f4c9176f760 ("iommu/tegra: Allow devices to be grouped")
> > Signed-off-by: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/tegra-smmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > index 8885635..44d40bc 100644
> > --- a/drivers/iommu/tegra-smmu.c
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -832,7 +832,7 @@ static struct iommu_group *tegra_smmu_group_get(str=
uct tegra_smmu *smmu,
> >  	group->soc =3D soc;
> > =20
> >  	group->group =3D iommu_group_alloc();
> > -	if (!group->group) {
> > +	if (IS_ERR(group->group)) {
> >  		devm_kfree(smmu->dev, group);
> >  		mutex_unlock(&smmu->lock);
> >  		return NULL;
>=20
> Acked-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>=20
> Thierry, I assume you'll add this on top of the referenced commit.
> Thanks,

Applied, thanks.

Thierry

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlo6oNcACgkQ3SOs138+
s6ED0w/+MWy9kjp+SsCsfbKGhGP9b4LQ35HhruR2ZLTtrHqhbA4Ip+QzEthihyYG
Tyfx49PyHwTEyCv6UwrARI5M5GOnnSmuCl81pT7CZ8kP/k/DFcIYVUBxXphqcKd5
x7/4IM/EG//usI3QwnSnRzCCRI/9MzEpV6wuafG3IQ6eZoiXQl2p5OLE3FH19Tlq
hQHBOGF1X9ypJDPpCXJHl0ZDij/7YlUVQxkTvx2OVlhsYCf/CtkW/IviLqvYrS26
Wzc8wZOJ2sc/pnNtCOKL+Drcrv2GN+8NmEsABITUc2+ehpp5mqlcw5TWnk7gmt9l
M6rlr5NPZQubxu4D4F9DyrXETC1LkoPRuKyTkfXDJ6t5slXJWXTrY8zPtlwaNSTl
z+prIoS1aIWqeQMQ4tJvabZXyqsPjYhKUEQh4b59doVP68AaltD1SpM1hYuUzlmz
u3w5/0sRHN4JyA2sffdfE5Pp/xbe3+iY1exc5+OrW/UAHC3++RjKlss4Lns8MpPM
YpV3mHpEmyo5wOhGTWn1DTCa+PJG80wq7zGCZTZrtpCKcxWqBkGPlpK2AhptJRo8
l3cXTgVRwnZ/Ws23dvcCFvpmPzF7lKjLtVSH9yn9SIgCAvy/0MOP9HiNCRPOFERa
wewuKrr7W91CZA59kxTb/U39aHFVIceJLFnGWaDGKFFNzRiKVyY=
=s2Pc
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
