Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723EA1EB5E3;
	Wed, 15 Apr 2026 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245928; cv=none; b=X7wv68fDNz4LCQ87fjSfUinIfEP+gY6k7Zakom5N6/nL53ozAGOCi8Ol94PePaDG29si8/AmO6iCg6SPNJg29QUIc/3lQCLRSiQK6T+8GbWldWsRgBwJw1lyclenVmizhoXE+SeiDiVJFRMCj/GNeU4ftRT0RzNyvCR0z8FH7T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245928; c=relaxed/simple;
	bh=yvPWI63mL2/V+hU0QPoactRfP5mRJFPKJMbs/wYt9m0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ELo9Ny8z2rUZsyATKARFriJ4dxuGm9HO+nKpiU7fFSw9cpy1HwFACJiQwv1gvRJTBCXzdvxAoaD7CIuRLmJP5Oh2qDVOIjbe4JPc1EeEyHd2OqSqYtghJhakMpVfQjcDtiVy0Oa8tIOvMv7c6kk4LI0TowVh3YRVaszu5CQbSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcWXaKyO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcWXaKyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64D6C19424;
	Wed, 15 Apr 2026 09:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776245928;
	bh=yvPWI63mL2/V+hU0QPoactRfP5mRJFPKJMbs/wYt9m0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XcWXaKyO5ZNQ0xk+sV5ll7pxf4b8gal5E19q3t48cSgYGHng8Ux2meScQCwZ+ocrK
	 qkWZ93SHWdpYvDnRxjPxusZyIjVBbTfAemHzG0aX2MIO4udypLibW1cDIB1Xh3xidA
	 qSV+pDFdh2udUnv3KGIaEABIwfREi4sVsplM6RhVCmm/SWe46+S9OOc3wAo9TzyF2D
	 0Im6N+C9XFJdNyfLNIiPaMzBSKev7RH+l2+TRx8HIrR7+JhW9wBQZguHeN4fr99HKf
	 KFclfUyrhajUfZ8SczcG5/XXowj14rnqNvqvo/TQfralpPrjSrRQBt2xHnh/AN82nY
	 zMb8GotepBeQA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us
Subject: Re: [RFC PATCH v3 4/5] dma-mapping: Encapsulate memory state during
 allocation
In-Reply-To: <20260410180504.GE2551565@ziepe.ca>
References: <20260408194750.2280873-1-smostafa@google.com>
 <20260408194750.2280873-5-smostafa@google.com>
 <20260410180504.GE2551565@ziepe.ca>
