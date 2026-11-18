Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030295;
	b=laJ/HXC36xx5quMbEJEdVNY2j3UliTeq8ObSNb+BkYIAfmDXozB9bKtBCiHypD9L6Mez
	 vUXYa5ZPjK8CIhc8tCD24acg5P4ELH70hNZv1EUDI7RkjPULlk+4dWV9SdH986F1oz+MM
	 QytgPcqvzOcKYUzeAO6iwYxGf0/dRO9l7guBa9Ifx1GInhF8zwhcmyb6u/Q6URSzj5nut
	 05Cf6aGMt76eQh39/JxEMIjptJxWHHm9O1/Y6bTQjpUtZxmt17p5BQCHbQVXbBLzk/hZD
	 hsECGmM3CwifSw9INEN+W8ywUkO6y/3mySGr+mk9GagpL+dvF3ZcGvhQPZncTL00DnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030295;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=fLthrjN5WgzhoWxabUT0whfp6slcAS4z3Nr3WCkNqVY=;
	b=nsCirklAbIo7+psTKALx/hAB3FGx4YPKbjIyCxu+DiWmOl3NYZb4K16o9HFfPHvddLYz
	 gfIn9okpDHOEXwTSrO1vJ+yP4CAm2ggBEAYWGLOvYvOFl+4sSO7kswMxlQ0pSoTxzbjur
	 Iw1rFOiRbUXkMBMA1m7YxYU7cPdT1j9c5latqUWfv4Qtaf5oLOJ4q7NuXGEmhtUm4ibmh
	 /Ud7DmafK6umyAqfnWBiFlmMA1bA1LY+afmh2T9SWYmxIkbbvxyMNKWkkPewDCqoOA4nX
	 4GqRDQXkVi+7GWMZFhLuVrzElqNz3M10sxYr4JRmhZU/6yAm5fp0AZZEtx2geKbFkRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=KXgDlwr9;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C38606A7E5;
	Wed, 18 Nov 2026 19:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73C38606A7E5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=KXgDlwr9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795030292;
	bh=fLthrjN5WgzhoWxabUT0whfp6slcAS4z3Nr3WCkNqVY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KXgDlwr9EYezTyhZH6f113tD9IXvmi78IgDfAdx3BajMOcug+kilIgq1izYqmUL8d
	 j8vEEjPLk/hzTs6DP7E274OX2N+OjJUcinoIkoN+MqcLe38W9bhTlhupvMQ2NY2yPu
	 Xl+e6YU8sYpquLVNXRJXhV2eULFoY45/tpYqWV1ugcP3ZDReRGPVZKkn/RFwoWkSND
	 6y5Jl6d7xbf0O5gz6j5J8ZwLrYuBkJk5fAej5MLEOY4A4oo+X4kGxSx9PU507r0raT
	 p/vhCtHtDzE9QGVV7v9dpAUYI0Gfhcv0Dl3P6PWrbk6aMiDZLXH9jpq8DWIwMofLcm
	 KchprO3vAlHTA==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E443117E0480;
	Wed, 18 Nov 2026 20:31:29 +0100 (CET)
Message-ID: <ede3b421d419a35c115ed584e60e74bfd6b91dff.camel@collabora.com>
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
Date: Wed, 18 Nov 2026 14:31:28 -0500
In-Reply-To: <20261118160909.GC3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
	 <20261116193821.GC2452510@ziepe.ca>
	 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
	 <20261117202055.GA3115493@ziepe.ca>
	 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
	 <20261118160909.GC3115493@ziepe.ca>
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
	protocol="application/pgp-signature"; boundary="=-NdLYfQQ4mCwqMscWXOoT"
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

--=-NdLYfQQ4mCwqMscWXOoT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 18 novembre 2026 =C3=A0 12:09 -0400, Jason Gunthorpe a =C3=A9cr=
it=C2=A0:
> On Wed, Nov 18, 2026 at 10:25:58AM -0500, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > Le mardi 17 novembre 2026 =C3=A0 16:20 -0400, Jason Gunthorpe a =C3=A9c=
rit=C2=A0:
> > > On Tue, Nov 17, 2026 at 05:09:11PM -0300, Daniel Almeida wrote:
> > > > Hi Jason,
> > > >=20
> > > > > On 16 Nov 2026, at 16:38, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >=20
> > > > > On Thu, Nov 12, 2026 at 02:00:07PM -0300, Daniel Almeida wrote:
> > > > > > This series adds a Rust abstraction for IOMMU paging domains. A=
 driver
> > > > > > can allocate a domain, attach it to its device, map pages into =
it, and
> > > > > > install a handler for its faults.
> > > > > >=20
> > > > > > This will be used by the upcoming rkvenc driver that my colleag=
ues
> > > > > > Detlev Casanova, Nicolas Dufresne and I are working on. More de=
tails on
> > > > > > this driver can be found by watching Nicolas Dufresne's talk at=
 LPC 2026
