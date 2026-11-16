Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.175.24.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856085;
	b=k7Qxt/6FniGhqXzTvVEcpxN6tSEzmqK7p5wPkhwOfu2/s/IbhVlxixMHfuM0vMgpT8iy
	 S8yuCGr73MhPCUTktYM/pe293c3MGoJRzodq7QfKFSz/2b6bnp3kQN6rgVHHvUwhvMdRh
	 jXhQNBNiwuJ1BLB8Av6iyr5XrAxpiOHlR/CFmVljOhIU+F+RZafnRPMl3ZS0Cc/+W0Kzs
	 mV5ehEogTXJbqfPmSoWCZFCoKz+OFwzeZm4FAOurmtZaXjdc5zfrmVE0luHcnUZ2J1LUW
	 qJWmq93RicNhnRWVimYfHXTvP6wPs96NwgkUNNCdAncQswOf3HrfO9TncQi7VWkErEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856085;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=G2OFv8TROnxnOwOkrogXO7YHSz0S+Zpl86NxGZaLyck=;
	b=imVq19TQ1TmH3yx4i5ZJki28aZuhCVSAAUY9435nUTPNjGNyebfO1MTRosEkS5FFzAUw
	 5FhvIWMw57bO0EJ1aIf2jfqKBG7Yuh9MsaPf9Fyb2cYLQYAcjsZoSXI6y+COg0V9dgHKp
	 mVorCzgMyoEQJH9JiBZeTRskXtF7LuH9i/gj9tQXY2F9geH+X4EvwsQBL5b69YFh5ueTs
	 ymLdPPULJdiOaspD1HVEbX0ter/1tnUOproqgEB1l77C7oVFzYMWN8CM4Eat06CXiJlGO
	 EShQg6W1GeFCTwNtf1759UcN5shbG0MD4m+5JuUSl/yyqP8jT+OWTBGWasqogDpSe2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=alpha.franken.de;
	spf=pass smtp.mailfrom=alpha.franken.de;
	arc=none smtp.remote-ip=193.175.24.41
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19F3606A32A;
	Mon, 16 Nov 2026 19:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C19F3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1xT23R-00068K-00; Mon, 16 Nov 2026 20:07:49 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id E4AEFC01AA; Mon, 16 Nov 2026 20:07:39 +0100 (CET)
Date: Mon, 16 Nov 2026 20:07:39 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 3/7] MIPS: mm: handle highmem pages in
 arch_dma_prep_coherent()
Message-ID: <avtUe_ryNhYYGz4A@alpha.franken.de>
References: <20261110094830.2081847-1-m.szyprowski@samsung.com>
 <CGME20261110094849eucas1p2ece5eda5ed8c159ec05951bb8a3052be@eucas1p2.samsung.com>
 <20261110094830.2081847-4-m.szyprowski@samsung.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110094830.2081847-4-m.szyprowski@samsung.com>

On Tue, Nov 10, 2026 at 10:48:23AM +0100, Marek Szyprowski wrote:
> arch_dma_prep_coherent() performs the cache maintenance on the address
> returned by page_address(). On 32-bit MIPS with CONFIG_HIGHMEM the kernel
> uses HASHED_PAGE_VIRTUAL, so page_address() returns NULL for a highmem
> page that is not kmapped, and dma_cache_wback_inv() then operates on
> the virtual range starting at 0 instead of the buffer, leaving any dirty
> cache lines of the buffer in place.
> 
> Highmem pages do reach this function: dma_alloc_contiguous() can return
> a highmem CMA page, which dma_direct_alloc() handles by forcing the remap
> path and calling arch_dma_prep_coherent() on that page before creating
> the uncached mapping. Since commit f5ff79fddf0e ("dma-mapping: remove
> CONFIG_DMA_REMAP") this path is available on all MMU architectures,
> including MIPS, which previously rejected highmem CMA pages.
> 
> Fix this by reusing dma_sync_phys(), which already handles highmem pages
> by mapping them one page at a time with kmap_atomic(). For lowmem pages
> it does a single dma_cache_wback_inv() over the whole range, so the
> behaviour is unchanged there.
> 
> Fixes: f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/mips/mm/dma-noncoherent.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
