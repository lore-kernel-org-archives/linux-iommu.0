From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/5] iommu: Limit iommu_attach/detach_device to devices
	with their own group
Date: Tue, 3 Feb 2015 13:25:07 +0100
Message-ID: <20150203122506.GC15068@ulmo.nvidia.com>
References: <1422317339-22620-1-git-send-email-joro@8bytes.org>
	<1422317339-22620-4-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3497045645721665900=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422317339-22620-4-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============3497045645721665900==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2015 at 01:08:57AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>=20
> This patch changes the behavior of the iommu_attach_device
> and iommu_detach_device functions. With this change these
> functions only work on devices that have their own group.
> For all other devices the iommu_group_attach/detach
> functions must be used.
>=20
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 63 +++++++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 59 insertions(+), 4 deletions(-)

Sorry for my ignorance, but I don't understand what IOMMU groups are
supposed to be or how to make use of them. It seems like a common idiom
is to simply allocate a new group and add a device to it in the IOMMU's
->add_device() callback, but I fail to see the reason for that.

Can anybody point me to documentation about this? I've looked and I did
not find anything.

Thierry

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU0L4iAAoJEN0jrNd/PrOhQYsP/3CtbCuU9IxGPw1gQfZRmOS/
VJTqnS9f0MKqiPcT6/uPF+tzljw9VsvTE75Kw4SxihTYbBlAE8atb7/CE5DVKCoa
XUsKxbAmxSTUEch7c9mnOAd5rjWO/tc/xoyjG3C/G69tFTgqev/UiB0lnxOdX9Dl
rdlHznmJQbEW/9fRDaLDR7mzc0nHhfeubXHeh/FUFvVB5sHd2CO9oHL544oVIxlP
M4S1OTO+EoZYN+UxbSBEZTkUuPTDteLnlfvq999uUFJ5HVBpR1A0MW+DMhHJw6Zs
5XTOB+n2N5qLC7lmatKi0XKJblvLLqiGaVgq9cFzaz1B4VJDcqtvSLjbFcIXuhrl
oI54+gxa10OJ+k7ef2H6+DU+opGnmROwbZoYVd/kehb2oACxuMJEQX+dKcRyu2B/
s/noXkuTvceXQG8XgK5NtoWTVo94hlafk8WOO6sAXzA0sjZZIGuvQCLTuJGyOSe5
fs1dd9wWVeLty7nzeJ/y7lFfFg5nrj+v6/L6XoDxNyF3B5xDaHE7LY1EgSggNfK7
M8+HYqOm69G/m6oVB8RXIxoAM8B99K50vLEGNBTpIA2H6nyutpbkZACqvJqhbBZK
nqVmSlrZENt1z2NsE5J8dU+moLipFxfuAPVPsTPdduX+r1TFvFJO3IidzpqkiA2k
KOECS8XJUd+sVz6eyDQk
=kLO9
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--

--===============3497045645721665900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3497045645721665900==--
