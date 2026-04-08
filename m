Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E64F376BDE
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677677; cv=none; b=RrohNRE6ymhMwt5FIc0JV/xUXA5vth4oArDtbjvLt/diVgID7poj+2NvU9MK4vsEehg23bvuIWSolk3kTs6MhKkmAUtaCKp8adEY7SevpxJeG8w4EZ6uwLz7NAwxT2h81yGEgO5KLRK69Q7O8Atd0nzHD4eFLeJNFDXzZCV5/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677677; c=relaxed/simple;
	bh=IQ7dKN8L4UZaeFiDQv8QKTj4LSuRG6pNboyXJnO/vcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eijmtGFanHjRtnnnGdKYxVmjao9yEHjIeki097sRhgRidL2D43Kl3Vt6RGYcx6LzYozgLBLivSnbcUiE+FLPr6T8eA7rmNtrJOy/3VFgGDXYTXAZ5fK9gWjV1KlXB6gd+lTI5pKYnWyPCzwcDmITJhJi7Q2q0kvK5TvEtbbC7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+yZh4pT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+yZh4pT"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48887ff8b73so454325e9.2
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775677675; x=1776282475; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gIZkNljvc8euLjmnwxUEEJNh/0dVrZPblskV0P24de4=;
        b=A+yZh4pTAy3WWuHCiwYmGuxg4HUE5DDQaU+vmGLkBuxuAp4IbI2419ubYXIL3DqpIX
         Da2uZZ8SpdzOmBuWEyy2B6dVRxR4XNfcmloS0MSRb8KpJNODZB1uB+PRyteDn3uFxHqc
         vDHr2t+IQBLY/mZpK20TdZVpgVbij/6FBQBxzrhnLPMemkXsKzS4pkE/zO/Hrn6GMPrU
         GGfkCbaiPQ7ZohCtniqqBhPTHUk5lEl19RillG1kIAxD95ELBvI9SktI2vjsUwVPbxbP
         Cm/BGIyNFMYrRU3UafiOwuQr1se9/X06/mMFISrwjNgJ0RZ5/3Svxq/0+G9+6DH+rY3z
         w84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677675; x=1776282475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIZkNljvc8euLjmnwxUEEJNh/0dVrZPblskV0P24de4=;
        b=GA1zgmiJGxgiTUKzzNKwv1YVmXwehNxuZvI51Gi70tcxRP5Cx2kbhn96D/k/N6QQfH
         VDbp/CRDtKUoiqM71Tf8CcmBwzDKyQtS6N3I3JDp2zSw8u1v8X0I6++QYuAmc8k+tAFq
         1KDtzixuuUx4UFR1VUKItKfqqfpicWItEpPFFg+DJabWl9Whq9Ta5OHIfPpbz7TOSOJg
         yYOTR1Co2DRLQdR+vKd8LnX4fgEjh5zSmv/su4mxx6rvYbld6Bq8iMmL3Qxy1mP5YGWj
         NcvVw0JQyzNERZCSqrsTiCkJc+t3juo4MLxl87DNJfNfwBQSeeuj0EqXkYMZc5ps59Bd
         S8pA==
X-Gm-Message-State: AOJu0Yw7nb1BOwyqPTJteqZfuWA0YENJ7JQpyiCVQuPgD+JlPjBJuTUV
	HLYrbTvCxZwr66kOrVejPQcTS2HhdtuQoSF6f8yfkTdF6F6NuKiiZdJ4p9qjpBFEpzQZ6g/w7Ky
	QdaWxBEVXbxk9OBe+AQEvh0jCs09HvjMLSBp7TgIBd6FtdUyg/LvEFyo3+Q6EVd7Zq9TEfWbgWx
	3V2SZ+r8a5MpzPmf1gwCe3sqjHQ78QnVivaYiLqCdaYkSvOA==
X-Received: from wmqy6.prod.google.com ([2002:a05:600c:3646:b0:488:7f5c:7693])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ecf:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-488aa33e02emr202999135e9.26.1775677674735;
 Wed, 08 Apr 2026 12:47:54 -0700 (PDT)
Date: Wed,  8 Apr 2026 19:47:38 +0000
In-Reply-To: <20260408194750.2280873-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260408194750.2280873-1-smostafa@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408194750.2280873-2-smostafa@google.com>
Subject: [RFC PATCH v3 1/5] swiotlb: Return state of memory from swiotlb_alloc()
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	jiri@resnulli.us, jgg@ziepe.ca, aneesh.kumar@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Make swiotlb_alloc() return the state of the allocated memory, at
the moment all the pools are decrypted but that would change soon.
In the next patches dma-direct will use the returned state to
determine whether to decrypt the memory and use the proper memory
decryption/encryption related functions.

