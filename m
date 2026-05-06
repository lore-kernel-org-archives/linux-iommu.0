Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C944C0432
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089664; cv=none; b=ErriYDplQDvs23CxrjLaPGI6JVXWRu1p4Ro1k7T5ncVUpLtk1pEdtZy9pzk1QEWAjYE4HS6aMuDP26iF1cWsjyrZg1RXcB7IqzsuxHSpz8zYTaw8OQt3y6WsWdus2+1Lu+HBpXamHQOVYfz5EMq/HGgCG34Bu02EORn4yizAxRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089664; c=relaxed/simple;
	bh=aik4UUSHAC8a5AGO/wN4zQeig4UP3Zc7cMBUEntTcWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lmd4wW5JLix0uFJBa1/Ip+WWDDP9rKov3MPwQ6s0S4bZ6gqlxrmhOOl05qs9tcJYHU/KVXf+dQYnXIkEewH3b778P0zbgIDBJqKcXAsIlrHp7iPVFDN9oQXMDTSsiZJ2PtkzT8YJUv85kywfFH3JoTw0QVDu73aogg10miZ8vUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u21hyTgv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u21hyTgv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b46da8c48eso120725ad.1
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 10:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778089656; x=1778694456; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KybkGyEAPJd/UFSLc8blkH8y2mvfwlowve0vuV+Is5U=;
        b=u21hyTgvyIH8SYVZ/KsfSlD5REdmUan4zek0RCmpgGm6qy3on85pJ60k+m3D7MR0kT
         hmzW/3KGZBsChhBstzH9Rs9GejO8d73QZyMxOkDWSNpTebN2zLF1Fjx4mfZ9tFms3Lss
         kmq2t4m+V0rXDAEGbQDGmszEoVLGyEcw57Uvk5kx/KKZb988PeM+F9KfGn5svGkj6UNS
         7kesYETABvZSo2ofCbpfahY4g5euj6CW0surQhU6/SdpSv6ey0vnCxIL/LIJAfBVmPAG
         fTFMsP9nBuBB5sQkU+J7zWGPvXa3Xf2/oYZCDG/SombfY6JM6LZfV+HLMB5nUH6h4T+a
         MXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778089656; x=1778694456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KybkGyEAPJd/UFSLc8blkH8y2mvfwlowve0vuV+Is5U=;
        b=omKuzGdvxfDRcsiNnGMB3eY8p/niBU5o8QaicFNg0fT9DodqF1w3vMcwcb3tu16ElH
         Qmif1eNYbUkbnca1wPQa3UyqBNsYfHa1Br0Qs98sAHPfBzUgNsTUXjHjcYMwjf2+xPC5
         yLP570oFz8QX3rHG554T9vYRn1AVi/3kxt/aLtgL0sKGyGBYl21m9KImQwEuYm0OD6j1
         HIOCvLLpkuJYzJdJ3sMqrW60wiLNvPpMqXGYTCnN5BATbimgC1tbccy686Onyd0LkSKA
         epmB8XGRTQhNGL0El+CxZO1PcOhLLb6HxNNZKiLcdWzG/A1b6CUeftXvpTYtOzrWmq1g
         VBhA==
X-Forwarded-Encrypted: i=1; AFNElJ+OiFHZCz2Uv1aSO4OJbyUqI+WAEDjLP3oMuB03BNGHX6FgIK0aizXuRCbZ53KbxqyIh9OpFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWo6vwGduMyJMDpnmWw3PXnM6a2Vg27+oUzf9QXjp6fm47riio
	1ePg0OrEz4RssdL11UlgF5pZ6BFm9aYiG/0o2l2s/+ttsb1YuEuCsEnXxaACIlQ7ig==
X-Gm-Gg: AeBDies2Jl3Xi+sPUJH7mpb20EmelJhHubb+kndMokhGp2xGPW1gl7YtpDMahC5L0kW
	oEDm+My4UZZZxf8G9/RLtViwbupS7YSRVYee8shniWr+9fxmrGD0wdzC6N0Wp5+xL3epXwPMmRv
	wrv5+ctSwTOJYY3AlAXFDc66J9kfN0Ro+uwBeqobqPJDl8zYmhN2Q0cCjovOlcNHcVEA/OcJALp
	tW+KiMxHUnFMkOnD0l2Cw9l26OBQ565J8WQy2wiw1eLGxjb65WUtX/B4RCsOqsZWjl203hXVxxI
	UAcViTLdqPqbnNgaJpTrwsm/hBj7EO+pplZqCxpwNjkCV12hU1XrnOflr8Wd/ppf6IgfnW27fIc
	eLfBcRGxSq1dB/wFAyB4qYoCNGNnaJRMVSo8yaTHjuF4NhusSbefsvTW47XsWTNVZQ5owV6/JRF
	izwocdESTvnDtiyWopq1UAL8/gODQuBGJCtuSt9gdlZ3IEhU0DwT4L8itSq/2xauz5Fu1B1WsBC
	WDBys7x
