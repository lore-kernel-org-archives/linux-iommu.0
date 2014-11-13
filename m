From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 00/12] NVIDIA Tegra memory controller and IOMMU support
Date: Thu, 13 Nov 2014 12:16:55 +0100
Message-ID: <20141113111653.GA23422@ulmo>
References: <1415871157-21968-1-git-send-email-thierry.reding@gmail.com>
 <1550140.Lb4KHPOqX1@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1550140.Lb4KHPOqX1@wuerfel>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, David Riley <davidriley-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 11:12:20AM +0100, Arnd Bergmann wrote:
> On Thursday 13 November 2014 10:32:25 Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > This is the sixth installment in the Tegra IOMMU and memory controller
> > support series. This version addresses the final outstanding comments f=
rom
> > Olof about using proper Kconfig symbols to track the dependencies. It a=
lso
> > splits up the driver into one part that implements the memory controller
> > only and a second part that implements the SMMU. This plays nicely with
> > the new Kconfig options introduced.
> >=20
> > Patch 1 is a preparatory patch that exposes the memory controller clock.
> >=20
> > Patches 2 and 3 is a pair of precursory patches needed to make this all
> > work on 64-bit ARM in the future.
> >=20
> > The device tree binding for the Tegra memory controller is added in pat=
ch
> > 4 and patch 5 is the bulk of the series that move the existing memory
> > controller and IOMMU drivers into the new unified driver that supports
> > Tegra30, Tegra114 and Tegra124.
>=20
> I just noticed that patch 5 has never made it into my inbox in any of the
> submissions. Did it get filtered by the mailing list?

Yes, linux-arm-kernel says it needs moderator approval. Do you want me
to bounce it to you directly?

Thierry

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUZJMlAAoJEN0jrNd/PrOhR0QQAKrQVWBXZMgesUqVDlLy3gYY
gTUxUOIMiwXD0z/iB6h7TBbesY+fN1YQDZGHlmMBXqn5uLCQ7tLV5tyyrRdNQDFp
xLKvOXeNYwftAKRTNBVvOPWwRM4lDyUILEOdJLcCoqBZLHArj0XN/Cuw4aiTvCZX
3fYOwUSFx0sCfi702rjhtYY1/rb95FL1g7ZKpUGehYL4SGSRcm59eyhZPnE75SC6
3t88a0Lfe/jIre6/+dPFvOy52rdGE9zMQ1JgrrZ9va3qVsEaeArqjfGNyLa0EZS+
QX+fHpVFqNBWFnJTX6FDwbDAt3w4tp28Ws1QEn50fZ7piGczsaP9Z3sPxVboLcIq
DxWIxP/6biiSkndYugrtq3u4IGwm9JtpEMoswbpudnV6utaUZRLmSsjtHjxCeZJL
RYAaP4W/gv4NN/s/1cvWBgj1QoNQbKjTxjdPm8bUhbAyy3/E6lQkaTY3LwKolHoT
t6AEmL5JhoANpbIc+SbQr8G+bqiYaPVOFNkPYvlB/S9BE2i7VW3C4l4BL8T5YdWn
YSyPCwfm99g1PRyVGC7t1RlmftVrvp0BMRA20PoM7XNur9pYNU24OHVFP+Tr2o2v
oNq0hpE+g2wHgja2Yr17MStYu3zTVAAlfC/QpxY57+T5Zz20g787Zy30DK4dkR4U
f8bBkdrw6G9+c1d2iy4J
=3G+h
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
