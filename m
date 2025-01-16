Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ECD22BAA2;
	Thu, 16 Jan 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043084; cv=none; b=GPkXW1kzBEYrtZhedw2ik3xk093yD2pASUQwwjDV4GC5l6K/omyw4zGF5nvo592ZnjQGEPUGYzm2Z/1z2Y/YeIFUUTOH3Ch/ZKiqaza6M97MteKqNeasusGZoNqT7B5qUWwjv3LqM3aRwYwsOVWdQLNBwfKhXFWzmLF5haOpGNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043084; c=relaxed/simple;
	bh=meKV/jTThaJJPlEBRNYEscH8AiNb8/IlrgInk+edJLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDYE4SXXFB8GHxJoOr5k+ox/mTbPR8/w62g6WmH6CdKE+sUHkIXHtvV3Ww8otMNJrXr8uZJcyE7rjIbFsO/Vz9CWcMaFSPTdJJt9fBV5lzIRovXhrvOiCpBQm7LWpvjIhkPB6Pbpo+7YOKhtR3FX1yTFsNLL6/2R/oXTCWjQDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbWMwpby; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbWMwpby"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76794C4CEE1;
	Thu, 16 Jan 2025 15:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737043083;
	bh=meKV/jTThaJJPlEBRNYEscH8AiNb8/IlrgInk+edJLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbWMwpby9OdnHcaL7e6ANn6F3e9B/1C30rovU+8u9QL/RY2UPR6VLBtqKkpNBYfZe
	 4HybTGOUzdxpOceSq+5SyM8z+I+frwtRJ09Gn0A3p+56slu+arEDIcF2OcR60IF11f
	 kwEfbR0qiGshaCW/xx9Z3Rkei6sISRIYKnpF0STp/opWoB3onWNxbZ73vDl/BHBpCP
	 jFh9itWq2GM69XlI3QVSBoxj20nAx2Q/nZSTCoSaChkYpZVhjKL3zmgN4fvdESHQf5
	 aOtukrquHC+LNxKyCb0s6ctZlX3n0Rk/ByUb9ptNyUmDjQruzwIFNkrqHfmRxroxws
	 JQZLiBestXbiw==
Date: Thu, 16 Jan 2025 16:57:56 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <Z4kshDHw8NEjQONR@pollux>
References: <20250108135951.GA18074@lst.de>
 <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de>
 <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de>
 <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de>
 <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux>
 <bbc60912-7ed5-4bb1-b273-8061abe49e10@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc60912-7ed5-4bb1-b273-8061abe49e10@arm.com>

On Thu, Jan 16, 2025 at 01:57:50PM +0000, Robin Murphy wrote:
> On 2025-01-16 1:17 pm, Danilo Krummrich wrote:
> > On Fri, Jan 10, 2025 at 11:41:54AM +0100, Danilo Krummrich wrote:
> > > On Fri, Jan 10, 2025 at 09:39:55AM +0100, Christoph Hellwig wrote:
> > > > On Thu, Jan 09, 2025 at 09:49:47AM +0100, Danilo Krummrich wrote:
> > > > > On Thu, Jan 09, 2025 at 09:08:12AM +0100, Christoph Hellwig wrote:
> > > > > > On Wed, Jan 08, 2025 at 04:21:33PM +0100, Danilo Krummrich wrote:
> > > > > > > What does "your code" mean? Duplicated in every driver?
> > > > > > 
> > > > > > Yes, interfaces to the DMA API should stay in readable C code and not
> > > > > > in weird bindings so that it reminds greppable and maintainable.
> > > > > > 
> > > > > 
> > > > > Rust drivers shouldn't use C APIs directly, but rather use an abstraction of the
> > > > > corresponding C API.
> > > > 
> > > > Don't force me to deal with your shiny language of the day.
> > > 
> > > Again, no one asks you to deal with or maintain this piece of Rust code.
> > > 
> > > > Maintaining
> > > > multi-language projects is a pain I have no interest in dealing with.
> > > > If you want to use something that's not C, be that assembly or rust you
> > > > write to C interfaces and deal with the impedence mismatch yourself as
> > > > far as I'm concerned.
> > > > 
> > > 
> > > This is exactly what we're doing and proposing here, isn't it?
> > > 
> > > We wrote a single piece of Rust code that abstracts the C API for all Rust
> > > drivers, which we offer to maintain ourselves.
> > > 
> > > What else are you asking for?
> > 
> > Since there hasn't been a reply so far, I assume that we're good with
> > maintaining the DMA Rust abstractions separately.
> 
> Indeed, FWIW it seems like the appropriate level of abstraction to me,
> judging by the other wrappers living in rust/kernel/ already. As far as the
> interaction with C code goes, it appears to be a pretty straightforward
> midlayer consumer of the DMA API much like others we already have (e.g.
> videobuf2-dma-*), just one which happens to be a language binding rather
> than some other kind of functional abstraction.
> 
> There is a realistic chance that the C API will evolve in ways which break
> the binding, but as long as a) that won't break non-Rust builds, and b) Rust
> folks are happy to take responsibility for un-breaking the Rust build if and
> when it happens, then that seems reasonable IMO.

Surely you can expect maintainers of the Rust abstraction to help with
integrating API changes -- this isn't different compared to driver / component
maintainers helping with integrating fundamental API changes for their affected
driver / component, like you've mentioned videobuf2-dma stuff.

At last year's LPC I held a talk [1] about Rust in the kernel and there was a
question at the end where I was asked how I think about cases where Rust
abstraction break caused C API changes.

My answer was that I'm not too concerned about this. We can just rely on what
already happens every day in kernel development: people work together and
collaborate. There are a lot of very core components that are widely used and
depending on the complexity of the change may require the help of the users to
integrate changes. So, I don't think with Rust abstractions we're adding
anything that the kernel does not already has a strategy to deal with.

- Danilo

[1] https://youtu.be/3Igmx28B3BQ?si=wD0CP-zku4U6fAsN

> 
> Thanks,
> Robin.
> 
> > 
> > Hence, the next version of this patch series will have the corresponding
> > maintainer entry.
> > 
> > - Danilo
> 
