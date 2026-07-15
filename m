Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232C44A0C;
	Wed, 15 Jul 2026 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096489; cv=none; b=Zy/nByB2q9Y6iHT0a8vIbnoarBgLQqcbSwjm2qMpQ1YL2eDJP3Afz1aOcF+8xxTQSBpGFodCuyq6qWnt+DiuPiWK43zaD5lizqk+92RAjjl3rYIXGX330rdrzfNJKXR1RwCAVGY15hp+Vx34dXOFcew8KKXCgsl2KpZobvdQ9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096489; c=relaxed/simple;
	bh=zrr/8QG4TBnO31u0geowDpSHj1WSlznSPJYFGAhqwqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCAms9TTxuOhoB37P3jmSXZ0si7uDJIjhRRHKTCgInCxwx9wxX6LH0U9qmT177kzwRx/yAWjsqNSlAtxexdY4m7rtJliLu3x+1DV3dE4F8b9meh1SJpvnZmr5MPBJZqDpuz3vx8qpSOTGT7p2wgiun/Kb7YjWc9Hcv0s9/iEIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcDlTBB6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcDlTBB6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80851F00A3A;
	Wed, 15 Jul 2026 06:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784096487;
	bh=n8HXYrZJxWHjjmj3qEyT+Zg6Jj3eLpVK+NKrXWZfxeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jcDlTBB6w3jar+gMo8sJ2wnylExEoKYg3oqsAi971GZqI/U5UXD/5lAnFaH0pAed1
	 AgW/W4DBhcbIZSVQO1w7/O6GIhLPZkRgUKNG5lXcSs69L7cmDqaFKN4uLYUz5lba8/
	 3oLl/xVLZbpOQ/EhSuTqMd4+ZpWd5sisGGPaFa1fzB45txm2Ae2o9Pj9BC8XZeXWDQ
	 D7Lmr3vKi4DsIMc6PCJQNgOueHApMAzsUTdS+WE2H/lMGuWQ6CmWaUnQSns++2Ikey
	 lDTk5Hp4JbOnzMM7XNMnsvv86oXz4yllbfATJJiBH/9qxx4TlncWAGZxBEvdKKcC7K
	 up+1DErnDWHjA==
Date: Wed, 15 Jul 2026 09:21:16 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH v2 03/10] dma: contiguous: Add API to check if an
 allocation is from CMA
Message-ID: <20260715062116.GA21348@unreal>
References: <20260708234854.4044652-1-skhawaja@google.com>
 <20260708234854.4044652-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708234854.4044652-4-skhawaja@google.com>

On Wed, Jul 08, 2026 at 11:48:47PM +0000, Samiullah Khawaja wrote:
> Add an API that uses cma_for_each() to check whether a DMA allocation is
> from a CMA region.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  include/linux/dma-map-ops.h |  6 ++++++
>  kernel/dma/contiguous.c     | 24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)

<...>

>  #ifdef CONFIG_DMA_DECLARE_COHERENT
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 03f52bd17120..0b1702bf39ca 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -130,6 +130,30 @@ struct cma *dev_get_cma_area(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_get_cma_area);
>  
> +struct dma_cma_check_data {
> +	phys_addr_t start;
> +	phys_addr_t end;
> +};

If this series is retried, use "struct phys_vec" here instead of
declaring a new structure:
https://elixir.bootlin.com/linux/v7.1.3/source/include/linux/types.h#L173

Thanks.
