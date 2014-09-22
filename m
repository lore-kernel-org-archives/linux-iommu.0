From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v3 6/7] arm: call iommu_init before
	of_platform_populate
Date: Mon, 22 Sep 2014 13:40:40 +0200
Message-ID: <20140922114039.GT1470@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-7-git-send-email-will.deacon@arm.com>
	<20140922093614.GK1470@ulmo> <11868654.D6MinQlF2p@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8114957450013074474=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <11868654.D6MinQlF2p@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============8114957450013074474==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZNotpC0yWfjHZxBL"
Content-Disposition: inline


--ZNotpC0yWfjHZxBL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2014 at 01:08:27PM +0200, Arnd Bergmann wrote:
> On Monday 22 September 2014 11:36:15 Thierry Reding wrote:
> > On Fri, Sep 12, 2014 at 05:34:54PM +0100, Will Deacon wrote:
> > > We need to ensure that the IOMMUs in the system have a chance to perf=
orm
> > > some basic initialisation before we start adding masters to them.
> > >=20
> > > This patch adds a call to of_iommu_init before of_platform_populate.
> >=20
> > Why can't you call it from of_platform_populate() directly? That way it
> > would be usable for all architectures rather than just ARM. Eventually
> > we're going to need the same thing for 64-bit ARM (and possibly others
> > as well).
>=20
> IIRC, of_platform_populate can be called multiple times, even recursively
> be drivers that populate their own child devices.

Indeed. Perhaps it could be conditionally called when root =3D=3D NULL. But
perhaps that's not safe either. Anyway, I still think we shouldn't be
making this some randomly placed early initcall anyway.

Thierry

--ZNotpC0yWfjHZxBL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUIAq3AAoJEN0jrNd/PrOh8yUQAJ72Y248MfCnEsAibyMCU+QW
357FAVSmTZo3x2gtfQBUAL/CWi5oZjGNSroIl8f6na+TmyKgv6Megg3llq1XgUXZ
LGgDId7elmmobaOPDR53Q8LPB59A8sVXmF9/jaaArPDpe4HNWuS/2UTjTanurs2h
dhoXCFAXlXyWguAcYkD2YYxNkqOCgiwcptm6NzxHn+CBmK8jpf229NbBkJHLT2He
iouN7rVvNCJ0XDRI3k2jwQCXvtxgkY54p2pLTc2E9S43LOBD5PsFDl8HsP+ww3pp
Aw5AhBOYTwAVjmR6vFLTsQ5oKpmod6NO7I0Wj2kjVOYvKTWuR4uHRJiJLWoB1JmR
YejbY7SUydpWZp6WvEdD+7agMOmMRSukTzUxrYHvG8wu63q5Uy5FaiUPHbI24Cga
se8XU/Dvk7579iSzlyIqUxwSsewnSJQZ+/YvJOm2YKE4rOWR8wKFsojGSld4Ac/m
qaEVy1yqs3+g+B33Aj/YpXXxkZzJcJ5JgDjVJmvd96nMMlvTWvoZIRaqbIuz8EXB
R/E2Qsq+PQIy9rvcb2EHcaaX6RByjDI5xF4DxlRmtErgTIzpHsGHu2eu1M8z3oTe
Q0/lI1AS4+8UYL/Q5RnfIsrF3tJHUct9ucBRgtfYMnuqTH3ybuqcGYn4GZdz0CKH
cIu6Yw4GmQ4f0a5uWi28
=8zCd
-----END PGP SIGNATURE-----

--ZNotpC0yWfjHZxBL--

--===============8114957450013074474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8114957450013074474==--
