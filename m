Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BD538A286
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773318420; cv=none; b=kovn6se7lyKcJpGiiHfi21mXGHuxnZ8Tsp0YIF5D050Y3/+D2zpfGCqsLpxXyjf1iPwddM2HvKBHWxhb/D5Yiew5tqFPf4WCaadrqXSaCnodDE6OVqmPv4Y5bwhWdHPL/xEf0L7xXkOToGvKIwgWNzQlTSGH0V5munvjOJn8mWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773318420; c=relaxed/simple;
	bh=kL0Vtw+iePKp4mxXk49bsuyKV2vV08txbV9fCNpa5ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euimheetz8yAqLD5OUrdWMUx8baBJY68Q+QrT7HCnbh3EnolwiSUozxcd71Rlzcp6xPD4qMlTc3eubUIwCJKljA03SDuEhSJCJShaTpf4WPtYojOFwWVEf/nDOd04PHbdGy6FgCcvebvkF2p0IH5BvGUHybLQ3+bvIQos7NHO38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QYHqLXwm; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QYHqLXwm"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cd767d2d70so101782085a.3
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 05:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773318418; x=1773923218; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bVLYsZeqdLLR0Cw+BVzWgzWP+lyAr3AqcCFZTxFfl4=;
        b=QYHqLXwmsE3RmI7dCNEMnMY4iVLxaoo6Xr4Nc83+5RbzLQOLtBFXWbdUH/bmpEPFNI
         4GrJx9H8U0tHQZT9w7rkuqWY57VBNUOkvl0kxkKOx8T+LBEWf7S8RLBa18YULEEutGz1
         1Lgpa417NIm4+TNw4Uj69dbw608MTHa4aIlvkDzL06MhxFVfb9zJALtSMAr6ewSt97nO
         9XWt23XqUg0sX6CaltS+D9BxAyZlx9szRO7RtnmBE7KLYOFCkLIJ1ON4HowXtQqnhJsi
         ytaXEmGvRg1mInQ96leeevH3+TNG3sEC+pmc58z/WjOK+p4K65M6td3ulKMuZKQ3gL4l
         Anmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773318418; x=1773923218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bVLYsZeqdLLR0Cw+BVzWgzWP+lyAr3AqcCFZTxFfl4=;
        b=nApyD6x+G/zHFWxYwszwDyn+RcTHlz2DQRf1Mr2fq1lfQq3Z80VtmNgE1mVRRq1HYZ
         rKR8oj070HkAbZS9P9cdu8jHmFcwv77+I7144JkIhg0xfI+G/eTSlMKJIOy6dHbor/h2
         V8iRPUmVS3nfMOOBjHGy+dalAw/OaoTpuNf1/GPwUZ189RRDmRsCuWF3aMunX+vFdQZd
         rnmrkX0HpmHBxHR1SECB84mzhs6rI2AppYXcKn5uLyVtfVMmrSAeECd/Z4a4BbuMQk4F
         hv/syTJDWnYOep3/+UehRAec1oijXdslf1AYuMxVe4Vpxq3LACndhsmNGtf+eIslXZ+p
         0xDw==
X-Forwarded-Encrypted: i=1; AJvYcCWZD588iV5t5WxGQzPtUxbcW/3GRWxWVv3Rq6krSRUx6HSkVC8WO72nCqthLtpjo6pfXAEIVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGXKWvvRhhrCx3cCON52t4i7xE13B4H1zOvNJAl0awNcf3wQgy
	GzZY58+F7rFbiCDLRgPIREtbXlyGKBwO1qsGteOskSYslrTdWmxyygVC98NHtYNrWFo=
X-Gm-Gg: ATEYQzz3erKHmqMGjLd5qXFAa1LccmBOVABrDoUYpxfHeMsMKnVWc+Nef82fK7SHowR
	ajq90cMxJm3uECIp7bko0ycQNCot4dAnb7mmGksiSwGqmz/u+hc9KWr61+PmUWorhmOkoXR0aFP
	XXqRABb73pvg9FirSWufFdQQ2yOe9sIhQGqiOafhYf5JA6RGqZ1lsdyw7dsGC4YlE4iUYdp6uQH
	knPHGwdL2JwwVgPEHDA3S8A+ekmzo1HCW5sWIOnrCzBkTOzQEUFi6AGk+dEZZHpB9P6+urfJBh7
	2zbVIzWCm4zP0f2qfryTolUtb3xGQdF+Wh8Jh9gqboTRRm5F5F1BhvWKPgnXus4dZ9NJ8cYK8yn
	ZKV30s6Ndq9isJAvCZpHJW5Sf3yNxDIbWFZxkixYb0kjbprBSTF8q0szYk2JWBOnSSzp8O4nrIJ
	OvUjjKgib2TyBItT6ynfmc9lxVzwmQHGANvnH5Hqz4FJhZfwvIeBI4JCQOfyXqQL9Xq6dKgU7sk
	WWsHsfp
X-Received: by 2002:a05:620a:4692:b0:8cd:9322:7c55 with SMTP id af79cd13be357-8cda193043amr787228385a.17.1773318418176;
        Thu, 12 Mar 2026 05:26:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fddfe8sm328304485a.12.2026.03.12.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:26:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0f7l-00000006ewH-1owB;
	Thu, 12 Mar 2026 09:26:45 -0300
Date: Thu, 12 Mar 2026 09:26:45 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 8/8] mm/hmm: Indicate that HMM requires DMA coherency
Message-ID: <20260312122645.GG1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-8-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-8-e00bc2ca346d@nvidia.com>

On Wed, Mar 11, 2026 at 09:08:51PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> HMM mirroring can work on coherent systems without SWIOTLB path only.
> Until introduction of DMA_ATTR_REQUIRE_COHERENT, there was no reliable
> way to indicate that and various approximation was done:

HMM is fundamentally about allowing a sophisticated device to
independently DMA to a process's memory concurrently with the CPU
accessing the same memory. It is similar to SVA but does not rely on
IOMMU support. Since the entire use model is concurrent access to the
same memory it becomes fatally broken as a uAPI if SWIOTLB is
replacing the memory, or the CPU caches are incoherent with DMA.

Till now there was no reliable way to indicate that and various
approximation was done:

> int hmm_dma_map_alloc(struct device *dev, struct hmm_dma_map *map,
>                       size_t nr_entries, size_t dma_entry_size)
> {
> <...>
>         /*
>          * The HMM API violates our normal DMA buffer ownership rules and can't
>          * transfer buffer ownership.  The dma_addressing_limited() check is a
>          * best approximation to ensure no swiotlb buffering happens.
>          */
>         dma_need_sync = !dev->dma_skip_sync;
>         if (dma_need_sync || dma_addressing_limited(dev))
>                 return -EOPNOTSUPP;

Can it get dropped now then?

> So let's mark mapped buffers with DMA_ATTR_REQUIRE_COHERENT attribute
> to prevent DMA debugging warnings for cache overlapped entries.

Well, that isn't the main motivation, this prevents silent data
corruption if someone tries to use hmm in a system with swiotlb or
incoherent DMA,

Looks OK otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
