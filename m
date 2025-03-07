Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E3226D0A;
	Fri,  7 Mar 2025 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363765; cv=none; b=BrLMil1evTv41FfXfy2y0db1AHqexI62zYSvvWO6SuKNIpJkSkOgDJlCyK6jKyTYjKMzJiNf6pZURIQKwoE8dF46mPSw4dtEV3FLwBW+o47NJrfQueo92L99Sg8sudtk2+S5AWQ8BC2JDDu6ZbrPIpG9qIeE1CioiUgJ4+0Imk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363765; c=relaxed/simple;
	bh=OjzgZIrF4I2Usopqifbp/MqmZF5LZWDEmj7w8BfGAOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFUGx/uolgfKyTRwlw2Ljr4Y0UcceQVZni+q/vaAuL9HQTQzWlnKEbdJQHRaMA6y4DFslhYScbPH4Zyy9CNDlSj8eC7PzfCmvoOP/Q788/B8IbqxQf0eHtDDMDsbJxdA8+J6aiRBVxOHBMY1bWjq0YW0BKP3hfP36CpC6OieQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRixdy6/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRixdy6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03B6C4CED1;
	Fri,  7 Mar 2025 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741363764;
	bh=OjzgZIrF4I2Usopqifbp/MqmZF5LZWDEmj7w8BfGAOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRixdy6/AE5PCxS5J+Ug/OE91n6wpvg3310s9xJb3CIlggDDaMfzy2YA0LLJ+wzMK
	 KFGtabUqbxPWftAGlrA6QpxjyQWW+ahk8AhjFm0mqplp2aYjzcSOHeSWdGqvdtsjWa
	 5ZO98/8DZC/a1MawaJ8lzVSvRTbr29iqgiQkGjo0VFQnTY/BpXNb8qpVx5QGEER8Pt
	 yG8lbMSBb1aU8bOym3nEioEKNrn15zHWOWI3z4OOjRi77OdaB2YFDkZQadiKpc7+cS
	 LbuzBZ+yjaDP12RjnaSRks4/IMqlBUTruFV5YbHfWu6XnsIkh8gMVS+90lt0FOdFpu
	 bZ0RF+V5CGFGw==
Date: Fri, 7 Mar 2025 17:09:17 +0100
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
Message-ID: <Z8saLZAylcVp89n_@cassiopeiae>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
 <20250306160907.GF354511@nvidia.com>
 <Z8qzP3CR8Quhp87Z@pollux>
 <20250307124809.GL354511@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307124809.GL354511@nvidia.com>

On Fri, Mar 07, 2025 at 08:48:09AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 07, 2025 at 09:50:07AM +0100, Danilo Krummrich wrote:
> > > The actual critical region extends into the HW itself, it is not
> > > simple to model this with a pure SW construct of bracketing some
> > > allocation. You need to bracket the *entire lifecycle* of the
> > > dma_addr_t that has been returned and passed into HW, until the
> > > dma_addr_t is removed from HW.
> > 
> > Devres callbacks run after remove(). It's the drivers job to stop operating the
> > device latest in remove(). Which means that the design is correct.
> 
> It could be the drivers job to unmap the dma as well if you take that
> logic.

I really don't understand what you want: *You* brought up that the
CoherentAllocation is not allowed to out-live driver unbind.

We agreed and provided a way that solves this. But then you point out the
unsolvable problem of malicious (or wrongly programmed) hardware and use it to
question why we then even bother solving the problem you just pointed out, that
is solvable.

So, what do you ask for?

> You still didn't answer the question, what is the critical region of
> the DevRes for a dma_alloc_coherent() actually going to protect?

Devres, just like in C, ensures that an object can't out-live driver unbind. The
RCU read side critical section is to revoke access to the then invalid pointer
of the object.

C leaves you with an invalid pointer, whereas Rust revokes the access to the
invalid pointer for safety reasons. The pointer is never written to, except for
on driver unbind, hence RCU.

We discussed all this in other threads already.

> 
> You also have to urgently fix the synchronize_rcu() repitition of you
> plan to do this.

I mentioned this a few days ago, and I did not forget it. :-)

> 
> > Now, you ask for a step further, i.e. make it that we can enforce that a driver
> > actually stopped the device in remove().
> 
> So where do you draw the line on bugs Rust should prevent and bugs
> Rust requires the programmer to fix?

It should prevent all safety related bug, but the one above is impossible to
solve, so we have to live with it. But that doesn't mean it's a justification to
stop preventing bugs we can actually prevent? Do you disagree?
