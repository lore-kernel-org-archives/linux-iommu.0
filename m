Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EBD331ECF
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328247; cv=none; b=M8/Wm+eOa4RqhiBA/ugN94eBeeSJNsI5baZQOch9EEUjsGXpVRcmkFYQGj/8N9AhJ4uAVvUS02+MyudTauL2KOj0U99TcmLc7bYPgLKuWLPHFGqHZ8P35VOgFFSFXqUhmOW6HFO1ezw58gcwSLrqLeQpTm+C6lwLO+DKlN9Bp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328247; c=relaxed/simple;
	bh=aHQVgc0XbAoX6FqrXywfPR54PJEC5nLyF3E3pt/kkOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B35GzExotZ5nortKHKSs5rsya5WfliINjcjpTZhCZH69LthszLASlPEC0007ryRYXOJgvBYDtJDIKytdgP2cFfP5hHnQVZtWbsgAm5lMfzGgZuIaay0EM1YHp4vSMDDndOcllNrxcGSpveTmepf/qwoagDmC97fMIrqA+i8YvTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hARzkPFj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hARzkPFj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c73cefe192so8925ad.1
        for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782328244; x=1782933044; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zeRIelXWCkeQ/dWoO1Ec0xhONeA3LFt7A97Ox2lp8yI=;
        b=hARzkPFjv6R4H7038PXFHLWS7bGTCT07frBuMYjiImQAEzl0G1i5PINjxWZw3ntDXu
         Yr6YanR+OI8M8L+GthwSku9fwLbljETLt5x8i42KosQBZgMmDeaMJ2GmSf7TZoM86HcH
         0MAtJWEmre9ZEfMO3xU2vJBOefcapsRcH65k7ghrIW85P3JywsAQwBrq5lirwjeSZ2iE
         ov5z6ZkMQXjq7VJK3Ovbw2IyE8y6Krm809VgxpxfZj/yBF1FdxDHKMYzI4saHQZCuLol
         Jkz8EWbVtwVc57JMp2oMnIUdFCCJv+TLmctcKNsK0jD7Qp+vpPw0+Nk+VzMFCNHRnEMB
         8erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782328244; x=1782933044;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zeRIelXWCkeQ/dWoO1Ec0xhONeA3LFt7A97Ox2lp8yI=;
        b=ktO7fIGuSizitN6uFy4cjlML3iOtjQCQGhyuIMfDnFUqbeBdrB8X5Gm18jFeE05Lhn
         MMixROx8B3c0WVmqpumfJDjHdLLA4xq/zkJOzpHn33w0H63m2fF31WmbnmxzFfpFSXHb
         kTgPO/qISOqGhrqD4YO4zIpW3GZV8ZyCZOX+IVKXfno96ijzTVH1J1/QGUGF+5BPxQV0
         V5SMB+98mthlUXViQZO9r86xyitTSRrDPQVPlUcZtq/jDDdpUf1Oemnr5k4hwnvXEU3W
         F7LvUuT9zW/yXms2sK3uUragQIukKxAaOQa+Oy2RUhNd8mkw9LXePn50b2GGWKjYOgmu
         UnIg==
X-Forwarded-Encrypted: i=1; AHgh+RodCh5rjq8vqYxB+jo8INfWOkxeKQH9bKpIGfEWbY6kTy89s+yInR1bg3KFHkGdHE9Zrf6mXA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/ftGvr+VVTQNYKyDKglVpOQqDDEOWUo7sUFwkMHG20j8MI87P
	iHqyQ+7zDcOon3DUImL+ggZzeWiGZ1+a1oxGP/Ui/FIZp8lwkUiJZlqEHwqWUgsRsA==
