From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 1/7] iommu: provide early initialisation hook for
	IOMMU drivers
Date: Mon, 1 Sep 2014 09:52:19 +0200
Message-ID: <20140901075216.GA24430@ulmo>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<1409327670-3495-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1163742575689829072=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409327670-3495-2-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============1163742575689829072==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2014 at 04:54:24PM +0100, Will Deacon wrote:
> IOMMU drivers must be initialised before any of their upstream devices,
> otherwise the relevant iommu_ops won't be configured for the bus in
> question. To solve this, a number of IOMMU drivers use initcalls to
> initialise the driver before anything has a chance to be probed.
>=20
> Whilst this solves the immediate problem, it leaves the job of probing
> the IOMMU completely separate from the iommu_ops to configure the IOMMU,
> which are called on a per-bus basis and require the driver to figure out
> exactly which instance of the IOMMU is being requested. In particular,
> the add_device callback simply passes a struct device to the driver,
> which then has to parse firmware tables or probe buses to identify the
> relevant IOMMU instance.
>=20
> This patch takes the first step in addressing this problem by adding an
> early initialisation pass for IOMMU drivers, giving them the ability to
> set some per-instance data on their of_node. This data can then be
> passed back to a new add_device function (added in a later patch) to
> identify the IOMMU instance in question.
>=20
> Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/of_iommu.c          | 14 ++++++++++++++
>  include/asm-generic/vmlinux.lds.h |  2 ++
>  include/linux/of_iommu.h          | 21 +++++++++++++++++++++
>  3 files changed, 37 insertions(+)

I don't think this is the right direction. We've been preaching that
using initcall ordering is a bad thing and people should be using
deferred probe instead. Now we have a bunch of these OF tables that do
the exact opposite. Note that these are nothing more than a variant of
initcalls that get called at platform-specific points in time.

There are also ongoing discussions about how to change the device probe
order to use dependencies (such as phandles from device tree) to prevent
excessive deferred probing. With that in place this would be solved in a
much more generic way.

Thierry

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBCWwAAoJEN0jrNd/PrOhrGMP/1hspDU2RUGj8ylLDjjhosoO
YPm00UfiVbw6ieSZFzA4CaTHxmqPlWAaqjxul3iZ5ZTuV7mUDxmCchN9+lcyLqk6
Zh6sKYkiQJowSSiqN+oSl+bi8irEfqYEtX3hFgvnEA4kBFBzeIPKrNPGfkBPdS8r
4xWU5U+gJGp8ZQi+PZE7NVsxPEUWyyVulHbwZEnC42BCa1VBg6v0Nr2xYYqEefja
3lHZv977fDKPRh7Q9LnXPpEZ9qbP3KbDkKTxEyPGbQ3pNgj8cLf+L2mZPxIZG+0O
tr3n1ls0I9wuKFOP1Det35H0YK9qhjzOY7kPPz5cI7cRYmjIiP0NTcfGzpCoo+nI
8QCH5yIxS9dA2VTCc6nb9fb83YidNsYoqdQXfXCs7JEwii13JwLBvp2fUC75CD7L
0BL1TeyPrAHoS/XCuNZfPTRjK6e8EGl3hU4r0mKpmEijsow+ZhrLIZiDdSjNgkEG
uuaGTtr0AvSNUoDCaQq+U2+eMJ7Lvr4DQ6BQkUaS3aYEXKjB1AgllDIyZr5CKLne
UWrgRq8E83H+LjMJ6Wyr37U02gYG+72KyBM/MNRwGnOH/j3B4K37emVioANr32cc
T22bn3Fi8kuGSfoUd9ks8DkNHSYBv13D+6ror6Ive9hRlVi6voU/KI+MxBatKAC3
uoIIfWC6QWhMimJivSru
=BrTq
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

--===============1163742575689829072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1163742575689829072==--
