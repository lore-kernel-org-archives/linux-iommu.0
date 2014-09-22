From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v3 6/7] arm: call iommu_init before
	of_platform_populate
Date: Mon, 22 Sep 2014 11:36:15 +0200
Message-ID: <20140922093614.GK1470@ulmo>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-7-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3379587122899823963=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1410539695-29128-7-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
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


--===============3379587122899823963==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F55Y67F01HNW3AgB"
Content-Disposition: inline


--F55Y67F01HNW3AgB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2014 at 05:34:54PM +0100, Will Deacon wrote:
> We need to ensure that the IOMMUs in the system have a chance to perform
> some basic initialisation before we start adding masters to them.
>=20
> This patch adds a call to of_iommu_init before of_platform_populate.

Why can't you call it from of_platform_populate() directly? That way it
would be usable for all architectures rather than just ARM. Eventually
we're going to need the same thing for 64-bit ARM (and possibly others
as well).

I also don't like how this uses what is essentially initcall ordering
when solutions have been proposed in the past to properly integrate this
with deferred probe and allow IOMMU drivers to be proper drivers. We
keep adding these special cases for devices that need to be probed early
and I think it's turning into a mess.

Thierry

--F55Y67F01HNW3AgB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUH+2OAAoJEN0jrNd/PrOhMjUQAMGIe3H9P6mz+5uw9Xa/DHtI
P5uyx9N+RCO+vxfE7kqg9BitmGvRpBL86axYCy03xW3tJLp7XCR5v+BW5cxFbiUY
bghwMPsQiMtzndqgxK4EgvNFm1DSyeXuewlja6O9F82dhbxMRtd3Tj9SuXTsZcN9
WEiArZe7igGzSJcjy8e86rcqJqH1B2O5tnUcttvf1bIWm5h03Wy6xGHI9XXuTNWv
fulx6B0wwwukQFyOErzUqarqPqp2A8jvFpHDRL3ZXidG/qSsgHLVjhbAG5Ls6e9/
QciEb28FbN44iAArnCy5c2plET3XQJfH+8IglLMzznFsC0a0Cti4YBIf72mHXQ7y
br2fAxVO0kGD3rtyh9A6dNskWJ0E91kau7ECwX4ZCaZ4RtJp6k40Dh0ZppgckLQd
eZ1z+A4qwbEnkv6v6NapKMX/hEHYJr3WZhWy3Ut3VrADlfAxP9jr1mkceIudCL3b
M61KB2p8RNAO0hxRM/DGr8huLPPmegkjofSopr+SQhM9YnyQ+oQN9fLghH6T+5LK
KwJJFXW1zI1RitEU+Lmg3IIvkRGi9p4hrQzVXd6em2DdeNdP/3R/2lbSsP7fXq5O
aDViQS0BysIK7l9XysdPyLkuIzdoXntJbYpOgvFAHhsaCqNQf3jXcJka0bIdzNXG
xYm+Ih+lfUVPEjwrLmfc
=PaZp
-----END PGP SIGNATURE-----

--F55Y67F01HNW3AgB--

--===============3379587122899823963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3379587122899823963==--
