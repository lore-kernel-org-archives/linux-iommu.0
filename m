Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEA727990E;
	Thu, 15 May 2025 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747343482; cv=none; b=BB1vTucbkuzmWFG7EDe9CnNDuNVcccu2xT616w2tGoZgWWFxj2IGs7SIVKP6YOFWkNmnX/onsdVvZUvtt5x4IiaflLjwnD64cBGSTstVCx2E4BV6jv/z6iio6Z2WJF7l2L6tSd0DNuiKlFbsUhQKLseHZ3CpAqtaIMCo3DJRZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747343482; c=relaxed/simple;
	bh=76b2FsZ7bxhwXZ3UFAT/V8jL4UEZ1JmSZ4WVDRpN1PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSt731PKXsfsAYosIovmjZpk223IHSFkRDfyUFT7ULiaXgmWmSlO3FZ1DQg7UkAuWAL4Z485lw0Ec7pZATnYllPPUMm6sa7bkA31CNCPnXiJdGzUinufV+WTB+QpA5QY4kqMRAnA84wxUjIqWFXa7cEernPrVfASAtAWYDTD2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6rZW6U9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6rZW6U9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388F3C4CEE7;
	Thu, 15 May 2025 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747343481;
	bh=76b2FsZ7bxhwXZ3UFAT/V8jL4UEZ1JmSZ4WVDRpN1PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6rZW6U9t4D4AHu4YsW433Hew5OY+vbKi1Jp/05gKTzBaApTRsS+dkCi76ivVDVHD
	 fETWkWglei5kOK+XxBRfurauMborScpboch4I5FuTvuFg/TH+R8eaC41NPq1vFR4TY
	 dGubF1gb7aSDz/krEwYVRoEEx/DgH9f4Pz9ds3QzwYqgJDiQT1TTc7ZHZSJ1ZarlEU
	 6LZWDqce8uhOhU204oBbmJ9DzoMJ18s1SADd//8B/gic7wCowln2VaDx2GbHoMb+fj
	 st9PBN/gXHYHQw8Ij6uUNyP6Fy3ywkw4eLX5U782WeDLh2L/qezjmsCps2sPYYNqvK
	 WoDZ523/KCjqQ==
Date: Thu, 15 May 2025 23:11:14 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, lyude@redhat.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH 1/2] rust: add initial scatterlist bindings
Message-ID: <aCZYcs6Aj-cz81qs@pollux>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
 <B3564D77-9E26-4019-9B75-B0C53B26B64F@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B3564D77-9E26-4019-9B75-B0C53B26B64F@collabora.com>

On Mon, May 12, 2025 at 08:39:36AM -0300, Daniel Almeida wrote:
> > On 12 May 2025, at 06:53, Abdiel Janulgue <abdiel.janulgue@gmail.com> wrote:
> > +impl SGEntry {
> > +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that the `struct scatterlist` pointed to by `ptr` is valid for the lifetime
> > +    /// of the returned reference.
> > +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> &'a Self {
> > +        // SAFETY: The pointer is valid and guaranteed by the safety requirements of the function.
> > +        unsafe { &*ptr.cast() }
> > +    }
> 
> Hmm, this name is not good. When people see as_ref() they will think of the
> standard library where it is used to convert from &T to &U. This is not what is
> happening here. Same in other places where as_ref() is used in this patch.

as_ref() is fine, we use this exact way commonly in the kernel, e.g. for Device,
GlobalLockedBy, Cpumask and for various DRM types.

Rust std does the same, e.g. in [1].

I think I also asked for this in your Resource patch for consistency, where you
call this from_ptr() instead.

[1] https://doc.rust-lang.org/std/ptr/struct.NonNull.html#method.as_ref
