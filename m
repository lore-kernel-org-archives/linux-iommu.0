From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/5] drm/nouveau: tegra: Detach from ARM
 DMA/IOMMU mapping
Date: Thu, 26 Apr 2018 14:41:03 +0200
Message-ID: <20180426124103.GF11985@ulmo>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425152849.GA2447@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1213382348=="
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180425152849.GA2447-9PYrDHPZ2Orvke4nUoYGnHL1okKdlPRT@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--===============1213382348==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 09:28:49AM -0600, Jordan Crouse wrote:
> On Wed, Apr 25, 2018 at 12:10:47PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > Depending on the kernel configuration, early ARM architecture setup code
> > may have attached the GPU to a DMA/IOMMU mapping that transparently uses
> > the IOMMU to back the DMA API. Tegra requires special handling for IOMMU
> > backed buffers (a special bit in the GPU's MMU page tables indicates the
> > memory path to take: via the SMMU or directly to the memory controller).
> > Transparently backing DMA memory with an IOMMU prevents Nouveau from
> > properly handling such memory accesses and causes memory access faults.
> >=20
> > As a side-note: buffers other than those allocated in instance memory
> > don't need to be physically contiguous from the GPU's perspective since
> > the GPU can map them into contiguous buffers using its own MMU. Mapping
> > these buffers through the IOMMU is unnecessary and will even lead to
> > performance degradation because of the additional translation.
> >=20
> > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> > I had already sent this out independently to fix a regression that was
> > introduced in v4.16, but then Christoph pointed out that it should've
> > been sent to a wider audience and should use a core API rather than
> > calling into architecture code directly.
> >=20
> > I've added it to this series for easier reference and to show the need
> > for the new API.
>=20
> This is good stuff, I am struggling with something similar on ARM64. One
> problem that I wasn't able to fully solve cleanly was that for arm-smmu=
=20
> the SMMU HW resources are not released until the domain itself is destroy=
ed
> and I never quite figured out a way to swap the default domain cleanly.
>=20
> This is a problem for the MSM GPU because not only do we run our own IOMM=
U as
> you do we also have a hardware dependency to use context bank 0 to
> asynchronously switch the pagetable during rendering.
>=20
> I'm not sure if this is a problem you have encountered.

I don't think I have. Recent chips have similar capabilities, but they
don't have the restriction to a context bank, as far as I understand.
Adding Mikko who's had more exposure to this.

> In any event, this code
> gets us a little bit further down the path and at least there is somebody=
 else
> out there in the cold dark world that understands my pain. :)

This doesn't actually fix anything on 64-bit ARM, and oddly enough I
haven't run into this issue myself on 64-bit ARM either. I think the
reason is that I haven't tested Nouveau on Tegra186 yet, which is the
first SoC which has an ARM SMMU. On prior 64-bit ARM chips we've used
the custom Tegra SMMU and that driver simply forbids creating any DMA
domains, so it will allow only explicit usage of the IOMMU API. There
is code in the generic DMA/IOMMU integration layer to not use the DMA
API with non-DMA IOMMU domains, but that's not true on 32-bit ARM,
unfortunately. It's entirely possible that Tegra186 will show exactly
the same problem that you are describing.

We do use the IOMMU API explicitly in the Tegra DRM driver as well,
and that is something that I've tested on Tegra186 and that I know to
be working. However, the reason why it works there is that the IOMMU
group will contain multiple display controllers, which will again
trigger a special case that will prevent the DMA/IOMMU integration
=66rom setting up a DMA domain for use with those devices.

> For your interest, here was my half-hearted attempt to avoid creating DMA
> domains in the first place based on a blacklist to try to spur a bit of
> discussion: https://patchwork.freedesktop.org/series/41573/

This looks very interesting and simple, but I can imagine that it will
see significant pushback from the ARM SMMU maintainers (if not complete
silence), because it adds SoC-specific knowledge to an otherwise fully
generic driver. Having the GPU driver explicitly detach from the IOMMU
domain sounds like a better option, but I don't see how that would help
with the context bank issue that you're seeing.

One other possibility that I can imagine is to add something to struct
device that could be used by arch_setup_dma_ops() to not attach any of
the IOMMU-backed DMA operations to the device. Unfortunately that code
is called before the driver's ->probe() implementation is called, so a
driver doesn't have an opportunity to set it. Something like
of_dma_configure() could still set that up, perhaps based on some DT
property, though I can already hear the NAK from DT maintainers because
this is, after all, policy, not hardware description.

The last solution that I can think of that might allow us to do this is
to add a flag to struct device_driver (bool explicit_iommu?) that will
be used by the DMA/IOMMU setup code to decide whether or not to attach
to the IOMMU automatically.

Though, again, I'm not sure that would actually solve your bank problem.
That's really something I don't see any other solution than to fix it in
the ARM SMMU driver. Perhaps context bank 0 can always be reserved for
non-DMA domains?

Thierry

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrhyN0ACgkQ3SOs138+
s6FmjQ//U3HvtvhAphVFr1x+uAqV+uMCOpAaY3OhLMyk/IlbCZ6ON/o3k/BHKuds
s3jR0P5kr81B+3bN3eZoIizqATXnGAK0heVjJh1/oNTWTkarXAPWPdpVWkRy2zwF
0q6nkT4+y1nIpzqIvKMK5iHnODYSxDe3iCgFhloSL/fS7ZJnVgLDI82qGU40TPuW
kl6o4vucrEV3qGN97sImgEO6pL2XHPEigc/Xbi2YAqUUwEWPNqUrGwoEIaU6wzWi
yK7LT7DtNli8p1lXCij2SqFduxka8wVMUXNe7CDTABbZ7DF8rCvXcwPjRnGnGrLP
/YEFMHYGiBLP4Wu7EIsqOrBNFF6OnLdb7TqA7Lt9zfC6EoncRtChGFnnRh+c0a7m
FHTts5H2MK6w4Pafw+AOd3OElLLxOx53lZSoEEwM/1npeQ9kBBpN+eOUzfBeWkkt
cWQoVLO6mLnpY3H8gpkoOhjLYvs4ILFjeT93EpJCeGDC8NtimZbBe3lcrfiEc7Xh
sHqDPR07QqJFBTLx7+kkw4RjEaOfkZXyAH27Qb8aSHneWWG2MNdfD+IqAAfU8+Be
eWC86kSM429C0ilAcpf5ZWxYLwXEmimltztg5ewbmzNejY7KFvaCZovVrbIpQJVU
+cS95j0ROIucy9XumPVxRu8Gh+mFMb9rqAzHyODy+cGoAJnsIsw=
=AocE
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--

--===============1213382348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTm91dmVhdSBt
YWlsaW5nIGxpc3QKTm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9ub3V2ZWF1Cg==

--===============1213382348==--
