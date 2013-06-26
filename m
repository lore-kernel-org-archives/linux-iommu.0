From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 18/23] iommu/tegra: smmu: Workaround PCIe IOMMU'able
Date: Wed, 26 Jun 2013 13:06:27 +0200
Message-ID: <20130626110626.GO27083@manwe>
References: <1372238906-9346-19-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZQ/M1iA+qg8otEW"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1372238906-9346-19-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--4ZQ/M1iA+qg8otEW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2013 at 12:28:21PM +0300, Hiroshi Doyu wrote:
> Make PCIe work as it is. IOMMU support can be implemented later.
>=20
> Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 3 +++
>  1 file changed, 3 insertions(+)

Can you provide more information about what the problem is here? Why is
PCIe not working when mapped through the IOMMU?

Thierry

--4ZQ/M1iA+qg8otEW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyssyAAoJEN0jrNd/PrOhrBAP/1DSf8OqN8itaKY87ZEt7S0j
ueKsnyVtzo8fCXtAfXZcHGL6ZRcuWRAnpMnxOhVELIqLSWsA08qR9+qVcKXsaFXo
fqfP+LVjpHr4VzrilR9dGe+kFj2iqoFfuSJrBir3C+G1lbNeuW3TjLJ0N8CbEJRS
ejluvfylEy2borOWC7cHANNrc3SW3JsKSmsG5vYrix33k0D0xwk3kThTiAFf2PKe
np8L4G4005DnH95xWO3mS6KRrUV1Saiee73lm1NHdW3y2lvhMoFcdFxm0R5NHqfR
xdgxqxF7yHBV3N/ecEgyywIM2zRCG4Ra96HJj0JY36HFFls/LNLNlT85UdjBNRUT
jvQSfWwYNo9bKZvpu77pD3Tc7c2R6llEjUnGq/z2HFhOGAbmKfapR62ohFKkzXYw
+DEVssxocEaIL5GgtNH7vhw7W1wGUvAnusiBWxG9ArTPfPE4jkCdsdS6CmC2KbKb
JOCU4KkJRQc97qKWVE+qYT/rujY2iBotbBMjj2c5fBAAFwj3SnYgHzkr+Yl+XqU3
yH0UlejQ6HHjfXQjaONvkOSzsUdD78yVTaK7vXnnsDm94sAv3WplC1zuWw87weA5
Qlf9FmGoLsqsXADMxHa45hPzWh0tZLhqKC1iwK0lG/YDg/9be133y7ro5f1c6tN/
amPBUHzuCP91Lu3lGkqj
=ggVc
-----END PGP SIGNATURE-----

--4ZQ/M1iA+qg8otEW--
