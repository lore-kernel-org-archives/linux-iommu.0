From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 18/19] iommu: exynos: init from dt-specific callback
	instead of initcall
Date: Mon, 15 Dec 2014 10:47:16 +0100
Message-ID: <20141215094714.GA517@ulmo.nvidia.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
	<1416395748-10731-19-git-send-email-m.szyprowski@samsung.com>
	<1826772.xgprzQcfXd@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4618587188833617635=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1826772.xgprzQcfXd@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, David Wodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

--===============4618587188833617635==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2014 at 02:45:36PM +0200, Laurent Pinchart wrote:
> Hi Marek,
>=20
> Thank you for the patch.
>=20
> On Wednesday 19 November 2014 12:15:47 Marek Szyprowski wrote:
> > This patch introduces IOMMU_OF_DECLARE-based initialization to the
> > driver, which replaces subsys_initcall-based procedure.
> > exynos_iommu_of_setup ensures that each sysmmu controller is probed
> > before its master device.
> >=20
> > Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/iommu/exynos-iommu.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index cd28dc09db39..88f9afe641a0 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
>=20
> [snip]
>=20
> > @@ -1125,4 +1134,21 @@ err_reg_driver:
> >  	kmem_cache_destroy(lv2table_kmem_cache);
> >  	return ret;
> >  }
> > -subsys_initcall(exynos_iommu_init);
> > +
> > +static int __init exynos_iommu_of_setup(struct device_node *np)
> > +{
> > +	struct platform_device *pdev;
> > +
> > +	if (!init_done)
> > +		exynos_iommu_init();
> > +
> > +	pdev =3D of_platform_device_create(np, NULL, platform_bus_type.dev_ro=
ot);
> > +	if (IS_ERR(pdev))
> > +		return PTR_ERR(pdev);
>=20
> If we end up having to create the IOMMU platform devices from within the=
=20
> drivers, the introduction of IOMMU_OF_DECLARE starts to feel like a worka=
round=20
> to me. I wonder whether it wouldn't then be better to let the driver core=
=20
> instantiate the IOMMU platform device from DT as for all other devices, a=
nd=20
> use device notifiers to defer probe of the bus masters until the required=
=20
> IOMMU(s) are registered.

Notifiers don't work very well for this. Notifier blocks are supposed to
return a very limited number of values, so sneaking in a -EPROBE_DEFER
isn't likely to work out very well.

This was in fact one of Hiroshi's proposals over a year ago and got
refused because of those reasons. The next solution was to introduce a
function, not very much unlike the of_iommu_configure() that would be
called in the core prior to calling into the driver's ->probe() callback
so that it could handle this at probe time (as opposed to device
creation time). That way the core can easily defer probe if the IOMMU is
not there yet. At the same time it can simply use the driver model
without requiring per-architecture hacks or workarounds.

Note that there is really no need for any of this configuration or
initialization to happen at device creation time. Drivers won't be able
to use the IOMMU or DMA APIs until their .probe(), so handling this any
earlier is completely unnecessary.

Thierry

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUjq4iAAoJEN0jrNd/PrOhMZ0P/3FhbAIe0ty1xTVoIPG/D/z1
akYj8ACysJv3J7OJjUAG/HGWw6nC2UvXeuaHgkb/MAAUyUJR6FsVAu6cVbtHORFI
35yNX0Q+Sly4hPF9oQVkobVbfFIHGehvf9alLMjCm/K6y2r0f9wA+ith6jdrqYrL
0jCcQKFjITgfEfEhR2r3xBR3HBzKapGs6/LK+DAw+7Aktk6N644qSAftDekE3YmZ
zVba/PpWtv4NFsk6y83qv856eIsn4up2PpGm+oDcVsR7z5Tkdd1/9N3BiKRyyyA8
Wt6kxLzQ6K0ZizNpsT9ETvuaRY4q9D8ACmqO7N0JtVzririYdsarpFY5rJOjplkh
i3n+jD+42ewF0iLITtRXeaTFuPPosR5AZXYyeT9LnqIO4ngOmofyIkIANSL6xzBN
Dv30D3iZk8QWBAM5xZcH3EAlnlqL4mQR8+CsSJ8ibFS8f4MaAiRrsJxj7BXZFhsL
1rFTEGmvtu1MFwVvgRhha8ZxBzhS11dO71M0q3BMJJLdA/Z9/vEFsw8geoiSoAjm
mGB9cCkQ0Tk3nMR80LxmodouGLO0YI7JZZoxMMgmrgevFBMYHfPKsv+oM5dhoZo0
26mmcEqmDA+1PVzjvsbg/WPQyOAIyUqLbLK5QBRFOF3g/Q/S0p3javLzN9IhkdGN
Q28HozFdlnXjddVYOIKi
=pCgd
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

--===============4618587188833617635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4618587188833617635==--
