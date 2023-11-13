Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960B18B02
	for <iommu@lists.linux.dev>; Mon, 13 Nov 2023 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BtKB32RV"
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 7999F66071C9;
	Mon, 13 Nov 2023 09:11:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699866667;
	bh=tOJ8JfvvgYmBC2IS/Nxx8y3QHEaQ0Vz0qh5a9gclmrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BtKB32RVb/ojYvoSNNOknxVWpwDeCmoJV+JMTiPDu/u42qHIisAQPJGSmr7ZSPSPg
	 89NjhTtSaCkpTV5npBeNon0iBUJlV2WtX67xzBm1Hv4QsKSYv1XXt01dmyj4uru1f6
	 C/sfMJxcJ4hCr4GItivpBzjpemSYR+qFa2xt2k7ZwOI3RZs6z8XUgLryTEMDxfj5E2
	 YoyPxdFstNBRoNDA/B0M1WPe9TalPTfc87oXmwKkrpurvCTwvy+afurDnIvGdwYdmE
	 3IlwQGt3wo0Nq+Mn+tUeOz1bN+RllGnx/7oBB65LGAA9GnkOKNGHylS6cSc12jptsj
	 OVr37h1EdWX4w==
Date: Mon, 13 Nov 2023 10:11:03 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>,
 Gaurav Kohli <quic_gkohli@quicinc.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to
 pgtable drivers
Message-ID: <20231113101103.1cc05c8c@collabora.com>
In-Reply-To: <20231110194215.GR4488@nvidia.com>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
	<20231110151428.GJ4634@ziepe.ca>
	<20231110164809.270f82bc@collabora.com>
	<20231110161229.GA462657@nvidia.com>
	<20231110201652.629b7228@collabora.com>
	<20231110194215.GR4488@nvidia.com>
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

On Fri, 10 Nov 2023 15:42:15 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> > > You can put a refcounter in that data per-page to count how many
> > > callers have reserved the page. Add a new "allocate VA" API to
> > > allocate and install page table levels that cover a VA range in the
> > > radix tree and increment all the refcounts on all the impacted struct
> > > pages.  
> > 
> > I like the general idea, but it starts to get tricky when:
> > 
> > 1. you have a page table format supporting a dynamic number of levels.
> > For instance, on ARM MMUs, you can get rid of the last level if you
> > have portions of your buffer that are physically contiguous and aligned
> > on the upper PTE granularity (and the VA is aligned too, of course).
> > I'm assuming we want to optimize mem consumption by merging physically
> > contiguous regions in that case. If we accept to keep a static
> > granularity, there should be no issue.  
> 
> If the last level(s) get chopped you'd have to stick the pages into a
> linked list instead of freeing it, yes.
> 
> > 2. your future MMU requests are unordered. That's the case for
> > VM_BIND, if you have multiple async queues, or if you want to fast
> > track synchronous requests.  
> 
> Don't really understand this?

I'm just saying that you don't know when BIND requests will be
executed, and combined with #1, it makes it more complicated to guess
what should stay around/be released.

>  
> > In that case, I guess we can keep the leaf page tables around until all
> > pending requests have been executed, and get rid of them if we have no
> > remaining users at the end.  
> 
> I assumed you preallocated a IOVA window at some point and then the
> BIND is just changing the mapping.

There's no concept of pre-allocated IOVA range in panthor, at least not
yet. We just map/unmap on demand without trying to attach these
operations to an higher level entity that have an IOVA range attached to
it (I assume this would be the VkImage/VkBuffer for Vulkan).

> The IOVA allocation would pin down
> all the radix tree memory so that that any map in the preallocated
> IOVA range cannot fail.

Question is, when would you do the IOVA range allocation? So far, I was
assuming that every BIND request was a combination of:

1/ Pre-allocate enough resources for this specific map/unmap to always
succeed

2/ Execute this BIND operation when time comes

IIUC, you're suggesting doing things differently:

1/ Reserve/pre-allocate the IOVA range for your higher-level
entity/object (through an explicit ioctl, I guess)

2/ BIND requests just map/unmap stuff in this pre-allocated/reserved
IOVA range. All page tables have been allocated during #1, so there's
no allocation happening here.

3/ When your higher level object is destroyed, release the IOVA range,
which, as a result, unmaps everything in that range, and frees up the
IOMMU page tables (and any other resources attached to this IOVA range).

> 
> > > Now you can be guarenteed that future map in that VA range will be
> > > fully non-allocating, and future unmap will be fully non-freeing.  
> > 
> > You mean fully non-freeing if there are no known remaining users to
> > come, right?  
> 
> unmap of allocated IOVA would be non-freeing. Free would happen on
> allocate

Does that mean resources stay around until someone else tries to
allocate an IOVA range overlapping this previously existing IOVA
range? With your IOVA range solution, I'd expect resources to be
released when the IOVA range is released/destroyed.

> 
> > > A new domain API to prepare all the ioptes more efficiently would be a
> > > great general improvement!  
> > 
> > If there are incentives to get this caching mechanism up and running,
> > I'm happy to help in any way you think would be useful, but I'd really
> > like to have a temporary solution until we have this solution ready.
> > Given custom allocators seem to be useful for other use cases, I'm
> > tempted to get it merged, and I'll happily port panthor to the new
> > caching system when it's ready.  
> 
> My experience with GPU land is these hacky temporary things become
> permanent and then a total pain for everyone else :( By the time
> someone comes to fix it you will be gone and nobody will be willing to
> help do changes to the GPU driver.

Hm, that doesn't match my recent experience with DRM drivers, where
internal DRM APIs get changed pretty regularly, and reviewed by DRM
driver maintainers in a timely manner...

Anyway, given you already thought it through, can I ask you to provide
a preliminary implementation for this IOVA range mechanism so I can
play with it and adjust panthor accordingly. And if you don't have the
time, can you at least give me extra details about the implementation
you had in mind, so I don't have to guess and come back with something
that's not matching what you had in mind.

Regards,

Boris
