Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE9730EF91;
	Fri, 12 Sep 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689190; cv=none; b=qJdsWMt0akykPaTvzFJe7MHc+KiVK0nchG/KRA72t2PM5BPe288RPDJYrqd2KgK2DGnPsEWu4TJ4rp8BLKAr/2KQbkcouvYQBFe2KWS+aTac3JehPBBFPKryGew9XZ43WFz+s97Y4c976bRnW5INg7fFP6xwGnnWbQ5/xU9CR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689190; c=relaxed/simple;
	bh=Y63oO/Ez/Xx54356NFRLcKdmi2+o1MjmCWY+eQ6jWto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbAPxVuYGWWFyL+wKWiOw/eFsW45q138/t4o/d42nbBqSUmQCbotxkYE5BmOza+xJnTdyq2jmU/hUz9fsDMikrqbasc1IXKtrYeGlXZOshuHsGum4ffZMwVqubg4Ys3zgxV8wvYkOj5qaW3StunAP5Y0eighiTMYyZvQVHNxpr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8D5C4CEF1;
	Fri, 12 Sep 2025 14:59:48 +0000 (UTC)
Date: Fri, 12 Sep 2025 15:59:45 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
	tglx@linutronix.de, robin.murphy@arm.com, akpm@linux-foundation.org
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
Message-ID: <aMQ1YeoB2PsO2e17@arm.com>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com>
 <yq5aikht1e0z.fsf@kernel.org>
 <aL7AoPKKKAR8285O@arm.com>
 <b5ee1ab3-f91f-4982-95c7-516f4968a6c9@arm.com>
 <20250908145845.GA699673@ziepe.ca>
 <d8687b08-6bb4-4645-8172-72936a51b0d8@arm.com>
 <aL8RdvuDbtbUDk2D@arm.com>
 <ea4b657e-13fa-485e-9d3c-5b395ad3d8e2@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea4b657e-13fa-485e-9d3c-5b395ad3d8e2@arm.com>

On Wed, Sep 10, 2025 at 11:08:19AM +0100, Steven Price wrote:
> On 08/09/2025 18:25, Catalin Marinas wrote:
> > On Mon, Sep 08, 2025 at 04:39:13PM +0100, Steven Price wrote:
> >> On 08/09/2025 15:58, Jason Gunthorpe wrote:
> >>> If ARM has proper faulting then you don't have an issue mapping 64K
> >>> into a userspace and just segfaulting the VMM if it does something
> >>> wrong.
> >>
> >> ...the VMM can cause problems. If the VMM touches the memory itself then
> >> things are simple - we can detect that the fault was from user space and
> >> trigger a SIGBUS to kill of the VMM.
> > 
> > Similarly for uaccess.
> > 
> >> But the VMM can also attempt to pass the address into the kernel and
> >> cause the kernel to do a get_user_pages() call (and this is something we
> >> want to support for shared memory). The problem is if the kernel then
> >> touches the parts of the page which are protected we get a fault with no
> >> (easy) way to relate back to the VMM.
> > 
> > I assume the host has a mechanism to check that the memory has been
> > marked as shared by the guest and the guest cannot claim it back as
> > private while the host is accessing it (I should dig out the CCA spec).
> > 
> >> guest_memfd provided a nice way around this - a dedicated allocator
> >> which doesn't allow mmap(). This meant we don't need to worry about user
> >> space handing protected memory into the kernel. It's now getting
> >> extended to support mmap() but only when shared, and there was a lot of
> >> discussion about how to ensure that there are no mmap regions when
> >> converting memory back to private.
> > 
> > That's indeed problematic and we don't have a simple way to check that
> > a user VMM address won't fault when accessed via the linear map. The
> > vma checks we get with mmap are (host) page size based.
> > 
> > Can we instead only allow mismatched (or smaller) granule sizes in the
> > guest if the VMM doesn't use the mmap() interface? It's not like
> > trapping TCR_EL1 but simply rejecting such unaligned memory slots since
> > the host will need to check that the memory has indeed been shared. KVM
> > can advertise higher granules only, though the guest can ignore them.
> > 
> 
> Yes, mismatched granules sizes could be supported if we disallowed
> mmap(). This is assuming the RMM supports the required size - which is
> currently true, but the intention is to optimise the S2 in the future by
> matching the host page size.
> 
> But I'm not sure how useful that would be. The VMMs of today don't
> expect to have to perform read()/write() calls to access the guest's
> memory, so any user space emulation would need to also be updated to
> deal with this restriction.
> 
> But that seems like a lot of effort to support something that doesn't
> seem to have a use case. Whereas there's an obvious use case for the
> guest and VMM sharing one (or often more) pages of (mapped) memory. The
> part that CCA makes this tricky is that we need to pick the VMM's page
> size rather than the guest's.

Given that the vmas in Linux are page-aligned, it's too intrusive to
support sub-page granularity in the host (if at all possible). So, based
on the discussion here, we do need the guest to play along and share
mappings with the granularity of the host page size. Of course, one way
is to mandate that the guest uses the same page size as the host.

The original patch needs some more changes mentioned in this thread. It
is missing places where we have set_memory_decrypted() but the size is
not guaranteed to be aligned. I would also replace the
arch_shared_mem_alignment() name with something that resembles the
mem-encrypt API (e.g. mem_encrypt_align(size) for lack of inspiration;
the default would return 'size' so there's no change for other
architectures). Using 'shared' is confusing since the notion of sharing
is not limited to confidential compute.

It does feel like this could be handled at a higher level (e.g. the
virtio code or specific device drivers doing DMA) but it won't be
generic enough. Bouncing of decrypted DMA via swiotlb is already
generic.

BTW, with device assignment, we need a second, encrypted swiotlb as it's
used for bouncing small buffers. Unless we mandate that all devices
assigned to realms are fully coherent.

-- 
Catalin
