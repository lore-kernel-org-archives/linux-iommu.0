Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449A2C158A
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011522; cv=none; b=ZGYD3uGfj1PpasDdOnb5Wa3autJoZ0SmQMm7jCD+ekS7Ty9HA360C4oZfbjZhOefJ0wix0up30x7NEsKdHjAkt5B3cXH4YsX7L6/lj/N9pxZ1ozJN8JGjLLZ5lKUBCrmzPyaqOFkVFvduEMTh6/PbioAdmECm8DOi90Gq7Btw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011522; c=relaxed/simple;
	bh=5ykcnLagaTLgxx9r2hXBNJ7fmnjaYdIjCpGctAQoeIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zcde/xWtTVMrLnOm/XBSq60XRfEI8nE3n+Jolzb3WsAKqwNDlUchn80SbkN0RjoyXd4ujO7xZWD2DsRdt+mICuSnWoD4oyJCOfjbLBhQWql8CAdjy5NrS3IiqI6wjk2rInhhe8c4ddv3mcuWJmmhSs4Iql6LrLbj964stPB8oFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eMldlTp/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eMldlTp/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490c737bcafso2162755e9.3
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781011519; x=1781616319; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7v0vfpWbXL2tO4K5nU3J31VniWsuUDENERYOQ4A7IA=;
        b=eMldlTp/1Sbx8nYCDqX7JesB0IuglCCTfV5jRsnpg4MpW0o+V4mP9Aq+iq/pXb2FY4
         RkrpvX1894zFdG/mwc/h0TSv0pXz/31VYNmUHC9e4KPr3Aems6rryn9a6F3UnV3ZS6pT
         X1U8OfF5oRKPYR6SWJBqTbE4sTfk25msZRvXvYWT8uDvG4Anz2aO4pibpW/nC97Gu9hb
         o6g8mCHiKEOJGVsyFPizj/i7b68WKb17RijMuoegipE8CKVc+Rgl1bKf5Wzp+sNzBC3E
         TdNvCmOKVRVra99/8JP6YVGe8ITVYT5gNj2BnjHY618EqcPT8iX2F1f2JeSu/RazoWeo
         7v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011519; x=1781616319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k7v0vfpWbXL2tO4K5nU3J31VniWsuUDENERYOQ4A7IA=;
        b=dUEw9FNgT7qcLDPvO6651zyD+Bti0KrKVXve72IEbbUNX5iUly9UD54091RqieDk3n
         hAFdpV3tlm9RK7a6Lr/0d8dLyo1YkJeLV8SKoNhzLSHlZZwNHQEVbABsP7Z3HpRCs2lh
         qeI6kHKJd0w6Md0JA1u/PrwgrNJ1prJYtpZUZxuItRKl+Du06VdadQWsrgdMChDDZCaE
         IJo/ZwZRYMfOKntWsymqCff77FtWPcUsgaPGa9OU+Pb5V7hHjYGGKBAyX4NwIfXTLUh4
         OL7WSmbNkiHDqE6R2E9U0Y57CO5kKErvnWry1MxQx0iIb65XymUtetjLGOuD88aWkeFT
         myFA==
X-Gm-Message-State: AOJu0YzjJb+355nvM6ACfQkao8qn/nRO/5D7uaWPyifE3jd1F9u1ymK0
	gBWkbSAeKHhQ2fi3JV3Kti5+fAcxbmkn6c4sYzBe97WeWOTyLM0BQEQ2fC5cTKzCRvY=
X-Gm-Gg: Acq92OFXRKuiU+KOh6lvlil+uFDwa4m7FrMaDjvhfr8OipmzeJOlhszepJ9YBrTr2Tj
	yTgAb3hDQ0c+kz6Kc6Kl7W+RfOI3DGGjX05l76o+nB/gTtk+69UFUE5R3sGkboaBBMKBSr1mJy7
	VGNxVlr7BI4ovxwAb92pdC+AKaVbYKuhFIJSlja9OkgqR+J6rBgc146XqGS9/OtQTslNvJhgzW3
	wwaIpnXmvbkF4hdOHipwKinZtJ9DB60LHuyZ8xHRpyDtNwdEF9riVO6qdACxsEwISMpAKgJs+QM
	3o/n3KzJuovvM0Z10lEsNEs7M5dk4aJgjg951LRZBeoxt2QruFF9DJf/YvMEwcSW+j3oFJS5/W7
	wJZVob5fBWp/Ro2XIEaxjP4mRfGQ2btcQeWyu95CAqUFUbGmsCLNjEbgW7NfLjY1Nx5VCdyA+2S
	a+EJK1wKlNL0LJtPYCkmS7r98=
X-Received: by 2002:a05:600c:1c1e:b0:48a:56d4:7274 with SMTP id 5b1f17b1804b1-490c25e7e1amr167118665e9.3.1781011519006;
        Tue, 09 Jun 2026 06:25:19 -0700 (PDT)
