Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090677;
	b=CAW8E61C1FY18BJvQ60gXsAf+r3h/Ybk7ZX3p0QW1v/KJQzVBibCDK8qyKexu2kE56Hx
	 TJK9V+vM5wDG/+kSarqeIxtLd8GlWCKeGBBRXDbCpUY3XQZUITq4fPhPwGwSwNM9nZ0BP
	 ecLMpdo3cxPLPOxX18Ds/PIaA7y7QzHOWQ2y1ooIzeEnR3mJ4I6LIMwlotme0lvmoeB7Z
	 ZEr23Nq+CvEJFULIaBcsjzHHBjvgua1cy3+42FVxl981gw5RRDSGEBGIwl8dmo6e5KOMY
	 gmrGC+GXZF8q4y+v2FrKOGqfTuRmZvEz766kIn0zZwCVO0KBVgl02kZT+NKC+wep/Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=SsWTDqy6U/s3LdSWkLHVQ7n4MxNSxrVjauJtJeDqFQI=;
	b=cDRB1pW8iWEbn3cLUqBjxTvkO6WBO6oJBLRtudUx29TkVqEqVDLVgU1KqPdDnCFpK+ia
	 U7IWzJjAQeNoGai4YRRHC6wk5imj1Bpv3kaHVl4akMqCvF5DeED1VAvWby/8qpyk6HmhX
	 bmfI386/Emwj7/SW3fWJ3Zuf9hzQyYvkoj2oUXKhljG4bHOdPJjJpQ3VoiMv3tWKtUXh3
	 9E7gp/EKGAn1FEaVYW7FxgkH3a/Wk95gIvNx11xyQ/6tHeOwTasAZo1uaqC5DhM16LdEc
	 EKg2xtv3W21ljGh2itKF5uFvaZpeQGEx4pHrjgnh136B3FHIohtHU/tSLk2/OkSxfaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vjOVArT2;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1E606A326
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 12:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7B1E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vjOVArT2
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3712b6d9843so2334242eec.1
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 04:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795090676; x=1795695476; darn=lists.linux.dev;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SsWTDqy6U/s3LdSWkLHVQ7n4MxNSxrVjauJtJeDqFQI=;
        b=vjOVArT2Z8t3vjArDCY2JGmGTOPB7Ht1p4CYo6KQZYJwdrXBCedLCxgHnebeTXBhDo
         1k+w0gm4Vt9IIsa4nRg86AR6v7VgXpXHqra09T8RBhVb5vkU1BUwmnyTYPF1HU1cuI67
         iDQrp7YuMhN5svWfJoAvddmkVkmTGk6Oq75aWhVoRWuUAwIhrYspN9W743AMbR1+AtYt
         UKOsUuajazYWKB4GgCfnShAC7IGQDhDGVIp+d1emE16ampQsgmjL7C6XU0sN73fjDJe/
         rKZqKl8PDV1ZQ/EIdc8I0wrTvYS9ruUYs6qGhfpPbx7TUwRSfUE3lIelzdrXcmxeSro4
         QCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090676; x=1795695476;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SsWTDqy6U/s3LdSWkLHVQ7n4MxNSxrVjauJtJeDqFQI=;
        b=bGsoCtVp2p664AUHVXVLnxTcI5vmjEl++8Qttx14Cfvi+aFYSzG48gETEVAae7doJM
         iwQYbVS2dQgg6yCg61koCMj9+RmDc65yuqRUmUKenLTHvqOOJd7OIEMuFWGxRNrYgdOf
         QuNa7SethNsa8JqQ/tjZ6Q/gtV83G0QDwuQYUcDVRyRQJvA/q/UplwjhKxprQ1J/0mmu
         VR7im3TymhNkbQ5ezfFIFUcShDF2FkJQ4r+Sd5EJG/I9Ow+voP6+lEyCpxBu6MlKnB0U
         JwFCu52NTl1M+97S/NAOZ+iw4+hH8BAd0ps1RBrHtzddWQJL84NnO9xO+dkBfLyvFdGL
         MkVw==
X-Forwarded-Encrypted: i=1; AL+hErGoVBMkmbdqWIvJ9k+8ID8pVZQfPldG2XAlDjQX4IUVR3M6qb4J1wLV5/tRHuq01EDEUuvkfw==@lists.linux.dev
X-Gm-Message-State: APuU4Z82owPt9/YmiwddWo9FglEvx/DTAHZs7CqlI2eCg+oz/YJVE1xk
	DEt6hyCfSqjX5czZPkpBWKe/K/9gZWsoX6QQ/+Vcj0+gry/moInuhn3P
