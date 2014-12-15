From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] iommu/exynos: Fix arm64 allmodconfig build
Date: Mon, 15 Dec 2014 15:56:15 +0000
Message-ID: <20141215155615.GD11764@sirena.org.uk>
References: <1418648413-32013-1-git-send-email-broonie@kernel.org>
 <548EDDCD.4060203@samsung.com>
 <20141215153529.GC11764@sirena.org.uk>
 <20141215153804.GK20738@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9pGKxSHTiGLjQSm"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141215153804.GK20738@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org


--i9pGKxSHTiGLjQSm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 15, 2014 at 03:38:04PM +0000, Will Deacon wrote:
> On Mon, Dec 15, 2014 at 03:35:29PM +0000, Mark Brown wrote:

> > I don't mind either way, it just seemed to be easier to report the bug
> > with a patch.  If Jeorg is busy perhaps it can go via the arm64 tree,
> > the issue is triggered by the addition of the platform there?

> Can I pass the buck to arm-soc, as they're handling arm64 platform code?

> It seems sensible to merge the fix via the same tree that introduced the
> breakage.

Sure, just resending to them...

--i9pGKxSHTiGLjQSm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUjwSeAAoJECTWi3JdVIfQAh4H/igjZphGnBpSx7WiFI6UCfEk
qF+s/XNUlk5WtzwcfyW/3Gcy5mWf0lEA5RsoeQbsOO9nQhw8rIx819+/GxzahAbO
TnZZme24FBUalkZkaq9v1crlVc5SI+sLix84Vm99Mxn80UdHofEAtpv0fnunheNI
32L3Qw2ijMqZIWwPaQARY0NF1snQw17cZ+e6Bd3/u1sSk2iuL4uzETIDCTe8HVqK
S2yYYyJhL1DPaLKOhkPdH4hOShC+VEFLNd7OQlSJ/TbQJ0xCf5LtdM4G3X6Epwit
7/5VFctT4qKC77kwN1aq3AcNJ7nlq9y7YO3vBvsJI2TG08kiXjf55CzPv722fbs=
=0lyc
-----END PGP SIGNATURE-----

--i9pGKxSHTiGLjQSm--
