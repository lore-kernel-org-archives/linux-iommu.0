From: Marius Vlad <marius.c.vlad@intel.com>
Subject: Re: iommu/vt-d: Use per-cpu IOVA caching,
 suspend-to-ram causes machine hang
Date: Mon, 6 Jun 2016 13:32:10 +0300
Message-ID: <20160606103209.GA30777@mcvlad-wk.rb.intel.com>
References: <CAHMfzJkuRBCMtkGniODGxfrZrmthx9nHog8vq-jCTMVJb_64Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0247392948=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <CAHMfzJkuRBCMtkGniODGxfrZrmthx9nHog8vq-jCTMVJb_64Bw@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Adam Morrison <mad@cs.technion.ac.il>
Cc: Omer Peleg <omer@cs.technion.ac.il>, David.Woodhouse@intel.com, intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org


--===============0247392948==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yes, that does it. Thanks.

On Mon, Jun 06, 2016 at 12:02:30AM +0300, Adam Morrison wrote:
> > Hi Omer the following commit introduced a regression when doing
> > suspend-to-ram. The machine never wakes up. We have more than
> > a few machines that hang: SNB-i7-2620m, IVB-3370, HSW-4470r, BDW-5600u,
> > BDW-525u.
>=20
> Jan Niehusmann posted a patch that fixes a similar problem:
>=20
>     http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1158159.h=
tml
>=20
> Can you please try it and see if it does the trick for you?
>=20
> Thanks,
> Adam

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXVVEpAAoJELmLWIAQzyE+PPsH/09TiVfglIde1tKwXnTHzrqt
CdRIxWuzDFDNgzPL7OhuRiPuqVi0AvZW5mgrzGG3T903frGtTEuuVq9VVas8225h
6Bp9kpgavTokBNfgIKKAJdiSI0Gmk/KjZg4xaazUgaMXd4ZK75ZG9fGscud/T8CZ
DZgW2sHaj677KTrHtHc3qDjsqUfSphiPyooZGNjiepycUVzJDryhMQKQQjB32gmb
i9rxPKOU12zctWB/Dn0i5NkLTpWUe3hHpPscfBhQpQ3zArGCIp1KKRdq91Xkqs0D
Lw8+D1SJH2AMuFM7VugcjOx6eg6aBRZHfGRUQsUr333nkfIfIDLhV3NZMQF8aV4=
=YdoD
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--

--===============0247392948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============0247392948==--
