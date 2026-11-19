Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108519;
	b=s8LBIA3Nqir+8Vz50h15taPNVzVC8YBQSE/P/iWCK3mAl0alXUBsdixm10oJPfA/Aa1I
	 ykcluKF+mzBnZzB7XFabaHb0KBWcG1IAO5QuKjYihiF3Qj0etGdDYu4upxKFbVLbQZexc
	 oc1AHQLZ4J2xCCXwRnjBNxqiiEqGmtE2KQO3sAsqcM8HwKkeUMCvd4ZhUgA+Furg8KbVl
	 4HlVMuxSn07QMa62kv3LCb3otYPEYEONGfxo7zjx52yTUyFOvgbJRk6AjCjMQfjNMcP/c
	 ekQX7DwovmOu71Fw9bCvh3Kuab7BXX9XZeWamJ0nmrFnocI8HmcJHMkvG7O7BoPO0bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=QLlAlF6sccc/yijrm/66Ncx3qXiAKuk+bopz8N9+Jgs=;
	b=dLVGhMPqhUuH/u6HtytBrF/YJ14uVfk03vQGFWmafGXeiBa3AAJecqAvVB48Z7VMxXb0
	 M+xTnI3JWJ6vAY3k1BAC4hpfmkpNZolrM8DCj3pjR4sO18s5Lw13QizAsNkH3Mxw5da7+
	 sJ79S+F/z0C59GRS5r9wrnezVOUoBFJYs8O8gkyJDnFJcIFvYO+06Ivwm9GqhlL9066+m
	 bxvvw0Toiwdjzh17yTED/plofV++sPaj96gNgj34PYTQ1lkwFdHN5N1mfnRBq6ZqEXkw2
	 OxIuNcq3RN6AJRrMUqLG8jmAOH46RERBssLpsJHsDJd7RmVHXyUDSY18lew3n8AKe4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z5pclpn3;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B257606A32C
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 17:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B257606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z5pclpn3
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd69954c755so2000526a12.3
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 09:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108517; x=1795713317; darn=lists.linux.dev;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QLlAlF6sccc/yijrm/66Ncx3qXiAKuk+bopz8N9+Jgs=;
        b=z5pclpn3IzUp7ZgY4s4YbJB7zlU+gZpSL6a+onuVYqrmoGo4apRPhw9hGqMPxKd38e
         R8+7xlRMMBQHQiT9OYw3pfIcafEQwJ6JXruRg8k7a7IjattKOJNy+GDQpvzAHlZ0h3k+
         xNCmi7NTBS0NkJHXzsuNt21EeLlBU8K1vS9urHoWDs3O9bf9v5Y7hU/VXaI2FrjYK/1S
         dUHZxnO4tPz28H9N8krsbQqZYk5Ojl+pS0WiQsbv48Lh6kRV9AQ6DclZUgwuljTd3uVq
         l5PPWlj76V34Hhg6nC/AVtKTBFmyrMDvOPy3RwtUPMReuRq9XkqGc4Ib1Iq+ep3am/H4
         FkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108517; x=1795713317;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QLlAlF6sccc/yijrm/66Ncx3qXiAKuk+bopz8N9+Jgs=;
        b=g7gDotlYXzzifsAEkaBiV2Sg8oGz18lfwda5KPRHoAvW6u4qyvePlPnUYn3LpuMgOd
         DmWa9oH+i9Tb1KrNldvDH0DbZ1L5St0ip2GgdrDSe8wl7J8U0hmY/ziJKh0UDZbAY7Br
         hpA+5LHo6wm8aV5ICiU7qGwYvOykJteS1eYd4IqlibCzu2BfPZR0KsXnEYJ6/J6sMXG7
         UHos/mzniVCuRdNjr+Ah1TAZvckgZWDOaTdP93N8N3h4R+IvbCG04Uvcf9Q4NvBBONUp
         ivgVYXcwt6TJnH1xV2cYLZaKQeLnmG6r8c5u00LvmLqQsdn9yrw6gRZhM+rPC8OG30bg
         3a6A==
X-Forwarded-Encrypted: i=1; AL+hErGywe5ZBrNW6jPhBi/yKSyFM66RBXnjRqJcbJpUbxAZ0CT5MPVXLR1K/+pKQfLmY1aWdJG/FQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/2+pJfZVnaAsx7ruhzCUS7lu/1wW+F70GSEIgdikGELH3JPFk1
	t4Ap9sRbDYxGrVDoD3M9/bm1qXDj3oMXHxzOhtDCHQ4k+NCMQcQhn6xb
X-Gm-Gg: AZFdTZdwC6DfHn8P9EWFc3sE/R9OEWd3w773S/YG5MeWQJvEka3SbAogWiBvhWBp6ae
	MopJc3YrpIYh09n1YPdchqr9QkykgJ+FOtE8auh1VOkBRBSJ6GSZuZa0NYk90/WGMy33FMJLket
	0vPt6lL7bRifsm19gmHO2DRKx8uyxbACj9PKpgHVRxQez05B10NsiUWdArsrA7PMnX4DFArrnUu
	oORzSUWILjcxG2IhR4yuFR45DGyOU60008FEBhRVHss/jMBjM4rek5e1UpsLd6RAkOd2FktkZbB
	pTnJjmPITEqfnCoXrvmo0VBXSY5xxPj3JvdfUTX0A9G7bjWlWOnhmbLcL4BMdz93ASpKfOzAJ+T
	uEkLi6DCn3yz+PDb4Vxi8J700b0B5SD8a4WAwHNgQJZD/LotE2t2BbkKH6+WNJufwmfQlgQXkL1
	29YQ54oRN+8RvFT4m2oQHWxFBKCWAS+VYnHGLQBARLgmn81To5fMWYRfZmvm02/ZEzaG+SssHID
	OYluM2YLvMkWFmic6roaqfi5NZiYAuYq2LAysDArJtPxv3jJCzk4O0Y9g2+EbttDB/Cl2o1sFOR
	F/uASXMPSL/w3gwXl7/gzalpEkI=
X-Received: by 2002:a17:90b:288e:b0:3b3:ec88:72a6 with SMTP id 98e67ed59e1d1-3b41c85284amr34574a91.3.1795108517546;
        Thu, 19 Nov 2026 09:15:17 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d96bd3sm3418882a91.12.2026.11.19.09.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:15:16 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Thomas
	Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
	Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v3 4/8] powerpc/mm: skip kmap for lowmem pages in __dma_sync_page()
In-Reply-To: <20261119151520.2383226-5-m.szyprowski@samsung.com>
Date: Thu, 19 Nov 2026 22:43:30 +0530
Message-ID: <4idclp6t.ritesh.list@gmail.com>
References: <20261119151520.2383226-1-m.szyprowski@samsung.com> <CGME20261119151530eucas1p1724ca5c2a4cb0e5a7d9ad91c936a2c6f@eucas1p1.samsung.com> <20261119151520.2383226-5-m.szyprowski@samsung.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> With CONFIG_HIGHMEM enabled, __dma_sync_page() unconditionally goes
> through __dma_sync_page_highmem(), which disables interrupts and
> kmaps the buffer one page at a time. This adds needless per-page
> overhead to every streaming DMA sync on such kernels.
>
> Use the per-page kmap path only when the buffer reaches into highmem
> and do a single __dma_sync() on the linear mapping otherwise.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/powerpc/mm/dma-noncoherent.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Thanks for taking care of this. LGTM.

Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