Date: Wed, 15 Apr 2026 15:08:40 +0530
Message-ID: <yq5ao6jka7hb.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Apr 08, 2026 at 07:47:41PM +0000, Mostafa Saleh wrote:
>> Introduce a new dma-direct internal type dma_page which is
>> "struct page" and a bit indicate whether the memory has been decrypted
>> or not.
>> This is useful to pass such information encapsulated through
>> allocation functions, which is currently set from swiotlb_alloc().
>> 
>> No functional changes.
>> 
>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>> ---
>>  kernel/dma/direct.c | 58 +++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 46 insertions(+), 12 deletions(-)
>> 
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index de63e0449700..204bc566480c 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -16,6 +16,33 @@
>>  #include <linux/pci-p2pdma.h>
>>  #include "direct.h"
>>  
>> +/*
>> + * Represent DMA allocation and 1 bit flag for it's state
>> + */
>
> I'd explain this wrappers a pointer and uses the low PAGE_SHIFT bits
> for flags..
>
>> +struct dma_page {
>> +	unsigned long val;
>
> unintptr_t ?
>
>> @@ -103,20 +130,21 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
>>  	dma_free_contiguous(dev, page, size);
>>  }
>>  
>> -static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
>> +static struct dma_page dma_direct_alloc_swiotlb(struct device *dev, size_t size)
>>  {
>> -	struct page *page = swiotlb_alloc(dev, size, NULL);
>> +	enum swiotlb_page_state state;
>> +	struct page *page = swiotlb_alloc(dev, size, &state);
>>  
>>  	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>>  		swiotlb_free(dev, page, size);
>> -		return NULL;
>> +		return DMA_PAGE_NULL;
>>  	}
>>  
>> -	return page;
>> +	return page_to_dma_page(page, state == SWIOTLB_PAGE_DECRYPTED);
>
> Should the struct dma_page have been introduced earlier instead of the
> swiotlb_page_state ? Seems a bit odd to have both
>
> If these are actually internally allocated struct pages, could you use
> the struct page memory itself to record the decrypted state? That
> would require more significant changes to the allocator calls.
>
>> @@ -184,9 +212,11 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
>>  static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
>>  		dma_addr_t *dma_handle, gfp_t gfp)
>>  {
>> +	struct dma_page dma_page;
>>  	struct page *page;
>>  
>> -	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
>> +	dma_page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
>> +	page = dma_page_to_page(dma_page);
>>  	if (!page)
>>  		return NULL;
>
> I would expect to see more usage of the dma_page here..
>
> Like I don't think this is really right:
>
>         *dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>
> Does page_to_phys(page) really work on decrypted memory? On CCA it
> will return the protected alias which doesn't seem like something
> useful?
>
> static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>                 phys_addr_t phys)
> {
>         if (force_dma_unencrypted(dev))
>                 return phys_to_dma_unencrypted(dev, phys);
>         return phys_to_dma(dev, phys);
>
> Above is all nonsense now that you have a direct indication of the
> address is decrypted memory or not, it should also be used right here
> directly.
>
> if (is_dma_page_decrypted(dma_page))
>    *dma_handle = phys_to_dma_unencrypted(..)
> else
>    *dma_handle = phys_to_dma(..);
>
> The later patch just makes it worse by adding even more confusing
> flags to phys_to_dma_direct().
>
> I think it should work out that everyone already knows what memory
> type they are working with before they call down to
> phys_to_dma_direct() - the calls to force_dma_unecrypted() here are
> just hacks because it previously did not.
>
> Anyhow, I think this series is alot better than the previous one. If
> you work a little harder to make it so there is only one
> force_dma_unecrypted() per high level DMA API call that would be
> perfect.

I tried the following:

1. Applied force_dma_unencrypted() at the high-level DMA APIs.
2. Marked the atomic pools as decrypted.
3. Marked swiotlb io_tlb_mem as decrypted.
4. Avoided adding dma_page; instead, we can cover all functions by passing arguments.

This is a fairly large change, and I was wondering whether this is
actually the direction we want to take.

If this looks good, I can start working on splitting them as smaller patches.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 94d514169642..782be0a4d454 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1650,7 +1650,7 @@ void *iommu_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    !gfpflags_allow_blocking(gfp) && !coherent)
 		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
-					       gfp, NULL);
+					   gfp, attrs & DMA_ATTR_CC_DECRYPTED, NULL);
 	else
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
 	if (!cpu_addr)
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index c249912456f9..1c5e3eb548af 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -90,14 +90,22 @@ static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
 {
 	return dma_addr_unencrypted(__phys_to_dma(dev, paddr));
 }
+
+static inline dma_addr_t phys_to_dma_encrypted(struct device *dev,
+						phys_addr_t paddr)
+{
+	return dma_addr_encrypted(__phys_to_dma(dev, paddr));
+}
 /*
  * If memory encryption is supported, phys_to_dma will set the memory encryption
  * bit in the DMA address, and dma_to_phys will clear it.
  * phys_to_dma_unencrypted is for use on special unencrypted memory like swiotlb
  * buffers.
  */
-static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr, bool unencrypted)
 {
+	if (unencrypted)
+		return dma_addr_unencrypted(__phys_to_dma(dev, paddr));
 	return dma_addr_encrypted(__phys_to_dma(dev, paddr));
 }
 
@@ -132,7 +140,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 	if (addr == DMA_MAPPING_ERROR)
 		return false;
 	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
