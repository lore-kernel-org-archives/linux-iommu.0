Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108997;
	b=IZThlOpLrrMxx3MrQucrEGlSBdhEqLv+OeybFWBsUCr08SMBNKt0rnfhabSUHVfW49/8
	 lWBzL+I5GjtkHHI3lAbIj3rR2Un/+X0FjaCrWDtHw+uYjHPNRL9CajBfcPpix+U7nK22X
	 skYiiIRdVLxXinnoDkW+F6iD5ZvwI4M/h+Vf8AGJ9uApirQyni+GKvwNjqz/S1td1VjeK
	 RFs7aCQxjRuXox8MxqBkapHdxyoK4jUh1LERlpxeqI0yGpGEFnYTBt2WL3KAPvQx1vCtO
	 9+vP9TuAxFCwOnlYn2PmeBorBqJPHH6qi5YVz/YTaSDt9QFlazSZdPhc4nosTN0U9RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type:Content-Transfer-Encoding;
	bh=dvwpM6x9UyT5LtxoyNzaw4LyWCYizJm0AMP5Y1DvOYE=;
	b=s81EoycJYgCk+RkdDzHstp9d7Nt5DzMPAnAV8ZWG2PrczCKuHk4OUtH9WZP3KsSpUgJ4
	 YGUn/MerxAIHOe++73+ewxeQ8GgX80J1Zt6AeB9IoKq7fjPReNNZhBcrc67mZAZEX4gmm
	 E2k0jTOdAO3LwIRq5vKOLFIZuQGhHOhHo6+JRG/DwgPPsRJsjV+5gbC7+Ztp60g83De8i
	 QVkXui0QVo6YJPeH+1Xuo7EO13Aa1BsylaCUvGs4txEhikDXuuZK+YGg3n7GyaNs5p96n
	 U1my2wr8b5kgDvbTj8b59ykzJWvmhTpP47hKGlTGEBhkVBt0mAB3AtV8W5+P8N5Pf4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kqs0m9Ch;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8CE606A33F
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 17:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C8CE606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kqs0m9Ch
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so5754820eec.1
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 09:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108996; x=1795713796; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvwpM6x9UyT5LtxoyNzaw4LyWCYizJm0AMP5Y1DvOYE=;
        b=Kqs0m9ChrWMwOFQ+p71BOgwNaN5tiXzmUOxKlOR8f1/EL7XlHiIR1VbA0VaZNOMiYn
         jPkoYFnUXkOS6kETtv9YCddXhTkcOMufOsBpOeBpLJ9B0rhN/WuAUygw7NDYBWvCn/td
         xvV6yNS1ny3qjlvk/YPyNYzqycHt5RtM4qxtPYTCT499dPOhhUo8rrMxAljUvix9Qa0i
         b92lPJrcM+Qup2DCqxxTbC0Cb+EWGnB2Tmj8T5y5vhNiOJy1eAK9btmoqmQ1waNl86Tb
         xthe8SBDK+vTAE24WhqEg34N5lHLpY6tlRlAm//gfMENZ3sviRDnglmhyA5ZJDpXgVPv
         Yp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108996; x=1795713796;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvwpM6x9UyT5LtxoyNzaw4LyWCYizJm0AMP5Y1DvOYE=;
        b=N7Bom9XG5xN7I9RuFNAwt2x0MU5rAPX+liMd4jPOWiaAjatNoymnJnXycNwUud504X
         Kq2tOQTBqeYDVxL9t3aRiStXLECdjYD5U9BeE0Kw7adZKQ3rcEzl38TSEG6mxH+Dprvk
         h/aq+ECs7eOQ9++WvgwYxccfQ/aoVue1kcWw7ySOTvqbQUXrMp53sR9/fy1c8eXFiVwB
         OdHExlzZ3dAI99Cc3/e/6YM/A3msaBBaQmzZG+Qf0dsr0i78ZqTzBPztIHy5FkIaJwhO
         VorMFD5c3kZqdRtmeBtqg22tnpkYJFQuAZ0+Gwp9PQcERHDnN21eWWH/2e4Q5EACFfoz
         ZIgg==
