Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2631B4F14;
	Fri, 10 Jan 2025 10:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505714; cv=none; b=CSExED41E2jsvNGfIHSrfmUa8rT1TL++HVPQe72CrVGR/3au8v2ZyA0Fr1EDMMfzuM96K/6vaias9AsxK6SCwGg4QlgI4YkPYT0yJnQhMOEUxUFlrf3ukUKWk2lA50px+fyUwb4kjRYbLtI990O7alCmIRRbjGABSoQGov5GMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505714; c=relaxed/simple;
	bh=yCnSxExYWaMh5dh1OGwzEHD4iNSkU1H4c7a1ji3tCdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ponwSbEo51D6lI9QxRNl5cIYSUFpmIhxe221hhFgmVXSHk9KmzLrgoZzB6p2BXi/HiDezMtd+4O9qfQMfE0cRaRhXRGoZuys4Du0sRop7ZUElm030kqS6rHZsY91gpS4/TyzMJ3hn75XK+Od8FPV1i46kz6HTDLpu4qrc7Kydqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2JaJu1k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2JaJu1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A85C4CED6;
	Fri, 10 Jan 2025 10:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736505714;
	bh=yCnSxExYWaMh5dh1OGwzEHD4iNSkU1H4c7a1ji3tCdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2JaJu1k6Ar8+L7uTLVGSokgYufZVi8n4XlnSd0lR0naCZrly69wo2jtOazBgc2oj
	 pBGQUS8WsacmraJucdoWP5mUivkiuEQd/rzDcqKhs6LArvFhu+eO/aVlwKCPbk3YcI
	 OT+p8LyT+W77Lul4CCB+IsAoMsLO4oSlqLtSmAPTNlumvi+lAT6lPL/Wp7w50GalPK
	 6lvB0QkHbEMVFnKKRo97ePUTsiUePaNvdKo32uj6JqmFIxZkYiJ4VzIzJMQsZX3GMf
	 wIuF72PUHHpUy6CyTm+dXvwnbw0/RBF8q6ksWIhF1lefPTrKR1WmwmUPDldD+CEA/T
	 dQ1ZwMT524vpg==
Date: Fri, 10 Jan 2025 11:41:47 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
Message-ID: <Z4D5a5NYrAbNxUL6@pollux>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <20250108122825.136021-3-abdiel.janulgue@gmail.com>
 <20250108135951.GA18074@lst.de>
 <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de>
 <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de>
 <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110083955.GA5395@lst.de>

On Fri, Jan 10, 2025 at 09:39:55AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 09, 2025 at 09:49:47AM +0100, Danilo Krummrich wrote:
> > On Thu, Jan 09, 2025 at 09:08:12AM +0100, Christoph Hellwig wrote:
> > > On Wed, Jan 08, 2025 at 04:21:33PM +0100, Danilo Krummrich wrote:
> > > > What does "your code" mean? Duplicated in every driver?
> > > 
> > > Yes, interfaces to the DMA API should stay in readable C code and not
> > > in weird bindings so that it reminds greppable and maintainable.
> > > 
> > 
> > Rust drivers shouldn't use C APIs directly, but rather use an abstraction of the
> > corresponding C API.
> 
> Don't force me to deal with your shiny language of the day.

Again, no one asks you to deal with or maintain this piece of Rust code.

> Maintaining
> multi-language projects is a pain I have no interest in dealing with.
> If you want to use something that's not C, be that assembly or rust you
> write to C interfaces and deal with the impedence mismatch yourself as
> far as I'm concerned.
> 

This is exactly what we're doing and proposing here, isn't it?

We wrote a single piece of Rust code that abstracts the C API for all Rust
drivers, which we offer to maintain ourselves.

What else are you asking for?
