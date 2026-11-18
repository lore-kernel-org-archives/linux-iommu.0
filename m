Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015565;
	b=yZS2H1fdKWMk3ZpaHOHv4rhKLtgDLMlnN8Uu59bdGe81RNfptDI4LQHndxrGhCe37WfP
	 vsm8I+/5VErJU93cxVBQdLJGsBj11URVOoU7+8NyhfCfYzkbcTpp2wYkA/b5V0FJrvFeB
	 8kAL13jLHycdIk5gZ5oUo+wJfXHePLSXU6Mw+r+ezFhsCbMvJxvs2QkL1s/iJ41TnzUzZ
	 XH1xXZejSPZ67HPbkv+piLEKaGJLiaO5xe/KUwdSdDRg3YWR1u9nhQT8firbGHYLNNpE8
	 vz/x2MJbyJpkQkfMXRxfaqBHSMzzC2c0eIizU6ELycnWaU2sJdzhCm2yjI+Jf9Ip0Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015565;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=Jj7CHtLt62pLL7MMim1REZseI1Ujb3pinwo7e+2pg+M=;
	b=nEJbbyJM/78MIHq7K+6KXfPhxqp1tCOXBNDa7bIzDnpAIigpNwccGw8ih0QtTGwVqVJy
	 eKLG+LM4pByhnwTDJgWDL7Ya+ti+ou7STcaYBDmB7G5aULD0CwqE/izWOo7ktwwhTbmDF
	 gQfRvbjv/Y5dPogpcm5pwjV4rC4kY4jlU1u6PlP55A4HUcMFx6JISJbcOHsuuJAMHja1/
	 v9ZSrHB/2jlSHZ+l51eltdSp22fNbo3/9nUcngCU5+jPIJUfnYDLM4KX8X/W/H4dWN1Sj
	 DkYKbWgjloVKGYTzustwNCBB5qfbX1s4YuBV1GgOsygTy2NBWAMV5TwFGlGbCZ0Mz0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Y0fe9G03;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D6060A2602;
	Wed, 18 Nov 2026 15:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02D6060A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Y0fe9G03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795015563;
	bh=Jj7CHtLt62pLL7MMim1REZseI1Ujb3pinwo7e+2pg+M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Y0fe9G03H0jsbGazwKmLkXR08FJJloc5QZKZiNTuNRmkB9eGrWBNAywPj0KzVjlLW
	 VJqOv2obWrRbvhf4aQdf0snXWLR3nKFoDggtAu/L57Bfwn0VWS36cupd615hf0z/ZE
	 /Qk9zhCbjoNaURDnpFZlQAKhbE9rpjZskRDAnAwGOEF+hx88uZiWnMU40n8vFelIRE
	 QmQPCf4ASWQlCqkcUs88o4VizwEFL2QKl06lMjAvJTdJjV8i55+yorSxqrHeu7lX0G
	 p3/p+rVyiJLIVnODQjw1cITkXIFuLt9Nz7Djr3Gh5fmgrXvpWvF2mdu6sdzv0fr93t
	 PNyHblA8aWz3g==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4E3F617E0B1E;
	Wed, 18 Nov 2026 16:26:00 +0100 (CET)
Message-ID: <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Daniel Almeida
	 <daniel.almeida@collabora.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo	 <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein	 <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	
 <work@onurozkan.dev>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	iommu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, Detlev Casanova	
 <detlev.casanova@collabora.com>
Date: Wed, 18 Nov 2026 10:25:58 -0500
In-Reply-To: <20261117202055.GA3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
	 <20261116193821.GC2452510@ziepe.ca>
	 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
	 <20261117202055.GA3115493@ziepe.ca>
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
	protocol="application/pgp-signature"; boundary="=-IJcHGH9mSee+VxCb9BnL"
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

--=-IJcHGH9mSee+VxCb9BnL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 17 novembre 2026 =C3=A0 16:20 -0400, Jason Gunthorpe a =C3=A9crit=
=C2=A0:
> On Tue, Nov 17, 2026 at 05:09:11PM -0300, Daniel Almeida wrote:
> > Hi Jason,
> >=20
> > > On 16 Nov 2026, at 16:38, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >=20
> > > On Thu, Nov 12, 2026 at 02:00:07PM -0300, Daniel Almeida wrote:
> > > > This series adds a Rust abstraction for IOMMU paging domains. A dri=
ver
> > > > can allocate a domain, attach it to its device, map pages into it, =
and
> > > > install a handler for its faults.
> > > >=20
> > > > This will be used by the upcoming rkvenc driver that my colleagues
> > > > Detlev Casanova, Nicolas Dufresne and I are working on. More detail=
s on
> > > > this driver can be found by watching Nicolas Dufresne's talk at LPC=
 2026
> > > > [0].
> > > >=20
> > > > As part of the security model, each client will have its own IOMMU
> > > > domain. This is needed as the submission model will let userspace s=
et
> > > > most of the encoder's registers directly, so the kernel cannot chec=
k
> > > > every memory access that a job makes the encoder do. With a single
> > > > domain, one client could make the encoder read or write the memory =
of
> > > > another client.
> > >=20
> > > How do you plan to get the paging domain in the first place?
> >=20
> > We plan to alloc a paging domain when a video encoder session is create=
d. Then
> > we call iommu_attach_device() before a job runs, and detach back to the=
 default
> > domain after it finishes so the next job can attach its own session's d=
omain.
> > This is so each session is isolated from each other.
>=20
> If you do that you can't use the DMA API at all in your driver as you
> have to set 'driver_managed =3D true'. Is it OK? If it is why not just
> use VFIO?
>=20
> Or are you planning DT horrors to get yourself a DT created "DMA
> struct" ?

This seem to digress. All we want to do is use the iommu subsystem as inten=
ded
for the case the iommu driver is not inside the DRM driver (which seems to =
have
never been the case so far in DRM). The existing infra for that (in C) is p=
retty
abstract an simple in my opinion, and built into the DMA API if you manage =
which
domain to attach to your device at the right time. To me, it fits CODEC HW
driver which are also simple. The DT horrors you refer to seems totally
unfounded, you just describe the iommu and the iommu subsystem will manage =
it
for your device.

>=20
> > The fault handler is used in the same way it is used in GPU drivers: to=
 kill
> > sessions if they fault. This way the driver can simply refuse further w=
ork from
> > a misbehaving client, for example. It is also the natural place to enqu=
eue a
> > reset if the codec hardware is frozen as a result of the fault.
>=20
> IIRC no GPU driver does that, they hook the obsolete fault handler not
> supported in new iommu drivers not the new PRI based one... IDK we
> have even wired this up to work this way.
>=20
> It is nicer if the HW can tell you it faulted rather than expect the
> iommu to do it.

We most likely don't need that, and should drop it from this series. We hav=
e
never used the fault handler in any linux-media codec in the past, the HW w=
ould
always endup producing an IRQ with a error or a timeout. Using the fault ha=
ndler
would probably be a bit racy too. Pausing work from a faulty source though =
isn't
a bad idea, but more of a nice future addition, assuming it can work in a n=
on-
racy way.

Nicolas

--=-IJcHGH9mSee+VxCb9BnL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCav3DhgAKCRDZQZRRKWBy
9DUJAP4x+G6i8V/mCJNB0vLdcr/oloJeHb9XQjPQTymPNu+lDQEA7nyMQLSBGku5
VljshCPKu96vUzI4tKRMkP9UWePglwg=
=PT9b
-----END PGP SIGNATURE-----

--=-IJcHGH9mSee+VxCb9BnL--
