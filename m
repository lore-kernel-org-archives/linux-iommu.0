From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 11/20] memory: tegra: Use of_device_get_match_data()
Date: Tue, 25 Sep 2018 12:00:46 +0200
Message-ID: <20180925100046.GD7097@ulmo>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-12-digetx@gmail.com>
 <20180924101354.GH21032@ulmo>
 <dcf439a0-249c-ff9f-292d-c807a736672a@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dcf439a0-249c-ff9f-292d-c807a736672a@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2018 at 09:39:43PM +0300, Dmitry Osipenko wrote:
> On 9/24/18 1:13 PM, Thierry Reding wrote:
> > On Mon, Sep 24, 2018 at 03:41:44AM +0300, Dmitry Osipenko wrote:
> >> There is no need to match device with the DT node since it was already
> >> matched, use of_device_get_match_data() helper to get the match-data.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/memory/tegra/mc.c | 10 ++--------
> >>  1 file changed, 2 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> >> index 5454ffe5b2e0..cdc33f93cf7c 100644
> >> --- a/drivers/memory/tegra/mc.c
> >> +++ b/drivers/memory/tegra/mc.c
> >> @@ -11,8 +11,7 @@
> >>  #include <linux/interrupt.h>
> >>  #include <linux/kernel.h>
> >>  #include <linux/module.h>
> >> -#include <linux/of.h>
> >> -#include <linux/platform_device.h>
> >=20
> > It's better not to remove these two because the code still uses
> > functions declared in them. If ever we were going to remove code using
> > linux/of_device.h and then remove the linux/of_device.h include, we'd
> > break the build and have to reintroduce the includes.
>=20
> That doesn't sound like a good argument. You're way too picky here ;)
>=20
> > The same would happen if linux/of_device.h were ever to stop including
> > linux/platform_device.h or linux/of.h. That may sound unlikely, but it
> > has happened in the past with other includes. It can also happen that
> > some restructuring takes place in some headers that is not so obvious
> > and then things can still start falling apart miles away.
>=20
> Restructuring will be somebody else problem. Not sure that we really
> should care about it, I think it is unnecessary. But since you're
> insisting..

It's actually a very common argument and I've seen patches in the past
that add includes just for the purpose of making sure the right
definitions get pulled in. This happens quite frequently as a preamble
to some major rework of some header files that would otherwise cause a
lot of breakage.

So I think it's best to be proactive about this and make sure we
explicitly pull in all the necessary headers in the first place,
irrespective of whether or not they may already get pulled in indirectly
by some other headers.

Thierry

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluqB04ACgkQ3SOs138+
s6Hyvg/9EeBObbdVirXsYp8DQaJ68XjG9k0VkZdp036X0ww9pWj9Kr+9A/6dVfBI
SlK/+mFR5/RAHF/b/STNONtdu1TJV+TeeAuaZLfvIsS/KRoTXLpT4eC1kaFAGoun
AH6rC68fNOSZoEmJbfSuAAbEhDLtNV4ITsW7ySwNB2Jn+TFAh3r/yd8WST769wY1
ZULruEX1spgzlK8+ksF0lW4YDIRsb/MdlXgFC02nU4BpnlgaaUDXM16SsTnmVRQs
jYC0WhFIXW+d9rebYDVdky/qQ7Eg5FtGDYXj6KBTGYVYenbB1HmXDm87rFUylIse
mHZkZ3IzIVIOCcERDIc22gL6V78BViU0wfhtmGzpL+YK3BqWJ4TuDYuVuBz5AdGm
NC7p4B+vNu7xULJpKrNgI1oGFmqE+NfyThmNMCoEEAbJ2ZRDrlTiPn6dQrM09irj
NhY7/aCX8XSF8L25GCmZ3KOOlq+/kJdol6or76ON1hKdplvUxWsh2v6XwBOelM7C
UhjbSvBZyTtUoWlly0dEB91Xrqbr4w4WH+Nu/Z2AQU/ue6itkTrwZK2RHF7uiBUI
9X8hu8hO7ZCHgY9k1k/3Wl3S9eJ6lyJ5NI7JpqQ+dVX94H90cO+/+/bRczTLPQNI
MBPx6I/hweSJ99xPdwgwIW1Uy2ce6VVFBclZI3LCpicXcgYKmyM=
=YEyv
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
