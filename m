From: Petr Tesarik <ptesarik-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 0/2][RFC] kernel/dma: Support platform-specific default
	CMA sizes
Date: Mon, 4 Mar 2019 13:24:06 +0100
Message-ID: <20190304132406.3245eac5@ezekiel.suse.cz>
References: <20190304115255.2088-1-tzimmermann@suse.de>
	<fe3f4ae9-6a51-0b50-09e9-6c7f52e530d3@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3154762966702971929=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <fe3f4ae9-6a51-0b50-09e9-6c7f52e530d3-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--===============3154762966702971929==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/thI4whUP_ZMTy38wQEEEy=q"; protocol="application/pgp-signature"

--Sig_/thI4whUP_ZMTy38wQEEEy=q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Mar 2019 12:01:29 +0000
Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

> Hi Thomas,
>=20
> On 04/03/2019 11:52, Thomas Zimmermann wrote:
> > This is an RFC patch set that adds support for configuring a default CMA
> > size, depending on the platform.
> >=20
> > At SUSE, our ARM installer image runs on a variety of platforms. One of
> > these, the Raspberry Pi 3, requires CMA to be allocated on order to pro=
vide
> > graphics output. Currently this can be done with the kernel's cma comma=
nd-
> > line parameter, or with a compile-time setting. The cma parameter requi=
res
> > user intervention during boot. Using a compile-time constant affects all
> > platforms. So both options are undesireable.
> >=20
> > This patch set adds a data structure and look-up code to select a defau=
lt
> > CMA size, depending on the device's model name. The kernel's cma parame=
ter
> > or a compile-time setting take precedence of the per-device default. =20
>=20
> Is there some issue with specifying a board-specific default CMA region=20
> via the existing DT binding[1]? I assume there are no ACPI concerns in=20
> this particular case.

Indeed.

Thomas, did you have a look how the installer gets booted on the
Raspberry Pi? Are we simply using the pre-installed bootloader in this
scenario?

Petr T

> Robin.
>=20
> [1]
> Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
>=20
> > For the Raspberry Pi 3, the CMA allocator now reserves 64 MiB (out
> > of 1 GiB) by default. We found that this is enough memory to run a
> > graphics installer or a simple desktop environment under X11.
> >=20
> > Thomas Zimmermann (2):
> >    kernel/dma: Support device-specific CMA defaults
> >    kernel/dma: Default to 64 MiB of contiguous memory on Raspberry
> > Pi 3
> >=20
> >   kernel/dma/contiguous.c | 62
> > +++++++++++++++++++++++++++++++++++++++++ 1 file changed, 62
> > insertions(+)=20


--Sig_/thI4whUP_ZMTy38wQEEEy=q
Content-Type: application/pgp-signature
Content-Description: Digitální podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAlx9GOYACgkQqlA7ya4P
R6dnKgf+NxFbWdBINDJpz5msBEVMUiuICGqW4ZRiq6RqKjyEHhav4jEjo9usZ2zm
5kab8I++if1eiqBgUbhi21Yc6RPcgpXD2GQUSdEOoNduPUoZU62EwWjZtacJP5lH
oOKFs/x0JVatkiYTCb0aL7Hpm95+DvuTkLL6/GV3/QqPgQUNJ/X0exbuZNrNouiT
Gn/IJzdU9OHTz7V5E2hwSCv/UrH/hxOR8q7qOiStNzhMrg8G2kitsb8mcyZ8y+8g
EDbOiRv7WSB+8903y8EfbrEhG5ZxI4p2pPDCZ0Nmnmd8IGpgVSkQ1r9ziaFNaZqa
03K/6TZFeZUrRZzjQKocvq654MvvZQ==
=byh2
-----END PGP SIGNATURE-----

--Sig_/thI4whUP_ZMTy38wQEEEy=q--

--===============3154762966702971929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3154762966702971929==--