-	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
+	    min(addr, end) < __phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
 		return false;
 
 	return end <= min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 60b63756df82..8f9dc14140b7 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -217,7 +217,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size, pgprot_t prot,
 void dma_common_free_remap(void *cpu_addr, size_t size);
 
 struct page *dma_alloc_from_pool(struct device *dev, size_t size,
-		void **cpu_addr, gfp_t flags,
+		void **cpu_addr, gfp_t flags, bool require_decrypted,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 99ef042ecdb4..dbf613502e8e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -93,6 +93,14 @@
  */
 #define DMA_ATTR_REQUIRE_COHERENT	(1UL << 12)
 
+/*
+ * DMA_ATTR_CC_DECRYPTED: Indicates memory that has been explicitly decrypted
+ * (shared) for confidential computing guests. The caller must have
+ * called set_memory_decrypted(). A struct page is required.
+ */
+#define DMA_ATTR_CC_DECRYPTED	(1UL << 13)
+
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..201e3ad38e35 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -111,6 +111,7 @@ struct io_tlb_mem {
 	struct dentry *debugfs;
 	bool force_bounce;
 	bool for_alloc;
+	bool decrypted;
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	bool can_grow;
 	u64 phys_limit;
@@ -282,7 +283,7 @@ static inline void swiotlb_sync_single_for_cpu(struct device *dev,
 extern void swiotlb_print_info(void);
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
-struct page *swiotlb_alloc(struct device *dev, size_t size);
+struct page *swiotlb_alloc(struct device *dev, size_t size, bool require_decrypted);
 bool swiotlb_free(struct device *dev, struct page *page, size_t size);
 
 static inline bool is_swiotlb_for_alloc(struct device *dev)
@@ -290,7 +291,7 @@ static inline bool is_swiotlb_for_alloc(struct device *dev)
 	return dev->dma_io_tlb_mem->for_alloc;
 }
 #else
-static inline struct page *swiotlb_alloc(struct device *dev, size_t size)
+static inline struct page *swiotlb_alloc(struct device *dev, size_t size, bool require_decrypted)
 {
 	return NULL;
 }
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 1147497bc512..0503af6d651a 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -31,7 +31,7 @@ static inline dma_addr_t dma_get_device_base(struct device *dev,
 					     struct dma_coherent_mem * mem)
 {
 	if (mem->use_dev_dma_pfn_offset)
-		return phys_to_dma(dev, PFN_PHYS(mem->pfn_base));
+		return __phys_to_dma(dev, PFN_PHYS(mem->pfn_base));
 	return mem->device_base;
 }
 
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8f43a930716d..b8b5d2ecd5a2 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -24,11 +24,11 @@
 u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
-		phys_addr_t phys)
+		phys_addr_t phys, bool unencrypted)
 {
-	if (force_dma_unencrypted(dev))
+	if (unencrypted)
 		return phys_to_dma_unencrypted(dev, phys);
-	return phys_to_dma(dev, phys);
+	return phys_to_dma_encrypted(dev, phys);
 }
 
 static inline struct page *dma_direct_to_page(struct device *dev,
@@ -39,8 +39,9 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
+	bool require_decrypted = force_dma_unencrypted(dev);
 	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
-	u64 max_dma = phys_to_dma_direct(dev, phys);
+	u64 max_dma = phys_to_dma_direct(dev, phys, require_decrypted);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
@@ -69,7 +70,8 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 
 bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys);
+	bool require_decrypted = force_dma_unencrypted(dev);
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys, require_decrypted);
 
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return false;
@@ -79,8 +81,6 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 
 static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
 {
-	if (!force_dma_unencrypted(dev))
-		return 0;
 	return set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
 }
 
@@ -88,8 +88,6 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 {
 	int ret;
 
-	if (!force_dma_unencrypted(dev))
-		return 0;
 	ret = set_memory_encrypted((unsigned long)vaddr, PFN_UP(size));
 	if (ret)
 		pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
@@ -104,9 +102,9 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
 	dma_free_contiguous(dev, page, size);
 }
 
-static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
+static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size, bool require_decrypted)
 {
-	struct page *page = swiotlb_alloc(dev, size);
+	struct page *page = swiotlb_alloc(dev, size, require_decrypted);
 
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		swiotlb_free(dev, page, size);
@@ -125,9 +123,6 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	WARN_ON_ONCE(!PAGE_ALIGNED(size));
 
-	if (is_swiotlb_for_alloc(dev))
-		return dma_direct_alloc_swiotlb(dev, size);
-
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page) {
@@ -165,7 +160,7 @@ static bool dma_direct_use_pool(struct device *dev, gfp_t gfp)
 }
 
 static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
-		dma_addr_t *dma_handle, gfp_t gfp)
+		dma_addr_t *dma_handle, gfp_t gfp, bool require_decrypted)
 {
 	struct page *page;
 	u64 phys_limit;
@@ -175,10 +170,10 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 		return NULL;
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
-	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
+	page = dma_alloc_from_pool(dev, size, &ret, gfp, require_decrypted, dma_coherent_ok);
 	if (!page)
 		return NULL;
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page), require_decrypted);
 	return ret;
 }
 
@@ -196,14 +191,16 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 		arch_dma_prep_coherent(page, size);
 
 	/* return the page pointer as the opaque cookie */
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page), true);
 	return page;
 }
 
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	bool require_decrypted = force_dma_unencrypted(dev);
 	bool remap = false, set_uncached = false;
+	bool mark_mem_decrypt = require_decrypted;
 	struct page *page;
 	void *ret;
 
