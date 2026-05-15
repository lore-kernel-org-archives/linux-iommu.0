Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF103EFFDB
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885001; cv=none; b=TubWA81nSj03Psup0GbDMe/CWTu3w5uiUR4IDtiNtFhEDYEEmUAb0ItF9P97nVgDR5DMWtyBzNljpyBxdfdC+I9ulHeTBmG85YzN7kDlSqK4Z+HdNxxry3VTxno5J1qBudMG+hzOIJg1lpB1HubP3rHpD0KYZQKFfFruS48ZId8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885001; c=relaxed/simple;
	bh=kaYeoiBhKH8QIrdUuVmAazULlTKQl2EsXPfmNkamrFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL37hfLG6fslEWXQZRoERK7XNOsn/ima6rqXpUJdVJw4/0ZN9/esPebv/cE3j9z5IphQFiCh9R6zAQHADqx1ADSrS2cjz/SI8lOy0X19rlyvkTOR9astlaRPQ/ibEj5PfgHEuDDi5UMrdTEJDLomE93QtE64s0gYBHbxWCDlp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=C4P+g42/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="C4P+g42/"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5102582e23eso4072641cf.1
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778884998; x=1779489798; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=COahKpUTP3FbIp/9gGBiaABm/08X7eZmQdMgy3y6jxs=;
        b=C4P+g42/8GXJ5FpW3hxNsSl5HGb0havYvJ1pIR/2KhxLKk2kg4qApUHfS3DyRFgxOn
         mgAphftWA/c6dje3KroERwYxlprpqCYJTiwRAZ+E3ZA8vEm0//jAhMy06x1tCenYPGv1
         qJpYdWWdtHsy42Fx+d8cQLNJHeJEv7oj3c3bzhPvFip5xIaYC4ZQjhgly54A8N7jNX0D
         K9gRqV0ALqCCC0DSEgajeih5HDOkby3gf7zZmoDyXGGcYlaiRjQ+0d/ceQP/wnoQ/IQv
         RszOemRIcM3SD+h7qR+SHqFo1co9NgYHYczJikjvD8gZNZI+ztWrDOVEHTRZ8V8henEF
         UOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884998; x=1779489798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COahKpUTP3FbIp/9gGBiaABm/08X7eZmQdMgy3y6jxs=;
        b=mePcuv6Vq71J3s0Ivnk8prO9xmdbIv8VM8K8v9QWTKsIRo26LVR2ywqpf74LAAhEoH
         sdl1dnabUnjoLJx3VuSXd1wcXQZR1NG+0ODkbWKkVJkNlwf4vltHRkxcXx3/C8ZQy2jF
         oLa6ewhaNF2jsZzMtUJ6/2SJAVpGZCKCy5ZgIxp5xOSeubY3psEEpT+1ANmOcd20I9rI
         lCTHxZhNiti81CDQ8LOmBMID5kZ7cqvlQjC1+1tIQJdC8In1X5kmx5vXgaLFq7Ykm1U+
         zo2NJ4b6EEktVne4MqL8jEexdrF6c5AjdnfK66Qg+u09C9QVIQg5BzZnbhKBwcc32f1E
         8BpA==
X-Forwarded-Encrypted: i=1; AFNElJ+nttXnV+ZtryLV+5vi+0kE3BJbXGYZ+XaYDOut1ISKYRxewvSphgovD/WSfkSc2jCQRlGh3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeqeJO8i7eOGfafkdAO4xgwMnyGVrX6WI9qEfytpZwjqs5R8Rw
	4rp6Ji5TaNznI3vUjIU0e8nMaN066cfQnDRsDajPpx+X6MtBE9dHngRroLy7aoTKsFQ=
X-Gm-Gg: Acq92OGLUZ/64tTz0+VvIQh/rqmsh+E5kSKX3YtLYIGaxVJrMV5hEmtICO51OWhNHyj
	mirX5xmqKzX8vNfiSG44Vv4KPw0T38wNPVyMNVA6yDqzXAWke69N+hvvbUU8t1us1owPTQ6sKwN
	c8gk1C2mPQZJQNIQeJCmm3+f04+Zf2EsBME0rJsaBVxBLHz06JCQRdMSPtki0H6KR4I7OoFdfG8
	pXtZXuLeRMMtAJ9Kp0DVWSD+fIkuOhArTfJVsN1zwy/ttEhItqSQgCpW9z86cpF6zCjG+/i44yH
	J27BtKbmwji5oJ9VJu9RDpBXuukaF6oUNK2joT8+DbpkvLPrsk08yiNdqjJmTCiuFG7il9+KphS
	ZnGciqBZYXCLm0eQBANtUXKMuAqkKWUnnSAZUa0WRZtRCLTK/S4BG/RYplxhe2ag1u5w1Kv9bi0
	XY1ClYz3h6ROBPmcOTv380yAEvOgyeKF7BmK5b4CJGlDtKVJ3uknl6+ey79aTxCZtRIlKS7v9j7
	v5Q6w==
X-Received: by 2002:a05:622a:5814:b0:50d:9b4a:e6f with SMTP id d75a77b69052e-5165a012120mr85384381cf.1.1778884998371;
        Fri, 15 May 2026 15:43:18 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645856d10sm56007601cf.26.2026.05.15.15.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:43:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO1FV-00000008F2P-03Ci;
	Fri, 15 May 2026 19:43:17 -0300
