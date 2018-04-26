From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/5] drm/nouveau: tegra: Detach from ARM DMA/IOMMU
	mapping
Date: Thu, 26 Apr 2018 14:09:41 +0200
Message-ID: <20180426120941.GC11985@ulmo>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
	<20180425151815.GB16075@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7103677196745434772=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180425151815.GB16075-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============7103677196745434772==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 08:18:15AM -0700, Christoph Hellwig wrote:
> The series seems to miss a cover letter.
>=20
> Also I really think this patch original patch shouldn't be in the proper
> series.

I added a note explaining why I included this. Not everyone in this
discussion had seen the patch and therefore may not be aware of the
problem that the series attempts to fix. I agree that it shouldn't
be merged as part of the series, though.

Thierry

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrhwYUACgkQ3SOs138+
s6F1yRAApwk/4hhrzydb/pEWbyUCP78zIU7Fzf2xnts9uNOUTuf6H1VjX3Z7ZhI7
XCnIuz9Bia+hiokgY2UpvTWPUS6LFuRAy6vgShL7G8fsbmYZsE9q9n98enyF6tmU
lJKUZxGW0F25sYxEBJ2kizrNR4K8b7nW/mwbpHUK1DUU+YqVwBg/Gd8GLGF6wg+I
G+xb8rFK207rZv6wzL68U9dOslcYb1GapS8UXqzXZivLMEK/dHal3xYmB0lEv/wL
7cH9snklso57/WNtr1OGL8+494O8o5tZXYyPXHn7mFF1Rznvbt4CVzcLp1z3S0i+
u8S2MFo8JI6Vj+WptDp2I3UmIMY7GXDKDhKlowcOTe5n4wfAjN/g1/Sl0Aryn46c
4NTxl7frwAVLvVkSxcErrT1HXhVgyCT/G4VqWG6Oiue8h/wz87i5OBV9pwqr3VgI
fxhxV/liF/zHHUBwelP/hd+AkZvejjMZuC+fwoxDOW+vCp7G9P72ec8mGvtWDyBW
dT3DktsXZ05+G+Iq/I04pQOv786gpezyWr3EaKATDKCHylN/9SWX543wyBzeWhbc
NY8NoR6KzVAt1V8IGvIuhfGt8QMn6UADnjplsELKoW0FoTYBU8T9VpI5LU7lu6O8
8JUkXfaeJuCJeBp2SRMpghQHtdVidiIHyD762FcKGvLQ9HLJZU8=
=hVVR
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--

--===============7103677196745434772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7103677196745434772==--
