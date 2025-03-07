Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632531C8625;
	Fri,  7 Mar 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337414; cv=none; b=CcyRt/iCS7JQyuY2tmHz/2Nfg3zzNeMfBPo5abh/rVzz/J/q952rDXGRdgGpAflCUeqtxls52DsRtjjn5T4O4Yt3ikG5f5dbkVmv94ltjq383YiFZhyDu9CeMdQ6lncFAyQ174e5cx7yANSr086+n1AB35Y3TOG1KYfKBUDqloo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337414; c=relaxed/simple;
	bh=awBu8u0irBnMyQWo3G8Lqu6cbt03nNzUk9SYRlTFHVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFeQnmdOQ5R+CF7ja3gAJMA1Wg2Pp/6FkdRaIVtyCdg0iXIZN6LmeIBU/O6n0VqiwPz2G2NjFHdV6G7qsZEHlDMGF6DNy4+jRjgzfrpDvTIk24skq0ufIrRWBHjkP1NKJt0ISr6kXi9j5oI2ygmEk+2IRIcRn5vZ4NOPYia2U4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sd+zPDhw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sd+zPDhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCB4C4CED1;
	Fri,  7 Mar 2025 08:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741337413;
	bh=awBu8u0irBnMyQWo3G8Lqu6cbt03nNzUk9SYRlTFHVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sd+zPDhw1aZKbdRbD1EG4J8udHHsuXcq/IzEo4Mp52aEwVnMO/XxLerKPkyea93OA
	 HgQg2bpqh7guLply4h53oV0XUZiKoLqFJfdJjCNpz7LFypTOQO6OFRIca19WPcyQo2
	 oOPdEJZyjJBxt2pse2OqfLLYQvQg3opZBbOCooceYNC2kEnAJ7cVhHS0IAsrpGEfhU
	 aMYVFvrRHIlerrugB9xibmWO1ti+WWqAjRnNREj4rTQcZgjKNL82dh6UpqLmQRcA3/
	 ykBWHby4Y6H2cnguivH1ayZbbRt8AFP83g1BRpq7XSof1yUyKmdVpOoL1fGZT32Kj9
	 2lmnJ7Y0EdUgQ==
Date: Fri, 7 Mar 2025 09:50:07 +0100
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
Message-ID: <Z8qzP3CR8Quhp87Z@pollux>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
 <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
 <20250305174118.GA351188@nvidia.com>
 <Z8mlAxsszdOH-ow8@cassiopeiae>
 <Z8m9j3SwWHqaCTXo@phenom.ffwll.local>
 <20250306160907.GF354511@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306160907.GF354511@nvidia.com>

On Thu, Mar 06, 2025 at 12:09:07PM -0400, Jason Gunthorpe wrote:
> On Thu, Mar 06, 2025 at 04:21:51PM +0100, Simona Vetter wrote:
> > > >  > a device with no driver bound should not be passed to the DMA API,
> > > >  > much less a dead device that's already been removed from its parent
> > > >  > bus.
> > > 
> > > Thanks for bringing this up!
> > > 
> > > I assume that's because of potential iommu mappings, the memory itself should
> > > not be critical.
> 
> There is a lot of state tied to the struct device lifecycle that the
> DMA API and iommu implicitly manages. It is not just iommu mappings.
> 
> It is incorrect to view the struct device as a simple refcount object
> where holding the refcount means it is alive and safe to use. There
> are three broad substates (No Driver, Driver Attached, Zombie) that
> the struct device can be in that are relevant.
> 
> Technically it is unsafe and oopsable to call the allocation API as
> well on a device that has no driver. This issue is also ignored in
> these bindings and cannot be solved with revoke.

This is correct, and I am well aware of it. I brought this up once when working
on the initial device / driver, devres and I/O abstractions.

It's on my list to make the creation of the Devres container fallible in this
aspect, which would prevent this issue.

For now it's probably not too critical; we never hand out device references
before probe(). The only source of error is when a driver tries to create new
device resources after the device has been unbound.

> IOW I do not belive you can create bindings here that are truely safe
> without also teaching rust to understand the concept of a scope
> guaranteed to be within a probed driver's lifetime.
> 
> > > > Also note that any HW configured to do DMA must be halted before the
> > > > free is allowed otherwise it is a UAF bug. It is worth mentioning that
> > > > in the documentation.
> > > 
> > > Agreed, makes sense to document. For embedding the CoherentAllocation into
> > > Devres this shouldn't be an issue, since a driver must stop operating the device
> > > in remove() by definition.
> >
> > I think for basic driver allocations that you just need to run the device
> > stuffing it all into devres is ok. 
> 
> What exactly will this revokable critical region protect?
> 
> The actual critical region extends into the HW itself, it is not
> simple to model this with a pure SW construct of bracketing some
> allocation. You need to bracket the *entire lifecycle* of the
> dma_addr_t that has been returned and passed into HW, until the
> dma_addr_t is removed from HW.

Devres callbacks run after remove(). It's the drivers job to stop operating the
device latest in remove(). Which means that the design is correct.

Now, you ask for a step further, i.e. make it that we can enforce that a driver
actually stopped the device in remove().

But that's just impossible, because obviously no one else than the driver knows
the semantics of the devicei; it's the whole purpose of the driver. So, this is
one of the exceptions where just have to trust the driver doing the correct
thing.

Having that said, it doesn't need to be an "all or nothing", let's catch the
ones we can actually catch.
