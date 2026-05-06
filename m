Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29DA494A10
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082382; cv=none; b=VqyoxWY7gqCdQOBGSm0KkicDUsKVxoZpt3h7+fBgVwCjGjxil92EDuwVl5vw4JrxM+u+u6Q/7k2fXiTSo8xMY/CQbjbWWFMw9FCF9FwdDnmBQp6laexE8hHU1qrV2Y03lUELhN32rJJe0lNM8JyxjnUHWqw3QGci/ZvRLIOETsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082382; c=relaxed/simple;
	bh=aaod1ZFh0Kl3dZBO6Bxc4frPfo9fo2hpePkKVgq0Ni0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH37T6sjXX8Z5SbdAYffXYWUWpsnFDG1JAEjne7ubLsm7gHHeeZG5W8kJjEjzi9H4i3Gntf0lgd9clTk/qXIAmaggOwYLqdHY0q7IVyo7qeUXVpgME1Qx2FhSmwcYnbLVKxTKathvvKthlrLy6/TIRmB7HZNoifgZpvLiu+Uc+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U8cmkEM6; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U8cmkEM6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778082372; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=raSCPl80ajnarfPmnTKHu+IU1VXBFxdWFJ0Zm2iNnT0=;
	b=U8cmkEM6Zr79MEDqQRBVkQ8Jrt7savTMDbLfoF1f7gRiBi6kfEmfpA/95HpuJHFN7Ll8A8dBVUnTrUW8m4g0u92HjXriWDhwxMGHGLdtB+vHRlAuEtk8RbTpcDLVGKUtrAUnj8xYG2VN/Wl1KH42vz76HTQKMYTwxnY38Kv17SQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X2Rf7zl_1778082370;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X2Rf7zl_1778082370 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 May 2026 23:46:11 +0800
Date: Wed, 6 May 2026 23:46:10 +0800
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
Message-ID: <aftiQuHOA0t2lfyP@U-2FWC9VHC-2323.local>
References: <20260428060550.7167-1-feng.tang@linux.alibaba.com>
 <6dd52f8b-7092-4d02-ba24-f8b55409b7b6@kernel.org>
 <afBxtIdWqv8pD8YE@U-2FWC9VHC-2323.local>
 <f900172c-341a-4956-b7b7-b297418be913@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f900172c-341a-4956-b7b7-b297418be913@kernel.org>

On Fri, May 01, 2026 at 08:51:39PM +0200, David Hildenbrand (Arm) wrote:
> On 4/28/26 10:37, Feng Tang wrote:
> > Hi David,
> 
> Hi!
> 
> [...]
> 
> >>
> >> Okay, so on x86 it is not silent, because they don't even have a default CMA area?
> > 
> > Right for default kernel configs.
> > 
> > In kernel/dma/Kconfig:
> > 
> > config CMA_SIZE_MBYTES
> > 	int "Size in Mega Bytes"
> > 	depends on !CMA_SIZE_SEL_PERCENTAGE
> > 	default 0 if X86
> > 	default 16
> > 
> > config CMA_SIZE_PERCENTAGE
> > 	int "Percentage of total memory"
> > 	depends on !CMA_SIZE_SEL_MBYTES
> > 	default 0 if X86
> > 	default 10
> > 
> >>>
> >>> One thought is to follow the current cma reserving policy for platform
> >>> with 'CONFIG_DMA_NUMA_CMA=y', that if the numa cma (either the 'numa cma'
> >>> or 'cma pernuma' method) is not explicitly configured, set it up
> >>> according to size of default 'dma_contiguous_default_area', while
> >>> skipping the numa node where the 'dma_contiguous_default_area' lies
> >>> in, this way the default behavior of platform with one NUMA node is
> >>> kept unchanged.
> >>
> >> So, the kernel is configured to have a certain CONFIG_CMA_SIZE_MBYTES size, but
> >> you go ahead and multiply that by the number of nodes? Sounds wrong.
> > 
> > Yes. I thought about that, and didn't have good solution, and used this
> > given it's on a multi-numa-node machine, which may not be too bad
> > regarding memory usage.
> 
> It sounds wrong given the existing config options.

Yes, it is confusing. 

> > 
> > Robin did concern about the memory usage for embedded/small devices in
> > v2 review, and we change to v3 to not affect them.
> > 
> >>
> >> The whole proposal here looks rather hacky.
> > 
> > I agree :)
> > 
> >> Wouldn't a default for e.g., pernuma_size_bytes make more sense, that users can
> >> then overwrite on the cmdline?
> >  
> > This sounds good to me, if no objection from others. Maybe default 64MB
> > or more. One good part is, all these setup is under protection of
> > CONFIG_DMA_NUMA_CMA. 
> 
> I cannot do the heavy thinking here because -EBUSY, but maybe you want a config
> option similar to CMA_SIZE_MBYTES/CMA_SIZE_PERCENTAGE that either controls that
> these sizes will be split over NUMA nodes, or another one, that sets the default
> for pernuma.

Maybe a CMA_NUMA_SIZE_MBYTES?
 
> [...]
> 
> >>> +extern int cma_get_nid(const struct cma *cma)
> >>> +{
> >>> +	return cma->nid;
> >>> +}
> >>
> >> Why do you have to store the nid instead of just looking it up from the base_pfn
> >> in here?
> > 
> > My thought was 'struct cma' already have 'nid' member, and when CONFIG_NUMA=y,
> > it may be useful to save the 'nid' info instead of NUMA_NO_NODE for the default
> > cma area (cmdline like cma=XXG@YYG could make it on different node)
> 
> Ah, yeah. It's a bit nasty that we have to handle the default area like that.
> 
> Another sign that we probably shouldn't deal with the default area :)

Yep, in v2 I didn't touch the default area, while Robin had a concern
that the v2 approach will bindly add an extra per-numa cma area for
the node which already has the default area, which will hurt those
small/embedded devices which has limited number of memory. Adding
the nid check is trying to keep the behavior of one node device
unchanged.

> > 
> >>
> >> Also, what is the expectation when the ranges would span different NIDs? (is
> >> that possible?)
> > 
> > Per my understanding, it won't. There is a cma_validate_zones() to prevent it
> > from crossing zones.
> 
> It's a bit confusing, because it ignores other nids.

I might have missed your point. Do you mean one cma are could have
multiple ranges? IIUC, the default cma area could have only one range
which was covered by this check, while hugetlb_cma could have multiple
ranges.

Thanks,
Feng
