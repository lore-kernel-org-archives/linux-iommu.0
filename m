Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167BA33FE;
	Fri, 21 Mar 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578500; cv=none; b=YIsAH3VXntqsQ6XzwvykAt8M7ZdWsvkMs9ootl0H197l+Gjy2tGQiwauX6feNmfhVoXnVbMxWHErW5J9MVclN4BoIaNTp7HYBcGWIkDpUZddOfoQ0c7mflmZs6yuI3ddZvZ4qytkW0TmWkyHd0p4zLrdKP73BthlLi1/iXQvNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578500; c=relaxed/simple;
	bh=5IK+fayIXGO1J9siJYn4pomELX8YNlKg+TiE6LBatcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP3bEgdQQE+ydPl0Ltjj+JIyHhMKbr2NVXtnTk/BVuT3DTbphMeooOeisEnXsqxCzEjRLjWC85iVs0XlwMUGbUYfSboszL+0pH3OTKBiu6fCkWVcRI5W671++HToC03V0mzm3EwDWUIYcDwRET1G1aBFuJqp80XtI9XoewrnD6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxU3eWCo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxU3eWCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE18C4CEE8;
	Fri, 21 Mar 2025 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578499;
	bh=5IK+fayIXGO1J9siJYn4pomELX8YNlKg+TiE6LBatcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxU3eWCokZN60a0lgjphfYzWcxFyAxmaKTdSW8cF0XVek18Q9bePNebKW64HPz2Hi
	 jHqAvUiRuGymOWc/cNNMrYnx+0IPIZT71xDjcfqgp1DE/CzX8LZc+TGvMoiLCubzuo
	 xpTmq+5DgD0/44c6xPANSt+n6PIrvftqz6iA40gACipG0x1zFygExKNNurzgRbWBzb
	 vVf7QTnca/zciEuJrU0QOR6Z1T3YXI6/255fblR+knrXPc1bBiaYjRY6PYJCoNds/E
	 dGxAQW3l5tMXSrgoq8So1ZLTDDLScAWj62ZzKKcNc5IDbP1oUctARtc0uYRRODEePT
	 dLkfsUbWwgr7w==
Date: Fri, 21 Mar 2025 18:34:53 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	robin.murphy@arm.com, aliceryhl@google.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v13 2/7] rust: add dma coherent allocator abstraction.
Message-ID: <Z92jPXvMOqhgv04k@pollux>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <20250307110821.1703422-3-abdiel.janulgue@gmail.com>
 <20250321172353.GO126678@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321172353.GO126678@ziepe.ca>

On Fri, Mar 21, 2025 at 02:23:53PM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 07, 2025 at 01:06:19PM +0200, Abdiel Janulgue wrote:
> 
> > +        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
> > +        let ret = unsafe {
> > +            bindings::dma_alloc_attrs(
> > +                dev.as_raw(),
> > +                size,
> > +                &mut dma_handle,
> > +                gfp_flags.as_raw(),
> > +                dma_attrs.as_raw(),
> > +            )
> 
> This is not the correct safety statement, the device must have a driver
> bound to call this function, a struct device reference is not
> sufficient.
> 
> I belive Danilo was suggesting to ignore this unsafety for now, but if
> so it should be documented correctly.

If just landed patches [1], which are the foundation of addressing this issue.

With the next cycle, this will be ensured by the type system.

> 
> Also think the use of devres here is going to be very problematic for
> drivers to use as I said in other emails. :(

In an earlier reply today in a different thread already gave you the link [2] of
what we landed, which, besides explaining the situation, also makes clear that
there is *no* Devres wrapper around a CoherentAllocation and why.

[1] https://lore.kernel.org/lkml/20250314160932.100165-1-dakr@kernel.org/
[2] https://github.com/Rust-for-Linux/linux/blob/rust-next/rust/kernel/dma.rs#L120
