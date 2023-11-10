Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC83AC22
	for <iommu@lists.linux.dev>; Fri, 10 Nov 2023 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MQclAG9N"
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 0ADBB6607322;
	Fri, 10 Nov 2023 19:16:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699643816;
	bh=cDl2KUHFlq/mVlIouwpK4UvQypa/RtX4olOYp85mX9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MQclAG9NdTvGYl+Z/+DFy/v/IMDk5Y6MJOgHsFoCVuT9Agib27EwOYSIwS2SJyrXu
	 Xm6gPjk1bKiSFMr6UdKihIO/KfEIAz8i9x0gctAKou2gSxH7E4SPm4MeoBPM7arbF/
	 Op8tsrrHMxVY2FxaBTPdgQo+GU0BMKa8HKKl/Du5zh796RntRjFtm8Uq19ZQHPtvjd
	 FUf4KXn+FrF8NqWBOyldAc+2YYGkUXiah38PqxCfNAk2qFzAzXUAHjqRy7bd45heGZ
	 KNGUpttO45oroOKkdZ194Ay1ujybskRL14hi1ANFstlJZ2TsP81yNn9Hn/dwmBHlOz
	 WouNXvP8TP73g==
Date: Fri, 10 Nov 2023 20:16:52 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>,
 Gaurav Kohli <quic_gkohli@quicinc.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to
 pgtable drivers
Message-ID: <20231110201652.629b7228@collabora.com>
In-Reply-To: <20231110161229.GA462657@nvidia.com>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
	<20231110151428.GJ4634@ziepe.ca>
	<20231110164809.270f82bc@collabora.com>
	<20231110161229.GA462657@nvidia.com>
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

On Fri, 10 Nov 2023 12:12:29 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Nov 10, 2023 at 04:48:09PM +0100, Boris Brezillon wrote:
> 
> > > Shouldn't improving the allocator in the io page table be done
> > > generically?  
> > 
> > While most of it could be made generic, the pre-reservation is a bit
> > special for VM_BIND: we need to pre-reserve page tables without knowing
> > the state of the page table tree (over-reservation), because page table
> > updates are executed asynchronously (the state of the VM when we
> > prepare the request might differ from its state when we execute it). We
> > also need to make sure no other pre-reservation requests steal pages
> > from the pool of pages we reserved for requests that were not executed
> > yet.
> > 
> > I'm not saying this is impossible to implement, but it sounds too
> > specific for a generic io-pgtable cache.  
> 
> It is quite easy, and indeed much better to do it internally.
> 
> struct page allocations like the io page table uses get a few pointers
> of data to be used by the caller in the struct page *.

Ah, right. I didn't even consider that given how volatile page fields
are (not even sure which ones we're allowed to used for private data
tbh).

> You can put a refcounter in that data per-page to count how many
> callers have reserved the page. Add a new "allocate VA" API to
> allocate and install page table levels that cover a VA range in the
> radix tree and increment all the refcounts on all the impacted struct
> pages.

I like the general idea, but it starts to get tricky when:

1. you have a page table format supporting a dynamic number of levels.
For instance, on ARM MMUs, you can get rid of the last level if you
have portions of your buffer that are physically contiguous and aligned
on the upper PTE granularity (and the VA is aligned too, of course).
I'm assuming we want to optimize mem consumption by merging physically
contiguous regions in that case. If we accept to keep a static
granularity, there should be no issue.

and

2. your future MMU requests are unordered. That's the case for
VM_BIND, if you have multiple async queues, or if you want to fast
track synchronous requests.

In that case, I guess we can keep the leaf page tables around until all
pending requests have been executed, and get rid of them if we have no
remaining users at the end.

> 
> Now you can be guarenteed that future map in that VA range will be
> fully non-allocating, and future unmap will be fully non-freeing.

You mean fully non-freeing if there are no known remaining users to
come, right?

> 
> Some "unallocate VA" will decrement the refcounts and free the page
> table levels within that VA range.
> 
> Precompute the number of required pages at the start of allocate and
> you can trivally do batch allocations. Ditto for unallocate, it can
> trivially do batch freeing.
> 
> Way better and more generically useful than allocator ops!
> 
> I'd be interested in something like this for iommufd too, we greatly
> suffer from poor iommu driver performace during map, and in general we
> lack a robust way to actually fully unmap all page table levels.

Yeah, that might become a problem for us too (being able to tear down
all unused levels when you only unmap a portion of it, and the rest was
already empty). That, and also the ability to atomically update a
portion of the tree (even if I already have a workaround in mind for
that case).

> 
> A new domain API to prepare all the ioptes more efficiently would be a
> great general improvement!

If there are incentives to get this caching mechanism up and running,
I'm happy to help in any way you think would be useful, but I'd really
like to have a temporary solution until we have this solution ready.
Given custom allocators seem to be useful for other use cases, I'm
tempted to get it merged, and I'll happily port panthor to the new
caching system when it's ready.

Regards,

Boris
