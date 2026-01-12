Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D53314DE;
	Mon, 12 Jan 2026 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205913; cv=none; b=Z14z/otLwIU9lsw4DEjPxR7oGuQRCU72WNoQUDjPWOwkwaquo6BMZsgE5DzVemkPpFyZugmAwG9kegTQYMbqFFg74VbhLvxbvrOAR2FQgluWfQnuNAG9g4szaGwxi5hyezkpSJdPSVtV65QXUgLJvswln+3iEp/8CBh5N5Pr4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205913; c=relaxed/simple;
	bh=tCYVK2KJiLtM1byBjt852VsVNwBecvgo8VgmVfXxN3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/+s/BbD2JGouj5Sah0lKvYTI/DSVEp55Wa7M1Oi3Fci2rhQflc2ouh5twUpUjzsk7cmiOMKRJK5NoI3nAIjrNj906DCAaLn8tgemMFODAXtbsY2VlSRpzmE3NRuja223y1jWmVvgrWgQJsBRMg7leb+/96PFiLmDHBCTltRHKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcY++MvR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcY++MvR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848ADC116D0;
	Mon, 12 Jan 2026 08:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768205912;
	bh=tCYVK2KJiLtM1byBjt852VsVNwBecvgo8VgmVfXxN3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AcY++MvRhT1n4A/1bDonPj+KcDnivKsadR+sLCPscy19ZFx9xTRj+1WoylkYwSDAW
	 evbk4UQ6HX3dTt6hJwU1GIhPht7QiQ2cj0OSR6WshxRgpZWEC6+oRAH5OG2BQgOv8b
	 CqcXGEAF3AXAGp7cptInwXaTD8Dz0QlTHqCQQZSql5L8hUBKDF98VT8pe0ZXGngpzE
	 6hEbcxqu4cDNOHM4K3iuG2voifqtwmQ/VNZGeDdVX/fXWN89/3i9E9Ob3zCk4NX9oV
	 T+MxwADkIZWHi2laRj2LQCeoJYcjs+4cDnbNwFDprKhqzr6elpBeg9FtmRTad35RQH
	 tgzp/SqOwARQQ==
Date: Mon, 12 Jan 2026 10:18:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, vigneshr@ti.com
Subject: Re: [PATCH] dma/pool: respect __GFP_NOWARN in dma_alloc_from_pool()
Message-ID: <20260112081825.GC14378@unreal>
References: <20260111014150.2411570-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111014150.2411570-1-s-adivi@ti.com>

On Sun, Jan 11, 2026 at 07:11:50AM +0530, Sai Sree Kartheek Adivi wrote:
> Currently, dma_alloc_from_pool() unconditionally warns and dumps a stack
> trace when an allocation fails.
> 
> This prevents callers from using the __GFP_NOWARN flag to suppress error
> messages, breaking the expectation that this flag will silence
> allocation failure logs.
> 
> Align dma_pool behaviour with other core allocators by checking for
> __GFP_NOWARN before issuing the warning.
> 
> Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  kernel/dma/pool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 26392badc36b..40dc2ab9915f 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -276,7 +276,8 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>  			return page;
>  	}
>  
> -	WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
> +	if (!(gfp & __GFP_NOWARN))
> +		WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));

WARN(!(gfp & __GFP_NOWARN), "Failed to get suitable pool for %s\n", dev_name(dev));

Thanks

>  	return NULL;
>  }
>  
> -- 
> 2.34.1
> 
> 