@@ -211,8 +208,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) && !require_decrypted &&
+	    !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
 	if (!dev_is_dma_coherent(dev)) {
@@ -246,15 +243,32 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
 	 */
-	if ((remap || force_dma_unencrypted(dev)) &&
-	    dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+	if ((remap || require_decrypted) && dma_direct_use_pool(dev, gfp))
+		return dma_direct_alloc_from_pool(dev, size, dma_handle,
+						  gfp, require_decrypted);
 
-	/* we always manually zero the memory once we are done */
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	if (is_swiotlb_for_alloc(dev)) {
+		page = dma_direct_alloc_swiotlb(dev, size, require_decrypted);
+		if (page) {
+			/*
+			 * swiotlb allocations comes from pool already marked
+			 * decrypted
+			 */
+			mark_mem_decrypt = false;
+			goto setup_page;
+		}
+		return NULL;
+	}
+
+	/*
+	 * we always manually zero the memory once we are done.
+	 * Don't request for highmem if we need a decrypted memory
+	 */
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, !require_decrypted);
 	if (!page)
 		return NULL;
 
+setup_page:
 	/*
 	 * dma_alloc_contiguous can return highmem pages depending on a
 	 * combination the cma= arguments and per-arch setup.  These need to be
@@ -268,7 +282,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
-		if (force_dma_unencrypted(dev))
+		if (require_decrypted)
 			prot = pgprot_decrypted(prot);
 
 		/* remove any dirty cache lines on the kernel alias */
@@ -281,10 +295,17 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_free_pages;
 	} else {
 		ret = page_address(page);
-		if (dma_set_decrypted(dev, ret, size))
+	}
+
+	if (mark_mem_decrypt) {
+		void *lm_addr;
+
+		lm_addr = page_address(page);
+		if (set_memory_decrypted((unsigned long)lm_addr, PFN_UP(size)))
 			goto out_leak_pages;
 	}
 
+
 	memset(ret, 0, size);
 
 	if (set_uncached) {
@@ -294,11 +315,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_encrypt_pages;
 	}
 
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page), require_decrypted);
 	return ret;
 
 out_encrypt_pages:
-	if (dma_set_encrypted(dev, page_address(page), size))
+	if (mark_mem_decrypt && dma_set_encrypted(dev, page_address(page), size))
 		return NULL;
 out_free_pages:
 	__dma_direct_free_pages(dev, page, size);
@@ -310,10 +331,13 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
+	/* if the device had requested for an unencrypted buffer, convert it to encrypted on free */
+	bool decrypted_dma_buf = force_dma_unencrypted(dev);
+	bool mark_mem_encrypted = decrypted_dma_buf;
 	unsigned int page_order = get_order(size);
 
-	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) && !decrypted_dma_buf &&
+	    !is_swiotlb_for_alloc(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
@@ -338,13 +362,25 @@ void dma_direct_free(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
 		return;
 
+	if (swiotlb_find_pool(dev, dma_to_phys(dev, dma_addr)))
+		/* Swiotlb doesn't need a page attribute update on free */
+		mark_mem_encrypted = false;
+
 	if (is_vmalloc_addr(cpu_addr)) {
 		vunmap(cpu_addr);
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
-		if (dma_set_encrypted(dev, cpu_addr, size))
+	}
+
+	if (mark_mem_encrypted) {
+		void *lm_addr;
+
+		lm_addr = phys_to_virt(dma_to_phys(dev, dma_addr));
+		if (set_memory_encrypted((unsigned long)lm_addr, PFN_UP(size))) {
+			pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
 			return;
+		}
 	}
 
 	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
@@ -353,21 +389,37 @@ void dma_direct_free(struct device *dev, size_t size,
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
+	bool require_decrypted = force_dma_unencrypted(dev);
 	struct page *page;
 	void *ret;
 
-	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
-		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
+	if (require_decrypted && dma_direct_use_pool(dev, gfp))
+		return dma_direct_alloc_from_pool(dev, size, dma_handle,
+						  gfp, require_decrypted);
+
+	if (is_swiotlb_for_alloc(dev)) {
+		page = dma_direct_alloc_swiotlb(dev, size, require_decrypted);
+		if (!page)
+			return NULL;
+
+		if (PageHighMem(page)) {
+			swiotlb_free(dev, page, size);
+			return NULL;
+		}
+		ret = page_address(page);
+		goto setup_page;
+	}
 
 	page = __dma_direct_alloc_pages(dev, size, gfp, false);
 	if (!page)
 		return NULL;
 
 	ret = page_address(page);
-	if (dma_set_decrypted(dev, ret, size))
+	if (require_decrypted && dma_set_decrypted(dev, ret, size))
 		goto out_leak_pages;
+setup_page:
 	memset(ret, 0, size);
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page), require_decrypted);
 	return page;
 out_leak_pages:
 	return NULL;
@@ -377,6 +429,9 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 		struct page *page, dma_addr_t dma_addr,
 		enum dma_data_direction dir)
 {
+	/* if the device had requested for an unencrypted buffer, convert it to encrypted on free */
+	bool decrypted_dma_buf = force_dma_unencrypted(dev);
+	bool mark_mem_encrypted = decrypted_dma_buf;
 	void *vaddr = page_address(page);
 
 	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
@@ -384,7 +439,10 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, vaddr, size))
 		return;
 
