Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10E274FC2;
	Fri,  5 Sep 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103929; cv=none; b=XolSR8BU6neDSndrSiz+u5Jes55HQ6+aQirF//36eQpkTuGYOQ8B12ZkIMR133/LYc/vC3LnDrPivmsnDvoD78C2v4NdqpBCgCwQjJM7rIeu04JVXWOPNrXEEYn0bFIZ+WkqKeqRB8nmuOVBZNDN4befoq/O2He2nPJFVOT/gpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103929; c=relaxed/simple;
	bh=ZOTjLz4f/m7qQgugzOpcO4mM2jpd9yFtO+LJ3mSPOIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGtRFRTB5MNgXqaR0ygJFuN/nZcSfHdwtsHSr+AVEmXvEqvDjqfdmTLz3p0Rw3zJlxODgmf4thlhtCtzexuMs7jVEHp2WcIQZx+9DSa9K9ad/kTdSlCcb6sJYim4HbQB1oTkYEJ9aWjbXoO3bAauXT7uCDt5bDhZi9jCFkjtyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62805C4CEF1;
	Fri,  5 Sep 2025 20:25:26 +0000 (UTC)
Date: Fri, 5 Sep 2025 21:25:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-coco@lists.linux.dev, will@kernel.org, maz@kernel.org,
	tglx@linutronix.de, robin.murphy@arm.com, suzuki.poulose@arm.com,
	akpm@linux-foundation.org, steven.price@arm.com
Subject: Re: [RFC PATCH] arm64: swiotlb: dma: its: Ensure shared buffers are
 properly aligned
Message-ID: <aLtHNCaMJTulDOw8@arm.com>
References: <20250905055441.950943-1-aneesh.kumar@kernel.org>
 <aLrh_rbzWLPw9LnH@arm.com>
 <20250905162258.GA483339@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905162258.GA483339@ziepe.ca>

On Fri, Sep 05, 2025 at 01:22:58PM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 05, 2025 at 02:13:34PM +0100, Catalin Marinas wrote:
> > > @@ -213,16 +213,20 @@ static gfp_t gfp_flags_quirk;
> > >  static struct page *its_alloc_pages_node(int node, gfp_t gfp,
> > >  					 unsigned int order)
> > >  {
> > > +	long new_order;
> > >  	struct page *page;
> > >  	int ret = 0;
> > >  
> > > -	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
> > > +	/* align things to hypervisor page size */
> > > +	new_order = get_order(ALIGN((PAGE_SIZE << order), arch_shared_mem_alignment()));
> > > +
> > > +	page = alloc_pages_node(node, gfp | gfp_flags_quirk, new_order);
> > >  
> > >  	if (!page)
> > >  		return NULL;
> > >  
> > >  	ret = set_memory_decrypted((unsigned long)page_address(page),
> > > -				   1 << order);
> > > +				   1 << new_order);
> > 
> > At some point this could move to the DMA API.
> 
> I don't think we should be open coding these patterns.
> 
> Esepcially given the above, it makes no sense to 'alloc page' and then
> 'decrypt page' on ARM CCA. decryption is not really a OS page level
> operation. I suggest coming with some series to clean these up into a
> more sensible API.
> 
> Everything wanting decrypted memory should be going through some more
> general API that has some opportunity to use pools.

I proposed something like GFP_DECRYPTED last year but never got around
to post a proper patch (and also add vmalloc() support):

https://lore.kernel.org/linux-arm-kernel/ZmNJdSxSz-sYpVgI@arm.com/

The GIC ITS code would have been one of the very few users, so we ended
up with open-coding the call to set_memory_decrypted().

-- 
Catalin
