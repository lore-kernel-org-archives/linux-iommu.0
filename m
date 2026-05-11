Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B03F2236FD;
	Mon, 11 May 2026 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477890; cv=none; b=bNZOlV4JyobCsMFSz6U7ut9ZjgjJEEpfbwCcYS2pfAad1q3o40Iew1IPiKEGGE+UQjG+MBQ0zewcL95ejoD5xwbYKYNmUcX8lYD8yJNM5LYGDQOHKnYNoIUoJH4sRIAXKmWQxOvUi8LrdS0x2ssZImIo0b1xAXrc/nj8pKJYq7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477890; c=relaxed/simple;
	bh=IpfAO1s4+NwwOUx8SsuPXv6LBmua3S4jzYDrwx5KXIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IkuWtG1/OjAqXsZYwD1qiAQrYC/OgsR28zNfntvZmMPlRXdeHmSh8ZiM0WlIvWAU0CEkrX+kAM3+k0hQQ5BTo7oTFhdebL6lMblzNiTPBWqM/D2jLhKvp3LX8SF0uIN7hg+zViFO8Bfo63aHbL6oHlZJYMieUhNbGMivG/liImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg1fk3FB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg1fk3FB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF403C2BCB0;
	Mon, 11 May 2026 05:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778477889;
	bh=IpfAO1s4+NwwOUx8SsuPXv6LBmua3S4jzYDrwx5KXIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Xg1fk3FB4gVuz1V+1X/p5nKJLDtVmXsxJ9ZgTXYNiSzwM+X7j6OCjt6hxTh4fDcji
	 KcFN3HqBPx7uMO0y31Bx2D4R6a3R9KzzXy53Q1Nb9Vhyzpz+drKbwd65xAMjZ1ye90
	 oVZRNway0fVXoQpAGL5+pSnlLUEy09arXiS5mkCo6+wRkxWL77sEUjRe/JeOq9Za3k
	 7nw6+JVv2p7yenFC8zBFnVG/UcScfLtsQ/78JI9KuRXsqxGnYLHrxGj+FI/Z3wI7Tr
	 /4h01n7pPs7DttANkrg1jTAU9E4ycx/qrPiuKuNqVPHVHuV4PPtUMCD8P6+I9H02az
	 zY4BtRs3PcWag==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/9] dma-direct: use DMA_ATTR_CC_SHARED in alloc/free
 paths
In-Reply-To: <af2sTsMX1Ap_EOiU@arm.com>
References: <20260427055509.898190-1-aneesh.kumar@kernel.org>
 <20260427055509.898190-3-aneesh.kumar@kernel.org>
 <af2sTsMX1Ap_EOiU@arm.com>
