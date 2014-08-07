From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Thu, 7 Aug 2014 08:24:11 +0200
Message-ID: <20140807062410.GC17340@ulmo>
References: <1406854484-3848-1-git-send-email-ohaugan@codeaurora.org>
 <1406854484-3848-2-git-send-email-ohaugan@codeaurora.org>
 <20140805151323.GB19709@laptop.dumpdata.com>
 <53E26127.1040805@codeaurora.org>
 <20140806201740.GW9809@8bytes.org>
 <53E2BA2D.1050007@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53E2BA2D.1050007@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Olav Haugan <ohaugan@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-arm-msm@vger.kernel.org, will.deacon@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2014 at 04:28:45PM -0700, Olav Haugan wrote:
> On 8/6/2014 1:17 PM, Joerg Roedel wrote:
> > On Wed, Aug 06, 2014 at 10:08:55AM -0700, Olav Haugan wrote:
> >> so you are suggesting that I check in "bus_set_iommu()" whether the
> >> driver has set the map_sg/unmap_sg function pointers or not and if not
> >> set it to the default? Is bus_set_iommu() the only way drivers can set
> >> up the callbacks?
> >=20
> > This doesn't work as the iommu_ops are now const. You have to either
> > update the iommu drivers individually to point to the default function,
> > or you do the check in the API function itself and fall back to the
> > default it no call-back is provided.
> >=20
>=20
> Ok, then I think it is better to just leave the fallback where it is now
> in the function itself.

What Konrad was suggesting is what I also proposed. The idea is to
implement a fallback as standalone function, then make all drivers use
that by default in the struct iommu_ops that they register. When drivers
implement an optimized version they can simply replace the fallback
implementation with their own.

Thierry

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4xuKAAoJEN0jrNd/PrOhu5QP/j3DQwoynloeQjrnIbZ5VAoy
XaPGhvK9y2rR2PKLYwwyAiS3pdNEjH74Ob/xFtSpjIzVnbQzYP42RG33JXWWp8gc
HNQ9P1MyuOqYNxnd9pP4DbCag5mIJLGpzhhUf6PWmolCJvTUTQOV49lRJhYgf0KZ
0hEhQ3C/91pVzEhHdrowtU3VbbyXHFUDjlKGeZNyqwJRwFp+wlKZrS8ywVdvtzgU
JDQaVqh/ls5TD5ztTC4jXmWPNx28f12kzsjVf3ZRbwI7cR9KFhVQNVUoi81WkyEe
XUsZfU3iml/Gk2N3zvCBJgfyQ/f3tyzE03cawSXoxexgrDWjHqtYHy56T2XpF1Hw
7xMcGIk2tLUgBlQtoTYYSReZhjjGyIW3gwKpnWcuUkxkR25Kk2LNpOFdl6jYx/qm
zdmWUmMQzVb/rkBNNxSp8fhS/5N0bXsbLeKfcpljxzwZ4FnA7TTozOsYJJfSNUCN
XNXQQ0r5jC/5L+JWGCZrijd2Q5wsaxxs9iWYuu0n9lH0G/JjCXxjTmu7zL+Lay1S
Ljhg2FawzdpmxZH0DobT40UYHZTmRDLCXYgD8Cmaal/DDfLQWq8kgnD4iPGHE0Dy
SEC883i+MCRyqD3nThxKMUL5tnt3E7f/yHSX0DQIoDM+rlV+rSbEwQbcLfGNmh/0
5RQciuvarOLVrUXlMuV8
=w4Yu
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
