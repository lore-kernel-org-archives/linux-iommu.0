From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [RFC v2 2/5] tps6586x: Add device tree support
Date: Wed, 25 Apr 2012 11:10:31 +0100
Message-ID: <20120425101031.GH3195@opensource.wolfsonmicro.com>
References: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de>
 <1335347102-14905-3-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1335347102-14905-3-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2012 at 11:44:59AM +0200, Thierry Reding wrote:
> This commit adds device tree support for the TPS6586x regulator.
>=20
> Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>

This looks basically good from a quick scan through but the pattern of
looking up regulator nodes by name is very common so should be factored
out - I made a similar comment in response to a recent patch from
Rhyland Klein and earlier today he posted a patch "regulator: add
generic of node parsing for regulators" which does just that.  Can you
please redo this on top of his code?  I'll probably apply it later
today, though I didn't properly read the code yet.

I guess it should be possible to apply this patch independantly of the
rest of the series?  It shouldn't break bisection if it's missing as
it's a new driver that's being added as the consumer.

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPl81QAAoJEBus8iNuMP3dBS8QAJPruEsNoL7r2Z9gZqvZHHBM
esaCCI2A8OYSLR1xFSw/2PbTuVJHtcNxX8lCh+VOJEHY1Tdy7WIrNS6+CFd5NAw6
M5E6CkiuIosffX2KonFdt+blp29mk+IVgoBtKK1HijbVcvaCxTPSr+mkKBsJYmcB
ZIyiIo4z1c5h5tuG0/ukYsYL7Su/bmP0WP1j3mseFr5H9ZMN/92lU6SaTK+jbUxC
DCEobHM286IZqeht6svHF72I5wqXII8XewRMiI1OeK8dZo/WW86r/Hs5lqZ1ZEEJ
iEo9b6+4sTkZMWdCiYiAwVYSNuS7gFk5EYFVDr5FzNLflf6k2eRvWwX3Zz8CcoAa
UOt1wslf3GEKU6Uzq8OpPB+bMHX6b4xjLAd0NsTRdyIHEkPevT8ZPioSMuJAMvBJ
msoPHndefaCLI3Rb0Utp+FvG0tKUZQ5u9acemuc8g1cFyXK7g71ujoItl1peK7hK
iNc9InaAh+zdkEsGMpTikv5xswkWjuyYZTAN3ZdofhyUSKX04joEGrfCiRXGxi84
ByUapiKTGWtR1JGsuj6WSOcwngheuYOLIFOABkUHQNsmmg2tDyLotNe2P1KatBOR
eEZkQTPOoPG6QywoaQio72pCPujvX5Wet67k4O8RpS1FGUioTmFLVUAvtmk+xg8b
cg0+XSoMFRyC67AWqKme
=24SH
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