-	if (dma_set_encrypted(dev, vaddr, size))
+	if (swiotlb_find_pool(dev, page_to_phys(page)))
+		mark_mem_encrypted = false;
+
+	if (mark_mem_encrypted && dma_set_encrypted(dev, vaddr, size))
 		return;
 	__dma_direct_free_pages(dev, page, size);
 }
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 6184ff303f08..fc6435d5b27c 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -83,6 +83,9 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 {
 	dma_addr_t dma_addr;
 
+	if (force_dma_unencrypted(dev))
+		attrs |= DMA_ATTR_CC_DECRYPTED;
+
 	if (is_swiotlb_force_bounce(dev)) {
 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 			return DMA_MAPPING_ERROR;
@@ -94,8 +97,12 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		dma_addr = phys;
 		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
 			goto err_overflow;
+	} else if (attrs & DMA_ATTR_CC_DECRYPTED) {
+		dma_addr = phys_to_dma_unencrypted(dev, phys);
+		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
+			goto err_overflow;
 	} else {
-		dma_addr = phys_to_dma(dev, phys);
+		dma_addr = phys_to_dma_encrypted(dev, phys);
 		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
 		    dma_kmalloc_needs_bounce(dev, size, dir)) {
 			if (is_swiotlb_active(dev) &&
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 2b2fbb709242..1a8077cec806 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -12,12 +12,18 @@
 #include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/cc_platform.h>
 
-static struct gen_pool *atomic_pool_dma __ro_after_init;
+struct dma_gen_pool {
+	bool decrypted;
+	struct gen_pool *pool;
+};
+
+static struct dma_gen_pool atomic_pool_dma __ro_after_init;
 static unsigned long pool_size_dma;
-static struct gen_pool *atomic_pool_dma32 __ro_after_init;
+static struct dma_gen_pool atomic_pool_dma32 __ro_after_init;
 static unsigned long pool_size_dma32;
-static struct gen_pool *atomic_pool_kernel __ro_after_init;
+static struct dma_gen_pool atomic_pool_kernel __ro_after_init;
 static unsigned long pool_size_kernel;
 
 /* Size can be defined by the coherent_pool command line */
@@ -76,7 +82,7 @@ static bool cma_in_zone(gfp_t gfp)
 	return true;
 }
 
-static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
+static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 			      gfp_t gfp)
 {
 	unsigned int order;
@@ -113,11 +119,14 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
 	 * shrink so no re-encryption occurs in dma_direct_free().
 	 */
-	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
+	if (dma_pool->decrypted) {
+		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
 				   1 << order);
-	if (ret)
-		goto remove_mapping;
-	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
+		if (ret)
+			goto remove_mapping;
+	}
+
+	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr, page_to_phys(page),
 				pool_size, NUMA_NO_NODE);
 	if (ret)
 		goto encrypt_mapping;
@@ -126,11 +135,13 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	return 0;
 
 encrypt_mapping:
-	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
-				   1 << order);
-	if (WARN_ON_ONCE(ret)) {
-		/* Decrypt succeeded but encrypt failed, purposely leak */
-		goto out;
+	if (dma_pool->decrypted) {
+		ret = set_memory_encrypted((unsigned long)page_to_virt(page),
+					   1 << order);
+		if (WARN_ON_ONCE(ret)) {
+			/* Decrypt succeeded but encrypt failed, purposely leak */
+			goto out;
+		}
 	}
 remove_mapping:
 #ifdef CONFIG_DMA_DIRECT_REMAP
@@ -142,46 +153,51 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	return ret;
 }
 