Also, add swiotlb_is_decrypted(), that will be used before calling
swiotlb_free() to check whether the memory needs to be encrypted
by the caller.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 include/linux/swiotlb.h | 25 +++++++++++++++++++++++--
 kernel/dma/direct.c     |  2 +-
 kernel/dma/swiotlb.c    | 23 ++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063..24be65494ce8 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -63,6 +63,7 @@ extern void __init swiotlb_update_mem_attributes(void);
  * @area_nslabs: Number of slots in each area.
  * @areas:	Array of memory area descriptors.
  * @slots:	Array of slot descriptors.
+ * @decrypted:	Whether the pool was decrypted or left in default state.
  * @node:	Member of the IO TLB memory pool list.
  * @rcu:	RCU head for swiotlb_dyn_free().
  * @transient:  %true if transient memory pool.
@@ -77,6 +78,7 @@ struct io_tlb_pool {
 	unsigned int area_nslabs;
 	struct io_tlb_area *areas;
 	struct io_tlb_slot *slots;
+	bool decrypted;
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 	struct list_head node;
 	struct rcu_head rcu;
@@ -281,16 +283,31 @@ static inline void swiotlb_sync_single_for_cpu(struct device *dev,
 
 extern void swiotlb_print_info(void);
 
+/*
+ * This contains the state of pages returned by swiotlb_alloc()
+ * A page can either be:
+ * SWIOTLB_PAGE_DEFAULT: The page was not decrypted by the pool.
+ * SWIOTLB_PAGE_DECRYPTED: The page was decrypted by the pool.
+ */
+enum swiotlb_page_state {
+	SWIOTLB_PAGE_DEFAULT,
+	SWIOTLB_PAGE_DECRYPTED,
+};
+
 #ifdef CONFIG_DMA_RESTRICTED_POOL
-struct page *swiotlb_alloc(struct device *dev, size_t size);
+struct page *swiotlb_alloc(struct device *dev, size_t size,
+			   enum swiotlb_page_state *state);
 bool swiotlb_free(struct device *dev, struct page *page, size_t size);
 
+bool swiotlb_is_decrypted(struct device *dev, struct page *page, size_t size);
+
 static inline bool is_swiotlb_for_alloc(struct device *dev)
 {
 	return dev->dma_io_tlb_mem->for_alloc;
 }
 #else
-static inline struct page *swiotlb_alloc(struct device *dev, size_t size)
+static inline struct page *swiotlb_alloc(struct device *dev, size_t size,
+					 enum swiotlb_page_state *state)
 {
 	return NULL;
 }
@@ -299,6 +316,10 @@ static inline bool swiotlb_free(struct device *dev, struct page *page,
 {
 	return false;
 }
+static inline bool swiotlb_is_decrypted(struct device *dev, struct page *page, size_t size)
+{
+	return false;
+}
 static inline bool is_swiotlb_for_alloc(struct device *dev)
 {
 	return false;
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8f43a930716d..6efb5973fbd3 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -106,7 +106,7 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
 
 static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
 {
-	struct page *page = swiotlb_alloc(dev, size);
+	struct page *page = swiotlb_alloc(dev, size, NULL);
 
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		swiotlb_free(dev, page, size);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9fd73700ddcf..8468ee5d3ff2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1763,7 +1763,8 @@ static inline void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 
-struct page *swiotlb_alloc(struct device *dev, size_t size)
+struct page *swiotlb_alloc(struct device *dev, size_t size,
+			   enum swiotlb_page_state *state)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	struct io_tlb_pool *pool;
@@ -1787,6 +1788,8 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 		return NULL;
 	}
 
+	if (state)
+		*state = pool->decrypted ? SWIOTLB_PAGE_DECRYPTED : SWIOTLB_PAGE_DEFAULT;
 	return pfn_to_page(PFN_DOWN(tlb_addr));
 }
 
@@ -1804,6 +1807,18 @@ bool swiotlb_free(struct device *dev, struct page *page, size_t size)
 	return true;
 }
 
+bool swiotlb_is_decrypted(struct device *dev, struct page *page, size_t size)
+{
+	phys_addr_t tlb_addr = page_to_phys(page);
+	struct io_tlb_pool *pool;
+
+	pool = swiotlb_find_pool(dev, tlb_addr);
+	if (!pool)
+		return false;
+
+	return pool->decrypted;
+}
+
 static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 				    struct device *dev)
 {
@@ -1844,6 +1859,12 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			return -ENOMEM;
 		}
 
+		/*
+		 * At the moment all restricted dma pools are always decrypted,
+		 * although that should change soon with CCA solutions introducing
+		 * device passthrough.
+		 */
+		pool->decrypted = true;
 		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
 				     rmem->size >> PAGE_SHIFT);
 		swiotlb_init_io_tlb_pool(pool, rmem->base, nslabs,
-- 
2.53.0.1213.gd9a14994de-goog

