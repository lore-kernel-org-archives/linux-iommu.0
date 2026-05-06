Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365664C0414
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091396; cv=none; b=S55EElhzCCd3loxOXuSpdCig2QVdPlyNdoocMMr8MCnCiOHzuSP1kqD39s/z1YLnZ80jI6PwbuUnFdbFSi4/v/eIS1y2r9eet2rxql5nB68coKBIgfsXktfxh6EgxOlJcVc6zZ5nTcto0atm3WgQ8+lZ8DTAj9Adkkk8Eogx97k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091396; c=relaxed/simple;
	bh=S9mvrWt8MHwjrniC+5hfqEcZPJwFH1boXGZmNPTls+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5eB0A9wXRyEQSYh8ZLGnt6P9hFQQNXMzX3aD/C8WyKm8iCBgvNtFuy/i8bHZH75jSAIxBqbrko2wxNEY6tBa0ZyQ4vmHmsIx2FrTN8YyhbD1T4N4Pzc5lL57JMECtMJxur8x2SmYemA/CaBwV7B1j9WWYZx1in8NFeDXmujqF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5668+1i; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5668+1i"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b46da8c48eso124505ad.1
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778091391; x=1778696191; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e7Y9JqHzZKULv50XrRzWAnOBKFiT4J2l9mPMNIlCT3Y=;
        b=T5668+1irnqfVlnAadlu/zg+zXkWSFN2jGfoaRfWAwSKAWVImzBpVtuOoujQYKg1nD
         h5OK6cpd3YTSLnwqsNcbHfhhxjag8a94puCbL1xt/x73ZpRBVm+iuefKqLG4N0Uomd6n
         ZtbFaQm31gRwTrhYOox6314NX+u6ViTAZCfZJBlli1sIeA3Ru1PmqzwSmbfvRtofFXn4
         5l3fxkSVXDBvi9oVxDK1yFtL+1fIHWpRnflnl0Lzj1vmv1+v5AXCIbnpx/Aa8R9UShst
         4gyawgCKMxhoRgCVb/sSGSUdUTQKihcVzV233HsKYyNFGR/j4BV5sEFjgJIO2GjYGYvB
         vs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091391; x=1778696191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7Y9JqHzZKULv50XrRzWAnOBKFiT4J2l9mPMNIlCT3Y=;
        b=Sct4BnGmik4jq45beiobeAUU+ngUyK+dF72yjeutzC+xV5KMvzIurcYYEVgXdgY3Yb
         LXuv20OtgjKBZu3jEbQ+VboPZwTOUaZundq7d4keuwLZHBoJkH3gwbbLIBZCDES7eJFY
         ox3zLE3Fw7U480cxJS4EtOwZFqU4Qx5tjamqx8ctD2OVv9e2UZE9ufqr5uM1k3k+b7gu
         XrJ9APTSxWMNQCAuQsM5cIpaFlNgT8eECNOW+IoWMRLoSH+0UOuK/+vEtZu6UVLkkNQf
         GLANlgb2wfbc9USdM6sDZx3aETzRDD6eOrt4OZMJ1XzPvh/yvPtkPzVYmzVGjpNjSi60
         Cqog==
X-Forwarded-Encrypted: i=1; AFNElJ9C3gG61qIKqUZeafi43XoP4RRumYy0CnZKFISiQ74I8dROdXPct2/+aM0RSCt86U+UY5ODbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJfxHcav0+6sYXx+vk4X8lnXO4hb8TcxMddX1r09M6Jgx8uhte
	CJd0Z5+RtUjYyWG2YGOXxCkO2d6MKu9qk8s2TwMerjvButzov7ufYXobv9gV7d9qcw==
