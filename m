From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/5] dma-mapping: Introduce dma_iommu_detach_device()
 API
Date: Mon, 30 Apr 2018 13:02:31 +0200
Message-ID: <20180430110231.GF2476@ulmo>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425101051.15349-2-thierry.reding@gmail.com>
 <20180425151934.GC16075@infradead.org>
 <20180426121136.GD11985@ulmo>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0997261042=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180426121136.GD11985@ulmo>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: nouveau@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org


--===============0997261042==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Content-Disposition: inline


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 02:11:36PM +0200, Thierry Reding wrote:
> On Wed, Apr 25, 2018 at 08:19:34AM -0700, Christoph Hellwig wrote:
> > On Wed, Apr 25, 2018 at 12:10:48PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >=20
> > > The dma_iommu_detach_device() API can be used by drivers to forcibly
> > > detach a device from an IOMMU that architecture code might have attac=
hed
> > > to. This is useful for drivers that need explicit control over the IO=
MMU
> > > using the IOMMU API directly.
> >=20
> > Given that no one else implements it making it a generic API seems
> > rather confusing.  For now I'd rename it to
> > arm_dma_iommu_detach_device() and only implement it in arm.
>=20
> That'd be suboptimal because this code is used on both 32-bit and 64-bit
> ARM. If we make the function 32-bit ARM specific then the driver code
> would need to use an #ifdef to make sure compilation doesn't break on
> 64-bit ARM.

Do you still want me to make this ARM specific? While I haven't
encountered this issue on 64-bit ARM yet, I think it would happen there
as well, under the right circumstances. I could take a shot at
implementing the equivalent there (which means essentially implementing
it for drivers/iommu/dma-iommu.c and calling that from 64-bit ARM code).

Thierry

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrm98UACgkQ3SOs138+
s6EExBAAmDM+xgOh1951XBz8yxrk7+Et/NzR5wNx72a5Mnnv6znRSNsYZrBNDS5v
91+B3jAy6oj9Yd6c7OJ62vPYUlyrri4cV4mIZX2HMhYBtn/Fj5Ur9l8KDS4kgPGB
9S++aqjlbk40yuxBpb2hHcHY7WDytTXq5UiWcejIn1+TIN0WR0uRFIyXYVgpAqdx
PQmzMXpCgZWpmKKu9takqENCMJNUqSaU4DDxj7E+PRmZpa2JWYnChjf0sGNupo3D
+funq3GO8+yThG46fVHHsDygwEelxkzBxdF6fgKC7wiU3kom6vUD6/2NcL8sRH0U
Fa+XKphCBPsuhL3EmBTtQtABtzIm6+Et9XmGInOR447z85KSp7mwzWcvLaGAfoij
BIO4AIL9SOg0J1cTce5oOrtCdBriGWFIXpp478MkfyitLPLAbqDkrn+GcfS53LoG
CXRllGJ3XCmtYJ/3TM9MjoieIHs5X5V5VLER+KTM+iWt4Jh0ooXr8O7orbmiQ99B
K92wilEwTzvyEMG+HQOO7aP4pt+gqLzV38Ly8yaZDsrTQdFpFjpmaTRWxJof9KTe
1GudUvLQfDAqD/sGxcQbCKIF908rTy57eCYC5Vb1o/bxxBIyeRc67seLeyDTk1mP
bXz4i9FFETrp97zMumjuwUcW/oFEmZx56RAsQu2PxnyoI+07xGY=
=n0M9
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--

--===============0997261042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0997261042==--
