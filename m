From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/5] drm/nouveau: tegra: Detach from ARM
 DMA/IOMMU mapping
Date: Thu, 26 Apr 2018 15:14:18 +0200
Message-ID: <20180426131418.GH11985@ulmo>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425152849.GA2447@jcrouse-lnx.qualcomm.com>
 <20180426124103.GF11985@ulmo>
 <fd6e0d90-7614-296b-2927-7b2745e8fbde@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1188704640=="
Return-path: <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fd6e0d90-7614-296b-2927-7b2745e8fbde-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/nouveau>
List-Post: <mailto:nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/nouveau>,
 <mailto:nouveau-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "Nouveau" <nouveau-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============1188704640==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 03:59:04PM +0300, Mikko Perttunen wrote:
> On 26.04.2018 15:41, Thierry Reding wrote:
> > On Wed, Apr 25, 2018 at 09:28:49AM -0600, Jordan Crouse wrote:
> > > On Wed, Apr 25, 2018 at 12:10:47PM +0200, Thierry Reding wrote:
> > > > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
> > > > performance degradation because of the additional translation.
> > > >=20
> > > > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > > ---
> > > > I had already sent this out independently to fix a regression that =
was
> > > > introduced in v4.16, but then Christoph pointed out that it should'=
ve
> > > > been sent to a wider audience and should use a core API rather than
> > > > calling into architecture code directly.
> > > >=20
> > > > I've added it to this series for easier reference and to show the n=
eed
> > > > for the new API.
> > >=20
> > > This is good stuff, I am struggling with something similar on ARM64. =
One
> > > problem that I wasn't able to fully solve cleanly was that for arm-sm=
mu
> > > the SMMU HW resources are not released until the domain itself is des=
troyed
> > > and I never quite figured out a way to swap the default domain cleanl=
y.
> > >=20
> > > This is a problem for the MSM GPU because not only do we run our own =
IOMMU as
> > > you do we also have a hardware dependency to use context bank 0 to
> > > asynchronously switch the pagetable during rendering.
> > >=20
> > > I'm not sure if this is a problem you have encountered.
> >=20
> > I don't think I have. Recent chips have similar capabilities, but they
> > don't have the restriction to a context bank, as far as I understand.
> > Adding Mikko who's had more exposure to this.
>=20
> IIRC the only way I've gotten Host1x to work on Tegra186 with IOMMU enabl=
ed
> is doing the equivalent of this patch (or actually using the DMA API, whi=
ch
> may be possible but has some potential issues).
>=20
> As you said, we don't have a limitation regarding the context bank or
> similar - Host1x handles context switching by changing the sent stream ID=
 on
> the fly (which is quite difficult to deal with from kernel point of view =
as
> well), and the actual GPU has its own MMU.

One instance where we still need the system MMU for GPU is to implement
support for big pages, which is required in order to do compression and
better performance in some other use-cases. I don't think we'll need
anything fancy like context switching in that case, though, because we
would use the SMMU exclusively to make sparse allocations look
contiguous to the GPU, so all of the per-process protection would still
be achieved via the GPU MMU.

Thierry

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrh0KcACgkQ3SOs138+
s6ET/hAAl3I5vduj0GoLRpKqnMsHfj8XJleCYi+4Wx8MNXgI2M3MdfQDyC1hZMUj
/ed49D0v0gKgmsLi9Xtm6Gf/jJgisI76FaKGJ34ZaUhi1HC5SfZ4gN/FtC7rPt/k
iqKv8e50+Vy69H3rtGEuNM+xy7qqiA7/IkcJqYJjA4enjm3X5dSJcIJLSVqfXzxX
n+XWRiBUaSIhilNZUCAPHm8nhKmLVrP7PW0B1+O8HPJk07H3mEMROA2L3cELYwHV
8CRg8vAEQiA0WSstD6fnU8IwD30KC4qNfbyQF2daptrM7Z/NencqlvRejEOU4g/1
t94fIw1BrMCTJGXxrO2LperGMyRJwlDG6KfDXliMMolw5Sfp8uZ6Crz5Nike4A7C
M0JGVIr10PcU9ffRkeB+L0QsJN/euzDzNASrup/l6eK7Jn2wOBrWN8jbr+PleYJm
AYuBCV2uLGTy1aMb22C098Js9iGuyf90DNW4m+HWZFFPcV8dtQT2h59zvgAKr2Er
PEQkxKFB8KMxNPuReNz60y3fdkMTJ6Ejc6qX3ZarsF7vH0jNq3Zf7hMClCuOddda
08uBeFIbyDcPg43eLaN8WcbY8kDahuGQkoI5lZPGgyfMVOia1vGyhFqNrjCSCJpS
EVj7XsSDHhD/uiKsBUchR1A8xf2eW3LSGCslCFB6D0A+dV+C1II=
=iN4x
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--

--===============1188704640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTm91dmVhdSBt
YWlsaW5nIGxpc3QKTm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9ub3V2ZWF1Cg==

--===============1188704640==--