X-Gm-Gg: AeBDiesr5kqFNGvbUgc1xBN8ihUJXaXVrj8rNpHzZbJ3NfQ1X30vxWVsutrTS8b9lVV
	CQHbYHJ2uIBW/Tsv3SLWuzfQdNa5vuhIZX1n6CiuQJjwnQbo8LaXHOluzUr5+haLrviLvCv+Xkm
	gk5l0Z1y/yKmvSUoXQbqH9GTNIDCpFZzIzK7eqsXawNvMKDOUpdQr4CngA71V4CDhNvwoYFohS9
	xx6MBjGBeOT7gSC/ITkamEhj55tpjut0pbqDHTsBl2k3SoeWtSIe/Dbmm/ER5BkEskQaLMys9z2
	gq5AnWo1hQuYOjhUe29bDdnynD3hTmlzktElUWxGTLX2F8a4givy7NkCxu/C6HM9mXOMEXYnKgg
	RXPgsVcFANP0JVplgwBE2+aBB2JykWlQ1iNUxlHKvy7b/qTggnSgGNOk7KmEfu0TJbjUJgWt7H1
	L5X1TcvcOuzxJrjhyxNrAthaZjcsdxKW6/aLEoCqo4pUuyS0TpAjN66bFc681jr/j+Lqy9VwrdC
	CMERKXh
X-Received: by 2002:a17:903:3887:b0:2b7:b03d:9847 with SMTP id d9443c01a7336-2ba7cecf689mr4399065ad.7.1778091390466;
        Wed, 06 May 2026 11:16:30 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4c196ecsm3120637a91.6.2026.05.06.11.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:16:30 -0700 (PDT)
Date: Wed, 6 May 2026 18:16:27 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v2 6/6] dma-debug: Ensure mappings are created and
 released with matching attributes
Message-ID: <afuFcwO8hHqWZWuc@google.com>
References: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
 <20260501-dma-attrs-debug-v2-6-8dbac75cd501@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260501-dma-attrs-debug-v2-6-8dbac75cd501@nvidia.com>

On Fri, May 01, 2026 at 09:35:10AM +0300, Leon Romanovsky wrote:
>From: Leon Romanovsky <leonro@nvidia.com>
>
>The DMA API expects that callers use the same attributes when mapping
>and unmapping. Add tracking to verify this and catch mismatches.
>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>---
> kernel/dma/debug.c | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
>
>diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>index 3dfed51c3d9aa..c38efc1ac8d6c 100644
>--- a/kernel/dma/debug.c
>+++ b/kernel/dma/debug.c
>@@ -1074,6 +1074,29 @@ static void check_unmap(struct dma_debug_entry *ref)
> 			   type2name[entry->type]);
> 	}
>
>+	/*
>+	 * This may be no bug in reality - but DMA API still expects
>+	 * that entry is unmapped with same attributes as it was mapped.
>+	 *
>+	 * DMA_ATTR_UNMAP_VALID lists the attributes that must be identical
>+	 * between map and unmap. Any attribute outside this set (e.g.
>+	 * DMA_ATTR_NO_WARN, DMA_ATTR_SKIP_CPU_SYNC) is allowed to differ.
>+	 */
>+#define DMA_ATTR_UNMAP_VALID                                               \
>+	(DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_FORCE_CONTIGUOUS |          \
>+	 DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT | DMA_ATTR_PRIVILEGED | \
>+	 DMA_ATTR_CC_SHARED)
>+	if ((ref->attrs & DMA_ATTR_UNMAP_VALID) !=
>+	    (entry->attrs & DMA_ATTR_UNMAP_VALID)) {
>+		err_printk(ref->dev, entry,
>+			   "device driver frees "
>+			   "DMA memory with different attributes "
>+			   "[device address=0x%016llx] [size=%llu bytes] "
>+			   "[mapped with 0x%lx] [unmapped with 0x%lx]\n",
>+			   ref->dev_addr, ref->size, entry->attrs, ref->attrs);
>+	}
>+#undef DMA_ATTR_UNMAP_VALID
>+
> 	hash_bucket_del(entry);
> 	put_hash_bucket(bucket, flags);
>
>
>-- 
>2.53.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
