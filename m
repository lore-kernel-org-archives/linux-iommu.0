From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 12/20] iommu/tegra: gart: Integrate with Memory
 Controller driver
Date: Tue, 25 Sep 2018 12:02:02 +0200
Message-ID: <20180925100202.GE7097@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-13-digetx@gmail.com>
 <20180924102322.GI21032@ulmo>
 <b2d283fc-ff52-3166-cd70-42f9cba93948@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qz2CZ664xQdCRdPu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b2d283fc-ff52-3166-cd70-42f9cba93948@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--Qz2CZ664xQdCRdPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 09:22:59PM +0300, Dmitry Osipenko wrote:
> On 9/24/18 1:23 PM, Thierry Reding wrote:
> > On Mon, Sep 24, 2018 at 03:41:45AM +0300, Dmitry Osipenko wrote:
> >> The device-tree binding has been changed. There is no separate GART de=
vice
> >> anymore, it is squashed into the Memory Controller. Integrate GART mod=
ule
> >> with the MC in a way it is done for the SMMU of Tegra30+.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/iommu/Kconfig      |  1 +
> >>  drivers/iommu/tegra-gart.c | 98 ++++++++++----------------------------
> >>  drivers/memory/tegra/mc.c  | 41 ++++++++++++++++
> >>  include/soc/tegra/mc.h     | 27 +++++++++++
> >>  4 files changed, 93 insertions(+), 74 deletions(-)
> >=20
> > I think this could technically have been two patches, but since they'd
> > have a compile-time dependency either way they need to be applied in the
> > correct order, so some coordination between IOMMU and Tegra trees is
> > going to have to happen anyway and might as well just stick this into a
> > single patch.
>=20
> I assume that Joerg will take the whole series once it's ready (no?),
> hence your ACK will be needed here and in other patches.

Yeah, either Joerg takes them all with my Acked-by's or provides his for
the IOMMU bits and I take the batch through the Tegra tree. I don't have
a strong preference.

Thierry

--Qz2CZ664xQdCRdPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqB5oACgkQ3SOs138+
s6Hkvw/5AWXy5G71xh8Re4QOcew+EqSH3Hh/AZ0z0t6SS3rJX6kjk6fiy39FHeb4
ZHMqZf2bpJLTPea6QiiWJ7VUAYVgnyb1plfuvHGttu0CGpmoSWROMclkm4KNArNW
XV7EDxbGbXpkfqm/uYMRQVMvYXn2malwgpXXVKgH8ABOaERTchxNJMoacuB7Y++b
E2LBcoLQbjfZZumyYjqCRQbbEa1BHhGD0sBOW4klTGJZMHRnS3VPs5rsyxN8YdJY
4+wz+00B4+JjNI5y13TynWL4ARLtGlwgAYZ6V1U09i+qQjUWsvFImrXGnxlt7aO9
2kxS18zkV9Ak2uD2oUFR3Tng9u+VDXOGh/1syuQ8lVoi1CT2N0/Au5AjuDvzM6gq
PrTHdrUtNQyU3chmLYBOfdfHuiaTgoTXgiw43AncaPWQyoLcjxwAYTnh+B1yuKqX
01JABU6g/HMQjksEDJXb/mY7zQ2IRuJn0eOL5wx5GF1p8+pEiC2i6wQKnZ16Flnd
k2xnwANk8i8vl+R4If9rJvMrc7FYOVSJbkkAopEozhvszsdn9sVbl708IiPesIi1
mhtCOaEwDe7fgrvhB9h74IbPiS6eg3POIZf4mL2JNbdd7+dWjOrkFGy0lx6Gc5S6
9YEjsHgopAg3zyB0eCBqAPXJo8lPGPPbT4NVbz9/9l8I839VyhQ=
=NkBG
-----END PGP SIGNATURE-----

--Qz2CZ664xQdCRdPu--
