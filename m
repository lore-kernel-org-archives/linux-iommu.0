Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC9621ADD1;
	Fri,  7 Mar 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368620; cv=none; b=LOzkIOgLwBQl32KOANRAsIyEQw0W0n1M2iV0V3vtOHsfN//c7swdKBcf1j9betS8+YydUtee7jrwYDV9VuqQYrI7uIqW584Z8gs5M6ECX4Tkzgy3CSzgLNNOyP/LvmSD2QYs1mmAaKx39pGqHwjhr+jajtYlkWdBd5zsFx4+cN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368620; c=relaxed/simple;
	bh=idZpOgGWwBcWwDlTrADTld9lJlnm8FlUf5M8sgWw7Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXQVtnK5dKYtRlGzwVn27QAe0SGPij1pX4A5s6ysnROofCsEU4gmThJz+t/KTtVOT6pjIrIjEDxKPUf5dSAfVx6fiTL2vu/dx0fHP3PoN88/NpehoRgOBMZ50FTQlklDr9zLC5R2hMDJa9h6xNHdbH781/2ZhrLCV+w0a3BIRDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG2yx83z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG2yx83z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D23C4CED1;
	Fri,  7 Mar 2025 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741368619;
	bh=idZpOgGWwBcWwDlTrADTld9lJlnm8FlUf5M8sgWw7Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iG2yx83zckufubez5OOpWPHQR2I52lDOX+Dhg3R0BFZ/eqTo4oD3GzbMUZ8XFNEH6
	 naejkbQoZnvfAYsDluW0lBydwiElJg43BGTJk/PyJny+4OwuluHVwqNGz1tgEEBqgv
	 /hz/NHjX1iPuY0cnV0C2nH4ZAfSQg9DNwDFZ0YFPtnP64yJpWMooh0YkYUkeRGrcJ2
	 BQcTuWueRugSi2gi7KEnmAGiecCNeKKNALsM7Sw5gYKdnRamDynbUpy+OnnT92NfBM
	 SS/hyL9TCNVSh2Z30GE6J7edjmRzGmC4yOBjumldrRitw7/gdz/XDYhQjTMgDsD1bA
	 4LJcWMMEWSg8w==
Date: Fri, 7 Mar 2025 18:30:13 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <Z8stJXrDtA5tZB40@cassiopeiae>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
 <20250306160907.GF354511@nvidia.com>
 <Z8qzP3CR8Quhp87Z@pollux>
 <20250307124809.GL354511@nvidia.com>
 <Z8rxm-BHldKqEwyp@phenom.ffwll.local>
 <20250307143821.GM354511@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307143821.GM354511@nvidia.com>

On Fri, Mar 07, 2025 at 10:38:21AM -0400, Jason Gunthorpe wrote:
> 
> This Rust direction is radically transforming how the driver lifecycle model
> of the kernel works

I already explained in other threads that the Rust abstractions follow the device
/ driver model. There is no "radical change" to it. Since I assume you still
refer to the Devres aspect of it, please find another explanation in [1].

But please also show in detail where you see the "radical change" of the driver
model, maybe there's some misunderstanding?

> with almost no review from any kernel experts.

Do you question Greg being an expert on the driver model? Who do you think
applied the patches after month of discussions on the mailing list and at
conferences?

> Certainly I object to it. I think others will too if they understood
> what was going on here.

Again, this stuff was on the corresponding mailing lists for month; I haven't
seen such objections.

I'm absolutely willing to address yours though. And I'm happy to be questioned
on this stuff by you and in general.

But please start doing so in a constructive way, i.e. if you find issues help
solving them instead of just trying to blame people. If you think there is no
issue, but still think another approach would be better, please send patches.

> Write a position paper in Documentation/ on how you imagine lifecycle
> will work with Rust driver bindings

Rust abstractions follow the driver model, just like the C code does.

What - and please provide details - should this position paper describe?
The driver model itself, implementation details of the Rust abstractions or
something else?

> and get some acks from experienced people??

Again, this stuff was on the list for month, I can't force people to review it.

Do you have a list of those experienced people? Maybe you can get them to
revisit things and contribute improvements?

However, let me also say that experienced people *did* review it and work on it.

---

[1] Devres - C vs. Rust
-----------------------

Starting with C, let's pick the following two functions.

	pcim_iomap()
	pcim_request_region()

Those two are called from probe() and the pointer returned from pcim_iomap() is
stored in some driver specific structure, which, depending on the subsystem and
driver, may out-live driver unbind.

If the driver is unbound the following functions are called automatically after
remove() from the corresponding devres callbacks.

	pci_iounmap()
	pci_release_region()

The pointer in the driver specific structure (if still existent) becomes
invalid.

In Rust the lifecycle of the I/O memory mapping and the resource region are
bound to a structure called pci::Bar.

Creating a new pci::Bar calls pci_iomap() and pci_request_region(). Dropping the
object calls pci_iounmap() and pci_release_region(). The pointer to the memory
mapping is embedded in the pci::Bar object.

The driver model prescribes that device resources must be released when the
driver is unbound. Hence, we can't hand out a raw pci::Bar object to driver,
because the object lifetime could be extended across the "driver is unbound"
boundary.

This is why we only ever give out the pci::Bar object in a Devres container,
i.e. Devres<pci::Bar>.

Devres puts the pci::Bar in a Revocable and sets up the devres callback. Once
the devres callback is called the embedded pci::Bar is dropped, which calls
pci_iounmap() and pci_release_region().

Subsequently, the access to the pci::Bar for the owner of the Devres<pci::Bar>
object is revoked, since the pointer to the memory mapping within the pci::Bar
just became invalid.

The latter is the only additional step the Rust abstraction does, in order to
not leave drivers with an invalid pointer. However, this additional safety
aspect is *not* a change of the driver model itself.
