From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu/omap: Play nice in multi-platform builds
Date: Fri, 6 Feb 2015 11:48:58 +0100
Message-ID: <20150206104856.GB17082@ulmo.nvidia.com>
References: <1423036690-3862-1-git-send-email-thierry.reding@gmail.com>
	<1423036690-3862-3-git-send-email-thierry.reding@gmail.com>
	<1718219.kRa6INVfJa@avalon> <54D258F0.8040905@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1216041222122948078=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <54D258F0.8040905-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============1216041222122948078==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2015 at 11:37:52AM -0600, Suman Anna wrote:
> Hi Thierry,
>=20
> On 02/04/2015 08:31 AM, Laurent Pinchart wrote:
> > Hi Thierry,
> >=20
> > Thank you for the patch.
> >=20
> > On Wednesday 04 February 2015 08:58:08 Thierry Reding wrote:
> >> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >>
> >> The OMAP IOMMU driver unconditionally executes code and registers a
> >> struct iommu_ops with the platform bus irrespective of whether it runs
> >> on an OMAP SoC or not. This causes problems in multi-platform kernels
> >> where drivers for other SoCs will no longer be able to register their
> >> own struct iommu_ops or even try to use a struct iommu_ops for an IOMMU
> >> that obviously isn't there.
> >>
> >> The smallest fix I could think of is to check for the existence of any
> >> OMAP IOMMU devices in the device tree and skip initialization otherwis=
e.
> >>
> >> This fixes a problem on Tegra20 where the DRM driver will try to use t=
he
> >> obviously non-existent OMAP IOMMU.
> >>
> >> Reported-by: Nicolas Chauvet <kwizart-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> >> Cc: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> >> Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> >> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >> ---
> >>  drivers/iommu/omap-iommu.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> >> index bbb7dcef02d3..e4d4f133a3b3 100644
> >> --- a/drivers/iommu/omap-iommu.c
> >> +++ b/drivers/iommu/omap-iommu.c
> >> @@ -1377,6 +1377,9 @@ static int __init omap_iommu_init(void)
> >>  	const unsigned long flags =3D SLAB_HWCACHE_ALIGN;
> >>  	size_t align =3D 1 << 10; /* L2 pagetable alignement */
> >>
> >> +	if (!of_find_matching_node(NULL, omap_iommu_of_match))
> >> +		return 0;
> >> +
>=20
> Need to call the of_node_put on the cases it succeeds right, you should
> change this to the semantics you used in the arm-smmu driver.

Good point. I've sent out an updated set of patches.

Thierry

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU1JwYAAoJEN0jrNd/PrOhIPIQALbD1pU2wd1HKvJxtZQkBLv6
cCfF5YiNd9OD5E5DLtr3dQMXnqkAHUOJ6l24xZIyloa0+KpTZOLifmafhyFPekGI
vuo2xfAo7jMae4O6JngbY+tmFEx7dSHQzzrJycZYPhkA8D/uLtpZkPD5NugXXmv5
PsT/Ryb4QgEaDEkkDopiwvNVldVhbST7lo2+U/jZs6/hOKgGgcKDvL/vEcPtr/ab
w6kX6ok13PeAJr/ITFgkbqMOcsYQWyOJ23RyY7LpO5BWYUPZ+PD1uiNldMYVzfy8
okOWOH7C6I9p5kG9Qa7pE1f+vkj3ldK02+khsYPpmVbW8YFAdNSkeN29iZ4JGyui
YWfpL5ZnCedqmavb8FuQaMkZBn4Deq9CL7cbdd8c/CMXF7qmPZ8Hld+bwOmBQWSg
gIbT6HyBbZI+nT0DZlVh2L/XnIzeZzM6X0nHzuDZov3zVCyVCmFQLscu6mUjmm1Q
yiGU8VE+WbqICA7UJm3/T0T2wJHW68TPLap7+DsIlerb0QhK9GqZK40gjQouWVip
3c8RqpK0G3voeksSqX+ilfnpS4/HEGb5d3+cOGiaR1xUMR1baw195H8Mnr9Cys+h
1DCkMQGkYMVIhneq5909t2619x1QUrdyvIgBUu2seTX9VI75k6tobtZA0EbMky27
Rsckagh8knEAgMXMgLrc
=a96K
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--

--===============1216041222122948078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1216041222122948078==--
