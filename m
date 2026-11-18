Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039007;
	b=EhKKRFXl16qxN73xNZhMo3ML03R1saU9UFcvP95CM2+4ocORwiixMWkjb1lu+M61kWGC
	 0YqwMvjl2pGb/DRusO+aiQ8+nLtUo1q572J8XlyaudUgsxuoH71rAPQCIjcIBDwH5z4xT
	 UV8X7ny/x2cx9b9hwld37ye2LdSCrr29F3yqNCqE8Z3Q6/82bCS323QPp34fePMLIvs0C
	 tCgOuOXYxAyiKC4VQJsEHIqpy+s9H1Nenkcx55Djovp79XvNQL9Qx4xkWjHPPX9xmeQSS
	 StiL1SvDTH/r+2mmMERVxLAe1o8u5pGiw07gRd910mB2JtXKkrjmgxtAJTwm7btk63w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039007;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=xxQ6PY+rfdV7jtvsJF4r/gSnP8FbOcab8QDdlt/1Mi0=;
	b=3Ohp5BHQhSKoUGkniONy6AKK3SyhHqn9tQoq8hc1P8IjpSLfHnK5N5ulTROJ6rxqLHE8
	 I068w/QJ5QFdWV4yLhshPOFcJ29J09TYJsriNNhx9xoiIw2T945/W6/9Kamw+n3ibtMly
	 PZ/npJwI6k3/yEA10PJQ0zkjowkSH5tFj+SmJL/zyyeRdZ98+v0+Iyc798VBcXHFAfC7d
	 WNnZQLIRw0GkepYYVfLHA8j70WLyuguSw38d7oWyO20nQSShtR8MaWDEPfjeAQuU/tOdq
	 vG8dIMncEEb5NLkBk6Mf/gwc/axX8NEGgP0iqrCu6V17k4By3X+kah86V73BkhjKVdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=TD3df0AC;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C884606A325;
	Wed, 18 Nov 2026 21:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C884606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=TD3df0AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795039004;
	bh=pgHuQ1HVyLgR9CsAiARcDsEuwXoOXy5E0ScCU9fZ9sY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TD3df0ACGoRlHtp9q44ZYPKQZ6UcmkINiKCv911AU5uMWca8dEO20sT6nX49FFj0z
	 ffdnbvwTJHFkWPOWJEmx+3OHgXc1VUD6ESCF/DQhLp9EJ9jQ8fS0m2BuP0xAg0gOHL
	 7/GXNT43ah2WCGsLSTbDiet9BYYD+ArPaoFKd+F0wVrrRZHWkian3eC88hOMXGNweu
	 F/xunel1sV19mUR/HNK7MqcxWDM1oZQQtZjuBfRsDELMVsUqHUfciI+6e6k6R3DhKg
	 iG2MPWstYgopvq/XQgFsbXgYxtHEvqt31eYxLGab+FBpoZMGiB3OLxlj+AwFU4yIbI
	 7NbEbgycJJwcQ==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2E83417E06BF;
	Wed, 18 Nov 2026 22:56:42 +0100 (CET)
Message-ID: <70ed0df5a04b11d8dcfe41d91e86fc28dedcb132.camel@collabora.com>
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, "Joerg Roedel (AMD)"	
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy	
 <robin.murphy@arm.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng	
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Tamir Duberstein	 <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	 <work@onurozkan.dev>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 	iommu@lists.linux.dev,
 rust-for-linux@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, Detlev Casanova	
 <detlev.casanova@collabora.com>
Date: Wed, 18 Nov 2026 16:56:40 -0500
In-Reply-To: <20261118195130.GE3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
	 <20261116193821.GC2452510@ziepe.ca>
	 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
	 <20261117202055.GA3115493@ziepe.ca>
	 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
	 <20261118160909.GC3115493@ziepe.ca>
	 <ede3b421d419a35c115ed584e60e74bfd6b91dff.camel@collabora.com>
	 <20261118195130.GE3115493@ziepe.ca>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ZJcI0aBBaUP96hypVc6s"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

