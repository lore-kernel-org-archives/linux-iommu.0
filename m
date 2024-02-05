Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388D1171A
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117800; cv=none; b=Nhl2wk+/2Kut0CgfW72mOtegNO1YqaM6AP6kFvAQUF6SN0eIVkW0Oez9tZGCVPW/p35WAZmr1yBWpT1YaTwqob3isTPTA7ffTR3krlyd2BCIzyiCOwGHP6WYnms0zc3yNs9WAfmp5UT04VSeRybgffG5tAvcCWprdIbjmxRlhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117800; c=relaxed/simple;
	bh=fRdIEkqC6AHAGWzL0sUwh5/9zm0uMpYulqzLdo0MgwQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WK7chZsYz8OohF9+wVUKIOagjtu4kf7XXm9QJ+FxY94nEo7W8RRAMU1qyOWb2HeRAdLriRBgz3CeE08Q1OmwqHDJeMW34/1/Ah1Br7V3UUVdTOaELC71g0iLlrsdcMJG93f4l+eJqscTeRYzq9pJr8Gm+VhZmV2Yzw/bRJxalkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbw49jmi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbw49jmi"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d9a541b720aso7109102276.0
        for <iommu@lists.linux.dev>; Sun, 04 Feb 2024 23:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707117798; x=1707722598; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4EARZAVpVD9KkNMBLza1efHrT0/oIuEoyKdcimlSgGM=;
        b=fbw49jmiMaJ3mFo0AzdkC7EahH4TPCWYKhqhKQrGv7lciaZaHfAbQumi+iXBVeONKP
         379Lu2PrXzwH6x4Mkf/+gvng2NPeUVSvfYLVhRwO1lkZuEtPxG9EKiBgm3fF+WcBVt3I
         fI4EwLsCzJnFLv4Q6V5Vohd/gArhiY0dsqmxKoexANa8ILjevgc9a80bC0pR7BmeNQOl
         UjOcIEClOGDAYxMJEqpwq7Kz7zO+fiwRs+obutMpM5Ut/ev0G4oO/oPMccJW2XVKXEVs
         8leJZ2Iq1qrN6GdO1wjsPSktbIn2glsBut914T+K5F1MPHwNSZzGUERVblwjsn1/LKUi
         t8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707117798; x=1707722598;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4EARZAVpVD9KkNMBLza1efHrT0/oIuEoyKdcimlSgGM=;
        b=iet4Y/r7cNI5aWuusmaatskhv3DGML2aNF2OZT4eVp6MeXfg/xntQ5P8VmJ+ddslcA
         3SXs9CT/LfX2poU0xzJ5+SnJ7nWrROvEZ1os0pI3b2FgGemvurTAWR+6DCpf27FrZOdD
         yEmYD8p2FkrRN+zFKGkqUkMD4lAME5Vt2IBqHmeBc77axoRdLBQxeyKUNyIeej7MrQEr
         9yenlHlX/n4OJOWHg9VG8+pKhQWx62MFijx1kRGLwelr+h/4cB5E/R82m6lmC+qlSKNT
         ZCrYm3emBMZ6cLcrQDfMJB6wtUGn6ZdsREniYkxaxsgomzo1LxV77e+GqBOOuyE5o2px
         8WmA==
X-Gm-Message-State: AOJu0YyyzyZMWeyJkwGt+buKsUQC8/6GY20Rp4rmqr+mUnB9JYuQT0L3
	i86Q0ihhQvQ/Hy+m8zDO52gUo98k+NRTfs3/QL8uoWOEfvIAqC4b0Gw8OxjM5ZEi+sWA26UWGR9
	Muae2wyBC9zvFeQ==
X-Google-Smtp-Source: AGHT+IFvjUyon8xN80jK9TU7mUOlXcStnpxF2ufvrWxqV7XeXls2wmP68BEODrRltr3fj4iJeTFNtVGnXhRb9uE=
X-Received: from howardyen2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:16f7])
 (user=howardyen job=sendgmr) by 2002:a05:6902:1b01:b0:dc6:ff54:249f with SMTP
 id eh1-20020a0569021b0100b00dc6ff54249fmr1547089ybb.8.1707117797934; Sun, 04
 Feb 2024 23:23:17 -0800 (PST)
Date: Mon,  5 Feb 2024 07:23:00 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205072312.2342188-1-howardyen@google.com>
Subject: [PATCH v2] dma-coherent: add support for multi coherent rmems per dev
From: Howard Yen <howardyen@google.com>
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	rafael@kernel.org, broonie@kernel.org, james@equiv.tech, james.clark@arm.com, 
	masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for multiple coherent rmems per device. This patch replaces
original dma_mem with dma_mems list in device structure to store multiple
rmems.

These multiple rmems can be assigned to the device one by one by
of_reserved_mem_device_init_by_idx() with the memory-region
declaration in device tree as below and store the rmem to the dma_mems
list.

	device1@0 {
		...
		memory-region = <&reserved_mem0>, <&reserved_mem1>;
		...
	};

When driver tries to allocate memory from the rmems, looks for the first
available rmem and allocates the memory from this rmem.

Then if driver removed, of_reserved_mem_device_release() needs to be
invoked to release all the rmems assigned to the device.

Signed-off-by: Howard Yen <howardyen@google.com>
---
Changelog since v1:
(suggested by Robin Murphy <robin.murphy@arm.com>)
- Replace the pointer(dma_mem) to a list_head(dma_mems) in the device
  structure and initialize the list_head in device_initialize().