> > > > > > [0].
> > > > > >=20
> > > > > > As part of the security model, each client will have its own IO=
MMU
> > > > > > domain. This is needed as the submission model will let userspa=
ce set
> > > > > > most of the encoder's registers directly, so the kernel cannot =
check
> > > > > > every memory access that a job makes the encoder do. With a sin=
gle
> > > > > > domain, one client could make the encoder read or write the mem=
ory of
> > > > > > another client.
> > > > >=20
> > > > > How do you plan to get the paging domain in the first place?
> > > >=20
> > > > We plan to alloc a paging domain when a video encoder session is cr=
eated. Then
> > > > we call iommu_attach_device() before a job runs, and detach back to=
 the default
> > > > domain after it finishes so the next job can attach its own session=
's domain.
> > > > This is so each session is isolated from each other.
> > >=20
> > > If you do that you can't use the DMA API at all in your driver as you
> > > have to set 'driver_managed =3D true'. Is it OK? If it is why not jus=
t
> > > use VFIO?
> > >=20
> > > Or are you planning DT horrors to get yourself a DT created "DMA
> > > struct" ?
> >=20
> > This seem to digress. All we want to do is use the iommu subsystem as i=
ntended
> > for the case the iommu driver is not inside the DRM driver (which seems=
 to have
> > never been the case so far in DRM).
>=20
> "As intended" means you use the DMA API and you do not touch
> the paging domain.
>=20
> "As intended" means you use iommufd if you want a domain full of user
> controlled mappings.

As discussed at LPC, we believe its pointless for this type of device to gi=
ve
any direct page choices to userspace. Can you explain why you believe
differently?

>=20
> > The existing infra for that (in C) is pretty abstract an simple in
> > my opinion, and built into the DMA API if you manage which domain to
> > attach to your device at the right time.
>=20
> What does this even mean? The DMA API owns the domain, not the
> driver.
>=20
> All the cases using these APIs in DRM and media are troubled in one
> way or another.
>=20
> For example the recent revelation they have always been using DMABUF enti=
rely wrong:
>=20
> https://lore.kernel.org/all/20261009125338.GB13920@nvidia.com/
>=20
> Tegra desires to undo their abuses.
>=20
> It was never intended for things to work like this, there is missing
> infrastructure.
>=20
> > To me, it fits CODEC HW driver which are also simple. The DT horrors
> > you refer to seems totally unfounded, you just describe the iommu
> > and the iommu subsystem will manage it for your device.
>=20
> "unfounded? You are not following along, I've written about this now
> many times to many different people. Follow the links and discussion
> from here:
>=20
> https://lore.kernel.org/all/20260917144804.GI3196566@ziepe.ca/
>=20
> If you use DT correctly there is no place to attach an iommu_domain to
> and you can't even use these APIs. You get DMA API only and that's it.
>=20
> You have to do something "wrong" in DT to create fake HW devices to
> even give you a struct device to even attach something to.
>=20
> Or you have to entirely give up DMA API and attach to your only struct
> device.

I'm not sure how this applies to our work. But since they are all broken
according to you, let me give example of cores/iommu mapping we are using, =
and
perhaps you'll be able to explain us correctly? I've picked the Rockchip vi=
deo
decoder, which is upstream but expose through V4L2 stateless API, but from =
a
hardware point of view is pretty much identical:

The DT (which I read you must be broken and in violation of everything, yet=
 all
reviewed by DT maintainers):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm64/boot/dts/rockchip/rk3588-base.dtsi#n1400

The multi-core support proposal, its not doing process isolation, its not
strictly needed in higher level abstraction (though could be better), but i=
ts
using domains so that each core can actually see the same memory:
https://lore.kernel.org/all/20260810-rkvdec-multicore-v2-0-986f89d22cdc@col=
labora.com/

The DMA abstraction that is used by the above driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/media/common/videobuf2/videobuf2-dma-contig.c

GEM kind of offer similar high level abstraction to DMA (with important
behaviour changes in of course, specially for write combine delivery), so t=
his
is what we have for now in the WIP driver. Check the LPC presentation for t=
he
rest of the context.

Nicolas

--=-NdLYfQQ4mCwqMscWXOoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCav39EAAKCRDZQZRRKWBy
9IV1AP9AxkflEeZ/bPaxvQmt8nZyMjXbjyeIHJu034CF7vtj+wD9H6GjJpenIQM8
yOiR+zj1r9H/KSkGDS6RmpGOgH1UNA0=
=UPaF
-----END PGP SIGNATURE-----

--=-NdLYfQQ4mCwqMscWXOoT--
