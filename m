Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2180238382;
	Thu,  6 Mar 2025 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278869; cv=none; b=iTEixzXKpN5IBcV6BET9vAj/WqWcWSpf/AABuZ5Wg4GaRbbf+G7HOYH3KsQqzk8xJpVsgdr3oRsmw+NAu+aWZw0fMyncrhlrVVV1OCF84gvil1zYGJ7J7cLSlf7uTFLSvQIiWv/Sj7GDKMrGeR5VLbkcC9ZFOOoMYfMm4YiFh7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278869; c=relaxed/simple;
	bh=y8w9Z5XBGvuLTNVCiYL3sVM/L5ZsatxzgXTOSmbh1dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIP7X3m4qedK230Tmfs83M2r7v1ixD2768aJ7Ow/yHOP8gfZbMd6Ibm3DYKxe3hMokjYLevFgrVtXn1Xq8xF/lyiJCGavfVxgVSYkVGiSdnB3pCvis9beb77ubxHpaVTKxRVMynqDw6YJ9gF3Gk499ZShA8McS/jcV6TI69wTIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlLxC4Wb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlLxC4Wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E4BC4CEE4;
	Thu,  6 Mar 2025 16:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741278868;
	bh=y8w9Z5XBGvuLTNVCiYL3sVM/L5ZsatxzgXTOSmbh1dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VlLxC4Wbu1cdNhjxZzjiVL/C5tkGwZlf23bdXVa3qCrhfN8CmtftVb20j29BCf5LK
	 Y/sCfElxHHfVikbYUa0e/0j7g2tgVXcml3GmVrK+8ujY+bKTwyyDOkpIcVRf1jMvZd
	 99WDtUreuEkMqxYlOBhNkc6rNSRpulykPMZi+jf0hHbBPlZvfkVM0dO3Ywphir7eun
	 q/xsNHIvW8ZxKWwLCQ1YKqjbfOA1Lwa6Jevn6uzKx3nuSgsV/ofiNou+XNm2v7aWmj
	 olBAhlmIn+u0d0pDU/N7HUZl91u0pODjgWjo3oBGF4APSlsZsI1L/H/BILmh4/oBlr
	 KwXleXLvWhoVg==
Date: Thu, 6 Mar 2025 17:34:21 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, aliceryhl@google.com,
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
Message-ID: <Z8nOjV5CoUfq6ogU@cassiopeiae>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
 <Z8nFJjb30_Wm3cJJ@cassiopeiae>
 <20250306161818.GG354511@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306161818.GG354511@nvidia.com>

On Thu, Mar 06, 2025 at 12:18:18PM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 06, 2025 at 04:54:14PM +0100, Danilo Krummrich wrote:
> > (For some reason, when replying to this mail, mutt removed Sima from To: and
> > instead switched Cc: to To:, hence resending.)
> 
> It is normal, Simona's mail client is setup to do that.

Huh! Never noticed that in the past.

> 
> > > I think for basic driver allocations that you just need to run the device
> > > stuffing it all into devres is ok.
> > 
> > What exactly do you mean with that? DMA memory allocations or "normal" memory
> > allocations?
> 
> Simona means things like a coherent allocation backing something
> allocated once like a global queue for talking to the device.

Yeah, that's what I propose then.

> 
> Ie DMA API usage that is not on the performance path.
> 
> > > But for dma mappings at runtime this will be too slow.
> > 
> > What exactly do you mean with "DMA mappings at runtime"? What to you think is
> > is slow in this aspect?
> 
> Things like dma_map_sg(), dma_map_page(), etc, etc.
> 
> You cannot propose to add any runtime overhead to those paths and get
> any support from the kernel community. They are performance paths
> optimized to be fast.

Oh, I didn't do that. How could I, since I did not knew what was referred
to? :-)

Quite the opposite, I fully agree with that.

I think for this we need higher level abstraction (which now that I know what
was meant I know Sima proposed already), or maybe provide an API that can
consolidate single operations for a single Devres container, etc.

But that's out of scope for this series.

- Danilo
