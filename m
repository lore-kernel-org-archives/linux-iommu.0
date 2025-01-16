Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91322A1D5;
	Thu, 16 Jan 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737033451; cv=none; b=Bi2B+eKTzLrOnbmVsFfoGGgOvOcBJu17UTMMr8ZaNFJjuUYyfVSATPCxbE4OSK2T8GLXRl9tyg6YkzGKTKaRNl8Ra78/MBUvE5CdZeJR834oiiDpaK++Mgdt/ckeNED3DXy+MzHBEYZqzRsdJ6Mpf+Xp4VW2Wf1mfGRaYbd/fMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737033451; c=relaxed/simple;
	bh=98YfFK3FLo/r2IcUebkfZNsNhdLdmUle6ZwkLclRkw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrSaXzsFbXc/YGuVs0Lc++1RLOu7dGsnHz40kWT67vIEYEJa4BgfxoYZQ/x/pOmfsnYo/x3K8XWQ/up4ZnJunJhRa3GpiE7qbyg38FvmFkuQ3iCAy6QRFQtQGjW42hv0tVt/UNxVTBsxRLhgStNk1znrHeI8iMX18t2Vxb8T08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvlIMcNP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvlIMcNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97D4C4CED6;
	Thu, 16 Jan 2025 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737033451;
	bh=98YfFK3FLo/r2IcUebkfZNsNhdLdmUle6ZwkLclRkw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvlIMcNPuW5PC6LunsMB/wk7ePhtPVrxSC2lErrCYeI+qwk3QofD1uzYzx57/6Wq0
	 3OsXZT8yw/pnQbTE05e1CG0vPLHOEh3oBBHCXzwsmkFC+DfItlWAhF4QtWlfxKvwin
	 seC+XCs9VFUN58Hf3dOrvT1KQGA5PwnxnPhD4tidr3aR+cDeGQq5zXIC4uXZfAAOXD
	 Nvu1PHjZpOgTg7f8507h6FEJu5uPciO/HhpeicBeNkvA+RXeft2CbbyBZp6TxAhQCr
	 W8FQiQzl4DRNmEfXT1dc81p6vGIiOlU1x1qMDJxsXQjTIqkNetLuxU8/U/YD+T8cRc
	 qqbBQclPjbHyw==
Date: Thu, 16 Jan 2025 14:17:24 +0100
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
Message-ID: <Z4kG5AcVeQKegLnb@pollux>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <20250108122825.136021-3-abdiel.janulgue@gmail.com>
 <20250108135951.GA18074@lst.de>
 <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de>
 <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de>
 <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de>
 <Z4D5a5NYrAbNxUL6@pollux>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4D5a5NYrAbNxUL6@pollux>

On Fri, Jan 10, 2025 at 11:41:54AM +0100, Danilo Krummrich wrote:
> On Fri, Jan 10, 2025 at 09:39:55AM +0100, Christoph Hellwig wrote:
> > On Thu, Jan 09, 2025 at 09:49:47AM +0100, Danilo Krummrich wrote:
> > > On Thu, Jan 09, 2025 at 09:08:12AM +0100, Christoph Hellwig wrote:
> > > > On Wed, Jan 08, 2025 at 04:21:33PM +0100, Danilo Krummrich wrote:
> > > > > What does "your code" mean? Duplicated in every driver?
> > > > 
> > > > Yes, interfaces to the DMA API should stay in readable C code and not
> > > > in weird bindings so that it reminds greppable and maintainable.
> > > > 
> > > 
> > > Rust drivers shouldn't use C APIs directly, but rather use an abstraction of the
> > > corresponding C API.
> > 
> > Don't force me to deal with your shiny language of the day.
> 
> Again, no one asks you to deal with or maintain this piece of Rust code.
> 
> > Maintaining
> > multi-language projects is a pain I have no interest in dealing with.
> > If you want to use something that's not C, be that assembly or rust you
> > write to C interfaces and deal with the impedence mismatch yourself as
> > far as I'm concerned.
> > 
> 
> This is exactly what we're doing and proposing here, isn't it?
> 
> We wrote a single piece of Rust code that abstracts the C API for all Rust
> drivers, which we offer to maintain ourselves.
> 
> What else are you asking for?

Since there hasn't been a reply so far, I assume that we're good with
maintaining the DMA Rust abstractions separately.

Hence, the next version of this patch series will have the corresponding
maintainer entry.

- Danilo
