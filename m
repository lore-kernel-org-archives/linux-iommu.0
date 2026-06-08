Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898532F8E8C
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942214; cv=none; b=FWVAlJEivpATsn4JNcL8xUs/N6wZ3EKmDLg6bRcYFpXU8qNBi4kO4rR0HTnim+qgg7n4zSfTBaBwvtdf5MDJ6jqzEvUoVSqvTHI2ZHT3z7b6rD3c+hFriOWf6mY6zna7AVDwuiGYmNdfJKaSvuqENGwTkXLDqt6s9ga95c/ASA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942214; c=relaxed/simple;
	bh=iw8L7cyxexJ3K2ZorONexK5r71ok4kUGe42dCeb3D3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SV78wdRDcW8pWdJah0Yd0f2IWPTKzTtOn9LlY8DMK4IVZqyCA6qHg64ed8zYySk9hGuhR4rR1LevjCZjHrT2hYuCEdqZL2/wxCXHOZEGCiIKkK+j1VENNKM9VaVGK1lffna0R5bS3dDRpGJIYS2E7LyzwFA/asSmhmG3N5+iwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dLCfDZ/C; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLCfDZ/C"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1336742714fso34359c88.1
        for <iommu@lists.linux.dev>; Mon, 08 Jun 2026 11:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780942212; x=1781547012; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xEllMNXAKazcdxTo09h79Zq4pXvu6XvS48U9FqZI2UI=;
        b=dLCfDZ/ChrwbOTOfhpH0pT93Pzm0BX6/y1KkxablAm8NIGJnugLSW6U6+lpfeMmR9Z
         VmmtEef7b85tCT7q1Z1IMwk8mlBi5xGUk66DoyuRGABdQ84aAo9ZCPEHVjhQeETiTNE9
         FetESvjcQ+Kqoj2xqnT3PPlnvW2LWKyvF0BTqr3ODwhtfbx93X+txASj8j/e6CmQzUrV
         m/p9yAusRDuy/dGxlE3jBpUAj0p8RXI13abIdJH2dqYG5F/260SxdTwC97QKS76Tm44i
         Z7Eqe4BXsLXkKhWCet4iPqxTgEAfUlt0L4wvE1gEz7lWArnY6LrJQ5qkxpBOHyp9r3T6
         nSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780942212; x=1781547012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEllMNXAKazcdxTo09h79Zq4pXvu6XvS48U9FqZI2UI=;
        b=MMLE+WU9K0C3Vzv1rql6u3tKme4ewOcgEgnkpr/bRnQ6iRpl5F7xRTEjtk6mysuLQq
         D+/KxSHmRbaMkfRg2vmgdo8h8crX0cAoUEs5OPgjwJUS/jzLwr8yXxNUMTLQT5D8O8rA
         tayV28WtjcWzgN3CHBTaV33n0hBwfQF43K7Dl7AsHBqMIqYT6s5vFWCreViKTbpspuyG
         o3mqeveKYefjYJm/MK42ijQf35h9JsmNoDlWqvaF9uLgWw2oVxQ6RGVq0aeVR49I3Pmj
         mK9ryjqYtX9QCGZfZ2CFtUTNPt2D3QntRwrIp1IEq5WdcV8HTjW4t+TfNn4z8tGPKcNS
         bKSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8aA9LtJiMfCA/YkqNMR+E790M2aYHJihS3RBkDJ4q1XHpqEkzF1yvLrrf6FLxD/zgRgTpFrg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywgc5gy0djIAcOprwMgQhgS13l8QDED5mXZZ8UNqIXA8sXTKn9v
	YrwOrzNw6Roy41HAHDsAHQp1BocLqV+9GNTGIIwwSgkIMQEq5OiCQpWe7+QINbjxMg==
X-Gm-Gg: Acq92OE6tAtGYn4Hs6rDK76GjJC1e+LiXt1YFdRJgMOpN+UbMITI0pC51uG3yotJZD4
	Fn6uoMlI8JDyanfpdRFhwFQCO1954fZ9TmvHu2j5r7IZGh5l/ZqWdOsh2+30zkhm7kXzCej7Kc0
	hlPF/I/pMUSf0eMtj3LkwVnim5/mTDXPDvmS/hqtkKHtXDSTzD+kZYvVuC3oRquWPUMEow8KRdh
	2dlmc5w5IWuJu8UxaUKmt/eQXlETSbZZDEP2GZvkOmj0O+UkYegNBY4ANOfY3hre7NWN9MbtCeS
	xS4afLTfWP1ilPNk9Re8+8RBufeDSSxIAfe+e4vNJZke1EHk5+bFgcTVgU3Cy+HqCb7pvGAz/4C
	dQ+SMqnAjknwe7IFHN4911MKqTu9QoK4p6+SynvIb8pAZZOcNuHBGeRR+Ah8cbQF2vPW576DP04
	Tx7wUYN961j5EAc8dEaywmnnUsOnHeyIGHqggLutuAcKtg9AdYwhFne02l4qPddNzof3N+5SQ=
X-Received: by 2002:a05:7022:38f:b0:11a:2c18:9e70 with SMTP id a92af1059eb24-13807c516c0mr439910c88.11.1780942210090;
        Mon, 08 Jun 2026 11:10:10 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5550bcdsm13363034c88.14.2026.06.08.11.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:10:09 -0700 (PDT)
Date: Mon, 8 Jun 2026 18:10:02 +0000
From: Pranjal Shrivastava <praan@google.com>
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
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 2/4] dma/pool: Add an API to check if DMA allocation
 is from pool
Message-ID: <aicFes0uxUFQAduC@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-3-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505002737.2213734-3-skhawaja@google.com>

On Tue, May 05, 2026 at 12:27:35AM +0000, Samiullah Khawaja wrote:
> DMA allocations can be done through DMA pools, add an API that can be
> used to check if an allocation is done from a pool. This will be used in
> the later commit during preservation of DMA allocation.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  include/linux/dma-map-ops.h |  1 +
>  kernel/dma/pool.c           | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 6a1832a73cad..6a0bc4ea2467 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -216,6 +216,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
>  bool dma_free_from_pool(struct device *dev, void *start, size_t size);
>  
> +bool dma_is_from_pool(struct device *dev, void *start, size_t size);
>  int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
>  		dma_addr_t dma_start, u64 size);
>  
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 2b2fbb709242..32ce4d6d7683 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -307,3 +307,16 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
>  
>  	return false;
>  }
> +
> +bool dma_is_from_pool(struct device *dev, void *start, size_t size)

Do we need struct device here? It seems unused?

Nit: we only ever pass 0 gfp_flags to dma_guess_pool, should we instead
name it: dma_is_from_atomic_pool() to be more accurate?

> +{
> +	struct gen_pool *pool = NULL;
> +
> +	while ((pool = dma_guess_pool(pool, 0))) {
> +		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
> +			continue;
> +		return true;
> +	}

Nit: The loop looks slightly ugly, can we have:

struct gen_pool *pool;

for (pool = dma_guess_pool(NULL, 0); pool != NULL; pool = dma_guess_pool(pool, 0)) {
	if (gen_pool_has_addr(pool, (unsigned long)start, size))
		return true;
}

> +
> +	return false;
> +}
> -- 
> 2.54.0.545.g6539524ca2-goog
> 

Thanks,
Praan
