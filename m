From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Mon, 19 Jan 2015 14:36:38 +0100
Message-ID: <20150119133633.GA23778@ulmo.nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<2804479.ZFl06ysk3j@avalon> <54BB58AA.5070407@nvidia.com>
	<5043167.LEiljZnGai@avalon> <20150119124305.GC7312@ulmo.nvidia.com>
	<20150119125051.GI32131@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1031207724937730706=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150119125051.GI32131-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============1031207724937730706==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 12:50:52PM +0000, Will Deacon wrote:
> On Mon, Jan 19, 2015 at 12:43:06PM +0000, Thierry Reding wrote:
> > On Sun, Jan 18, 2015 at 01:18:51PM +0200, Laurent Pinchart wrote:
> > > On Sunday 18 January 2015 15:54:34 Alexandre Courbot wrote:
> > > > On 01/16/2015 08:18 AM, Laurent Pinchart wrote:
> > [...]
> > > > > The second way is to implement a mechanism to let drivers signal =
that they
> > > > > want to handle DMA mappings themselves. As the mappings need in t=
he
> > > > > general case to be created before the probe function  is called
> > > >=20
> > > > Sorry for being ignorant here, but why is that?
> > >=20
> > > Because a driver can call the DMA mapping API in its probe function, =
to=20
> > > allocate DMA coherent memory for instance. We need to ensure that the=
 DMA=20
> > > mapping IOMMU has set up the required IOMMU ops by that time. As expl=
ained=20
> > > above I don't like the idea of sprinkling explicit calls to initializ=
e IOMMU=20
> > > support in the vast majority of drivers, especially when they shouldn=
't be=20
> > > IOMMU-aware, so we then need to initialize everything that is needed =
before=20
> > > the first call to the DMA mapping API.
> >=20
> > The original patch that Hiroshi posted based on my comments was to have
> > the driver core call iommu_attach(), which would then set up everything
> > needed right before calling into the driver's ->probe(). This works
> > quite nicely because by definition the driver can't allocate any DMA
> > before ->probe(). And, like you said, this allows deferred probe to be
> > used.
> >=20
> > To me it's so obviously the right solution that I remain flabbergasted
> > with how much resistance it's received (or how much it's being ignored).
>=20
> Have you considered reposting the patches based on what we currently have
> (which has the advantage of identifying a specific IOMMU instance)?

No, I hadn't. Initially my patches included a solution for identifying
individual IOMMU instances, too. There was a small registry with a list
of struct iommus. That was supposed to get used to store per-instance
data (by being embedded in a driver-specific structure). I'd need to
look in more detail how that could be done with the infrastructure that
your patchset creates. I'm somewhat burried below other tasks right now
so don't expect to have any time to look into this anytime before -rc6
or -rc7 at the earliest.

Thierry

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUvQhhAAoJEN0jrNd/PrOhmMAP/2gox6QfokBn5l/Gbva0S701
sOTy72GebWgKrBoyXX7zPoNQha+tmroiRunQ/R6Xtmn9XkcH62aF+xeaFPIwg3EX
NdNqY/279nu8FzjZHmeOxRrwtKfV82g0f5huiLGVh7LH30/2vP3vegUJ1jQY8L+5
23Wm01zYKODMomTOpttvKTT+rhynWglR0+Ac1VgDa+TWDWt7W34oM4/v5Iq8DHUF
/gC0FOoKDt8VrteAq7NByRpBWovRfP6RYVhGADZohX2nPFWndCwNt72Hwit429gZ
AA2DZkXTnPbD4Tda1gNoMjbzV9zuVIHnh8MeYaft/BvqksddZsDtQuuApknbSqxs
HJ0odpl71yNMkGi6sIuDs+9HliDsOHa1gheQwaXEGDDrQkLxjwADDleYl/EbtU0s
Btgg0uapcbfLfi391zVRb8JaEzCkpRYpbeznW0MuMU0Joe9nAYpccA7jIgqadeA1
YV0CW1OuHRqZX/JQqzU4i0e7uNQsagyzb1aloL/Al9UlcZmgI/5XfeENZLOnWeEi
0p20tz0p6CZWAB8WlY4cOFlriEoXOesHJM+TPxJjVxN2Ry/z5u5RzcBRI4B8dJ05
VP/myfSIbHLMcqCy+fBhiK4HjoN6HulAgwBXEGNQKxO6mj36shN7XCQYRL8uHsXN
lSwhRLT51MheNBfnnf6+
=pafx
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

--===============1031207724937730706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1031207724937730706==--