X-Received: by 2002:a17:903:1a24:b0:2b4:6153:e541 with SMTP id d9443c01a7336-2ba7cc54db5mr4362405ad.3.1778089655109;
        Wed, 06 May 2026 10:47:35 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365c25f8cf9sm3409281a91.4.2026.05.06.10.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:47:34 -0700 (PDT)
Date: Wed, 6 May 2026 17:47:31 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v2 3/6] dma-debug: Remove unused DMA attribute parameter
Message-ID: <aft-oG90nnHkjzDb@google.com>
References: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
 <20260501-dma-attrs-debug-v2-3-8dbac75cd501@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260501-dma-attrs-debug-v2-3-8dbac75cd501@nvidia.com>

On Fri, May 01, 2026 at 09:35:07AM +0300, Leon Romanovsky wrote:
>From: Leon Romanovsky <leonro@nvidia.com>
>
>debug_dma_alloc_pages() always receives a DMA attribute value of 0,
>because dma_alloc_pages() never receives any attributes from its callers.
>As preparation for upcoming patches, remove this unused attribute from
>the debug routine.
>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>---
> kernel/dma/debug.c   | 5 ++---
> kernel/dma/debug.h   | 6 ++----
> kernel/dma/mapping.c | 2 +-
> 3 files changed, 5 insertions(+), 8 deletions(-)
>
>diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>index 1a725edbbbf6a..3b53495337f5c 100644
>--- a/kernel/dma/debug.c
>+++ b/kernel/dma/debug.c
>@@ -1567,8 +1567,7 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
>
> void debug_dma_alloc_pages(struct device *dev, struct page *page,
> 			   size_t size, int direction,
>-			   dma_addr_t dma_addr,
>-			   unsigned long attrs)
>+			   dma_addr_t dma_addr)
> {
> 	struct dma_debug_entry *entry;
>
>@@ -1586,7 +1585,7 @@ void debug_dma_alloc_pages(struct device *dev, struct page *page,
> 	entry->dev_addr  = dma_addr;
> 	entry->direction = direction;
>
>-	add_dma_entry(entry, attrs);
>+	add_dma_entry(entry, 0);
> }
>
> void debug_dma_free_pages(struct device *dev, struct page *page,
>diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
>index da7be0bddcf67..24b8610850fbd 100644
>--- a/kernel/dma/debug.h
>+++ b/kernel/dma/debug.h
>@@ -47,8 +47,7 @@ extern void debug_dma_sync_sg_for_device(struct device *dev,
> 					 int nelems, int direction);
> extern void debug_dma_alloc_pages(struct device *dev, struct page *page,
> 				  size_t size, int direction,
>-				  dma_addr_t dma_addr,
>-				  unsigned long attrs);
>+				  dma_addr_t dma_addr);
> extern void debug_dma_free_pages(struct device *dev, struct page *page,
> 				 size_t size, int direction,
> 				 dma_addr_t dma_addr);
>@@ -113,8 +112,7 @@ static inline void debug_dma_sync_sg_for_device(struct device *dev,
>
> static inline void debug_dma_alloc_pages(struct device *dev, struct page *page,
> 					 size_t size, int direction,
>-					 dma_addr_t dma_addr,
>-					 unsigned long attrs)
>+					 dma_addr_t dma_addr)
> {
> }
>
>diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>index 23ed8eb9233e5..6cbefbd4158c8 100644
>--- a/kernel/dma/mapping.c
>+++ b/kernel/dma/mapping.c
>@@ -733,7 +733,7 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
> 	if (page) {
> 		trace_dma_alloc_pages(dev, page_to_virt(page), *dma_handle,
> 				      size, dir, gfp, 0);
>-		debug_dma_alloc_pages(dev, page, size, dir, *dma_handle, 0);
>+		debug_dma_alloc_pages(dev, page, size, dir, *dma_handle);
> 	} else {
> 		trace_dma_alloc_pages(dev, NULL, 0, size, dir, gfp, 0);
> 	}
>
>-- 
>2.53.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
