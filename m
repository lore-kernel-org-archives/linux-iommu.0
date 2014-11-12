From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 05/12] memory: Add NVIDIA Tegra memory controller
 support
Date: Wed, 12 Nov 2014 15:47:16 +0100
Message-ID: <20141112144715.GD26488@ulmo>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
 <1415376063-17205-6-git-send-email-thierry.reding@gmail.com>
 <20141112142150.GV10744@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141112142150.GV10744-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2014 at 03:21:50PM +0100, Joerg Roedel wrote:
> On Fri, Nov 07, 2014 at 05:00:56PM +0100, Thierry Reding wrote:
> >  drivers/iommu/tegra-smmu.c               | 1295 ----------------------=
--------
> >  drivers/memory/tegra/smmu.c              |  716 +++++++++++++++++
>=20
> This new smmu.c is an IOMMU driver, why do you put it in drivers/memory
> and not in drivers/iommu?

The SMMU is part of a larger IP block that's also a memory controller.
Having it in drivers/iommu would mean that we need to provide a
mechanism to synchronize between the two drivers. They also share a
number of data tables, so that would need to be shared somehow as well.
By keeping both in the same directory we don't have to expose any of
this publicly.

Thierry

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUY3LzAAoJEN0jrNd/PrOhq08P/13t2RFKG6zoeXqVac9S6XS8
pOS3Sq/OD4H6meqfBhAhK7BV6yjMDudlUuauIyEmWMj35c4LqZOSLeUk7m2sYhS/
iShx+BIY94oFLFCNW0oQ96Xjprvfc75zrBcd28Qo1ddghACEro+br+NnXPKBVZMY
lpheNi5CS0gUeNMcwsZxEp4UybEpZNBZf0hMMiwtsksClALObAUbT/cim+TEdtdF
jJJx+M5RScW/Ev5RZwUJffinjNuoAUanSJ3WNDHybSs7hJb4VtkiEgvzU2yIUAr6
jhP0ceJTHfUZ3kM4W2EmIKly9hfcF3O6vrXP0bZuloQS474iwWZEh6Ddrf8/TCbf
bvN3aGWXXlBiUZJ83MeO7ECdgVg3XJWyC6L5t3bd1N2wCA6CY9d4QoDbo3ydErvh
LP3qzQoWnnkYT8XywaI9snwjl1kLfUMJ87kmaZIMxwkqKjRN+MZrpFkZY7O6BcbS
S4Sv0+9d+YH7f9VV2ApKXtmAgretBVG+pkxEJD1j5+cfcvfB3Fx+SpKEIopNiifx
6cWTgtXq35Tmlb6+fFTP9ryUE9TdxNhKzFeYuT9bmCGPMsMIkP05o/GwRfA5RMjJ
aimpfUiRnkaffuQcUfsuictI5OC8z9GLZsbxL6C3rhq2buTETwtl2xnV9WQvP6gO
wtf2M2psjRVwD93fWGee
=8H0d
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
