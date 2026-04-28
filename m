Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3163E3148
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367007; cv=none; b=Q/Wxef6JN5sGSNw5lis+pBQfQKYTV4U4GOI296HRSPdm4GB6c8hu09H6fez8jocQwyvmA2gRdIOkXzdhdrfxVVD8FgW+CCfo0ZV9M0dukufMTkrpPWx4KPVz0u5PZmXPcfkMiv9alb/wQAoVCknU0fotV12Zk0WiEqgJwzLBACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367007; c=relaxed/simple;
	bh=PCg341CEvH/iElDQ5yNTrI97030Jl1V/2iyPh/9j4zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfKOu4unIhgM8hJJ6LyCYAPzKOOaBB8J+KrevLT4h+Ge791IOXd2qjJzdaTQ1S++ntptgKBkx9+W6JQ7o07AwON8k18scSIY9arKKuoQeKjc64bYLtiZWsEgZtynUC1TX79Ladk0U35nZdry6PGXCz9gutNeEBmMQzVkhHdiEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jzW+RS/+; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jzW+RS/+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777367003; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=ipahEW+GGYKoUkQjhbzDfkF4W3Q2W6HmS1nNqAHycr8=;
	b=jzW+RS/+QPw0ah3ql3B1IYAdfDhIlYIMbniWsHNHMtAL1DiHrUi26oZ1ZCxrENF9xp+Vb8wgW2biALSpYuBxU/VMwyRkMjlSM6c9athnZdfPibh19gB2/eFwMIdRqIaA7Rd+0m5jU95rSpyX6g3i6TBFUdS0DlKIx9Am7s156/0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X1u5t9W_1777367001;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X1u5t9W_1777367001 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Apr 2026 17:03:21 +0800
Date: Tue, 28 Apr 2026 17:03:20 +0800
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
Message-ID: <afB32MQG9vx_j9NP@U-2FWC9VHC-2323.local>
References: <20260428060550.7167-1-feng.tang@linux.alibaba.com>
 <6dd52f8b-7092-4d02-ba24-f8b55409b7b6@kernel.org>
 <afBxtIdWqv8pD8YE@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afBxtIdWqv8pD8YE@U-2FWC9VHC-2323.local>

On Tue, Apr 28, 2026 at 04:37:08PM +0800, Feng Tang wrote:
> > >  include/linux/cma.h     |  1 +
> > >  kernel/dma/contiguous.c | 14 ++++++++++++--
> > >  mm/cma.c                | 11 ++++++++++-
> > >  3 files changed, 23 insertions(+), 3 deletions(-)
> [...]
> > > +extern int cma_get_nid(const struct cma *cma)
> > > +{
> > > +	return cma->nid;
> > > +}
> > 
> > Why do you have to store the nid instead of just looking it up from the base_pfn
> > in here?
> 
> My thought was 'struct cma' already have 'nid' member, and when CONFIG_NUMA=y,
> it may be useful to save the 'nid' info instead of NUMA_NO_NODE for the default
> cma area (cmdline like cma=XXG@YYG could make it on different node)

One interesting thing is about the API to get nid, I initially worked on
6.19 base, and used 'pfn_to_nid()' which worked well, but I got a kernel
panic when rebasing to 7.1. 

It turned out, latest kernel changed the order of default cma reserving to
before the initialization 'struct page' (only tested on arm64), and
pfn_to_page() will return NULL at the reserving time, so I changed to
early_pfn_to_nid(). Storing the 'nid' could save the logic of chosing the
right API in cma_get_nid().

Thanks,
Feng

