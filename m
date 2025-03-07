Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E564F23E23C;
	Fri,  7 Mar 2025 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374233; cv=none; b=EG5YI/Z36H4p4yDc2ZweJCu3J2gfCwSgEjsxMBNGHGzwKz1JIoNXSFlj8qTq/3xg7rM2aqDhys6sS77CvVEJZKH3z6VV6/eZ7q/Nk5Zfq5F+rxpQU5Vn98WVGj65am0q+iSvWDBvAN94n1XWmUbIHX8VRBA4oTFKDFR5P/8rlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374233; c=relaxed/simple;
	bh=7XE+okAqZbnST1X4dPRpwQVmabqaYZxhCYTZ9oCbMuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEUHt5B4JyrEi4bab7llAb8QYUPviRKhWDmX6QyH1K+BVHlhV8MFVE2DLACXCk1dsMDsI9wuLdFlKXrSNqkscSsq8ms5uxn7RujAlpFHfQ7twZkvh8O4WjjZHJdWsQqJAi3sLtCSGLZh4HlxwWv8coYztBoqKoviW8tJYDlE3yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgT6Bczv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgT6Bczv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E35EC4CED1;
	Fri,  7 Mar 2025 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741374232;
	bh=7XE+okAqZbnST1X4dPRpwQVmabqaYZxhCYTZ9oCbMuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgT6BczvX+Ncor2NddjIGOQ+7gzQy7kLqXwCbnixouO20Ubkh5fx2F8Zi3TR66UXL
	 Ai0v0F2vlxpBMK/WGIDK7K68Z2iSAb8Iop3Hnd0FtYWN/itA4erqXwhsnQa0LWI3lc
	 vwMF+VRRDcvaliXpxfXQuWor8R+0e17LpcQIQz1y4dV+TwYFlSbq4frC40ejNEbNci
	 azz9IDU8tbMkgTnMZLNuRaJVbghcAcxQ25xLzXh9O9olxXVCSddYlCB2kMupO22J/x
	 xUaIE5QdasLmZcgoLOpGrtAqFiPFJR2LnD/oML4VPc/cggf5OIJ9reqrHXfkctTxsH
	 r7dnPts+Vmxdg==
Date: Fri, 7 Mar 2025 20:03:45 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
	robin.murphy@arm.com, daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
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
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
Message-ID: <Z8tDEU2BKj9F3hZ8@cassiopeiae>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
 <20250306160907.GF354511@nvidia.com>
 <Z8qzP3CR8Quhp87Z@pollux>
 <20250307124809.GL354511@nvidia.com>
 <Z8saLZAylcVp89n_@cassiopeiae>
 <20250307165751.GT354511@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307165751.GT354511@nvidia.com>

On Fri, Mar 07, 2025 at 12:57:51PM -0400, Jason Gunthorpe wrote:
> 
> Why are you explaining very simple concepts as though I do not
> understand how RCU or devm works?
> 
> I asked you what you intend to protect with the critical region.

When you ask what the critical region protects, I think that it protects the
resource pointer from changing.

I did not read it as "what's meant to be within the critical region".

> 
> I belive you intend to wrapper every memcpy/etc of the allocated
> coherent memory with a RCU critical section, correct?
> 
> Meaning something like:
> 
>   mem.ptr = dma_alloc_coherent(&handle)
>   make_hw_do_dma(handle)
> 
>   start RCU critical section on mem:
>       copy_to_user(mem.ptr) // Sleeps! Can't do it!
>   dma_free_coherent(mem, handle)
> 
> Right?

Yes, that would indeed be a problem. Thanks for pointing it out.

While we could do an SRCU variant, provide separate try_access() methods, etc.,
I think we should do something more efficient:

There is no reason to revoke the *whole* CoherentAllocation object, but only the
the parts that are critical to actually cleanup on driver unbind, i.e. iommu
mappings, etc.

The actual memory allocation itself is not an issue in terms of living beyond
driver unbind and hence doesn't need to be revoked.

With this, you would not need any critical section to access the
CoherentAllocation's memory from the driver.

> Further, if the critical section ever fails to obtain mem.ptr the
> above code is *BUGGY* because it has left a HW DMA running, UAF'd the
> now free'd buffer *and the driver author cannot fix it*.

I don't think that'd be the case in a Rust driver, your example is in C, and
hence doesn't do the Rust style error and cleanup handling that the
corresponding Rust code would do.

But as mentioned above, putting the whole CoherentAllocation in a Devres
container seems wrong anyways. We need to do it at a finer granularity.
