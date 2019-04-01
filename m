From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
Date: Mon, 01 Apr 2019 08:43:47 -0700
Message-ID: <8736n120jw.fsf@anholt.net>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-3-robh@kernel.org>
 <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com>
 <155412649586.24691.809508732198367112@skylake-alporthouse-com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1030244635=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <155412649586.24691.809508732198367112@skylake-alporthouse-com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Chris Wilson <chris@chris-wilson.co.uk>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Robin Murphy <robin.murphy@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

--===============1030244635==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Chris Wilson <chris@chris-wilson.co.uk> writes:

> Quoting Daniel Vetter (2019-04-01 14:06:48)
>> On Mon, Apr 1, 2019 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
>> > +{
>> > +       int i, ret = 0;
>> > +       struct drm_gem_object *obj;
>> > +
>> > +       spin_lock(&filp->table_lock);
>> > +
>> > +       for (i = 0; i < count; i++) {
>> > +               /* Check if we currently have a reference on the object */
>> > +               obj = idr_find(&filp->object_idr, handle[i]);
>> > +               if (!obj) {
>> > +                       ret = -ENOENT;
>
> Unwind previous drm_gem_object_get(), the caller has no idea how many
> were processed before the error.

I had the same thought, but the pattern we have is that you're loading
into a refcounted struct that will free the BOs when you're done,
anyway.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyiMbMACgkQtdYpNtH8
nujFuRAAtd7ggD7Y+nzWpAGHGpCEBgf6La2B4uHi5SYwMJ1ayMSjxnkx31DyQ4el
ehc1zitZ8lNeJs3RkeIQTlBcLvVmCvkiKRftEIHihA+hbPl9Y8+sadcEbSln2kHT
vjGZyEQ9anQjQIOSaiSmUMVO2MzbbjS9VNsRP87jHDiqu40WSA9R8lP0yFnbjTkJ
4Fc4wnoduR+Z+o5DxhknFRhBfivIswXI25LnB+gG/cCJ4i8N6QjoY/qbQnnQHcwK
hbDTWkqeN2lyzZkTW/fvvksDRY+ODAj1J5kyQohhe9O3qtTRxawtHcRWqjPRDXfY
LC4bKRjRk9184JJQxnwW8KqsuYsqciHDPjWY8U6ezoTrHQ2QnRguC4IiUSICLrhT
Ova551wK9xbKIfhVd1M1NWx5QgOn7KWoy7Oiv+DMHGGN7+ohHzo5kABb3OLQA36o
DRMTk0Ot3KsTFCskbHR0mkGTCEFjyC96R9VmkSToi1QCW8enDwe4jdskXcX5An8h
59dZvFgCn641x08E6mG1j2PkyuzezV7puE5CbJWlJWlaVRXP+QGngydTS29AaJip
GOT2fIabzQ8fQ3eCmaD9Wtpx7xY8p6HAIwmk95fk/XjtTLs4iS9ZGc8+vM+ISdWv
Qaw7BpiSXNPLGi3/C1rGpLTCaDVcEWafWJkEDf9puOnci7aSwjM=
=jMdG
-----END PGP SIGNATURE-----
--=-=-=--

--===============1030244635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1030244635==--