- Modify the required changes in coherent.c.

 drivers/base/core.c    |  3 ++
 include/linux/device.h |  5 ++--
 kernel/dma/coherent.c  | 66 ++++++++++++++++++++++++++++--------------
 3 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..d9af38d7b870 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3108,6 +3108,9 @@ void device_initialize(struct device *dev)
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	dev->dma_coherent = dma_default_coherent;
+#endif
+#ifdef CONFIG_DMA_DECLARE_COHERENT
+	INIT_LIST_HEAD(&dev->dma_mems);
 #endif
 	swiotlb_dev_init(dev);
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 97c4b046c09d..5fa15e5adbdc 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -648,7 +648,7 @@ struct device_physical_location {
  * @dma_parms:	A low level driver may set these to teach IOMMU code about
  * 		segment limitations.
  * @dma_pools:	Dma pools (if dma'ble device).
- * @dma_mem:	Internal for coherent mem override.
+ * @dma_mems:	Internal for coherent mems.
  * @cma_area:	Contiguous memory area for dma allocations
  * @dma_io_tlb_mem: Software IO TLB allocator.  Not for driver use.
  * @dma_io_tlb_pools:	List of transient swiotlb memory pools.
@@ -749,8 +749,7 @@ struct device {
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
 
 #ifdef CONFIG_DMA_DECLARE_COHERENT
-	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
-					     override */
+	struct list_head	dma_mems; /* Internal for coherent mems */
 #endif
 #ifdef CONFIG_DMA_CMA
 	struct cma *cma_area;		/* contiguous memory area for dma
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index ff5683a57f77..91aa63d3327b 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -18,15 +18,9 @@ struct dma_coherent_mem {
 	unsigned long	*bitmap;
 	spinlock_t	spinlock;
 	bool		use_dev_dma_pfn_offset;
+	struct list_head	node;
 };
 
-static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
-{
-	if (dev && dev->dma_mem)
-		return dev->dma_mem;
-	return NULL;
-}
-
 static inline dma_addr_t dma_get_device_base(struct device *dev,
 					     struct dma_coherent_mem * mem)
 {
@@ -61,6 +55,7 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 	dma_mem->pfn_base = PFN_DOWN(phys_addr);
 	dma_mem->size = pages;
 	dma_mem->use_dev_dma_pfn_offset = use_dma_pfn_offset;
+	INIT_LIST_HEAD(&dma_mem->node);
 	spin_lock_init(&dma_mem->spinlock);
 
 	return dma_mem;
@@ -90,10 +85,8 @@ static int dma_assign_coherent_memory(struct device *dev,
 	if (!dev)
 		return -ENODEV;
 
-	if (dev->dma_mem)
-		return -EBUSY;
+	list_add_tail(&mem->node, &dev->dma_mems);
 
-	dev->dma_mem = mem;
 	return 0;
 }
 
@@ -132,9 +125,13 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 
 void dma_release_coherent_memory(struct device *dev)
 {
+	struct dma_coherent_mem *mem_tmp, *q;
+
 	if (dev) {
-		_dma_release_coherent_memory(dev->dma_mem);
-		dev->dma_mem = NULL;
+		list_for_each_entry_safe(mem_tmp, q, &dev->dma_mems, node) {
+			list_del_init(&mem_tmp->node);
+			_dma_release_coherent_memory(mem_tmp);
+		}
 	}
 }
 
@@ -187,12 +184,17 @@ static void *__dma_alloc_from_coherent(struct device *dev,
 int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 		dma_addr_t *dma_handle, void **ret)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	struct dma_coherent_mem *mem_tmp;
 
-	if (!mem)
+	if (list_empty(&dev->dma_mems))
 		return 0;
 
-	*ret = __dma_alloc_from_coherent(dev, mem, size, dma_handle);
+	list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
+		*ret = __dma_alloc_from_coherent(dev, mem_tmp, size, dma_handle);
+		if (*ret)
+			break;
+	}
+
 	return 1;
 }
 
@@ -226,9 +228,16 @@ static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
  */
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	struct dma_coherent_mem *mem_tmp;
+	int ret = 0;
 
-	return __dma_release_from_coherent(mem, order, vaddr);
+	list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
+		ret = __dma_release_from_coherent(mem_tmp, order, vaddr);
+		if (ret == 1)
+			break;
+	}
+
+	return ret;
 }
 
 static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
@@ -271,9 +280,16 @@ static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 			   void *vaddr, size_t size, int *ret)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	struct dma_coherent_mem *mem_tmp;
+	int retval = 0;
+
+	list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
+		retval = __dma_mmap_from_coherent(mem_tmp, vma, vaddr, size, ret);
+		if (retval == 1)
+			break;
+	}
 
-	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
+	return retval;
 }
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
@@ -351,8 +367,16 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 static void rmem_dma_device_release(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-	if (dev)
-		dev->dma_mem = NULL;
+	struct dma_coherent_mem *mem_tmp, *q;
+
+	if (dev) {
+		list_for_each_entry_safe(mem_tmp, q, &dev->dma_mems, node) {
+			if (mem_tmp == rmem->priv) {
+				list_del_init(&mem_tmp->node);
+				break;
+			}
+		}
+	}
 }
 
 static const struct reserved_mem_ops rmem_dma_ops = {
-- 
2.43.0.594.gd9cf4e227d-goog

