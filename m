Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182618;
	b=2Cl6IwrRTJL+RSpYIKKiFKhAMQ6zGjSqR4PjhbCoDx6lx3ewq96kaeYdJpljp2nXd1wN
	 E7rUpjdXPIS6OLmlcNtoCyGrJf6CqbIQ1O9TVPOF1MnwbXBWXgSaQ1OPDRCCUjYE+bGfX
	 pPWzjlMLjo+Q2J6yC+/ZCifOwBOkw2yZAh4DplbZstOHpt9K2ARxbWgsiLKiyRJXwLQft
	 2vMXO3cWsw1RPlnfJ8gq2V655x8lGhmytZjj3Qd2v6RihV+s5sfwxbel9okMr3tB0XhSl
	 dFP3Q7zg1nLhAv6STHis65lM+7vGyX54yE425EC8H5rDDSm85aTYivijbqOZacOO9kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=uU+g78pFe3woDmujMNPfhZ/0Qi8mHsxDvK4Ws3nTpkw=;
	b=MUY59pDpVRqEEJlrlU3fJUo/HA1T9A3yzxYXrEBNP12t0dySlPunRICU0PdMGX5yVw+H
	 BHpDUkyOoBjbXkzBu/61xK3bxmm3zthWBFQ2bbVOoHSLeI80Cl5TlRa3doT8WZ8HldCpN
	 VYNN4VbfHP7YT0+/z56BQ4HDS/WDa65TODRJYGjO/bnRBUyeyw4WMnb1Q9l9bvlM5++XM
	 8hr2DCNwwEFUfWn0ED51VFB3M17kLAvYz8C5ITNX0Y6l5hJLEjQrobAU6n3zWBe00+kX8
	 kzwzuaq3Jj4N7tvtlzLmBOEhMzLlfZzCF+pi/FpuSJEWyetsu1l7BGKKUgDZiW8//iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=lkJrv0d3;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F1606A336
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 915F1606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=lkJrv0d3
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-949657a20d7so121270885a.1
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795182616; x=1795787416; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uU+g78pFe3woDmujMNPfhZ/0Qi8mHsxDvK4Ws3nTpkw=;
        b=lkJrv0d39cIPbPG1GPtPJ4hIBEb2p+iAP2YiSRUTHHMcFyFCRoYVjfqdoWNPLCex37
         QtqxNFu+1DZBoRFjGxdF7qPG262ykBqUiqN0nrqCtPWtTedPXXXy9DoCDdsQ8DU4CXZX
         LgPpsLL3VH0i47KlGw7/viilrIIIK5JklcA1c882l6tcpT3fzzyVp39i+UfOFMY1qF+k
         px6jADzT+3yyA4fYCnh51NeX34/xhG3I9MWtbam1/R2yML7CL8hW6f44PF1DxLllSSAq
         nC6eI4J6YoCAfcSWYoRTlbZm/inMDo8o71Xn1Ldev76kRI2ehox33YEFVk0VwzZGamt1
         lbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182616; x=1795787416;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uU+g78pFe3woDmujMNPfhZ/0Qi8mHsxDvK4Ws3nTpkw=;
        b=FKxDHMSpPOYiXyvnlCPsNQFDiGtmsr6AHbKkkGsl5UHPrZtQzvCYeMI/14CXZujxWx
         IRnvOOXXaNSIaZgt6TswhZDxTz9w2cmg7NLO6E9i9XzhJu5w7hWst1fF8vw8lZBAn4B2
         9k0h2iI08aafo2Kch0zP03U+pTBKs5ZtMN18qCRqy4zehWN7N2zPu4UfuF3YsrcGswsF
         4riJcacKIGejjSH3uG61pKaCFMdMwDaxQffkAjKqLxoghfZbYGGGHPN77ll8v6mtXDR2
         SEVKLZW1ukyZfclznyIzYl9uAcHp89v4EqEJVE4pbguRF3YuTiiS++FyW0AskPsrXY+m
         2AHg==
