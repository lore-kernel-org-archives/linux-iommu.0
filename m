From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ARM: dma-mapping: Implement
	arm_dma_iommu_detach_device()
Date: Wed, 30 May 2018 14:54:46 +0200
Message-ID: <20180530125446.GA1595@ulmo>
References: <20180530080345.2353-1-thierry.reding@gmail.com>
	<20180530080345.2353-2-thierry.reding@gmail.com>
	<eee02391-aa25-da84-f98a-b5fed6c69599@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9088189861595639827=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <eee02391-aa25-da84-f98a-b5fed6c69599-5wv7dgnIgG8@public.gmane.org>
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
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============9088189861595639827==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 30, 2018 at 10:59:30AM +0100, Robin Murphy wrote:
> On 30/05/18 09:03, Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > Implement this function to enable drivers from detaching from any IOMMU
> > domains that architecture code might have attached them to so that they
> > can take exclusive control of the IOMMU via the IOMMU API.
> >=20
> > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> > Changes in v3:
> > - make API 32-bit ARM specific
> > - avoid extra local variable
> >=20
> > Changes in v2:
> > - fix compilation
> >=20
> >   arch/arm/include/asm/dma-mapping.h |  3 +++
> >   arch/arm/mm/dma-mapping-nommu.c    |  4 ++++
> >   arch/arm/mm/dma-mapping.c          | 16 ++++++++++++++++
> >   3 files changed, 23 insertions(+)
> >=20
> > diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/=
dma-mapping.h
> > index 8436f6ade57d..5960e9f3a9d0 100644
> > --- a/arch/arm/include/asm/dma-mapping.h
> > +++ b/arch/arm/include/asm/dma-mapping.h
> > @@ -103,6 +103,9 @@ extern void arch_setup_dma_ops(struct device *dev, =
u64 dma_base, u64 size,
> >   #define arch_teardown_dma_ops arch_teardown_dma_ops
> >   extern void arch_teardown_dma_ops(struct device *dev);
> > +#define arm_dma_iommu_detach_device arm_dma_iommu_detach_device
> > +extern void arm_dma_iommu_detach_device(struct device *dev);
> > +
> >   /* do not use this function in a driver */
> >   static inline bool is_device_dma_coherent(struct device *dev)
> >   {
> > diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-=
nommu.c
> > index f448a0663b10..eb781369377b 100644
> > --- a/arch/arm/mm/dma-mapping-nommu.c
> > +++ b/arch/arm/mm/dma-mapping-nommu.c
> > @@ -241,3 +241,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma=
_base, u64 size,
> >   void arch_teardown_dma_ops(struct device *dev)
> >   {
> >   }
> > +
> > +void arm_dma_iommu_detach_device(struct device *dev)
> > +{
> > +}
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index af27f1c22d93..6d8af08b3e7d 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -2400,3 +2400,19 @@ void arch_teardown_dma_ops(struct device *dev)
> >   	arm_teardown_iommu_dma_ops(dev);
> >   }
> > +
> > +void arm_dma_iommu_detach_device(struct device *dev)
> > +{
> > +#ifdef CONFIG_ARM_DMA_USE_IOMMU
> > +	struct dma_iommu_mapping *mapping =3D to_dma_iommu_mapping(dev);
> > +
> > +	if (!mapping)
> > +		return;
> > +
> > +	arm_iommu_release_mapping(mapping);
>=20
> Potentially freeing the mapping before you try to operate on it is never =
the
> best idea. Plus arm_iommu_detach_device() already releases a reference
> appropriately anyway, so it's a double-free.

But the reference released by arm_iommu_detach_device() is to balance
out the reference acquired by arm_iommu_attach_device(), isn't it? In
the above, the arm_iommu_release_mapping() is supposed to drop the
final reference which was obtained by arm_iommu_create_mapping(). The
mapping shouldn't go away irrespective of the order in which these
will be called.

> > +	arm_iommu_detach_device(dev);
> > +
> > +	set_dma_ops(dev, arm_get_dma_map_ops(dev->archdata.dma_coherent));
> > +#endif
> > +}
> > +EXPORT_SYMBOL(arm_dma_iommu_detach_device);
>=20
> I really don't see why we need an extra function that essentially just
> duplicates arm_iommu_detach_device(). The only real difference here is th=
at
> here you reset the DMA ops more appropriately, but I think the existing
> function should be fixed to do that anyway, since set_dma_ops(dev, NULL) =
now
> just behaves as an unconditional fallback to the noncoherent arm_dma_ops,
> which clearly isn't always right.

The idea behind making this an extra function is that we can call it
unconditionally and it will do the right things. Granted, that already
doesn't quite work as elegantly anymore as I had hoped since this is
now an ARM specific function, so we need an #ifdef guard anyway.

I don't care very strongly either way, so if you and Christoph can both
agree that we just want arm_iommu_detach_device() to call the proper
variant of set_dma_ops(), that's fine with me, too.

Thierry

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlsOnxMACgkQ3SOs138+
s6GE2A//dfsRFRDkGJeKcLMXf4TFhfseAUT1M6c5Fm5cxwQwqWDiMbsZOXdMBloM
o437ndD8QbfaraVHFTscD3uOsp3OHfVqpYyJCGHhihp4nqslBXsy/i8Qv9ej4ENi
eEP8Dn3WEeNTobl70Rvsy40ERt1G+BKp2HSDV/wbRkGLHj0LyqVjaWOPxGcbIe4q
opKibSGoOU1T5kdq2OcX8IZz/lV2VUu1wLVn9k+AYdRq8ID4hPbXjGL1RjciMB6Y
VHvW4GM8wZm+ZpguE8iUEcKlXFRF/AbAI18D841m8CHY0USo/TdmOMgBEsJdn+iM
ZaqAiqiUpXD05DpGhbUXcXC6Ynup6qjMRkTdvaJax5RgTKevRzWvfDvVL8y8y+A2
9spYEqWgByhnnZXPeaqERX9Tn6+Pk8tveG6WFsudyFKKp3i0ZgbbpGS5lsfJsQVV
6zmG8mscuX9eBwB490VLbFXA/mWEzgh2nD90oPQhE8FHV2vduEfgk1hzlmzlcOTb
ohLKBzxiwYVj9KIPVhnCpfRE0XC8Nt3DYngYQwbRoe5xAHLi+5F4PaeDmH2tlSc+
o0+BowVO6K+5VuKmEm/xuqrzlftt95uLlQYmn7OlmPutPQizRlg40yFVE8UC2Nn0
jIsJq7FYlcsIif5NTMD/rRgMc6nrP7TeoncewfImdkWrpUayVTs=
=seGm
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

--===============9088189861595639827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9088189861595639827==--
