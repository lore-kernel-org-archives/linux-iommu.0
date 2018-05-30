From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 2/2] drm/nouveau: tegra: Detach from ARM DMA/IOMMU
 mapping
Date: Wed, 30 May 2018 15:41:16 +0200
Message-ID: <20180530134116.GB5400@ulmo>
References: <20180530080345.2353-1-thierry.reding@gmail.com>
 <20180530080345.2353-3-thierry.reding@gmail.com>
 <7960e4fc-f680-f8d1-0c5a-3ff1e13b3154@arm.com>
 <20180530130045.GB1595@ulmo>
 <856db04f-592c-1618-36a8-100808693813@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3953824513073992350=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <856db04f-592c-1618-36a8-100808693813@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: nouveau@lists.freedesktop.org, Joerg Roedel <joro@8bytes.org>, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jordan Crouse <jcrouse@codeaurora.org>, iommu@lists.linux-foundation.org, Ben Skeggs <bskeggs@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org


--===============3953824513073992350==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 02:30:51PM +0100, Robin Murphy wrote:
> On 30/05/18 14:00, Thierry Reding wrote:
> > On Wed, May 30, 2018 at 11:30:25AM +0100, Robin Murphy wrote:
> > > On 30/05/18 09:03, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > Depending on the kernel configuration, early ARM architecture setup=
 code
> > > > may have attached the GPU to a DMA/IOMMU mapping that transparently=
 uses
> > > > the IOMMU to back the DMA API. Tegra requires special handling for =
IOMMU
> > > > backed buffers (a special bit in the GPU's MMU page tables indicate=
s the
> > > > memory path to take: via the SMMU or directly to the memory control=
ler).
> > > > Transparently backing DMA memory with an IOMMU prevents Nouveau from
> > > > properly handling such memory accesses and causes memory access fau=
lts.
> > > >=20
> > > > As a side-note: buffers other than those allocated in instance memo=
ry
> > > > don't need to be physically contiguous from the GPU's perspective s=
ince
> > > > the GPU can map them into contiguous buffers using its own MMU. Map=
ping
> > > > these buffers through the IOMMU is unnecessary and will even lead to
> > > > performance degradation because of the additional translation. One
> > > > exception to this are compressible buffers which need large pages. =
In
> > > > order to enable these large pages, multiple small pages will have t=
o be
> > > > combined into one large (I/O virtually contiguous) mapping via the
> > > > IOMMU. However, that is a topic outside the scope of this fix and i=
sn't
> > > > currently supported. An implementation will want to explicitly crea=
te
> > > > these large pages in the Nouveau driver, so detaching from a DMA/IO=
MMU
> > > > mapping would still be required.
> > >=20
> > > I wonder if it might make sense to have a hook in iommu_attach_device=
() to
> > > notify the arch DMA API code when moving devices between unmanaged an=
d DMA
> > > ops domains? That seems like it might be the most low-impact way to a=
ddress
> > > the overall problem long-term.
> > >=20
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > ---
> > > > Changes in v3:
> > > > - clarify the use of IOMMU mapping for compressible buffers
> > > > - squash multiple patches into this
> > > >=20
> > > >    drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 5 +++++
> > > >    1 file changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/d=
rivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> > > > index 78597da6313a..d0538af1b967 100644
> > > > --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> > > > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
> > > > @@ -105,6 +105,11 @@ nvkm_device_tegra_probe_iommu(struct nvkm_devi=
ce_tegra *tdev)
> > > >    	unsigned long pgsize_bitmap;
> > > >    	int ret;
> > > > +#if IS_ENABLED(CONFIG_ARM)
> > >=20
> > > Wouldn't CONFIG_ARM_DMA_USE_IOMMU be even more appropriate?
> >=20
> > Not necessarily. arm_dma_iommu_detach_device() is always defined on ARM,
> > only with CONFIG_ARM_DMA_USE_IOMMU=3Dn it will be empty. So this check =
is
> > a guard to make sure we don't call the function when it isn't available,
> > but it may still not do anything.
>=20
> Calling a function under condition A, which only does anything under
> condition B, when B depends on A, is identical in behaviour to only calli=
ng
> the function under condition B, except needlessly harder to follow.
>=20
> > > > +	/* make sure we can use the IOMMU exclusively */
> > > > +	arm_dma_iommu_detach_device(dev);
> > >=20
> > > As before, I would just use the existing infrastructure the same way =
the
> > > Exynos DRM driver currently does in __exynos_iommu_attach() (albeit w=
ithout
> > > then reattaching to another DMA ops mapping).
> >=20
> > That's pretty much what I initially did and which was shot down by
> > Christoph. As I said earlier, at this point I don't really care what
> > color the shed will be. Can you and Christoph come to an agreement
> > on what it should be?
>=20
> What I was getting at is that arm_iommu_detach_device() already *is* the
> exact function Christoph was asking for, it just needs a minor fix instead
> of adding explicit set_dma_ops() fiddling at its callsites which only
> obfuscates the fact that it's supposed to be responsible for resetting the
> device's DMA ops already.

It still has the downside of callers having to explicitly check for the
existence of a mapping, otherwise they'll cause a warning to be printed
to the kernel log.

That's not all that bad, though. I'll prepare version 4 with those
changes.

Thierry

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsOqfoACgkQ3SOs138+
s6GJgA//f5cwicHdAeHRwp276/TQ2rU5ptWf8sY2AoiKYQzkWTZzNnSGZ7CQyFMc
pw4L3NjfQptwtEzqoijyHJs7vkEp9ZZy2dvHQcGvwRHTyaU5u9PefoN1nYuKM0LV
jiVGUZiF1MaBfL5UlvuH79BNyNhZAQ5gRKxsYkd1AWXF1s9pSuS+C4vXIJ5Io0IB
GUK2Fb1vEupCTdXdv4OhBXgMyFb61a7UdVz94Jg6IvZE1ThPL15aTEAzKRnp9xkD
UC0N+Jsz4kdmd+Lt9uNkVQM5zmasGXzON8qwRESs7yJZ9kgKaErgsEBZtS7siAtw
KSUxn+vKgq8USscwaT071i4vtrSXzBvuPdC4XxYEVHG/EH2N4EqVh5onNuqczzJ3
Fds2HAhTB+TVdhrealywJicxwkYhflKMrNuxMdvtx0boFzGXDI/pZoNnUEtRZrC/
oHxTVNBNx1BttEfkZJ4JPObXFtn42bv0sUG8WNyJ95gu2cicw1VWwWnsH4U6JWiN
l7DOVQDQRH/Rv0kKbrr18oS59wNx6tYHcxpGLLhOLi/k9exX0R9uPvvixFlGVyha
eQvKtcwvEw//PsAiTfnD1537tpHq97c8Sv741GqKzoOJ30VFS8Xv8NrenaBy4FZe
bNE/e2Zed7l+eNMnUSoWOFReKaxr1WElvOgTDYo9CnGBVV9nMQU=
=9XT9
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--


--===============3953824513073992350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3953824513073992350==--