X-Gm-Gg: AfdE7ck48tgknsctSSTKZuBpIg/qAmL1JQ2Xsm8pIDzrRi9Oky/j+SXNp382WShyg7y
	axcv3ueYVnxKT34DnciU3gGReH/fxoDtOnh1FuZWAe+ZH6A0Ll/qsK9HtWS11F0Ntc01M0CrGYz
	AYbtoWtpay7UH67g36NBuQSd3J+hK13DKuGU+g5ldMQik+DCMksyTX5dEe+wEH5McEvdf9nqTDs
	5eYnE4LJjSs48dsdNF6TkhSWTYJM00ap4ebKqxcfwjtQpFqi3WPdAKv9olmP981fZ+DfC6wuTkM
	dObbBQlxem+yHCHY43/mZNtKVGJvdVi0bhtDcNwSiVZqQXRnG6dw3R5kH1rvvg9MJddyvs0q5d2
	GCFRQ/WJixjfXpt5QAWgrNpeOovf2a+srJmEabp5vDYZUUa2S4tcZq/QI1A4+YzwD3FMMHa5apR
	BNyp21pxL7NMjw2j/ILYl0zlj1xTZ8GgnxlL/1FEtFXeU6n1dWjamOhAHd1rXhmysxGv+baIzi6
	6ZgtzUt
X-Received: by 2002:a17:902:d50c:b0:2c1:ee6e:be1c with SMTP id d9443c01a7336-2c7f78d26e7mr319365ad.26.1782328243785;
        Wed, 24 Jun 2026 12:10:43 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40ee417sm2715140b3a.40.2026.06.24.12.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 12:10:43 -0700 (PDT)
Date: Wed, 24 Jun 2026 19:10:39 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [RFC PATCH 2/4] dma/pool: Add an API to check if DMA allocation
 is from pool
Message-ID: <ajwpcdIXEeFj-uUr@google.com>
References: <20260505002737.2213734-1-skhawaja@google.com>
 <20260505002737.2213734-3-skhawaja@google.com>
 <aicFes0uxUFQAduC@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aicFes0uxUFQAduC@google.com>

On Mon, Jun 08, 2026 at 06:10:02PM +0000, Pranjal Shrivastava wrote:
>On Tue, May 05, 2026 at 12:27:35AM +0000, Samiullah Khawaja wrote:
>> DMA allocations can be done through DMA pools, add an API that can be
>> used to check if an allocation is done from a pool. This will be used in
>> the later commit during preservation of DMA allocation.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  include/linux/dma-map-ops.h |  1 +
>>  kernel/dma/pool.c           | 13 +++++++++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
>> index 6a1832a73cad..6a0bc4ea2467 100644
>> --- a/include/linux/dma-map-ops.h
>> +++ b/include/linux/dma-map-ops.h
>> @@ -216,6 +216,7 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
>>  		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
>>  bool dma_free_from_pool(struct device *dev, void *start, size_t size);
>>
>> +bool dma_is_from_pool(struct device *dev, void *start, size_t size);
>>  int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
>>  		dma_addr_t dma_start, u64 size);
>>
>> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
>> index 2b2fbb709242..32ce4d6d7683 100644
>> --- a/kernel/dma/pool.c
>> +++ b/kernel/dma/pool.c
>> @@ -307,3 +307,16 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
>>
>>  	return false;
>>  }
>> +
>> +bool dma_is_from_pool(struct device *dev, void *start, size_t size)
>
>Do we need struct device here? It seems unused?
>
>Nit: we only ever pass 0 gfp_flags to dma_guess_pool, should we instead
>name it: dma_is_from_atomic_pool() to be more accurate?

dma_guess_pool() goes through all of them when passing 0, look at the
prev logic inside it and how it is used by the dma_free_from_pool(). But
you are right they are all atomic, but semantically we want to check
whether it is part of any pool so lets keep it as is. WDYT?
>
>> +{
>> +	struct gen_pool *pool = NULL;
>> +
>> +	while ((pool = dma_guess_pool(pool, 0))) {
>> +		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
>> +			continue;
>> +		return true;
>> +	}
>
>Nit: The loop looks slightly ugly, can we have:
>
>struct gen_pool *pool;
>
>for (pool = dma_guess_pool(NULL, 0); pool != NULL; pool = dma_guess_pool(pool, 0)) {
>	if (gen_pool_has_addr(pool, (unsigned long)start, size))
>		return true;
>}

It is a basically a copy dma_free_from_pool() without the free part, so
keeping the style consistent.
>
>> +
>> +	return false;
>> +}
>> --
>> 2.54.0.545.g6539524ca2-goog
>>
>
>Thanks,
>Praan

Thanks,
Sami
