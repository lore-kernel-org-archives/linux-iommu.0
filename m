Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EF24C6E;
	Sat, 14 Sep 2024 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726274326; cv=none; b=UQljDfRglNc8Rx7ckheTBdNlX8N2X+0iQk6oRFV9dVRvVQvrFD/DoMFXA5VGihu6ce0HzVgHFDIyZegkU9vmMGfahZx+IyEXY0JnUQ3Z5OvmyZHVwmG7OqfIkGQ5casNLwmEyYTWXURun7i8GmksygTInR43fK11IO4mndELqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726274326; c=relaxed/simple;
	bh=xPV8+ZCZJcBdtoPdBMxViz7qFsscKin9fUcUeIj1Das=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pnuGja4J6lg4Eyuqd3RXjr9W/bcuQOVKva6G98JR4ThZ9WK49Zci4ZUUi0YbEyUIuI0Q8+NILQ+M3AbmRvfXb5bOax7xiOOYF6dx4P9XRSj1f9HC78Jp7SJR7ijJG/bZbKJhdqVI4XArzyKmMdwKcZRK52AAFriHu7IMUhZJ+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvdbTk0q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvdbTk0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41336C4CEC0;
	Sat, 14 Sep 2024 00:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726274325;
	bh=xPV8+ZCZJcBdtoPdBMxViz7qFsscKin9fUcUeIj1Das=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IvdbTk0qtd4kv3EfRvhJuttLjW3wI/AaYCcs7hTeWEW6MqTOT1+S1Kfkw9qbfJpS6
	 sT2wWYpJ2h/HfHJQmeFREzvUXXoI3z5FiXFDc3vtRx1oqGfiekJ62ApfahE818lPhs
	 3+WNpwNyFhD1JQA5EOY/47tZ6dGUXxX6k8NOPdGOMGYj9XZlFAZLaeA9Q2iRiolSsd
	 xfkCowhZtEn7sRRuROXJMO/pjSo3xwK3RVMeRPwE0a+jBFxfQWYWhsahFU5zTISYi5
	 umMVtk0N2Mhf2HhpfoP54Hc6PapCaPWT7ZUvXymslbMS31ETfwCyGcKW9DUFbSCyUJ
	 2JzXKNEK9i/Kw==
Date: Fri, 13 Sep 2024 17:38:28 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Jan Beulich <jbeulich@suse.com>
cc: Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
    iommu@lists.linux.dev
Subject: Re: [PATCH] xen/swiotlb: add alignment check for dma buffers
In-Reply-To: <a0b0dec5-03c1-4b69-aa0e-65771251d859@suse.com>
Message-ID: <alpine.DEB.2.22.394.2409131728420.1417852@ubuntu-linux-20-04-desktop>
References: <20240913145655.10076-1-jgross@suse.com> <a0b0dec5-03c1-4b69-aa0e-65771251d859@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 13 Sep 2024, Jan Beulich wrote:
> On 13.09.2024 16:56, Juergen Gross wrote:
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
> >  {
> >  	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
> >  	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
> > +	unsigned int order = get_order(size);
> >  
> >  	next_bfn = pfn_to_bfn(xen_pfn);
> >  
> > +	/* If buffer is physically aligned, ensure DMA alignment. */
> > +	if (IS_ALIGNED(p, 1UL << (order + PAGE_SHIFT)) &&
> 
> Why this check? xen_swiotlb_alloc_coherent() guarantees it, while
> xen_swiotlb_free_coherent() only checks properties of the original
> allocation. And for xen_swiotlb_map_page() this looks actively
> wrong to me, in case that function was called with offset non-zero.

I understand xen_swiotlb_alloc_coherent and xen_swiotlb_free_coherent
not needing the check, but I think we might need the check for
xen_swiotlb_map_page. At that point, I would keep the check for all
callers. Unless there is another way to detect whether the mapping needs
alignment specifically for map_page?

For the offset, in theory if the device needs alignment, the offset
should be zero? If the offset is not zero, then there should be no
alignment requirement. The way Juergen wrote the check, we would take
the fast path if offset != zero, which makes sense to me.