-static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
+static void atomic_pool_resize(struct dma_gen_pool *dma_pool, gfp_t gfp)
 {
-	if (pool && gen_pool_avail(pool) < atomic_pool_size)
-		atomic_pool_expand(pool, gen_pool_size(pool), gfp);
+	if (dma_pool->pool && gen_pool_avail(dma_pool->pool) < atomic_pool_size)
+		atomic_pool_expand(dma_pool, gen_pool_size(dma_pool->pool), gfp);
 }
 
 static void atomic_pool_work_fn(struct work_struct *work)
 {
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		atomic_pool_resize(atomic_pool_dma,
+		atomic_pool_resize(&atomic_pool_dma,
 				   GFP_KERNEL | GFP_DMA);
 	if (IS_ENABLED(CONFIG_ZONE_DMA32))
-		atomic_pool_resize(atomic_pool_dma32,
+		atomic_pool_resize(&atomic_pool_dma32,
 				   GFP_KERNEL | GFP_DMA32);
-	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
+	atomic_pool_resize(&atomic_pool_kernel, GFP_KERNEL);
 }
 
-static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
-						      gfp_t gfp)
+static __init struct dma_gen_pool *__dma_atomic_pool_init(struct dma_gen_pool *dma_pool,
+		size_t pool_size, gfp_t gfp)
 {
-	struct gen_pool *pool;
 	int ret;
 
-	pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
-	if (!pool)
+	dma_pool->pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+	if (!dma_pool->pool)
 		return NULL;
 
-	gen_pool_set_algo(pool, gen_pool_first_fit_order_align, NULL);
+	gen_pool_set_algo(dma_pool->pool, gen_pool_first_fit_order_align, NULL);
+
+	/* if platform is using memory encryption atomic pools are by default decrypted. */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+		dma_pool->decrypted = true;
+	else
+		dma_pool->decrypted = false;
 
-	ret = atomic_pool_expand(pool, pool_size, gfp);
+	ret = atomic_pool_expand(dma_pool, pool_size, gfp);
 	if (ret) {
-		gen_pool_destroy(pool);
+		gen_pool_destroy(dma_pool->pool);
 		pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
 		       pool_size >> 10, &gfp);
 		return NULL;
 	}
 
 	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
-		gen_pool_size(pool) >> 10, &gfp);
-	return pool;
+		gen_pool_size(dma_pool->pool) >> 10, &gfp);
+	return dma_pool;
 }
 
 #ifdef CONFIG_ZONE_DMA32
@@ -207,21 +223,22 @@ static int __init dma_atomic_pool_init(void)
 
 	/* All memory might be in the DMA zone(s) to begin with */
 	if (has_managed_zone(ZONE_NORMAL)) {
-		atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
-						    GFP_KERNEL);
-		if (!atomic_pool_kernel)
+		__dma_atomic_pool_init(&atomic_pool_kernel, atomic_pool_size, GFP_KERNEL);
+		if (!atomic_pool_kernel.pool)
 			ret = -ENOMEM;
 	}
+
 	if (has_managed_dma()) {
-		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA);
-		if (!atomic_pool_dma)
+		__dma_atomic_pool_init(&atomic_pool_dma, atomic_pool_size,
+				       GFP_KERNEL | GFP_DMA);
+		if (!atomic_pool_dma.pool)
 			ret = -ENOMEM;
 	}
+
 	if (has_managed_dma32) {
-		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA32);
-		if (!atomic_pool_dma32)
+		__dma_atomic_pool_init(&atomic_pool_dma32, atomic_pool_size,
+				       GFP_KERNEL | GFP_DMA32);
+		if (!atomic_pool_dma32.pool)
 			ret = -ENOMEM;
 	}
 
@@ -230,19 +247,38 @@ static int __init dma_atomic_pool_init(void)
 }
 postcore_initcall(dma_atomic_pool_init);
 
-static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
+static inline struct dma_gen_pool *dma_guess_pool(struct dma_gen_pool *prev, gfp_t gfp)
 {
 	if (prev == NULL) {
-		if (gfp & GFP_DMA)
-			return atomic_pool_dma ?: atomic_pool_dma32 ?: atomic_pool_kernel;
-		if (gfp & GFP_DMA32)
-			return atomic_pool_dma32 ?: atomic_pool_dma ?: atomic_pool_kernel;
-		return atomic_pool_kernel ?: atomic_pool_dma32 ?: atomic_pool_dma;
+		if (gfp & GFP_DMA) {
+			if (atomic_pool_dma.pool)
+				return &atomic_pool_dma;
+			if (atomic_pool_dma32.pool)
+				return &atomic_pool_dma32;
+			return &atomic_pool_kernel;
+		}
+
+		if (gfp & GFP_DMA32) {
+			if (atomic_pool_dma32.pool)
+				return &atomic_pool_dma32;
+			if (atomic_pool_dma.pool)
+				return &atomic_pool_dma;
+			return &atomic_pool_kernel;
+		}
+		if (atomic_pool_kernel.pool)
+			return &atomic_pool_kernel;
+		if (atomic_pool_dma32.pool)
+			return &atomic_pool_dma32;
+		if (atomic_pool_dma.pool)
+			return &atomic_pool_dma;
 	}
-	if (prev == atomic_pool_kernel)
-		return atomic_pool_dma32 ? atomic_pool_dma32 : atomic_pool_dma;
-	if (prev == atomic_pool_dma32)
-		return atomic_pool_dma;
+	if (prev == &atomic_pool_kernel) {
+		if (atomic_pool_dma32.pool)
+			return &atomic_pool_dma32;
+		return &atomic_pool_dma;
+	}
+	if (prev == &atomic_pool_dma32)
+		return &atomic_pool_dma;
 	return NULL;
 }
 
