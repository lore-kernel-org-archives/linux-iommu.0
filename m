Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC91FCC
	for <iommu@lists.linux.dev>; Tue, 11 Oct 2022 06:40:16 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id EC98A67373; Tue, 11 Oct 2022 08:40:10 +0200 (CEST)
Date: Tue, 11 Oct 2022 08:40:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Issue seen since commit f5ff79fddf0e ("dma-mapping: remove
 CONFIG_DMA_REMAP")
Message-ID: <20221011064010.GA3646@lst.de>
References: <20221010185739.vgw27m7fpmftly3q@cantor>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010185739.vgw27m7fpmftly3q@cantor>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 10, 2022 at 11:57:39AM -0700, Jerry Snitselaar wrote:
> I still need to grab a system and try to see what it is doing on the
> subsequent shutdowns, because it seems to me that any time
> bnx2fc_free_session_resc() is called it will end up there, unless the
> allocs are not coming from vmalloc() in the later boots. Between the
> comments in dma_free_attrs(), and preempt.h, dma_free_coherent()
> shouldn't be called under a spin_lock_bh(), yes?

It shouldn't.  And you would have seen the same BUG_ON on many non-x86
architectures even beforethe commit..

> I think the comments
> in dma_free_attrs() might be out of date with commit f5ff79fddf0e
> ("dma-mapping: remove CONFIG_DMA_REMAP") in place since now it is more
> general that you can land in vunmap().

Yes, the comment has always been a bit too specific, and is even more
so now.

> Also, should that WARN_ON() in
> dma_free_attrs() trigger as well for the BH disabled case?

Probably.  And we should probably early return in that case to "just"
leak the memory instead of crashing the kernel when called from a buggy
driver.