X-Forwarded-Encrypted: i=1; AL+hErEhboHkAe0PebE5CKnRfXKRcL3wTQ2QHD2tGRTe7XmZyYZqwrs+DzqMqXd05/qbTz0+wXNHGQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/wp3k3oAa4IodCZkD1UZxHjF22tyYin2yoz+bTGlrOoN8dOG9w
	0+bnogoQIBgxTwhVUox9YRLcKIzAw+eKwgevxTzQuVYEP9mZ+GieSMjv
X-Gm-Gg: AZFdTZe9gB3puMxPNRIwMraC5iSe1cympQdWz55cben/L1LVx0E09N+kiVZxS72EhNv
	BB63jSvvT7pqqzSaxViccGnrgDcZKwabesuW0TwZIOq5NWSofAVwX5rEZoqt8tFwareC1jzCEW4
	c8jZm30pmfegB7uNaeKG0ZRhy66WBUq0irRzxfxXGRO+ZzZyCbv5uP3BJPRiPvWKbuYeqFK4vRH
	O0IEQLDmL4jeJ4B+A3u9wKVv7hjvwqCTnPqUR8s8EXyX1lmuDRnMgL0SIj1WZLT0cRJ/RJXulyK
	lqLOIFwN2rmQkSyxmSZhj44vjnCnKmp0ynzoY/M1wkWu30rcDiTxPF3+vLnrqDzVLnAe9FTS44k
	h674WEzmHiRgPjhgz2Ko9lZoYXV12dSqJbrRI3wvbkuDDM1P9Y5Kwjsdy4CbX4gZXK33dXCNVRy
	OTQIMdmjLJx2LDA1i9oBL+AhZew72cpVikUqT+T1ySRl37tkacDcG+GqbqAJxlZJfNIWMVOYQNn
	jea3UsLb8tml7W9pCRJBcuI+m8Teb9rum77xtz32f3p/mzUe4zrJHO0+0z/RBGjpf2ln6K0xtmc
	Zavbm0e3UWRoG8PNeuD50cXlytdXJ7P9LNcHrnzE/X2o9jOj
X-Received: by 2002:a05:693c:829b:10b0:383:a0bd:275a with SMTP id 5a478bee46e88-3856e947850mr47370eec.7.1795108996234;
        Thu, 19 Nov 2026 09:23:16 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm265231eec.26.2026.11.19.09.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:23:15 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>, Thomas
	Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
	Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v3 5/8] powerpc/mm: handle highmem pages in arch_dma_prep_coherent()
In-Reply-To: <20261119151520.2383226-6-m.szyprowski@samsung.com>
Date: Thu, 19 Nov 2026 22:45:22 +0530
Message-ID: <33swlp3p.ritesh.list@gmail.com>
References: <20261119151520.2383226-1-m.szyprowski@samsung.com> <CGME20261119151531eucas1p2be2ec1360d1d94c80b200c53b25f292c@eucas1p2.samsung.com> <20261119151520.2383226-6-m.szyprowski@samsung.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

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

That is correct.

>
> Use __dma_sync_page() with DMA_BIDIRECTIONAL, which the
> arch_sync_dma_for_*() hooks already use and which kmaps highmem pages
> one at a time. Without CONFIG_HIGHMEM it does the same
> flush_dcache_range() on the linear mapping as before.
>
> Fixes: f2902a2fb40c ("powerpc: use the generic dma coherent remap allocator")

I don't think we need a Fixes tag here for the reason you quoted above.
I’m afraid that adding a Fixes tag might cause this patch to be
backported without the previous patch, which would result in extra work
for lowmem pages on highmem-enabled kernels

I think we should drop the "Fixes" tag here.

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/powerpc/mm/dma-noncoherent.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Otherwise, LGTM. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

