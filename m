Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AEC18E1A;
	Mon, 10 Feb 2025 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208531; cv=none; b=b3/9IXUnKjIdVpRJvMGkbPlQsg54mZ3XLBo1FEegdPkbvBUiyHTigBRjue4WqFZ5jpKwMFUnqxxSuqv64PwTai4IZ1+HcJ/2DiEUc93rAVoFwbpCfea4bp2ui0WTX+oWoyXd1Q+Rdobkd9UOA8GLcR77mQCcInimTmiST8WS298=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208531; c=relaxed/simple;
	bh=thYgUbeYVGHZPV0USkDjewuRNCG8NgYk5V3cwEE1KiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdfs3SzL1N9+akazRdcsI2XlMz93mMvbNA55VGZgK/M5GdKPGLjgo9p/2NwpPfn58629HEhlBslcyC0c1Z/LFTMO0zAI1hoIlVwOTwBcKzuDb0svT/Eh7ib9BqmmSjRpKkeAF6a7EFe9bhaGGZypkv38+wye/nc8jMCmMdehrgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvDv055t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvDv055t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3382C4CED1;
	Mon, 10 Feb 2025 17:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739208531;
	bh=thYgUbeYVGHZPV0USkDjewuRNCG8NgYk5V3cwEE1KiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvDv055tOhMqP3PQ8WPctJRZSsrhBRGppq1gxLlIaLBsgyiTM6ioLendBVB5M8htj
	 Avt9pYcz4sI8YVWgG/LF9US5vuOqAxrEx+xKbtLn36hG/iSyMOB3VN7i74s1a8TChw
	 ozO2KG8SV3y/v0DOnzzyGXPuZO8J/oa85jyFcdBgzWMX26yQg+GiR5f1/AKFgXyHhS
	 95CCxSMDirnbla6N7ZxqGhw0sj8lhLQfjFJTrgmlCYNGHRk50OwCo+HNMSEdCLtYGd
	 81NTo4JUY0wvF2rv8D+H9PuZTpO/bxguLM3kVGusNpa5IoWvama2VrjbDh7DSkSFLX
	 Soh7aS0/aLQlw==
Date: Mon, 10 Feb 2025 17:28:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Neal Gompa <neal@gompa.dev>
Cc: Hector Martin <marcan@marcan.st>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	David Airlie <airlied@redhat.com>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
Message-ID: <d6cae188-28e5-409f-86ed-7ddf374fd354@sirena.org.uk>
References: <2025013148-reversal-pessimism-1515@gregkh>
 <1bbdf8b7-a70b-4994-865e-7fcb8d53ebef@marcan.st>
 <20250207-prehistoric-married-dormouse-3e1aa7@lemur>
 <7742420.9J7NaK4W3v@skuld-framework>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vUvEawX9GvOqAgIQ"
Content-Disposition: inline
In-Reply-To: <7742420.9J7NaK4W3v@skuld-framework>
X-Cookie: Your domestic life may be harmonious.


--vUvEawX9GvOqAgIQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 03:25:26AM -0500, Neal Gompa wrote:
> On Friday, February 7, 2025 1:16:11=E2=80=AFPM Eastern Standard Time Kons=
tantin=20
> Ryabitsev wrote:

> > It is my goal to be able to give subsystems a way to use forges without=
 it
> > impacting how they interact with upstream or handle tree-wide changes. =
That
> > is, once I'm done moving things from one Benevolent Company to another.

> Honestly, this is probably not possible. If a subsystem moves to a forge=
=20
> workflow, it pretty much means tree-wide changes need to work partially t=
hat=20
> way too.

We do actually have some people using forges already, for example the
SOF people do a bunch of their review on github and then turn that into
patch serieses which they send via the normal email route when they're
happy with them.  I think tree wide stuff flows in via back merges or
rebases, one of the benefits of delegation is that it's not my problem.
This all works perfectly well from my side, as far as I know it's fine
for the SOF people too.  It certainly doesn't seem insurmountable.

--vUvEawX9GvOqAgIQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeqN0oACgkQJNaLcl1U
h9AHeQf8D3EyzeI73AlZMyFnbNnX2qLRGNgCXhX4mhcEDErMfNdHpO81kIr4d4yV
tH41zTgmoQ4AYTQ5qFNYqvUbAsn2O+D0N1395waTKRcVAbRaEs9yRPR9j1AiXTJ+
yEOlbITDIegoG9MlJitaVmhZaECGtDiAU+7aa3jyCQcohvwNszb2iU8D9KVjyzq1
lNuJIpihtKOR6CxL6//2168+1SDJSdLv8wK5Vnsyts39PCeHk3fQH7ydJAZy0Wwo
9uTwW7w1/RgsGAsgWoEFozRct4zHyd3cZr2RYEr+rxQJuxuYkX7IFvSG787kqFtp
0PlHzNVU5Ny7whhx5tpQCA93yDaf9g==
=3at5
-----END PGP SIGNATURE-----

--vUvEawX9GvOqAgIQ--