X-Gm-Gg: AZFdTZdVhxc15dacKTvidswT8ndD55jPWSFy3rKEnIiGattvM3tSMmIFAE+kfLBual5
	wU22eauH1vuv6xyCSIq+UKYS28fuGvJxFJNfRFHDc5TBptZb0dV93nUzKikxFd01Cell617kruF
	fMWiukaVaq+oZgI7bjKZ3j3qYjuK18G6ba1n65QJGqyig3eMoVGs8g0EdEB4vApQVV/hwKbj9DK
	kYvMltLdP1xYTxZox83zk23rCqUEf1Ax+D9fZkeF+V89kt9PwKuCajnjM7c594/MM0G6lCAd9TS
	48zUz/BrII1O5LO36jzPX5OOVPyMlutKL6sYICLF7IiJZXSbYr659uE+fbPwmKDTGRkxh0IbIqY
	oU9lF+M057qLi6don2zmBzVcINcvRT7FD+dM2H/kdRtMVfVlgEOjWHxUQjmYA6GgcxIwwD9rA3O
	F+nDIo7GnassqOMN/BwNr8atQDm4i5r4aTr1reDxES9eGCoTmGrIiW+sd8XPVx4OSP7GyRbByfg
	AgJRsE7OLBqXCx0PLnFHvXIoWMzihVhs+Ny24zD/85Xygs/4hbgSiZaUbwzonwIMfyWh49cUY3n
	XNPPbnWKgwrcHmIGlDSISaCYfkuOeHPDiptlWI35aQ7eF6G9xw==
X-Received: by 2002:a05:7300:1c9c:b0:361:1dd6:531b with SMTP id 5a478bee46e88-38281025c89mr5440546eec.26.1795090675937;
        Thu, 19 Nov 2026 04:17:55 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a80bc19bsm17656695eec.29.2026.11.19.04.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 04:17:54 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 4/7] powerpc/mm: handle highmem pages in arch_dma_prep_coherent()
In-Reply-To: <20261110094830.2081847-5-m.szyprowski@samsung.com>
Date: Thu, 19 Nov 2026 17:37:02 +0530
Message-ID: <jym96n4p.ritesh.list@gmail.com>
References: <20261110094830.2081847-1-m.szyprowski@samsung.com> <CGME20261110094850eucas1p1f10fa1473aca341473077f60a088b490@eucas1p1.samsung.com> <20261110094830.2081847-5-m.szyprowski@samsung.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> arch_dma_prep_coherent() performs the cache maintenance on the address
> returned by page_address(). On 32-bit powerpc with CONFIG_HIGHMEM that
> is NULL for a highmem page which is not kmapped, so the flush would
> operate on the wrong virtual range and leave the dirty lines of the
> buffer in place.
>
> The generic DMA code may pass highmem pages to this hook:
> dma_direct_alloc() handles a highmem page returned by
> dma_alloc_contiguous() by forcing the remap path, which calls
> arch_dma_prep_coherent() on that page before creating the uncached
> mapping. This cannot happen on powerpc today only because it does not
> select HAVE_DMA_CONTIGUOUS, so dma-direct never gets a highmem page
> there, but nothing in the hook's contract rules it out.
>
> Use __dma_sync_page() with DMA_BIDIRECTIONAL, which the
> arch_sync_dma_for_*() hooks already use and which kmaps highmem pages
> one at a time. Without CONFIG_HIGHMEM it does the same
> flush_dcache_range() on the linear mapping as before.
>

Does that mean, this change can add additional overhead for
CONFIG_HIGHMEM=y kernels, where the buffer received still belongs to
lowmem? (Because of extra per-page book keeping like
local_irq_save/restore, kmap_xxx). Thoughts?

Although functionally the change looks correct to me. But maybe
__dma_sync_page() on powerpc side could use some cleanups (outside of
this patch series perhaps).


-ritesh

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/powerpc/mm/dma-noncoherent.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
> index 30260b5d146d..e646256365d5 100644
> --- a/arch/powerpc/mm/dma-noncoherent.c
> +++ b/arch/powerpc/mm/dma-noncoherent.c
> @@ -118,7 +118,5 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>  
>  void arch_dma_prep_coherent(struct page *page, size_t size)
>  {
> -	unsigned long kaddr = (unsigned long)page_address(page);
> -
> -	flush_dcache_range(kaddr, kaddr + size);
> +	__dma_sync_page(page_to_phys(page), size, DMA_BIDIRECTIONAL);
>  }
> -- 
> 2.43.0
