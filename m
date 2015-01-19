From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Mon, 19 Jan 2015 13:43:06 +0100
Message-ID: <20150119124305.GC7312@ulmo.nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<2804479.ZFl06ysk3j@avalon> <54BB58AA.5070407@nvidia.com>
	<5043167.LEiljZnGai@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1433760520430270009=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5043167.LEiljZnGai@avalon>
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
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============1433760520430270009==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2015 at 01:18:51PM +0200, Laurent Pinchart wrote:
> Hi Alexandre,
>=20
> On Sunday 18 January 2015 15:54:34 Alexandre Courbot wrote:
> > On 01/16/2015 08:18 AM, Laurent Pinchart wrote:
[...]
> > > The second way is to implement a mechanism to let drivers signal that=
 they
> > > want to handle DMA mappings themselves. As the mappings need in the
> > > general case to be created before the probe function  is called
> >=20
> > Sorry for being ignorant here, but why is that?
>=20
> Because a driver can call the DMA mapping API in its probe function, to=
=20
> allocate DMA coherent memory for instance. We need to ensure that the DMA=
=20
> mapping IOMMU has set up the required IOMMU ops by that time. As explaine=
d=20
> above I don't like the idea of sprinkling explicit calls to initialize IO=
MMU=20
> support in the vast majority of drivers, especially when they shouldn't b=
e=20
> IOMMU-aware, so we then need to initialize everything that is needed befo=
re=20
> the first call to the DMA mapping API.

The original patch that Hiroshi posted based on my comments was to have
the driver core call iommu_attach(), which would then set up everything
needed right before calling into the driver's ->probe(). This works
quite nicely because by definition the driver can't allocate any DMA
before ->probe(). And, like you said, this allows deferred probe to be
used.

To me it's so obviously the right solution that I remain flabbergasted
with how much resistance it's received (or how much it's being ignored).

Thierry

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUvPvZAAoJEN0jrNd/PrOhU9IP/0FOeRzpFZkmTs3QhMKxkgwe
535HZb0w5ML+d6YI7Vevbk7NkEiKFFUhdRlKL9ymKpPmkueYE1aUsoYDL1wgKd7M
4IKsgJXDqO1vIcU0aByDS3jm47CCDaEdEtyu3zBbkntWqIhLdIVsyVl6hb1leC4b
SOamGAsgkmtx7YAS91OduX7glfb22VHq9C35rAWUJpj5WxMmvi3H37/db5tadoAB
3GZwFdYdfY3dgzbdTDK+1lYq4UG/x/V7nxeIyqNtIShtpLJazpT1G5hilGYKT7OJ
npa0dBZuHHOeXdnfXYSFaKnYiBnceZH0beTA8bSL6r8VMBcgaIwOMHsEJRpobwrv
7IrYBAzwUAETTh2EP4BSMsunmWczJfa2V7M0RlEU+Me8rytG/fRTBJBfj9pgpS+n
gzN6TLbok5TKybvxD0zKM4b/fjW9kSZdqxkLL5A8eUKLlnGyWjdtypcuV4Hcs2mY
I1QvCfUpcq6ipk3vOi2ny6BkTIVeuBqKIyzH3A6uwvllGW6IMbqcxoy0fwuma6+q
66MSMVg33RmERD8lTf6lUHKv+jrR5+DZrPCjAtJLQaE4Sjl6gXqulOZGPivDgXo/
fpokU9EDe50h3t8UOljDRNy67GmhbOeVKOM24huzj/a/1k3Dzm1NSBx9ISAsxrS9
+fj7HkvwhW8/E73LcyeQ
=/o5m
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--

--===============1433760520430270009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1433760520430270009==--
