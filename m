Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103228;
	b=QTsaPTt8pTMV8rV253lCcfe6w5W1w74w65YCWwaSfNUMRkqVunErbDOcurExiAji7jTM
	 dxaW7SOKlYXjb1kz3Cq4BBPIi0mhFpcK+AfeP8bWYk5VUKYBF8MzFK5XdEX0B41Z4U8P5
	 FMlLQf7APLCwXxe4Jgqf7llOUxEoCgk23nNB1R03V0BU9ZNxKXS8PmpsOHp1YZ3dmlh9O
	 N1G2mZZjJluM1xNFeYrvRYjbxB3XiX0u4vwKq9EQrV6He+EwvV66r3ZxkaEwsvKk2J4Gm
	 rzEy4HoxqQmusm2y4ZDrZbyO+qtBK6dDr4dpBLphS7rpI4QxHikf0rP52190s3jzI2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103228;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=i/2eBaDlENYHBrc7c5WJuNaoO0uM35xX9VzqdyJy/SI=;
	b=O0l5xfE0mgLfa2XXCc3NwN+uZLlG+R+sPikXMaDOVIYc0RolI51JpcYOGVpwqTPEJqiz
	 qRXTpRpj/6zlRIGgYOIgbQYcK9lZc8PphoxBqCCwOASW0njG+872VbBDs0xk+JmPdZoRI
	 DvLPsNJ6A/tFSVqCLmOvKbHGD6t27x6LPeGBbb+bpIkTdTNMDg0HYHKg1+fMV7yeoPCtv
	 gE9zRPtYxanAB0jeIKXITq/sR0Fn9/NyLiaEkqZHiPzT4LtJwCiwIqwRNSIt9dXhjc6I4
	 faXXHWfT+XaF3xnlQCqD+QA6Fb+qoxwa1e2tIxDCS2KE5qoDRmFH3ifFjyTfGn0sCsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=e0VvPrIT;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327060A2611;
	Thu, 19 Nov 2026 15:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F327060A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=e0VvPrIT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795103226;
	bh=pkdcwHwB3w5af4YAyvVrMlpBkQp3oqomrFFYmpopMWk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=e0VvPrITlscyDdSJfiRlu7DbbuvW03O247BdtGKV0g9gR5VDTh2HigjE3ft8An/NM
	 XKDiqUtOvlV3fDzDCvFr4VmNyLhKzDn3ktB0i7hAH5oF0hGAKRgqSfW2g115D7ttSr
	 z1Ut/tc3uxYHMWD8geLKPCtDbK/ECw/wxtUDh+lpE+4Q0X4EtJTzdgEQ8BdYX/A7T6
	 2SO301zNO8kDpu3F7qGNgiWtDUBtuafy/bKT+pbl0Mms/e7NCmWq8LTpfl7Icuuo24
	 6c0yX+6Zj+twePDzzKCl2AEwKveJSm5nvs05tViXmth1RTwG8GwD6EyEp3KVryiVqW
	 R6eduK9CNiP7g==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A58F017E04AE;
	Thu, 19 Nov 2026 16:47:03 +0100 (CET)
Message-ID: <da198506005be5c69d61105a5519121fe7bcdd36.camel@collabora.com>
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy	
 <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon
	 <will@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>,  Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,  Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Abdiel Janulgue	 <abdiel.janulgue@gmail.com>, iommu@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, Detlev Casanova <detlev.casanova@collabora.com>
Date: Thu, 19 Nov 2026 10:47:01 -0500
In-Reply-To: <20261119150857.GK3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
	 <20261116193821.GC2452510@ziepe.ca>
	 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
	 <20261117202055.GA3115493@ziepe.ca>
	 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
	 <20261118160909.GC3115493@ziepe.ca>
	 <fe60c0bd-1ee2-4b33-8ca3-564ee08e6db5@arm.com>
	 <CF2BE3BB-4F16-49FC-8421-B2B823BB7BB4@collabora.com>
	 <20261119143151.GH3115493@ziepe.ca>
	 <32a64e144c11bec72908ce143044773808be5115.camel@collabora.com>
	 <20261119150857.GK3115493@ziepe.ca>
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
	protocol="application/pgp-signature"; boundary="=-kkIaoF7bHVHvcS0UAPcF"
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

--=-kkIaoF7bHVHvcS0UAPcF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 19 novembre 2026 =C3=A0 11:08 -0400, Jason Gunthorpe a =C3=A9crit=
=C2=A0:
> On Thu, Nov 19, 2026 at 09:52:59AM -0500, Nicolas Dufresne wrote:
> > Le jeudi 19 novembre 2026 =C3=A0 10:31 -0400, Jason Gunthorpe a =C3=A9c=
rit=C2=A0:
> > > With the additional twist that alot of embedded HW has apparently
> > > choosen to not implement SSID but instead has a pool of SIDs that one
> > > device can use, functionally similar to SSID.
> > >=20
> > > We'd need also API support for unbundling the DT iommus=3D[] SID list
> > > into something that the SIDs can be attached more like a PASID.=C2=A0=
 That
> > > need, I think, has become clear with all the DT tricks and fake busse=
s
> > > to try to work around this issue. :|
> >=20
> > The word "fake" never flies with the DT maintainers. On that subject, I=
 still
> > don't know what you mean with iommus=3D[].
>=20
> When you write your DT you can list all the iommu streams in one
> iommus property. Like this randomly picked out of the DT files:
>=20
>         iommus =3D <&sysmmu_decon0x>, <&sysmmu_decon1x>;
>=20
> If you do that then Linux sets the struct device containing it to
> put the same paging domain on all of those iommus.
>=20
> It doesn't make any sense to open code this in drivers when you can
> just have the core code do it by writing your DT to match how the
> driver wants to work...

The will be rejected, as it does not map the hardware. If you check multi-c=
ore
codecs, each pair of core+iommu are independent from each other, at least e=
nough
that they could be driven by different device drivers. And so they have bee=
n
described separately in the DTs. I don't see a fault here.

Its a Linux design decision to manage them as a group, so Linux can schedul=
e
them fairly between processes. It would also conflict with the power manage=
ment,
which arguably should happen independently. On this last bit, I'm actually =
a bit
concern of how careless the multi-core patchset are regarding PM of the dev=
ice
that owns the shared domain, it only works by accident as they schedule cor=
e0
first, and other cores are only used if core0 is busy (there is no affinity=
).

Collecting all cores using the component mechanism, and picking one master =
and
sharing its domain to all other is pretty small effort, I don't want to go =
too
crazy here. But I'm open for better DT mapping if something would be accept=
ed by
the DT maintainer.

Nicolas

--=-kkIaoF7bHVHvcS0UAPcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCav8Z9QAKCRDZQZRRKWBy
9NEnAPsH9GRCZV+KDrqinZiHq6m4Cr/ajHkbFvGo1kLQXaXqYAEAsdYQBgBSjliv
lU4jcH1EuRr023RuyH7PTwbC/HfiOgA=
=IR4z
-----END PGP SIGNATURE-----

--=-kkIaoF7bHVHvcS0UAPcF--
