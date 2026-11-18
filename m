Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030899;
	b=hwEvf7lnaz0Lowbk3IOKWPnojHtcni2ngPgopqUCwK4epcvIww41Q6lCv6tt8AIGetPW
	 xdjKvAFhrBWf5gJa37JWuvNcXBAizRQE8z80Jx0bh0ucy31+6zSv+J7jYomZwlZfx5dNb
	 UtVar9iy7hhk/vS7GmT9o7NI30oeGNKlsrUao+OcD10/UXOInQXKnyLJdY9OB4rv7lifO
	 nZzJVPbsxCaEtHAeKwBa7kzeDH6i1srickk0VoHkj+lJ+fjQr36tNApvJhnco36z3yleZ
	 R8zDzv87xiPeatKkXXl0hvGxyW96fHEUdPzmSX5C+DWmjy+xnsh4KOhay8Tj8E82S7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030899;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=sxI1zN1iSt5WLFJOiBLp/HXVFEB2cTTrPgSWUehu01E=;
	b=i2bKhD9iCrO4pr4R4aj0q7wPhQD7eOg1gv3hqhPDUJlfzmaIsKxq1ms/2DkJ30dgrPwc
	 e5+8edTpo4W/jH8obLISB6nG1MGccf+Sivotzd0I7iy5XjozTUiTWeuAfg8uftFpW8ag8
	 nOzdM5CMskZwV8dgrxCFEcwOKMP+FzdchD2ppueyMME1Ok+Nl0iw54IoCqhjiT57pFsE1
	 B5g3C4gZSKx5VURhjdkSk2HCeD5NIldI1WhOrjurVkyu2Lat1qvQEbADvEphPyUF/qPr/
	 f8i5MnSCvHfbhD+TJnSwJZ4OukkNZ7mEvTvp/fQb0dzFI1PltAn8zoDvt2tjxXtyREg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=D9PAuqN3;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA0606D35E;
	Wed, 18 Nov 2026 19:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6AA0606D35E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=D9PAuqN3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795030896;
	bh=sxI1zN1iSt5WLFJOiBLp/HXVFEB2cTTrPgSWUehu01E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=D9PAuqN3aX9RLO/jkUibeLIHu70RVAZVUaKrReKklMbzcY1Uf6KzfcBnJg2H1P82W
	 3CKEr3AB8uoQ5KecvYP/yZwcBhI/lpaI/0FJg0E0Rs0OO4vh9VSzYmnfAdeMHPDxmY
	 ghYMaBzuryJPVfdLaHoHNbvUBTmKG+Jjbsg9mJ1zB54rXbsJUhaSeRsjHjjNJG9rX2
	 Pe3X0Oehlym2FY1ikig37oO0W/HFqHagwrMydpsbqAwaSCYLuQcfy/pXA133S9LOLY
	 x1UpZUXnWJuo91nzm7+n03xEye1eDBlmfOSeIUK47PxrlUdUzyLf1mdT4ZHuhcsLJh
	 AwGV5vLZKDi8w==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 30B0C17E0406;
	Wed, 18 Nov 2026 20:41:34 +0100 (CET)
Message-ID: <457fe01cc1fbc5b6e2d7b5c9c167012b56fe86b2.camel@collabora.com>
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
Date: Wed, 18 Nov 2026 14:41:32 -0500
In-Reply-To: <20261118193521.GD3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
	 <20261116193821.GC2452510@ziepe.ca>
	 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
	 <20261117202055.GA3115493@ziepe.ca>
	 <615C3DA2-4C02-4A8B-AEC4-70D498672559@collabora.com>
	 <20261118193521.GD3115493@ziepe.ca>
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
	protocol="application/pgp-signature"; boundary="=-upUcWOi2k3hKqqHR1efN"
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

--=-upUcWOi2k3hKqqHR1efN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jason,

Le mercredi 18 novembre 2026 =C3=A0 15:35 -0400, Jason Gunthorpe a =C3=A9cr=
it=C2=A0:
> > No, not OK :/ We want to use GEM shmem, which calls into the DMA API in=
ternally
> > through drm_gem_shmem_get_pages_sgt() -> dma_map_sgtable().
>=20
> You cannot continue to use DMA API once you start touching a paging
> domain directly. It is why driver_managed exist.

You are building a strong argument around something that is not what we int=
ent
this binding to be used for. If you had cared about the context you'd know =
we
don't want to touch paging from userspace in this type of drivers. At least=
 not
until we have a really good reason to include this complexity. And I agree,=
 its
quite likely the iommu subsystem API would just fall short, its far from
perfect.

There is a line to draw between GPU and VPUs, and memory management is wort=
h
looking into. But seriously, let's have this discussion once the driver is =
ready
for the ML, so we can code to correlate to.

Nicolas

--=-upUcWOi2k3hKqqHR1efN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCav3/bAAKCRDZQZRRKWBy
9Dn+AP9Sxy4GNfTEn1PqG1A0ThC0jQy5J14QKl3UgwHTTy5xEwD/aLpZ8keoPdWW
1b0zIzgEtpqE19BhAIWbV68uFqtn0AA=
=xdUx
-----END PGP SIGNATURE-----

--=-upUcWOi2k3hKqqHR1efN--
