Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845851E3772
	for <iommu@lists.linux.dev>; Thu, 30 Jan 2025 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738244618; cv=none; b=eDeQPaGicGOF1WNg0RtL1erHAE0vuN6btr2OuS160JcICTgIzW0Xv/2dloUHrSOAeYY/+WiHqzR/wiFXmbCZ+mCqo3B+lCnjHYTE6GRahJ5ajDVBh+U79SMtqNn6ATNGUPRMFJy/aCBKPBwIXmU3gW885uRSbwwgOTIsIpaiTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738244618; c=relaxed/simple;
	bh=lfMC4b1zgzO5tcD9HIygOzojNEhZCfTv8yVzHUqMo9Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=av0u+3fd1vHZbPSjGXlT/qySTSVzis9ZbRGtxQbSjTX6oDkSd2u3TocNIiJLFiSqnNjxfIjhR/3OtgZvfQmYkocG42rBo2BotHxpdYXLngNftu7El5OLRv3GbnyQ3ohrmQvWysLp3iX8BtfwyPX42cs9YX070Bg3ja43a3vxk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ars+vOAF; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ars+vOAF"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YkKwv2l8Tz9t9R;
	Thu, 30 Jan 2025 14:43:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1738244607; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lfMC4b1zgzO5tcD9HIygOzojNEhZCfTv8yVzHUqMo9Q=;
	b=Ars+vOAFXv78op6rFVAYTnrdyPJUs+p0T1MbdRNK/9e/1KSmK6Fzc/vEUWCYDcASpalrqq
	O6zzxxMJLKIqrurIDQEU/EHaqLLhya0XJUuMvYN6fmfXUn9d1u6kQ5aNHp72XjZJFyd/d1
	5s1i2glxhB4z24JY5k6BCPpfxc71HQgDcRNrvTMzsqE7T2XMXqrBsIh/AcT7vS8v/Ia3iw
	QEfc7hMQtSvxUlKVDrpYlJG+svag0Ii179ydEjs+V6jcAd/4UTnh9KFIRIEZrDr13ubLyc
	5u1zsxfWMTuI2KCH9f1ZtTEPi2sPk0m7mhjVHmubbninnJ4i7ipjDRTUulc4IQ==
Message-ID: <2c9a78be6b72b68b47ba869dea247e935468fa4c.camel@mailbox.org>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Daniel Almeida <daniel.almeida@collabora.com>, phasta@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Abdiel Janulgue
 <abdiel.janulgue@gmail.com>,  aliceryhl@google.com, robin.murphy@arm.com,
 rust-for-linux@vger.kernel.org,  Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,  Gary
 Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>, open list
 <linux-kernel@vger.kernel.org>, Marek Szyprowski
 <m.szyprowski@samsung.com>,  airlied@redhat.com, "open list:DMA MAPPING
 HELPERS" <iommu@lists.linux.dev>,  Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 30 Jan 2025 14:43:21 +0100
In-Reply-To: <F2D88DDC-DE2E-4422-9A37-951C28F23A7B@collabora.com>
References: <20250108122825.136021-3-abdiel.janulgue@gmail.com>
	 <20250108135951.GA18074@lst.de>
	 <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
	 <20250108151858.GB24499@lst.de> <Z36X_ZnCmBQBMoZ6@pollux>
	 <20250109080812.GA20431@lst.de> <Z3-NqwAG_96yq8VD@pollux>
	 <20250110083955.GA5395@lst.de> <Z4D5a5NYrAbNxUL6@pollux>
	 <Z4kG5AcVeQKegLnb@pollux> <20250128092334.GA28548@lst.de>
	 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
	 <F2D88DDC-DE2E-4422-9A37-951C28F23A7B@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-ID: aa47e728840a1fb9d74
X-MBO-RS-META: hgbogqkcsjia3k3hm37ezizixkogbti3

On Thu, 2025-01-30 at 10:35 -0300, Daniel Almeida wrote:
>=20
> >=20
> > Hallo,
> >=20
> > would some sort of official statement by the "entire community"
> > reassure you that the burden of keeping Rust abstractions working
> > with
> > any changes on the C side rests entirely on the Rust side's
> > shoulders?
> > (because that's what the statements made by the latter seem to mean
> > to
> > me)
> >=20
>=20
>=20
> This has been offered over and over in this thread, i.e.:
>=20
>=20
> ```
> If you don't feel comfortable maintaining the Rust abstraction (or
> just don't
> want to), that's fine. I don't think anyone expects you to do that,
> we can take
> care of that instead.
> ```
>=20
> https://lore.kernel.org/rust-for-linux/Z3-NqwAG_96yq8VD@pollux/


Yup, I've read the whole thread. I was referring to the statements in
those mails in my response.

My thinking is that such a file is the most official, most binding
statement / offer the project has.


P.



>=20
> Communication is not the issue here.
>=20
> Also, this person waited until v8 to give a single line NAK. This is
> not very nice.
>=20
> =E2=80=94 Daniel

