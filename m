Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2093F0767;
	Mon, 11 May 2026 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507264; cv=none; b=C+UgCw8YYxKff3i0xmqow4SQFQAza6BdqS+4nMQwyEUEKZ8XbUyBwwwTMUu0NAN20JsRbug5f2a5p2xMAobC3pi0PWftYeKHDjBUYQtDQEBIPpmN58rSt8FEZLqk+KnVLvcmoiTBAnpItJsAnZJL3H31oyB4AXY5e33A2ibm04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507264; c=relaxed/simple;
	bh=DO0CEk4PDTH7B5mKGoePWsVv/dBexRVKuLQLjZWrftY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTEaUZUzEPrhmgksBZhyMZ6Jx9zkFhlQXCuOj/xYRo9RkhIgHeOMVIlfdqlO5+qLUIlZRDZdNqnOExR+1nSYTXpfRQtroMb7YhdiaBAzAj4nPLJGuX+vpvlCpnREZPWzAGWs1qIQrPATVYvCenJ2aBW5bMnOuBNIHkRvMnN67HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuxg+xHj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuxg+xHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4A9C2BCB0;
	Mon, 11 May 2026 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778507263;
	bh=DO0CEk4PDTH7B5mKGoePWsVv/dBexRVKuLQLjZWrftY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uuxg+xHjp/JYX/ccPTYilRbmu182EdYt08U/jdxjDVGgKnRvXUM15TARE3ZVW7Non
	 CmhTBLpmO8p3NvXGPTPwKAoGfWNBuqaU1JyIj+dgx8H6w+g/E1zxanmS2VH7MRP/5D
	 06gIPeI+aYWECJL4OQ2XGa7wvxQ/cMkqrJU41IeaUTG1cZ5w45UVzOKtgXdMTbhH35
	 rmULiGEAl86uN+ij5+0OcrQ2xaOaHR2voRJrj2Dcztq/xzv3zLS4VEq5oHs8QHGAt0
	 jIgLqRjmFjmUuq4Rv7QqbN9sJAHFA3Qwl5pO8ExkLqEu4rddexdyUMJil6XbOSABm7
	 8QH5kIqlLyvRA==
Message-ID: <1da07b4c-43a5-4eee-b7f5-0b96742df2a5@kernel.org>
Date: Mon, 11 May 2026 15:47:39 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-contiguous: add kconfig option to setup numa cma area
 if not configured explicitly
To: Feng Tang <feng.tang@linux.alibaba.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Liam.Howlett@oracle.com,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
References: <20260509072543.69650-1-feng.tang@linux.alibaba.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260509072543.69650-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 09:25, Feng Tang wrote:
> There was a report on a multi-numa-nodes arm64 server that when IOMMU
> is disabled, the dma_alloc_coherent() function always returns memory
> from node 0 even for devices attaching to other nodes, while they can
> get local dma memory when IOMMU is on with the same API.
> 
> The reason is, when IOMMU is disabled, the dma_alloc_coherent() will
> go the direct way and call dma_alloc_contiguous(). The system doesn't
> have any explicit cma setting (like per-numa cma), and only has a
> default 64MB cma reserved area (on node 0), where kernel will try
> first to allocate memory from.
> 
> Robin Murphy suggested to setup pernuma cma or disable cma, which did
> solve the issue. While there is still concern that for customers
> which don't have much kernel knowledge, they could still suffer from
> this silently as some architectures enable cma area by default (not
> an issue for X86 though, which set CONFIG_CMA_SIZE_MBYTES to 0 by
> default) for most Linux distributions.
> 
> One thought is to follow the current cma reserving policy for platform
> with 'CONFIG_DMA_NUMA_CMA=y', that if the numa cma (either the 'numa cma'
> or 'cma pernuma' method) is not explicitly configured, set it up
> according to size of default 'dma_contiguous_default_area', while
> skipping the numa node where the 'dma_contiguous_default_area' lies
> in, this way the default behavior of platform with one NUMA node is
> kept unchanged (say embedded/small devices don't need to allocate
> extra memory).
> 
> Add a new bool kernel config CONFIG_CMA_SIZE_PERNUMA to control whether
> to enable it. Even when the config is enabled, user can still disable
> it by kernel-cmdline setting like "numa_cma=0:0" or "cma_pernuma=0".
> 
> To get the node info of cma area, add some helper function and setup
> in cma code.
> 
> Reported-by: Changrong Chen <chenchangrong.ccr@alibaba-inc.com>
> Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
> 
> In v4, the cma_get_nid() code is still kept, and if people really
> think it's not necessary, we can use the "nr_online_nodes() > 1" 
> instead as mentioned by Robin.

Yes, I'd hope we can get rid of that. It's rather nasty :)

-- 
Cheers,

David
