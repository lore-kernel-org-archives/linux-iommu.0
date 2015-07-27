From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 18/18] iommu: tegra-smmu: remove cacheflush.h
Date: Mon, 27 Jul 2015 16:13:33 +0200
Message-ID: <20150727141331.GD16858@ulmo.nvidia.com>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
	<E1ZJhXt-0004Ck-LR@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1750416314326871453=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <E1ZJhXt-0004Ck-LR-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============1750416314326871453==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 01:30:17PM +0100, Russell King wrote:
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> ---
>  drivers/iommu/tegra-smmu.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index e5d6bc45c58f..4a8b66f05d8f 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -16,8 +16,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> =20
> -#include <asm/cacheflush.h>
> -

Doesn't this logically belong in patch 13/18, along with the DMA API
conversion that drops the last reference to these functions?

Again, I can take care of squashing this into 13/18 if you don't have
any objections and send a pull request to Joerg.

Thierry

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVtjyLAAoJEN0jrNd/PrOhGlIQAMENAPRx/dcXvKUcQhOzYXuj
NjzqrARJ2JbNqnd1g1A2juRuXtvz0KQ2Cgn48D5wHvvlvG7vAbuYK0eW/9Gu9qSZ
xmIoj/McAM9Z7xzSeZM37Xyawm8dUeD0OHSAN5Qd+gMC187m4kqGH72eJ9vYj6HF
F/8hCZo4YIuZSza96jeycqZurmg6R5Paj9LMHR8elXnAE0wFTn8F+Ncmyfc+MZMe
qweyx5vP4CLLyRvC5MfCHjFKwR63pmJHYBbNHQKYW5zfqrwdycQpdJfzPQqpCWc4
foknXakqU2SSzYCa9FgcZfctF3s/HaIdgFZ5vv75zW1cstk1Cu++nDZWlGOkmkDT
XKmInXJWk4EjBVg8fcr3xA/QDd+/V76+1hfhdMU5X3KNXIKLZAUtY5HR2uWKjiAx
8pxpMiVwDTuaI2aeUp4Ylf9v0SDgBN9qIT1dU1aQkSGNtbI8uL7YGVu/HVGo+575
FyZ8EF4PoRcKc8qL/kM8oRtd9xLtTkxztXpnCZrDaZ3Sq1LrgwVFVlglZsobx+VL
LLfFT+NJmbnhl5HbRu40Y982VjH7DkUYdUVrbIxqb9r9jz3f7KX6G8ufRtbHrEe9
ALd5BWM2qL9j5s/8EMyoP4o1lQwCtZN2oHER5C52mtbDqg1BFL14M3ocQC9exsoT
bW4t7fY9On/bCGsL53WD
=Fo3g
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--

--===============1750416314326871453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1750416314326871453==--
