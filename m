From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] iommu/exynos: Fix arm64 allmodconfig build
Date: Mon, 15 Dec 2014 15:35:29 +0000
Message-ID: <20141215153529.GC11764@sirena.org.uk>
References: <1418648413-32013-1-git-send-email-broonie@kernel.org>
 <548EDDCD.4060203@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EjZgaMZ/nZOUrj58"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <548EDDCD.4060203@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org


--EjZgaMZ/nZOUrj58
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2014 at 02:10:37PM +0100, Krzysztof Koz=C5=82owski wrote:

> Hi Mark,

> Few days ago I posted similar patch:
> https://lkml.org/lkml/2014/12/5/268
> but no one have picked it up.

> Anyway the fix of yours seems fine to me.

I don't mind either way, it just seemed to be easier to report the bug
with a patch.  If Jeorg is busy perhaps it can go via the arm64 tree,
the issue is triggered by the addition of the platform there?

--EjZgaMZ/nZOUrj58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUjv/BAAoJECTWi3JdVIfQmGEH/A3Wtgs43p4O4HXNCH23BR5q
08Um4rrDmhdLZp6yzsPHevUxxDrYwc03Tl0wd3QSN63Sw7wRR5dgJMedHDrBGYNG
zk+Ko8ZItzMai25nDWmXjqxQnPaf3DdTCoz9HSGDQlKlWx2Ji65LYZjmPMO8rl4m
S0lteS0nFOFS5hFv0saDjCPbC23vdM6TT6rrezYYOqljU/UcgbrLWnOdeDKVLJdi
UmMWCNo30vDUSWOokfPidNulQoEj93wzAslRgnHAkacSU7XTwjKDkm8FiUQJdFPE
rpSOK+uYUKXyCKMitlQwljYcbSOuMPac9RWcqnZk4iyss6P1jmdATDGZSjzU00Q=
=H6Sg
-----END PGP SIGNATURE-----

--EjZgaMZ/nZOUrj58--
