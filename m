From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu/omap: Play nice in multi-platform builds
Date: Fri, 6 Feb 2015 11:47:44 +0100
Message-ID: <20150206104742.GA17082@ulmo.nvidia.com>
References: <1423036690-3862-1-git-send-email-thierry.reding@gmail.com>
	<1423036690-3862-3-git-send-email-thierry.reding@gmail.com>
	<1718219.kRa6INVfJa@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0310480718302923314=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1718219.kRa6INVfJa@avalon>
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
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============0310480718302923314==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2015 at 04:31:55PM +0200, Laurent Pinchart wrote:
> Hi Thierry,
>=20
> Thank you for the patch.
>=20
> On Wednesday 04 February 2015 08:58:08 Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > The OMAP IOMMU driver unconditionally executes code and registers a
> > struct iommu_ops with the platform bus irrespective of whether it runs
> > on an OMAP SoC or not. This causes problems in multi-platform kernels
> > where drivers for other SoCs will no longer be able to register their
> > own struct iommu_ops or even try to use a struct iommu_ops for an IOMMU
> > that obviously isn't there.
> >=20
> > The smallest fix I could think of is to check for the existence of any
> > OMAP IOMMU devices in the device tree and skip initialization otherwise.
> >
> > This fixes a problem on Tegra20 where the DRM driver will try to use the
> > obviously non-existent OMAP IOMMU.
> >=20
> > Reported-by: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > Cc: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> > Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/omap-iommu.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> > index bbb7dcef02d3..e4d4f133a3b3 100644
> > --- a/drivers/iommu/omap-iommu.c
> > +++ b/drivers/iommu/omap-iommu.c
> > @@ -1377,6 +1377,9 @@ static int __init omap_iommu_init(void)
> >  	const unsigned long flags =3D SLAB_HWCACHE_ALIGN;
> >  	size_t align =3D 1 << 10; /* L2 pagetable alignement */
> >=20
> > +	if (!of_find_matching_node(NULL, omap_iommu_of_match))
> > +		return 0;
> > +
>=20
> We should convert the omap-iommu driver to proper DT instantiation, but t=
his=20
> should do for now.
>=20
> >  	p =3D kmem_cache_create("iopte_cache", IOPTE_TABLE_SIZE, align, flags,
> >  			      iopte_cachep_ctor);
> >  	if (!p)
> > @@ -1394,6 +1397,9 @@ subsys_initcall(omap_iommu_init);
> >=20
> >  static void __exit omap_iommu_exit(void)
> >  {
> > +	if (!of_find_matching_node(NULL, omap_iommu_of_match))
> > +		return;
> > +
> >  	kmem_cache_destroy(iopte_cachep);
> >=20
> >  	platform_driver_unregister(&omap_iommu_driver);
>=20
> The exit function will never be called as the omap-iommu driver is always=
=20
> built-in. You could just remove the exit function.

I've omitted this hunk since this code will not run anyway. I agree that
we should remove the code altogether if it's dead anyway, but that kind
of cleanup isn't really suitable for patches this late in the release
cycle.

Thierry

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU1JvOAAoJEN0jrNd/PrOhfw4P/387AhzjA18+iZqiV+DhBgHK
nkhxZeC/nnCs6pMWm3royXU2cq6PUVCRQHyNhbcrBaXkSfAE8lVe7HwkuM/j77Vo
XRtkxV86SubnLgCUheWQ1gmy0t/1jn+fEtYgLeQEDOvbzcH31LSp0lGh1Nd9NR4i
YvYC3hndM/WLUDwZck/j+YGlVKImo/gXV7VUQIlS5rDC/WAc2ABarNT8HR0UJYG5
Sm5BpTQ1iYik5FCYRVV4tizACS6mU/56GNbxmya699wKj1fAScw1647Mi2L1Gjot
qOlpJxlFLSF1RtPQ4r5ECQdfW6UfWxq/sNyjpkoBRfDgaiUGWVt0SNJxW+Py3OoY
Ci/2F47HTYOO+ASISLJrsBuIoq8DC3MVmSz45LxkKSp1/JP15iFvlHSftYDUntle
K0UeW3gcOfGgJTYTdocWaAetMMUT0QT7wKfbm6ueLUi2hD1bTb5Fo9X0uza2kjFT
JcCCyKYpabQmFyDp6n2L2vVip9SQvHjdobCyTNHI7hx4gwFFxcJeP3ftaVcpGyE9
PWQN39FelB4nrZYxKpawoUGLRflMxwj+Xp/o33/qPE6IOSCqvM4lS7q62CRni/Df
+3gea9+H03I0hkUmox9ffX3lFaZmW5yjcH0boNVZFmJetnxzkYQ/uJHIV8k/p08f
rkvFQGw+g/lId3ZS1dPN
=vTou
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

--===============0310480718302923314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0310480718302923314==--