X-Forwarded-Encrypted: i=1; AL+hErFBzf5RR3xJfdyDF2zFiHj0uYOR16HoALHKn3cMlVPtkDuGv6I9k4vlxgp9woyznzZPJfz4Gw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/+RGW43QznVEWtyH8Y/suL7KFobJXQVqZZTTZtMnhsa8UK7uv6
	rmIqqLxTKaq3lhnRcnV2dmzPk3zWIc3bqlBzzyU5/NlRGcN5v3jj1/A7zwv03/ZaIn4=
X-Gm-Gg: AYBFou0+f9/xc8eFAWKvQ5RwrAgwiRwaHv9+wiiFCLqiPTvGpfIomwnepMw1FqhsLZb
	v4wtDBjKCln8RoVdl/CLiATCmTacEkHOxYAAj/apciGLVfIxaxkDUSENmJ1CGoWE2r3gEOtOag6
	1F1RLUFe/rNWV70fgf3dR0R7Q+bpLOkMwLzvjIoPuYSvHKwrViRx/OoEJyDMzSBBqh2lnaCXiBT
	2vrsOH2RNKnnGiCbf3nXaM5dGq67cu97gDQcu3njlzlT+75D/IgqNqTJkAdijxNMQkl7wma88h9
	anwdA0ARdF7MazR1BO6aFZcWf9gUqeT3TyoHOSUpG2UyxRrv2hm3o0OCol7wT7Y1obN6eRL0sx9
	PAzdwLgImreRT3SgPECvLIoqLOB1gjvYCsZZL3uoaGNR8Q9UbTSGLfmQ1ZD4iEIJ13fNO3ro/tx
	dW1xDcY2kwEEc40vPzY+Gi6Na4Qdp/q5BD9A4dw80uIu9Xnp3S/cbopPpuR9F2SlAgHYqRCC/sM
	9W8pDSGmJnW44ru1RbWfqLA1JGBFhAfM3hg2+f5xVqY6dOPZpBTCyhbpUFAQtGvJmZGhgJml2i0
	9IA+0w==
X-Received: by 2002:a05:620a:4111:b0:939:5cd5:e243 with SMTP id af79cd13be357-949ba80f8acmr491343985a.6.1795182615989;
        Fri, 20 Nov 2026 05:50:15 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f7cf3sm190597085a.31.2026.11.20.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:50:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xUP0H-00000003hHG-3ovL;
	Fri, 20 Nov 2026 09:50:13 -0400
Date: Fri, 20 Nov 2026 09:50:13 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Luigi Rizzo <lrizzo@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Luigi Rizzo <rizzo.unipi@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Naman Gulati <namangulati@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 00/25] PISA: Pre-mapped IOVA Superpage Allocator
 for DMA and CoCo
Message-ID: <20261120135013.GO3115493@ziepe.ca>
References: <20261109182533.3594984-1-lrizzo@google.com>
 <20261120010655.467825-1-lrizzo@google.com>
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
In-Reply-To: <20261120010655.467825-1-lrizzo@google.com>

On Fri, Nov 20, 2026 at 01:06:30AM +0000, Luigi Rizzo wrote:
> This is v3 of the RFC previously posted as DMA_PMD [0], now renamed PISA
> ("Pre-mapped IOVA Superpage Allocator"). The text below follows
> Documentation/core-api/pisa.rst (patch 25/25), which has the details.

I thought the conclusion was to just do this stuff in netdev pagepool,
now you come with an enormous AI series spread across the entire
kernel?

> - Needs bounce buffers: in Confidential Computing VMs, PISA allocators
>   pre-decrypt 2MB pages in place, avoiding swiotlb bounce-buffer copies.

It seems this was ignored too. We want the bounce buffers in CC. They
serve a security purpose. You cannot loose control of the shared
memory buffers have have them leak into SKBs, user mappings and so
on. It is not secure.

I don't see how any of this is valuable or necessary for CC,
especially when we really don't even expect to have an vIOMMU for CC
very often..

Jason