--=-ZJcI0aBBaUP96hypVc6s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 18 novembre 2026 =C3=A0 15:51 -0400, Jason Gunthorpe a =C3=A9cr=
it=C2=A0:
> On Wed, Nov 18, 2026 at 02:31:28PM -0500, Nicolas Dufresne wrote:
> > > > This seem to digress. All we want to do is use the iommu subsystem =
as intended
> > > > for the case the iommu driver is not inside the DRM driver (which s=
eems to have
> > > > never been the case so far in DRM).
> > >=20
> > > "As intended" means you use the DMA API and you do not touch
> > > the paging domain.
> > >=20
> > > "As intended" means you use iommufd if you want a domain full of user
> > > controlled mappings.
> >=20
> > As discussed at LPC, we believe its pointless for this type of device t=
o give
> > any direct page choices to userspace. Can you explain why you believe
> > differently?
>=20
> This is what was asked for a few messages back?
>=20
> > I'm not sure how this applies to our work. But since they are all broke=
n
> > according to you, let me give example of cores/iommu mapping we are usi=
ng, and
> > perhaps you'll be able to explain us correctly? I've picked the Rockchi=
p video
> > decoder, which is upstream but expose through V4L2 stateless API, but f=
rom a
> > hardware point of view is pretty much identical:
> >=20
> > The DT (which I read you must be broken and in violation of everything,=
 yet all
> > reviewed by DT maintainers):
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi#n1400
>=20
> You linked to a clocks line, I have no idea what I'm supposed to look
> at in this file. Can you explain what parts of the DT apply to what
> you are intersted in?

No, I linked to the four nodes, 2 decoders, 2 iommus.

>=20
> > The multi-core support proposal, its not doing process isolation, its n=
ot
> > strictly needed in higher level abstraction (though could be better), b=
ut its
> > using domains so that each core can actually see the same memory:
> > https://lore.kernel.org/all/20260810-rkvdec-multicore-v2-0-986f89d22cdc=
@collabora.com/
>=20
> IIRC This is the driver that had the weird not-quite-an-iommu issue and
> there were many complaints about it doing things with the API that
> make no sense because it's HW is bad.
>=20
>                 /*
>                  * To rewrite mapping into the attached IOMMU core, attac=
h a new empty domain that
>                  * will program an empty table, then detach it to restore=
 the default domain and
>                  * all cached mappings.
>                  * This is safely done in this interrupt handler to make =
sure no memory get mapped
>                  * through the IOMMU while the empty domain is attached.
>                  */

We are aware of this, someone have to find the time to go back to it and sp=
end
another year in discussion to try and fit the need to re-program the rkiomm=
u
after a decoder fault.

Our best guess of the hardware problem is that its "self reset" mechanism o=
n
fault spill over the mmio of the iommu. It pretty hard to create a rkiommu
function that does not look like a bigger hack. And until we had an agreeme=
nt,
this made it work for the users.

>=20
> But that doesn't excuse this:
>=20
>   As each core has its own IOMMU core, buffers must be mapped in each
>   core's IOMMU so that any run() call can use any core without having to
>   remap everything.
>=20
>   To do that, we use rockchip iommu domain's iommu devices list.
>   With that, one IOMMU domain can be mapped on multiple devices, meaning
>   that each call to iommu_map() will flush the new mapping on all devices
>   in the list.
>=20
> We have DT for this already, you use iommus=3D[] and list all your
> iommus and it sets everything up for you. Going around and changing
> domains behind the scenes when the core already attached DMA API

Mind linking examples and doc? No one mentioned this, maybe the DT maintain=
er
need to be educated, you guys don't participate when these bindings are mad=
e.

Can we group the iommus from driver instead of DT ? (these DT predates us t=
rying
to use the HW unfortunatly, so backward compatibility is kind of needed). N=
ote
that appart from the hack above the v4l2 mutli-core case has completely sta=
tic
domain, just that there is N device with the same domain. It is less safe, =
since
it does not do process isolation.