Date: Fri, 15 May 2026 19:43:17 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, iommu@lists.linux.dev, kyle@mcmartin.ca,
	kernel-team@meta.com, Rik van Riel <riel@meta.com>
Subject: Re: [PATCH 5/5] iova: add KUnit test suite
Message-ID: <20260515224317.GM7702@ziepe.ca>
References: <20260513020304.1528751-1-riel@surriel.com>
 <20260513020304.1528751-6-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513020304.1528751-6-riel@surriel.com>

On Tue, May 12, 2026 at 10:00:22PM -0400, Rik van Riel wrote:
> From: Rik van Riel <riel@meta.com>
> 
> Add a kunit suite for the augmented-rbtree IOVA allocator, plus an
> iova_domain_verify_invariants() helper (compiled only when the test
> config is enabled) that walks the tree and confirms every node's
> gap_to_prev, clamped_gap32, __subtree_max_gap, and __subtree_max_gap32
> match what recomputation from scratch yields.
> 
> Test cases:
>   - test_init_destroy: domain lifecycle, no leaks.
>   - test_basic_alloc_free: single alloc/free roundtrip, top-down reuse.
>   - test_size_aligned: alignment of size_aligned allocs across orders 0..7.
>   - test_top_down_preference: sequential allocs decrease in pfn_lo.
>   - test_limit_pfn_respected: 100 allocs all stay <= limit_pfn.
>   - test_reserve_iova: allocs avoid the reserved range.
>   - test_find_iova: lookup by pfn returns the right iova.
>   - test_32bit_in_64bit_domain: 1000 64-bit allocs followed by a 32-bit
>     alloc must still find a slot below DMA_BIT_MASK(32) -- exercises
>     the __subtree_max_gap32 augmentation.
>   - test_two_phase_alignment: pack size-2 size_aligned allocs, free
>     every other; subsequent size-2 alloc must succeed via the phase-2
>     fallback search since phase-1's S+A-1 threshold prunes the size-2
>     gaps.
>   - test_pci_32bit_workaround_pattern: alternate 32-bit-first allocation
>     attempts with 64-bit fallback, mirroring dma-iommu.c.
>   - test_stress_random: 2048 random alloc/free operations with mixed
>     sizes, alignments, and 32/64-bit limits, with periodic invariant
>     checks.
> 
> Each test verifies the augmented invariants both during and after the
> test run so that any sequencing bug in insert / erase / rotate /
> propagate is caught at the operation that introduced it.
> 
> Tested by: building drivers/iommu/iova.o and drivers/iommu/iova-kunit.o
> (no warnings); runtime execution requires booting a kernel with
> CONFIG_IOMMU_IOVA_KUNIT_TEST=y under qemu-system-x86_64 (not available
> on this devvm).
    ^^^^^^^^^^^^^^^

Heh, you should still read the patches when using claude :)

Can you add a .kunitconfig please? The tests should run with a command like:

    tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/.kunitconfig

Also it is worth while to carefully read each test because claude will
happily write nonsense tests that avoid actual bugs so they succeed...

> +static struct iova_test_ctx *iova_test_init_ctx(struct kunit *test)
> +{
> +	struct iova_test_ctx *ctx;
> +	int ret;
> +
> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx);
> +
> +	ret = iova_cache_get();
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	init_iova_domain(&ctx->iovad, TEST_GRANULE, 1);
> +	ret = iova_domain_init_rcaches(&ctx->iovad);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	ctx->initialized = true;
> +	KUNIT_ASSERT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
> +	return ctx;
> +}
> +
> +static void iova_test_cleanup(struct kunit *test, struct iova_test_ctx *ctx)
> +{
> +	if (ctx->initialized) {
> +		KUNIT_EXPECT_TRUE(test, iova_domain_verify_invariants(&ctx->iovad));
> +		put_iova_domain(&ctx->iovad);
> +		iova_cache_put();
> +		ctx->initialized = false;
> +	}
> +}
> +
> +static void test_init_destroy(struct kunit *test)
> +{
> +	struct iova_test_ctx *ctx = iova_test_init_ctx(test);
> +
> +	iova_test_cleanup(test, ctx);
> +}

This iova_test_init_ctx()/iova_test_cleanup() stuff is not the right
way to use kunit. Add a fixture and remove it from every test.

> +bool iova_domain_verify_invariants(struct iova_domain *iovad)
> +{
> +	bool ok = true;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +	iova_walk_verify(iovad->rbroot.rb_node, iovad, &ok);
> +	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> +	return ok;
> +}
> +EXPORT_SYMBOL_GPL(iova_domain_verify_invariants);

EXPORT_SYMBOL_IF_KUNIT

>  int iova_domain_init_rcaches(struct iova_domain *iovad);
>  struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>  void put_iova_domain(struct iova_domain *iovad);
> +#if IS_ENABLED(CONFIG_IOMMU_IOVA_KUNIT_TEST)
> +bool iova_domain_verify_invariants(struct iova_domain *iovad);
> +#endif

Don't really need this #ifdef

Jason