@@ -272,16 +308,20 @@ static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
 }
 
 struct page *dma_alloc_from_pool(struct device *dev, size_t size,
-		void **cpu_addr, gfp_t gfp,
+		void **cpu_addr, gfp_t gfp, bool require_decrypted,
 		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
 {
-	struct gen_pool *pool = NULL;
+	struct dma_gen_pool *dma_pool = NULL;
 	struct page *page;
 	bool pool_found = false;
 
-	while ((pool = dma_guess_pool(pool, gfp))) {
+	while ((dma_pool = dma_guess_pool(dma_pool, gfp))) {
+
+		if (dma_pool->decrypted != require_decrypted)
+			continue;
+
 		pool_found = true;
-		page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
+		page = __dma_alloc_from_pool(dev, size, dma_pool->pool, cpu_addr,
 					     phys_addr_ok);
 		if (page)
 			return page;
@@ -296,12 +336,14 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 
 bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
-	struct gen_pool *pool = NULL;
+	struct dma_gen_pool *dma_pool = NULL;
 
-	while ((pool = dma_guess_pool(pool, 0))) {
-		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
+	while ((dma_pool = dma_guess_pool(dma_pool, 0))) {
+
+		if (!gen_pool_has_addr(dma_pool->pool, (unsigned long)start, size))
 			continue;
-		gen_pool_free(pool, (unsigned long)start, size);
+
+		gen_pool_free(dma_pool->pool, (unsigned long)start, size);
 		return true;
 	}
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9fd73700ddcf..ff31c197586d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -262,7 +262,18 @@ void __init swiotlb_update_mem_attributes(void)
 	if (!mem->nslabs || mem->late_alloc)
 		return;
 	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
-	set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
+	/*
+	 * if platform support memory encryption, swiotlb buffers are
+	 * decrypted by default.
+	 */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+		io_tlb_default_mem.decrypted = true;
+		set_memory_decrypted((unsigned long)mem->vaddr, bytes >> PAGE_SHIFT);
+	} else {
+		io_tlb_default_mem.decrypted = false;
+	}
+
+
 }
 
 static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
@@ -429,6 +440,7 @@ void __init swiotlb_init(bool addressing_limit, unsigned int flags)
 int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 		int (*remap)(void *tlb, unsigned long nslabs))
 {
+	bool unencrypted_tlb_mem = io_tlb_default_mem.decrypted;
 	struct io_tlb_pool *mem = &io_tlb_default_mem.defpool;
 	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
 	unsigned int nareas;
@@ -505,8 +517,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!mem->slots)
 		goto error_slots;
 
-	set_memory_decrypted((unsigned long)vstart,
-			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
+	if (unencrypted_tlb_mem)
+		set_memory_decrypted((unsigned long)vstart,
+				     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
+
 	swiotlb_init_io_tlb_pool(mem, virt_to_phys(vstart), nslabs, true,
 				 nareas);
 	add_mem_pool(&io_tlb_default_mem, mem);
@@ -570,7 +584,8 @@ void __init swiotlb_exit(void)
  * Return: Decrypted pages, %NULL on allocation failure, or ERR_PTR(-EAGAIN)
  * if the allocated physical address was above @phys_limit.
  */
-static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
+static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes,
+		u64 phys_limit, bool unencrypted)
 {
 	unsigned int order = get_order(bytes);
 	struct page *page;
@@ -588,13 +603,13 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
 	}
 
 	vaddr = phys_to_virt(paddr);
-	if (set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
+	if (unencrypted && set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
 		goto error;
 	return page;
 
 error:
 	/* Intentional leak if pages cannot be encrypted again. */
-	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
+	if (unencrypted && !set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
 		__free_pages(page, order);
 	return NULL;
 }
@@ -609,7 +624,7 @@ static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
  * Return: Allocated pages, or %NULL on allocation failure.
  */
 static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
-		u64 phys_limit, gfp_t gfp)
+		u64 phys_limit, bool unencrypted, gfp_t gfp)
 {
 	struct page *page;
 
@@ -617,14 +632,14 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	 * Allocate from the atomic pools if memory is encrypted and
 	 * the allocation is atomic, because decrypting may block.
 	 */
-	if (!gfpflags_allow_blocking(gfp) && dev && force_dma_unencrypted(dev)) {
+	if (!gfpflags_allow_blocking(gfp) && unencrypted) {
 		void *vaddr;
 
 		if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
 			return NULL;
 
 		return dma_alloc_from_pool(dev, bytes, &vaddr, gfp,
-					   dma_coherent_ok);
+					   true, dma_coherent_ok);
 	}
 
 	gfp &= ~GFP_ZONEMASK;
@@ -633,7 +648,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	else if (phys_limit <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;
 
-	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit))) {
+	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit, unencrypted))) {
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
 		    phys_limit < DMA_BIT_MASK(64) &&
 		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))
