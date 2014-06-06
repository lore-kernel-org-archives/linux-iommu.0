From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
Date: Sat, 7 Jun 2014 00:45:45 +0200
Message-ID: <20140606224542.GA22188@mithrandir>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6915435674400188627=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============6915435674400188627==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is somewhat off-topic, but given the various concepts discussed in
this thread I'm beginning to wonder how they will be implemented. The
current implementation hooks the IOMMU API into the DMA mapping API, and
the way this is done is by setting a single IOMMU (or rather a set of
IOMMU operations) globally per bus type.

There are two issues that I can see with that: one is that we can't
support multiple IOMMUs in the system at all, and the other is that
there is no context associated with the IOMMU ops, and therefore there
is no way to differentiate between two instances of the same IOMMU. A
few drivers use global variables to keep track of context information
but that won't work with multiple instances, unless they keep a global
list of all instances and then require explicit lookup in each of the
IOMMU operations. That sounds more like a workaround rather than a
proper solution to me.

Discussion in this thread indicates that both of the above will be
required at some point. Have I completely missed something or will we
have to rework (parts of) the IOMMU API to make this work?

One other thing that I have some difficulty understanding is how we can
support things like process isolation using the current IOMMU API. Since
a device will be statically assigned to one IOMMU domain at probe time
there is no way we can change the address space upon a context switch.

Thierry

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkkSWAAoJEN0jrNd/PrOhnAoP/3dnbiyJe31uxLcJwE0Bm10+
EMBYvkA7Bct+YasVpd/xS3BVCda+L4mG3qDxUWJriU9YZ6ybEnRIrpPhxh1+xoWA
iQXLkPHK+1+0f5NR56vqfOtDlY+NS2YQx2lQZ/CtswpRSzA8dYXGiVZwWXQMjsC/
f+Uj19Wusn+4Qym4AekPP5HclGyqBpYuqmZM8Yp96QHyrd3jEu4YZeRh492Fs9Xv
Xi8R5en3ZHEfU2erAgJIrY1jg0/g8TI6WGaXmGEz5SsTX7QSLde1RaJYsSoLOqsE
zm2icD8FEM3oS95zoAuoFXk5N0zL/xNWDghurLWcmG6A6iHNAeB0qAYebq888HNe
KUUObwgkfy2UaFGcLqf1VmQ8uw4p76yNwgRT1Zv+jNO7zsrZAo7zyzcYFnF4pHrv
BmspaojhXs3CRVXG0PwipcYP2SmKgnV2KpkK4aHnAS6uUMyEHP6ZB2UOqi7/SfOD
57h5Eo6ZczLWbYzYHaLr7JZE2F94p9h2vZg6utUmlaWoVFFgJeowWr+DgpdhiCwH
EFhYz4+YP4f8tEpnMY39Y8BqMJayIYbinqVgmwsbHOQWQnYAV+D3f0UzxxxRnqjP
tYhmNsaC+fiW0ZXAifXcxkddv+Dr1Owg7cEvZ7lFr6CCsIdEsbVfs8aFZ5zHQiCI
p2HYv8e/oeHFxbpX+8wi
=iyXI
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

--===============6915435674400188627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6915435674400188627==--
