Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC15A31;
	Fri, 16 May 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418136; cv=none; b=nDDYXM5PcVLw/Ddzd5PcgFzyKWBF5KW47wxtjqnmlJlbH62Zm+bB81IIzAeBYMhy/0yc0vAFkxrjmgjGkilV5+d/ISsJ74nj0z0PYmxwVpBumnjBCj6MHQrcbrxOSltnx8LKRQUpxjeGTK3apz2a5iw1isA41o2p1D/PEvq1G2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418136; c=relaxed/simple;
	bh=87659Yp0pBUovntwXSCrP69ngOFsdE4y0V+GC8gkJPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mfvgvlxqmh0vtW7oL40PyMh47JctpYCuQUWS3ppTiKpv4SsoAdqFL2mY6VIPw9J+Rwb8aQGa/4Yn/r9VrV5LlxFfdKpmHw6ajDmegpT9NeUOhamNRuSL8H8D/UBZpMq6+rzMTo8AwJG6lmV6d7Li7n4m5dNUANrBymps420cTno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXsYRLW9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXsYRLW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88CFC4CEE4;
	Fri, 16 May 2025 17:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747418135;
	bh=87659Yp0pBUovntwXSCrP69ngOFsdE4y0V+GC8gkJPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXsYRLW9S2kor5aUGNfsKLqJVIoZythoR8GaXfP38Yy4hdPsAcVf5kRj5L/i6j/i8
	 lGloeN3rqntU+5KdeNDQm3FMLA1jMGC2qPwUFj9A5netwgHaQ5OSaJNJoF2PRU8Ux4
	 gSt5y/JoHkV0Ex2LG7Y4zKPbrMhTS7SXvXvcru46DcmjhBxvDED/1sAEyRV29iP+eT
	 9zJljoguKeT1kH0DsESv2DSpZ7hkZuMRP8CuS7r5Fx4jJ1vJw9373bVUb9yF41ui9F
	 8tfFaGHseseXow1DdgkCdHZ4I6e3fElbcx4JnxQVWEEcoT7CHtpMFSGT6M06fUt/qz
	 wV+Fm6eGPTzwg==
Date: Fri, 16 May 2025 19:55:27 +0200
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
Message-ID: <aCd8D5IA0RXZvtcv@pollux>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
 <B3564D77-9E26-4019-9B75-B0C53B26B64F@collabora.com>
 <aCZYcs6Aj-cz81qs@pollux>
 <E2F129BE-777A-4DBD-BC3E-44033BCD11E4@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E2F129BE-777A-4DBD-BC3E-44033BCD11E4@collabora.com>

On Fri, May 16, 2025 at 01:57:59PM -0300, Daniel Almeida wrote:
> Hi Danilo, 
> 
> Replying to you and Lyude here at the same time.
> 
> > On 15 May 2025, at 18:11, Danilo Krummrich <dakr@kernel.org> wrote:
> > 
> > On Mon, May 12, 2025 at 08:39:36AM -0300, Daniel Almeida wrote:
> >>> On 12 May 2025, at 06:53, Abdiel Janulgue <abdiel.janulgue@gmail.com> wrote:
> >>> +impl SGEntry {
> >>> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// Callers must ensure that the `struct scatterlist` pointed to by `ptr` is valid for the lifetime
> >>> +    /// of the returned reference.
> >>> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::scatterlist) -> &'a Self {
> >>> +        // SAFETY: The pointer is valid and guaranteed by the safety requirements of the function.
> >>> +        unsafe { &*ptr.cast() }
> >>> +    }
> >> 
> >> Hmm, this name is not good. When people see as_ref() they will think of the
> >> standard library where it is used to convert from &T to &U. This is not what is
> >> happening here. Same in other places where as_ref() is used in this patch.
> > 
> > as_ref() is fine, we use this exact way commonly in the kernel, e.g. for Device,
> > GlobalLockedBy, Cpumask and for various DRM types.
> > 
> > Rust std does the same, e.g. in [1].
> > 
> > I think I also asked for this in your Resource patch for consistency, where you
> > call this from_ptr() instead.
> > 
> > [1] https://doc.rust-lang.org/std/ptr/struct.NonNull.html#method.as_ref
> > 
> 
> That is not the same thing. What you've linked to still takes &self and returns
> &T.

Fair enough. :)

> So, IMHO, the problem is not conflicting with the std AsRef, in the sense that the
> code might not compile because of it. The problem is taking a very well
> known name and then changing its semantics.

I don't see the problem, a function signature is always read as a whole, in this
case:

	fn as_ref<'a>(ptr: *mut bindings::foo) -> &'a Self

which reads as "take this pointer and give me a reference", i.e. "as ref".

Anyways, I'm not very much opinionated about the exact name, I care about
consistency.

So, if you feel like we should name it differently, please also change the
existing functions in the kernel.

> Anyways, this is just a small observation. I'll drop my case, specially
> considering that the current as_ref() is already prevalent in a lot of code upstream :)
> 
> — Daniel
> 
