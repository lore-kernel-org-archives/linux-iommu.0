Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37309819
	for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738243663; cv=none; b=Bc00EjpVIb9ZN+MctQKnvbUEgt4/SYEJ/IFqETXdB1Oj4DkitiVDETEadfNk5yKAQ/+kRk9T7aDUhvSX+ZRqNFu5V/fN9WeGgzkT9CXwkZhVasOK7nq3M0+Gx+JLGD8NCQlc0CfbmSj/k03fEzfvOpb2h+5tUmmLFiX1PkQDIsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738243663; c=relaxed/simple;
	bh=O7YyO+uijoU7i+42mLeb/uq7ar3D8ZwmNJb9tmfdZFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZCWCFFT7tN8CblpST1k9oG+y1KdUzh3Uk/mSlRLNPUk7S0vhqLrGZw8PE8bg3F1ODQ0MqQNDmJxeZWiIKDmbdCHPlapsIlGxremxudWfoRa4Dn2sitmUHqdC02++p94yvNUB9IjvHoz0Iav7N6wmy2kmgKEE4l4S6wC/dtpDszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NiimSCwf; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NiimSCwf"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YkKP74clyz9sqN;
	Thu, 30 Jan 2025 14:19:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1738243163; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7YyO+uijoU7i+42mLeb/uq7ar3D8ZwmNJb9tmfdZFA=;
	b=NiimSCwfvQEAAZ3FZ8x3y+CWPynqeHSRRVngAj2pnMIRqS2v3RaVhMRop/VGitmr8iBg1D
	c5143vHykbQIQ5gW8XWt5GceKu37fPni0E3n8zi7YYzgb7kP+OtjDVZrw/w7LhU6LTW9nj
	PogkQS54EpQhdkBUB4vtrmhCyxC0Kq+Rj9zBVgASO/aylqwT+oNgB7pCHq4tW+UnWh8F6C
	olqLKh3UpuopW+odHjYDVnwKD2j1DejbJf685ks+CInZzhSaKWcvOwaG8iVxDf3coSmPXY
	kH5I4WNhCN+TzCNZiRne067kdl8flDydeDLSsWCUy38bauQSy4hbhy8zQkrJpw==
Message-ID: <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Abdiel Janulgue
 <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com,
 aliceryhl@google.com,  robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, open list
 <linux-kernel@vger.kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>, airlied@redhat.com, "open list:DMA MAPPING
 HELPERS" <iommu@lists.linux.dev>, Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 30 Jan 2025 14:19:16 +0100
In-Reply-To: <20250128092334.GA28548@lst.de>
References: <20250108122825.136021-3-abdiel.janulgue@gmail.com>
	 <20250108135951.GA18074@lst.de>
	 <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
	 <20250108151858.GB24499@lst.de> <Z36X_ZnCmBQBMoZ6@pollux>
	 <20250109080812.GA20431@lst.de> <Z3-NqwAG_96yq8VD@pollux>
	 <20250110083955.GA5395@lst.de> <Z4D5a5NYrAbNxUL6@pollux>
	 <Z4kG5AcVeQKegLnb@pollux> <20250128092334.GA28548@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-ID: 4cdc5cbb72f064dabb6
X-MBO-RS-META: 6tazpg4mgfk94i9qjk4o41ieqhr1ppzr

On Tue, 2025-01-28 at 10:23 +0100, Christoph Hellwig wrote:
> On Thu, Jan 16, 2025 at 02:17:24PM +0100, Danilo Krummrich wrote:
> > Since there hasn't been a reply so far, I assume that we're good
> > with
> > maintaining the DMA Rust abstractions separately.
>=20
> No, I'm not.=C2=A0 This was an explicit:
>=20
> Nacked-by: Christoph Hellwig <hch@lst.de>
>=20
> And I also do not want another maintainer.=C2=A0 If you want to make Linu=
x
> impossible to maintain due to a cross-language codebase do that in
> your driver so that you have to do it instead of spreading this
> cancer
> to core subsystems.=C2=A0 (where this cancer explicitly is a cross-
> language
> codebase and not rust itself, just to escape the flameware brigade).


Hallo,

would some sort of official statement by the "entire community"
reassure you that the burden of keeping Rust abstractions working with
any changes on the C side rests entirely on the Rust side's shoulders?
(because that's what the statements made by the latter seem to mean to
me)

As I see it, at least as long as Rust code is just drivers and
abstractions which sit on top of the core infrastructure, which is C,
breakages or a hypothetical unmaintainability would only affect the
Rust side, whereas the traditional kernel could go on working and being
maintained as it always did.

I'm thinking about something like a linux/LANGUAGES file, which
specifies what languages you can use and what the rules are. Written
down transparently black on white. As a counterpart to linux/LICENSES,
basically.


Philipp