Date: Mon, 11 May 2026 11:08:00 +0530
Message-ID: <yq5afr3ytsjr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Apr 27, 2026 at 11:25:02AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> @@ -365,10 +389,14 @@ void dma_direct_free(struct device *dev, size_t size,
>>  struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>>  		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
>>  {
>> +	unsigned long attrs = 0;
>>  	struct page *page;
>>  	void *ret;
>>  
>> -	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
>> +	if (force_dma_unencrypted(dev))
>> +		attrs |= DMA_ATTR_CC_SHARED;
>> +
>> +	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
>>  		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
>
> I was looking at Sashiko's reports and it noticed the wrong type
> returned here. Not something your patch introduces but I think it should
> be fixed rather than continue to propagate it. It's been around since
> 5.10, commit 5b138c534fda ("dma-direct: factor out a
> dma_direct_alloc_from_pool helper"). This code path isn't used much I
> guess.
>

I can add this change as one of the patch

modified    kernel/dma/direct.c
@@ -165,24 +165,24 @@
 	return !gfpflags_allow_blocking(gfp) && !is_swiotlb_for_alloc(dev);
 }
 
-static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+static struct page *dma_direct_alloc_from_pool(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, void **cpu_addr, gfp_t gfp,
+		unsigned long attrs)
 {
 	struct page *page;
 	u64 phys_limit;
-	void *ret;
 
 	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
 		return NULL;
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_from_pool(dev, size, &ret, gfp, attrs,
-				  dma_coherent_ok);
+	page = dma_alloc_from_pool(dev, size, cpu_addr, gfp, attrs,
+				   dma_coherent_ok);
 	if (!page)
 		return NULL;
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
 					 !!(attrs & DMA_ATTR_CC_SHARED));
-	return ret;
+	return page;
 }
 
 static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
@@ -212,7 +212,7 @@
 	bool mark_mem_decrypt = false;
 	bool allow_highmem = true;
 	struct page *page;
-	void *ret;
+	void *cpu_addr;
 
 	/*
 	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
@@ -278,9 +278,12 @@
 	 * the atomic pools instead if we aren't allowed block.
 	 */
 	if ((remap || (attrs & DMA_ATTR_CC_SHARED)) &&
-	    dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle,
-					  gfp, attrs);
+	    dma_direct_use_pool(dev, gfp)) {
+		page = dma_direct_alloc_from_pool(dev, size,
+					dma_handle, &cpu_addr,
+					gfp, attrs);
+		return page ? cpu_addr : NULL;
+	}
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
@@ -318,12 +321,12 @@
 		arch_dma_prep_coherent(page, size);
 
 		/* create a coherent mapping */
-		ret = dma_common_contiguous_remap(page, size, prot,
+		cpu_addr = dma_common_contiguous_remap(page, size, prot,
 				__builtin_return_address(0));
-		if (!ret)
+		if (!cpu_addr)
 			goto out_free_pages;
 	} else {
-		ret = page_address(page);
+		cpu_addr = page_address(page);
 	}
 
 	if (mark_mem_decrypt) {
@@ -334,18 +337,18 @@
 			goto out_leak_pages;
 	}
 
-	memset(ret, 0, size);
+	memset(cpu_addr, 0, size);
 
 	if (set_uncached) {
 		arch_dma_prep_coherent(page, size);
-		ret = arch_dma_set_uncached(ret, size);
-		if (IS_ERR(ret))
+		cpu_addr = arch_dma_set_uncached(cpu_addr, size);
+		if (IS_ERR(cpu_addr))
 			goto out_encrypt_pages;
 	}
 
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
 					 !!(attrs & DMA_ATTR_CC_SHARED));
-	return ret;
+	return cpu_addr;
 
 out_encrypt_pages:
 	if (mark_mem_decrypt && dma_set_encrypted(dev, page_address(page), size))
@@ -427,14 +430,14 @@
 {
 	unsigned long attrs = 0;
 	struct page *page;
-	void *ret;
+	void *cpu_addr;
 
 	if (force_dma_unencrypted(dev))
 		attrs |= DMA_ATTR_CC_SHARED;
 
 	if ((attrs & DMA_ATTR_CC_SHARED) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle,
-					  gfp, attrs);
+					&cpu_addr, gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
@@ -445,7 +448,7 @@
 			swiotlb_free(dev, page, size);
 			return NULL;
 		}
-		ret = page_address(page);
+		cpu_addr = page_address(page);
 		goto setup_page;
 	}
 
@@ -453,11 +456,11 @@
 	if (!page)
 		return NULL;
 
-	ret = page_address(page);
-	if ((attrs & DMA_ATTR_CC_SHARED) && dma_set_decrypted(dev, ret, size))
+	cpu_addr = page_address(page);
+	if ((attrs & DMA_ATTR_CC_SHARED) && dma_set_decrypted(dev, cpu_addr, size))
 		goto out_leak_pages;
 setup_page:
-	memset(ret, 0, size);
+	memset(cpu_addr, 0, size);
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
 					 !!(attrs & DMA_ATTR_CC_SHARED));
 	return page;



