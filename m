Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B47442A
	for <iommu@lists.linux.dev>; Fri, 10 Nov 2023 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JJbaqDi4"
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 9678066073E4;
	Fri, 10 Nov 2023 15:48:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699631293;
	bh=B9o6OQfSP0BFlU1mn+rGDd1tSmaexT3fOYDHXF/HFsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JJbaqDi4AuyrP6l66ntWvLF/lxLxI7+OVoUaYFGXKO6oN+V6YrMbdMItOyJAr0bbl
	 XB4tLc0aX8EYXRZWMmq0L5bdLqSW298PFZHPNyLb3B+rts2sTKsXj6/g5H+2Eup8gS
	 1FM0hwnaQsmXxWjqsA8gJMZog6FpKO6VJLKG4B7quXmCDTNmKfmJxljZ1cPegnCdxq
	 JOs0MrcdhAOeEd1uXWIPDEhvbGHKMI7bqADR/hEtQ3m+yvDlgPPicJpgeUxNKs7lKt
	 nO0JDPmG/XQvQ95U05KmkP/F01oy2KpwWsV4K+Z2PJcJ6pqcIqjrE+kmJY0WCJErxD
	 +P2GddXRJ8Plw==
Date: Fri, 10 Nov 2023 16:48:09 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Rob Clark <robdclark@gmail.com>,
 Gaurav Kohli <quic_gkohli@quicinc.com>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to
 pgtable drivers
Message-ID: <20231110164809.270f82bc@collabora.com>
In-Reply-To: <20231110151428.GJ4634@ziepe.ca>
References: <20231110094352.565347-1-boris.brezillon@collabora.com>
	<20231110151428.GJ4634@ziepe.ca>
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

Hi Jason,

On Fri, 10 Nov 2023 11:14:28 -0400
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Fri, Nov 10, 2023 at 10:43:50AM +0100, Boris Brezillon wrote:
> > Hello,
> > 
> > This patchset is an attempt at making page table allocation
> > customizable. This is useful to some GPU drivers for various reasons:
> > 
> > - speed-up upcoming page table allocations by managing a pool of free
> >   pages
> > - batch page table allocation instead of allocating one page at a time
> > - pre-reserve pages for page tables needed for map/unmap operations and
> >   return the unused page tables to some pool  
> 
> Why would these topics be unique to GPU drivers as a user?

They are not, it's just that the primary use case for this extension
was a GPU driver, and that other GPU driver maintainers have expressed
interest in this solution too. Gaurav has a different use case that has
nothing to do with caching MMU page table allocations.

> 
> Shouldn't improving the allocator in the io page table be done
> generically?

While most of it could be made generic, the pre-reservation is a bit
special for VM_BIND: we need to pre-reserve page tables without knowing
the state of the page table tree (over-reservation), because page table
updates are executed asynchronously (the state of the VM when we
prepare the request might differ from its state when we execute it). We
also need to make sure no other pre-reservation requests steal pages
from the pool of pages we reserved for requests that were not executed
yet.

I'm not saying this is impossible to implement, but it sounds too
specific for a generic io-pgtable cache.

> 
> > A real example of how such custom allocators can be used is available
> > here[1]. v2 of the Panthor driver is approaching submission, and I

That's actually v3, not v2.

> > figured I'd try to upstream the dependencies separately, which is
> > why I submit this series now, even though the user of this new API
> > will come afterwards. If you'd prefer to have those patches submitted
> > along with the Panthor driver, let me know.  
> 
> Patches like this should come with users,

Fine, I can submit those two patches as part of the panthor patch
series if you prefer.

> but I think you should
> refocus this effort to improving the io pagetable itself not allowing
> a GPU driver to replace its insides.

These 2 patches don't come out of the blue. This has been discussed
with Robin who suggested to go for this simple solution where
allocations are deferred to the io-pgtable user. Turns out Gaurav
came up with a different use case where these custom page table
allocators would be useful.

Regards,

Boris