Received: from mordecai ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm574197205e9.9.2026.06.09.06.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:25:18 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:23:53 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy
 <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Will
 Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Steven Price
 <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>, Jason
 Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, Alexey
 Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, x86@kernel.org, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH v6 16/20] dma: swiotlb: free dynamic pools from process
 context
Message-ID: <20260609152353.6a9f60f8@mordecai>
In-Reply-To: <20260604083959.1265923-17-aneesh.kumar@kernel.org>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
	<20260604083959.1265923-17-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 14:09:55 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> swiotlb_dyn_free() is used after removing a dynamic swiotlb pool from
> RCU-protected lists. It can call swiotlb_free_tlb(), which may need to
> restore the encryption state of an unencrypted pool with
> set_memory_encrypted() before freeing the pages.
> 
> RCU callbacks run in atomic context, but set_memory_encrypted() is not
> guaranteed to be atomic-safe on all architectures. For example, page
> attribute updates may allocate page tables or take sleeping locks.

Good catch!

> Use queue_rcu_work() for dynamic pool freeing instead. This keeps the RCU
> grace period before freeing a published pool, while running the actual pool
> teardown from workqueue context. Use the same helper for the transient-pool
> error path, since that path may also be reached from atomic DMA mapping
> context.

Strictly speaking, it's not necessary, because this is in the error
path just after allocating a transient pool. There are only two
possible scenarios:

a. The transient buffer was allocated from a sleeping context, and then
   it's also OK to decrypt memory.

b. The transient buffer was allocated in atomic context, but then it was
   allocated from a coherent pool and it is returned to that pool
   rather than decrypted.

However, it's also fine to queue an RCU work. The logic is definitely
cleaner and easier to maintain.

> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Petr T

> ---
>  include/linux/swiotlb.h |  4 ++--
>  kernel/dma/swiotlb.c    | 19 +++++++++++--------
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 4dcbf3931be1..526f82e9da45 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -64,7 +64,7 @@ extern void __init swiotlb_update_mem_attributes(void);
>   * @areas:	Array of memory area descriptors.
>   * @slots:	Array of slot descriptors.
>   * @node:	Member of the IO TLB memory pool list.
> - * @rcu:	RCU head for swiotlb_dyn_free().
> + * @dyn_free:	RCU work item used to free the pool from process context.
>   * @transient:  %true if transient memory pool.
>   */
>  struct io_tlb_pool {
> @@ -79,7 +79,7 @@ struct io_tlb_pool {
>  	struct io_tlb_slot *slots;
>  #ifdef CONFIG_SWIOTLB_DYNAMIC
>  	struct list_head node;
> -	struct rcu_head rcu;
> +	struct rcu_work dyn_free;
>  	bool transient;
>  	bool unencrypted;
>  #endif
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index f4e8b241a1c4..4c56f64602ea 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -774,13 +774,10 @@ static void swiotlb_dyn_alloc(struct work_struct *work)
>  	add_mem_pool(mem, pool);
>  }
>  
> -/**
> - * swiotlb_dyn_free() - RCU callback to free a memory pool
> - * @rcu:	RCU head in the corresponding struct io_tlb_pool.
> - */
> -static void swiotlb_dyn_free(struct rcu_head *rcu)
> +static void swiotlb_dyn_free_work(struct work_struct *work)
>  {
> -	struct io_tlb_pool *pool = container_of(rcu, struct io_tlb_pool, rcu);
> +	struct io_tlb_pool *pool =
> +		container_of(to_rcu_work(work), struct io_tlb_pool, dyn_free);
>  	size_t slots_size = array_size(sizeof(*pool->slots), pool->nslabs);
>  	size_t tlb_size = pool->end - pool->start;
>  
> @@ -789,6 +786,12 @@ static void swiotlb_dyn_free(struct rcu_head *rcu)
>  	kfree(pool);
>  }
>  
> +static void swiotlb_schedule_dyn_free(struct io_tlb_pool *pool)
> +{
> +	INIT_RCU_WORK(&pool->dyn_free, swiotlb_dyn_free_work);
> +	queue_rcu_work(system_wq, &pool->dyn_free);
> +}
> +
>  /**
>   * __swiotlb_find_pool() - find the IO TLB pool for a physical address
>   * @dev:        Device which has mapped the DMA buffer.
> @@ -835,7 +838,7 @@ static void swiotlb_del_pool(struct device *dev, struct io_tlb_pool *pool)
>  	list_del_rcu(&pool->node);
>  	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
>  
> -	call_rcu(&pool->rcu, swiotlb_dyn_free);
> +	swiotlb_schedule_dyn_free(pool);
>  }
>  
>  #endif	/* CONFIG_SWIOTLB_DYNAMIC */
> @@ -1276,7 +1279,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
>  	index = swiotlb_search_pool_area(dev, pool, 0, orig_addr, tbl_dma_addr,
>  					 alloc_size, alloc_align_mask);
>  	if (index < 0) {
> -		swiotlb_dyn_free(&pool->rcu);
> +		swiotlb_schedule_dyn_free(pool);
>  		return -1;
>  	}
>  

