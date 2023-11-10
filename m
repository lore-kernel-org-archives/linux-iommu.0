Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336712E46
	for <iommu@lists.linux.dev>; Fri, 10 Nov 2023 09:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hr1IGq+o"
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id D123166073EF;
	Fri, 10 Nov 2023 09:52:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699609955;
	bh=21JPMc5nCzm9ynbxzOvHCWdhr+G/7u4J/hhGJKmwPiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hr1IGq+oqoJ9Rr9acOW3M64iX3LlRXTD1EYZcN6fIQQ/5yG5CjEoniES62bBbkrpi
	 h0ipr9LIm4GwFzFXISjFhjjCL8uUJUn8KEsOHTcV4P9HM7fCevRb7Q9ASJx2FXAOwE
	 WUlBIBMI1YwEvRYeQB9VXnqxtu+h+QZYYz7psOCq7U1SWW1w/Xomq16zhGNsaPvYr4
	 WJ6Yl3evU6bHj3OwofnGfx1Xg6BQ5otDfkLriVpTevxlhBFkoelAfAAKdaPbjq0V6v
	 4qsQ1KkPQkPtKL936n1kwRJi3+oRdNXNqnbYVpqK8w3hr+fOhl6EJT4Ocd6Bd6gf76
	 UDh+sRVxjpJIA==
Date: Fri, 10 Nov 2023 10:52:31 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, Will Deacon
 <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Clark
 <robdclark@gmail.com>
Subject: Re: [PATCH 2/2] iommu: Extend LPAE page table format to support
 custom allocators
Message-ID: <20231110105231.3a8fd2ff@collabora.com>
In-Reply-To: <04ae3d0c-d850-63c7-80bb-f90e26f5b758@arm.com>
References: <20230809121744.2341454-1-boris.brezillon@collabora.com>
	<20230809121744.2341454-3-boris.brezillon@collabora.com>
	<04ae3d0c-d850-63c7-80bb-f90e26f5b758@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Sep 2023 17:42:01 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 09/08/2023 1:17 pm, Boris Brezillon wrote:
> > We need that in order to implement the VM_BIND ioctl in the GPU driver
> > targeting new Mali GPUs.
> > 
> > VM_BIND is about executing MMU map/unmap requests asynchronously,
> > possibly after waiting for external dependencies encoded as dma_fences.
> > We intend to use the drm_sched framework to automate the dependency
> > tracking and VM job dequeuing logic, but this comes with its own set
> > of constraints, one of them being the fact we are not allowed to
> > allocate memory in the drm_gpu_scheduler_ops::run_job() to avoid this
> > sort of deadlocks:
> > 
> > - VM_BIND map job needs to allocate a page table to map some memory
> >    to the VM. No memory available, so kswapd is kicked
> > - GPU driver shrinker backend ends up waiting on the fence attached to
> >    the VM map job or any other job fence depending on this VM operation.
> > 
> > With custom allocators, we will be able to pre-reserve enough pages to
> > guarantee the map/unmap operations we queued will take place without
> > going through the system allocator. But we can also optimize
> > allocation/reservation by not free-ing pages immediately, so any
> > upcoming page table allocation requests can be serviced by some free
> > page table pool kept at the driver level.  
> 
> We should bear in mind it's also potentially valuable for other aspects 
> of GPU and similar use-cases, like fine-grained memory accounting and 
> resource limiting. That's a significant factor in this approach vs. 
> internal caching schemes that could only solve the specific reclaim concern.

I mentioned these other cases in v2. Let me know if that's not detailed
enough.

> > diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> > index f4caf630638a..e273c18ae22b 100644
> > --- a/drivers/iommu/io-pgtable.c
> > +++ b/drivers/iommu/io-pgtable.c
> > @@ -47,6 +47,18 @@ static int check_custom_allocator(enum io_pgtable_fmt fmt,
> >   	if (!cfg->alloc)
> >   		return 0;
> >   
> > +	switch (fmt) {
> > +	case ARM_32_LPAE_S1:
> > +	case ARM_32_LPAE_S2:
> > +	case ARM_64_LPAE_S1:
> > +	case ARM_64_LPAE_S2:
> > +	case ARM_MALI_LPAE:
> > +		return 0;  
> 
> I remain not entirely convinced by the value of this, but could it at 
> least be done in a more scalable manner like some kind of flag provided 
> by the format itself?

I added a caps flag to io_pgtable_init_fns in v2. Feels a bit weird to
add a field that's not a function pointer in a struct that's prefixed
with _fns (which I guess stands for _functions), but oh well.

Regards,

Boris
