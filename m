Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34D3D810F
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777365435; cv=none; b=tTJ0DXTYxEGhGvirwSA1SvaKvinivOqrvLnjpGQFmkbf+FE/nCC+x9Qfb49pmN5AsRx6hCvUf5N+RxMOIiq8SLzfSv9n82Ul+J5rli2ClJ7Dc3guqqwsk0xbXS9IdulqAAYWDpegJ4Si84dXhrWut7MTZrTBDA+m81iCKsMpBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777365435; c=relaxed/simple;
	bh=bFI3e4HqNdfIJ2hzy8kEa8NN7YkQujVN2mgZIjwgopQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pse74I+IFfzlAVV9EHg5IzMop8BevQCOq9YOJIMd18Dg88cCIdbREo+ocxe3hiwsXoBOwV0SyJht3aHMDlYnILdC72y7MosWsJjhAQy46c3rAB5O6WtxZmUa2zE8ObJjPrT95TBF7XyyZr2pxHRm4dcgAC5Gf2ho55U5LFQznAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c0dpP7Hg; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c0dpP7Hg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777365430; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=myH3QOIFz0y2hknBNFxgLWJcfHd2Xwb17shw2Tk83v4=;
	b=c0dpP7HgfFGKLpB3nC8dqF8ECTViQSdBko6BVwsog6umbc+Tdru+hlO5mmjw89srBSqgs/ThxKM4GRjnFN3EXollXAyRjAXmLMu81EIyx0N8+I6AZTJ9L7vepsTTjrIas22gUAF9i9A09xeHVJlfl3FXkTsa75x06TLhigBbe2A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X1txRAC_1777365428;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X1txRAC_1777365428 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Apr 2026 16:37:09 +0800
Date: Tue, 28 Apr 2026 16:37:08 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Liam.Howlett@oracle.com,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
Subject: Re: [PATCH v3] dma-contiguous: setup default numa cma area if not
 configured explicitly
Message-ID: <afBxtIdWqv8pD8YE@U-2FWC9VHC-2323.local>
References: <20260428060550.7167-1-feng.tang@linux.alibaba.com>
 <6dd52f8b-7092-4d02-ba24-f8b55409b7b6@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6dd52f8b-7092-4d02-ba24-f8b55409b7b6@kernel.org>

Hi David,

Thanks for the review!

On Tue, Apr 28, 2026 at 09:52:15AM +0200, David Hildenbrand (Arm) wrote:
> On 4/28/26 08:05, Feng Tang wrote:
> > There was a report on a multi-numa-nodes ARM server that when IOMMU is
> > disabled, the dma_alloc_coherent() function always returns memory from
> > node 0 even for devices attaching to other nodes, while they can get
> > local dma memory when IOMMU is on with the same API.
> > 
> > The reason is, when IOMMU is disabled, the dma_alloc_coherent() will
> > go the direct way and call dma_alloc_contiguous(). The system doesn't
> > have any explicit cma setting (like per-numa cma), and only has a
> > default 64MB cma reserved area (on node 0), where kernel will try
> > first to allocate memory from.
> > 
> > Robin Murphy suggested to setup pernuma cma or disable cma, which did
> > solve the issue. 
> 
> That sounds like the obvious approach to me.

Indeed. We also gave some of them to the reporter once we got the report. 

> > While there is still concern that for customers
> > which don't have much kernel knowledge, they could still suffer from
> > this silently as some architectures enable cma area by default (not
> > an issue for X86 though, which set CONFIG_CMA_SIZE_MBYTES to 0 by
> > default) for most Linux distributions.
> 
> Okay, so on x86 it is not silent, because they don't even have a default CMA area?

Right for default kernel configs.

In kernel/dma/Kconfig:

config CMA_SIZE_MBYTES
	int "Size in Mega Bytes"
	depends on !CMA_SIZE_SEL_PERCENTAGE
	default 0 if X86
	default 16

config CMA_SIZE_PERCENTAGE
	int "Percentage of total memory"
	depends on !CMA_SIZE_SEL_MBYTES
	default 0 if X86
	default 10

> > 
> > One thought is to follow the current cma reserving policy for platform
> > with 'CONFIG_DMA_NUMA_CMA=y', that if the numa cma (either the 'numa cma'
> > or 'cma pernuma' method) is not explicitly configured, set it up
> > according to size of default 'dma_contiguous_default_area', while
> > skipping the numa node where the 'dma_contiguous_default_area' lies
> > in, this way the default behavior of platform with one NUMA node is
> > kept unchanged.
> 
> So, the kernel is configured to have a certain CONFIG_CMA_SIZE_MBYTES size, but
> you go ahead and multiply that by the number of nodes? Sounds wrong.

Yes. I thought about that, and didn't have good solution, and used this
given it's on a multi-numa-node machine, which may not be too bad
regarding memory usage.

Robin did concern about the memory usage for embedded/small devices in
v2 review, and we change to v3 to not affect them.

> 
> The whole proposal here looks rather hacky.

I agree :)

> Wouldn't a default for e.g., pernuma_size_bytes make more sense, that users can
> then overwrite on the cmdline?
 
This sounds good to me, if no objection from others. Maybe default 64MB
or more. One good part is, all these setup is under protection of
CONFIG_DMA_NUMA_CMA. 

> > 
> > To get the node info of cma area, add some helpr funciton and setup
> > in cma code.
> > 
> > Reported-by: Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
> > Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> > ---
> > Changelog:
> > 
> >   since v2:
> >     * setup the numa cma are following default cma, while
> > 	  skipping the node holds the default cma (Robin Murphy)
> > 	* add cma_get_node() help and related code
> > 	* add reporter info 
> > 
> >   since v1:
> > 	* don't use the original way of adding alloc_pages_node()
> > 	  before trying default cma node (Robin Murphy)
> > 	* setup default numa cma area if not configured (Ying Huang)
> > 
> >    v2: https://lore.kernel.org/lkml/20260423095243.14239-1-feng.tang@linux.alibaba.com/
> >    v1: https://lore.kernel.org/lkml/20260414090310.92055-1-feng.tang@linux.alibaba.com/
> > 
> >  include/linux/cma.h     |  1 +
> >  kernel/dma/contiguous.c | 14 ++++++++++++--
> >  mm/cma.c                | 11 ++++++++++-
> >  3 files changed, 23 insertions(+), 3 deletions(-)
[...]
> > +extern int cma_get_nid(const struct cma *cma)
> > +{
> > +	return cma->nid;
> > +}
> 
> Why do you have to store the nid instead of just looking it up from the base_pfn
> in here?

My thought was 'struct cma' already have 'nid' member, and when CONFIG_NUMA=y,
it may be useful to save the 'nid' info instead of NUMA_NO_NODE for the default
cma area (cmdline like cma=XXG@YYG could make it on different node)

> 
> Also, what is the expectation when the ranges would span different NIDs? (is
> that possible?)

Per my understanding, it won't. There is a cma_validate_zones() to prevent it
from crossing zones.

Thanks,
Feng

> 
> -- 
> Cheers,
> 
> David
