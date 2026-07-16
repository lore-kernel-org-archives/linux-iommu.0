Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141023AE706
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221092; cv=none; b=SVjb5unIhVWB3M7iNlGIWG/X4NTQ6MprAhYbpCef2ub72Z8EWPKfKNw721TWFDqkSKtEI9CDkt7LohpdnybS7RyawBWwLgtiRDazBlz620iPBcdgmylKEs/ZiVoSHwn9vGljpaxatzGBVnMMqA6oP+3mclwPwpw6Smm40fPEpFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221092; c=relaxed/simple;
	bh=kOEeQKgd9Qi92gSe3w5lOrX8i/Iosnzz/6Xd87zGRhI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hfk31FVW5XITJ0yXT+GmbxzsJBMOEKmmgP5xwwTkWEjSX953VrGc3RNFdIYSSxjAk948Pqs3RxEk8tKbTn0g6uUzEuswSE0C1ah0HowgTrZcNSTZ/1C5qAmIsgvEDXaA4/VbhLIaD/dvz9gHoSHtVyvgj4BhpLwpANpaWeDues0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NzoLBRtD; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NzoLBRtD"
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784221082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jC4p4Ne6/jLWSLskeAq6PhK3LdwKo4FxILlpTyonIAI=;
	b=NzoLBRtD+O2u9AcgHZtfKMgXcga+qLhFKthO1GlzTLVouCV2Aq05/j9oIk+2lQHxV40PwN
	0CZS3G9sfJCFe61gaEjL1Q7fJWRNA4sS+jMvmZvl8bmFZnpaizzIf57h2e2ss7V/vBGwCw
	47u9tjpdeInTvHDJ/D2zx4vURd9rMGQ=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 16:57:37 +0000
Message-Id: <DK05KUIDJVLZ.61UIWOL0K3OT@linux.dev>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "David Hildenbrand"
 <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Zi Yan" <ziy@nvidia.com>, "Jan Kara" <jack@suse.cz>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Byungchul Park" <byungchul@sk.com>, "Gregory
 Price" <gourry@gourry.net>, "Ying Huang" <ying.huang@linux.alibaba.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Chris Li"
 <chrisl@kernel.org>, "Kairui Song" <kasong@tencent.com>, "Kemeng Shi"
 <shikemeng@huaweicloud.com>, "Nhat Pham" <nphamcs@gmail.com>, "Baoquan He"
 <baoquan.he@linux.dev>, "Barry Song" <baohua@kernel.org>, "Youngjun Park"
 <youngjun.park@lge.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>, "Thomas
 Gleixner" <tglx@kernel.org>, "Chuck Lever" <cel@kernel.org>, "Jeff Layton"
 <jlayton@kernel.org>, "NeilBrown" <neil@brown.name>, "Olga Kornievskaia"
 <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey"
 <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker"
 <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, <iommu@lists.linux.dev>,
 <loongarch@lists.linux.dev>, <linux-nfs@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm: move internal mempolicy APIs to new internal
 header
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Matthew Wilcox" <willy@infradead.org>, "Brendan Jackman"
 <jackmanb@google.com>
References: <20260716-folio-alloc-cleanups-v1-0-5363b8e92d33@google.com>
 <20260716-folio-alloc-cleanups-v1-1-5363b8e92d33@google.com>
 <alkLSzQvzT9zJbY1@casper.infradead.org>
In-Reply-To: <alkLSzQvzT9zJbY1@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu Jul 16, 2026 at 4:48 PM UTC, Matthew Wilcox wrote:
> On Thu, Jul 16, 2026 at 02:30:10PM +0000, Brendan Jackman wrote:
>> There are no external users for this surface, reduce the scope.
>> -struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
>> -		struct mempolicy *mpol, pgoff_t ilx, int nid);
>
> Hm.  So what we're saying is that allocations which respect mempolicy are
> only for core mm and not for, eg, device drivers to do.  Is that really
> what we want to say?  I don't think so, because that's inconsistent
> with having just widened __filemap_get_folio_mpol to allow guest_memfd
> to specify a mempolicy.

Yeah I agree, mempolicy definitely seems like a "public concept".=C2=A0 All
I'm saying here is this specific function doesn't have any external
users so it doesn't need to be an external header.=20

... With the ulterior motive that I want to add a new parameter to it
that actually _is_ mm-internal. Namely, alloc_flags, so I can add
ALLOC_UNMAPPED to implement AS_NO_DIRECT_MAP, i.e. the next iteration of
[0]. So basically this is
about trying to extend the allocator without creating a GFP flag.

So I'm envisaging if an external user arises for it later, we'd slap two
underscores on the beginning of the internal one, (with the alloc_flags
arg), and then bring back the public one as a wrapper.

Does that make sense?

[0]: https://lore.kernel.org/all/20260410151746.61150-1-kalyazin@amazon.com=
/
