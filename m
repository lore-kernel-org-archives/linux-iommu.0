From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] ARM: dma-mapping: update comment about handling
	dma_ops when detaching from IOMMU
Date: Fri, 14 Sep 2018 18:11:56 +0200
Message-ID: <20180914161156.GB906@kunai>
References: <20180913151716.6333-1-wsa+renesas@sang-engineering.com>
	<20180913151716.6333-2-wsa+renesas@sang-engineering.com>
	<CAMuHMdV_xpj62BkqwoTAaaugM3BkDRQTC=E0cEDqKBg3sUYNBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8644401150453280278=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdV_xpj62BkqwoTAaaugM3BkDRQTC=E0cEDqKBg3sUYNBg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============8644401150453280278==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2018 at 02:15:01PM +0200, Geert Uytterhoeven wrote:
> On Thu, Sep 13, 2018 at 5:18 PM Wolfram Sang
> <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org> wrote:
> > Update the comment because we don't set the pointer to NULL anymore.
> > Also use the correct pointer name 'dma_ops' instead of 'dma_map_ops'.
> >
> > Fixes: 1874619a7df4 ("ARM: dma-mapping: Set proper DMA ops in arm_iommu=
_detach_device()")
> > Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
>=20
> Nice catch!
>=20
> Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Thanks, so I sent this seperately via ALKML now.


--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlub3cwACgkQFA3kzBSg
KbZBbRAAr9FUPBM/xafVRAtQivVuRwm9hR8mLRKPGHRuj6GBiEIcwH50OokDvsrS
vH4PiT6mXjS7HEkQ+N9INFIKJNibcj62IUZyVXe2GIEUft6A1xVeronjv/278Yg9
ExDON7xo3xR2FPapTDKrsEPKhc9r20DGlaHnOoHl8cRDvTeHaUdVIck74kV+irby
Fz0x2OGNeMo+5iW9NuodQdmGWJZKNDjisSd3jl/0BVp6skLt38NId3HHY0H1IbI8
2sVBVOgFZ17gQxAV4I3iu3XMjJWpWhXt3gNIBhp/duK1/N61SURd0x8dfYGUdLVi
s7LpGsv4x16mp4Vl1oSkwqSLfgHTOKoBS1hRei90nAkFLS1CuHNdJoKoo7yQpxX2
E+WqccOQiKkhMaepGxmycUDzTfslNEsVG2FV/pyZ9SoDJQE/iTXKrllcttpitfyf
6X9NOqeunyRJDyBseqS3zsCMivD20197ZOG0yu/wv+ixzlVSKCGUljUPlqx00S3H
Sa1+JiKPr7yRneb4T7IdEAE5pUr+flxDXHWu85676AUAmbxN2JVnwGzRJ2BgSnGf
6bE4dhAkLSPOd18UzsZeu/Tj61Ys8xLzagA1Akq4uHWkpegTa/23qIfccDzN1G6d
Vl96IMyXBXNE7zbBwvXzq+SNtrJe46XWPLoJcKu4/Z+iGVaouJI=
=+tnW
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--

--===============8644401150453280278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8644401150453280278==--