>=20
> Then WTF is this:
>=20
> -                       ret =3D iommu_map(iommu_get_domain_for_dev(core->=
dev),
> -                                       virt_addr, phys_addr,
>=20
> Seriously? You cannot directly map to a DMA API owned domain. It is
> fully illegal.

I guess I should fix that one, suggested change below (I'll make a patch la=
ter).
We should drop iommu_map() from any bindings. But that leaves us with no wa=
y to
use the rkiommu and do process isolation, which basically defeat the purpos=
e of
an iommu no?


RFC:
---
diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec-rcb.c b/drivers/=
media/platform/rockchip/rkvdec/rkvdec-rcb.c
index fdcf1f1773797..37d5677e4c8f9 100644
--- a/drivers/media/platform/rockchip/rkvdec/rkvdec-rcb.c
+++ b/drivers/media/platform/rockchip/rkvdec/rkvdec-rcb.c
@@ -9,7 +9,7 @@
 #include "rkvdec.h"
 #include "rkvdec-rcb.h"
=20
-#include <linux/iommu.h>
+#include <linux/dma-mapping.h>
 #include <linux/genalloc.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
@@ -44,7 +44,6 @@ void rkvdec_free_rcb(struct rkvdec_ctx *ctx)
 {
        struct rkvdec_dev *dev =3D ctx->dev;
        struct rkvdec_rcb_config *cfg =3D ctx->rcb_config;
-       unsigned long virt_addr;
        int i;
=20
        if (!cfg)
@@ -58,11 +57,11 @@ void rkvdec_free_rcb(struct rkvdec_ctx *ctx)
=20
                switch (cfg->rcb_bufs[i].type) {
                case RKVDEC_ALLOC_SRAM:
-                       virt_addr =3D (unsigned long)cfg->rcb_bufs[i].cpu;
-
-                       if (dev->iommu_domain)
-                               iommu_unmap(dev->iommu_domain, virt_addr, r=
cb_size);
-                       gen_pool_free(dev->sram_pool, virt_addr, rcb_size);
+                       dma_unmap_resource(dev->dev, cfg->rcb_bufs[i].dma,
+                                          rcb_size, DMA_BIDIRECTIONAL, 0);
+                       gen_pool_free(dev->sram_pool,
+                                     (unsigned long)cfg->rcb_bufs[i].cpu,
+                                     rcb_size);
                        break;
                case RKVDEC_ALLOC_DMA:
                        dma_free_coherent(dev->dev,
@@ -125,29 +124,19 @@ int rkvdec_allocate_rcb(struct rkvdec_ctx *ctx,
                                                        SZ_4K);
                }
=20
-               /* If an IOMMU is used, map the SRAM address through it */
-               if (cpu && rkvdec->iommu_domain) {
-                       unsigned long virt_addr =3D (unsigned long)cpu;
+               if (cpu) {
                        phys_addr_t phys_addr =3D dma;
=20
-                       ret =3D iommu_map(rkvdec->iommu_domain, virt_addr, =
phys_addr,
-                                       rcb_size, IOMMU_READ | IOMMU_WRITE,=
 0);
-                       if (ret) {
+                       dma =3D dma_map_resource(rkvdec->dev, phys_addr, rc=
b_size,
+                                              DMA_BIDIRECTIONAL, 0);
+                       if (dma_mapping_error(rkvdec->dev, dma)) {
                                gen_pool_free(ctx->dev->sram_pool,
                                              (unsigned long)cpu,
                                              rcb_size);
                                cpu =3D NULL;
-                               goto ram_fallback;
                        }
-
-                       /*
-                        * The registers will be configured with the virtua=
l
-                        * address so that it goes through the IOMMU
-                        */
-                       dma =3D virt_addr;
                }
=20
-ram_fallback:
                /* Fallback to RAM */
                if (!cpu) {
                        cpu =3D dma_alloc_coherent(ctx->dev->dev,

--=-ZJcI0aBBaUP96hypVc6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCav4fGAAKCRDZQZRRKWBy
9FqhAP4pY0JMdUIZJr/LhHtvb6DsQm54XOOj6JgdlKQ2E+itcwD/Vm7FSFzr0alW
F+xXlxvgDMiEUu59Utc6C6/8cilSAws=
=LlMs
-----END PGP SIGNATURE-----

--=-ZJcI0aBBaUP96hypVc6s--
