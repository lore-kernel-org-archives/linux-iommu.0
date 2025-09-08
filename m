Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B492E2DCD;
	Mon,  8 Sep 2025 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352316; cv=none; b=OmcTH8Mibz83du4ruthDipmRiLjPqQLjmsJfywIJNMEtxFoq7q5g8QTZvv+7feP22HlWtbpRb8L6r40zA2VGGlcBoEhHdoF3GA9cZ36RY0V9VzxaZplFaByS8n0RBtWXQgdKd0Tn8tw6rUAJfFQGj9NS0XEk1mNwy4038XeJEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352316; c=relaxed/simple;
	bh=zkhWWy+sRv33C/oGCQzLKd0+ELPB11Lho+CSt3t+2vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdiMkFXR4hRmdM5chU98IT3N+qslk8g/leJ57tXQNh0ieXbUSr6dgSQ6qhj/EFYcFBwS74g5af5n5xXpcUyVHAOyLhI9Ap70K2sJ5VaDz4bJONlBiXEfB19K+Qk6DI1DFChUliVhBZ5d0ApJoUY3KxXQKsaVMHaogNvARjdhvuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D14C4CEF1;
	Mon,  8 Sep 2025 17:25:14 +0000 (UTC)
Date: Mon, 8 Sep 2025 18:25:10 +0100
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
Message-ID: <aL8RdvuDbtbUDk2D@arm.com>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com>
 <yq5aikht1e0z.fsf@kernel.org>
 <aL7AoPKKKAR8285O@arm.com>
 <b5ee1ab3-f91f-4982-95c7-516f4968a6c9@arm.com>
 <20250908145845.GA699673@ziepe.ca>
 <d8687b08-6bb4-4645-8172-72936a51b0d8@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8687b08-6bb4-4645-8172-72936a51b0d8@arm.com>

On Mon, Sep 08, 2025 at 04:39:13PM +0100, Steven Price wrote:
> On 08/09/2025 15:58, Jason Gunthorpe wrote:
> > If ARM has proper faulting then you don't have an issue mapping 64K
> > into a userspace and just segfaulting the VMM if it does something
> > wrong.
> 
> ...the VMM can cause problems. If the VMM touches the memory itself then
> things are simple - we can detect that the fault was from user space and
> trigger a SIGBUS to kill of the VMM.

Similarly for uaccess.

> But the VMM can also attempt to pass the address into the kernel and
> cause the kernel to do a get_user_pages() call (and this is something we
> want to support for shared memory). The problem is if the kernel then
> touches the parts of the page which are protected we get a fault with no
> (easy) way to relate back to the VMM.

I assume the host has a mechanism to check that the memory has been
marked as shared by the guest and the guest cannot claim it back as
private while the host is accessing it (I should dig out the CCA spec).

> guest_memfd provided a nice way around this - a dedicated allocator
> which doesn't allow mmap(). This meant we don't need to worry about user
> space handing protected memory into the kernel. It's now getting
> extended to support mmap() but only when shared, and there was a lot of
> discussion about how to ensure that there are no mmap regions when
> converting memory back to private.

That's indeed problematic and we don't have a simple way to check that
a user VMM address won't fault when accessed via the linear map. The
vma checks we get with mmap are (host) page size based.

Can we instead only allow mismatched (or smaller) granule sizes in the
guest if the VMM doesn't use the mmap() interface? It's not like
trapping TCR_EL1 but simply rejecting such unaligned memory slots since
the host will need to check that the memory has indeed been shared. KVM
can advertise higher granules only, though the guest can ignore them.

-- 
Catalin