@@ -681,7 +696,8 @@ static void swiotlb_free_tlb(void *vaddr, size_t bytes)
  */
 static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 		unsigned long minslabs, unsigned long nslabs,
-		unsigned int nareas, u64 phys_limit, gfp_t gfp)
+		unsigned int nareas, u64 phys_limit, bool unencrypted,
+		gfp_t gfp)
 {
 	struct io_tlb_pool *pool;
 	unsigned int slot_order;
@@ -701,7 +717,7 @@ static struct io_tlb_pool *swiotlb_alloc_pool(struct device *dev,
 	pool->areas = (void *)pool + sizeof(*pool);
 
 	tlb_size = nslabs << IO_TLB_SHIFT;
-	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, gfp))) {
+	while (!(tlb = swiotlb_alloc_tlb(dev, tlb_size, phys_limit, unencrypted, gfp))) {
 		if (nslabs <= minslabs)
 			goto error_tlb;
 		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
@@ -737,7 +753,8 @@ static void swiotlb_dyn_alloc(struct work_struct *work)
 	struct io_tlb_pool *pool;
 
 	pool = swiotlb_alloc_pool(NULL, IO_TLB_MIN_SLABS, default_nslabs,
-				  default_nareas, mem->phys_limit, GFP_KERNEL);
+				  default_nareas, mem->phys_limit, mem->decrypted,
+				  GFP_KERNEL);
 	if (!pool) {
 		pr_warn_ratelimited("Failed to allocate new pool");
 		return;
@@ -1224,7 +1241,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	nslabs = nr_slots(alloc_size);
 	phys_limit = min_not_zero(*dev->dma_mask, dev->bus_dma_limit);
 	pool = swiotlb_alloc_pool(dev, nslabs, nslabs, 1, phys_limit,
-				  GFP_NOWAIT);
+				  mem->decrypted, GFP_NOWAIT);
 	if (!pool)
 		return -1;
 
@@ -1591,17 +1608,18 @@ void __swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
 dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
+	bool require_decrypted = attrs & DMA_ATTR_CC_DECRYPTED;
 	phys_addr_t swiotlb_addr;
 	dma_addr_t dma_addr;
 
-	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
+	trace_swiotlb_bounced(dev, __phys_to_dma(dev, paddr), size);
 
 	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
 	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
 	/* Ensure that the address returned is DMA'ble */
-	dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
+	dma_addr = phys_to_dma(dev, swiotlb_addr, require_decrypted);
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
 		__swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
 			attrs | DMA_ATTR_SKIP_CPU_SYNC,
@@ -1763,7 +1781,7 @@ static inline void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 
-struct page *swiotlb_alloc(struct device *dev, size_t size)
+struct page *swiotlb_alloc(struct device *dev, size_t size, bool require_decrypted)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_pool *pool;
@@ -1774,6 +1792,9 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 	if (!mem)
 		return NULL;
 
+	if (mem->decrypted != require_decrypted)
+		return NULL;
+
 	align = (1 << (get_order(size) + PAGE_SHIFT)) - 1;
 	index = swiotlb_find_slots(dev, 0, size, align, &pool);
 	if (index == -1)
@@ -1843,9 +1864,18 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			kfree(mem);
 			return -ENOMEM;
 		}
+		/*
+		 * if platform supports memory encryption,
+		 * restricted mem pool is decrypted by default
+		 */
+		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+			mem->decrypted = true;
+			set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
+					     rmem->size >> PAGE_SHIFT);
+		} else {
+			mem->decrypted = false;
+		}
 
-		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
-				     rmem->size >> PAGE_SHIFT);
 		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
 					 false, nareas);
 		mem->force_bounce = true;
