Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1003AEF3E
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554543; cv=none; b=RcRC2398K5eqXYxBmOYyQT9Yl2/iAQDm7YM86LuVYFeWEw+xoUK8blg7emS91BpCH8GuWNS6Tlqmsp/coynmMy2NMR8Zx/Q6G5qf1lJYYU7tdM3aZ4YjvtrCVgeWyVkCF+6d498a/+ZwDOJ8adz2RN5gI3XrlE+wtUQcwMwAapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554543; c=relaxed/simple;
	bh=RdRwHLtqxvz/z/PEiPampV1fF/tsKEjDL2KcdgvCuhU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CkfNGifX99wWSJ/tlZYOeV1RK3FlrquBSJxGHnCq7yxT7+m79plrhrJJCXHkkKkzNFzoe8O1An5CL3eAPKqeiDRoa1Tk4hqd9uTiN16N6M++Nin4OGVShNi/h+6tZKhiu3HlNDJ3R1eUPMsOA0r7fiW81Pgj3ySkdJMpUE8ydU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=doYpKvME; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="doYpKvME"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8479b45ad08so1819429b3a.3
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 16:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554540; x=1784159340; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+S3FWpLmbV8ubn+1hh1NL45mx9rPGtnbGgWXMOw/Cc=;
        b=doYpKvMEqql1E+WsE53lKtpvI5Vh9dCLcNU0WJCTgS/rEZLt36tnu236kcfbUjeYCa
         jsaa/szI8rss+onK0AeKk13bSojzSTqd4HJl80hXZgtDf/zmIJBuSLLkct5v041GfgQm
         aIkT6HyYKJ1WldUEMYOD7dIWDnf7lu6VhCyGaR5MSsd791gfhjKe96Lxv2vEir+NEjMW
         lE83y0mxpdqttO4eHDs958jOAzVY+FftqpU/MFG6UzNjzs+loRKEyhcpEAy90TG8YNyf
         /Be8MjOiG0br0zeIA0OL8A0d2nGpxK6/HPcQ8aO69lPS2kKgVAiGJhG7X1II5F5hl5Bz
         PB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554540; x=1784159340;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+S3FWpLmbV8ubn+1hh1NL45mx9rPGtnbGgWXMOw/Cc=;
        b=gzy6KJiCNCU8cKd+iMkL2aTbYve7jXJLC7xLU8T4FxxAYYgGuvSeW8y46USOBgeeJw
         sQLrqbjDzuaFt6BmmeGblVK9m0an2VbcNzJZPHMpIGt3m3Ud0D8foVghldCfRMT4/pZa
         KW9zyJtsHUq57vyHQb/e2D6YwJEiotept+kY001VQw7kjkV05HobV1fyiseU5ABS6YoV
         FehjQ9s3YQKNPYoJw6L5ZEMYy2uR+EIM94N/hCTDekTBcOYEiq0Mi9LCtWWxt4zYFVJx
         2W/LMhzKXa8I7mGUpaFoDzLJWLidR/5e/DvJ0N3W+NEWGqLXWiXbAcsKc4uctzHZB0Js
         vlog==
X-Forwarded-Encrypted: i=1; AHgh+RrOPoWR3mYHYTRbdotn3KzY4HNcWoM1p+KVg397cNTumSgXoqwSr7IHcwNX3ZzgiY6WE7wYcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdmHlf/yH3RoJ0XvxCKA4TY6K0Ptdbnw5uayvP6qDYxc8zzVu8
	a9yS/hyBCkRb5jo3K8R43aNi+2WmYuYvePMRlSEoZOSoxfSVRLdg3+bQqq3xn6t1hSi3Q1LvZfl
	bRBmS85AGySp+NA==
X-Received: from pfqp3.prod.google.com ([2002:aa7:9e83:0:b0:847:9570:daf0])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8f0b:b0:842:708f:39be with SMTP id d2e1a72fcca58-84842fdf097mr4788740b3a.5.1783554540334;
 Wed, 08 Jul 2026 16:49:00 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:50 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-7-skhawaja@google.com>
Subject: [RFC PATCH v2 06/10] dma-mapping: Add API to preserve/restore DMA allocation
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add new DMA APIs that allow preserving/restoring DMA allocations across
live update.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-mapping.h | 50 +++++++++++++++++++++++++++++++++++++
 kernel/dma/mapping.c        | 49 ++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index db8ab24a54f4..3756fc15467b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -210,6 +210,15 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
 void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
 int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct sg_table *sgt);
+#ifdef CONFIG_DMA_LIVEUPDATE
+int dma_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+				  size_t size, dma_addr_t dma_handle,
+				  unsigned long attrs, u64 *state);
+void dma_unpreserve_allocation(struct device *dev, u64 state);
+void *dma_restore_allocation_attrs(struct device *dev, size_t size,
+				   dma_addr_t *dma_handle, gfp_t gfp,
+				   unsigned long attrs, u64 state);
+#endif
 #else /* CONFIG_HAS_DMA */
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 		struct page *page, size_t offset, size_t size,
@@ -496,6 +505,26 @@ static inline bool dma_need_unmap(struct device *dev)
 }
 #endif /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
 
+#if !defined(CONFIG_DMA_LIVEUPDATE) || !defined(CONFIG_HAS_DMA)
+static inline int dma_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+						size_t size, dma_addr_t dma_handle,
+						unsigned long attrs, u64 *state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void dma_unpreserve_allocation(struct device *dev, u64 state)
+{
+}
+
+static inline void *dma_restore_allocation_attrs(struct device *dev, size_t size,
+						 dma_addr_t *dma_handle, gfp_t gfp,
+						 unsigned long attrs, u64 state)
+{
+	return NULL;
+}
+#endif
+
 struct page *dma_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
 void dma_free_pages(struct device *dev, size_t size, struct page *page,
@@ -618,6 +647,27 @@ static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
 }
 
+static inline int dma_preserve_coherent_allocation(struct device *dev, void *cpu_addr,
+						   size_t size, dma_addr_t dma_handle, u64 *state)
+{
+	return dma_preserve_allocation_attrs(dev, cpu_addr, size,
+					     dma_handle, 0, state);
+}
+
+static inline void dma_unpreserve_coherent_allocation(struct device *dev, u64 state)
+{
+	dma_unpreserve_allocation(dev, state);
+}
+
+static inline void *dma_restore_coherent_allocation(struct device *dev, size_t size,
+						    dma_addr_t *dma_handle,
+						    gfp_t gfp, u64 state)
+{
+	return dma_restore_allocation_attrs(dev, size, dma_handle, gfp,
+					    (gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0,
+					    state);
+}
+
 static inline void dma_free_coherent(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle)
 {
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 23ed8eb9233e..3b07bf30722c 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -12,6 +12,8 @@
 #include <linux/gfp.h>
 #include <linux/iommu-dma.h>
 #include <linux/kmsan.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/dma_alloc.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -628,6 +630,53 @@ u64 dma_get_required_mask(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 
+#ifdef CONFIG_DMA_LIVEUPDATE
+int dma_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+				  size_t size, dma_addr_t dma_handle,
+				  unsigned long attrs, u64 *state)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_is_from_dev_coherent(dev, cpu_addr))
+		return -EOPNOTSUPP;
+
+	if (dma_alloc_direct(dev, ops))
+		return dma_direct_preserve_allocation(dev, cpu_addr, size,
+						      dma_handle, attrs,
+						      state);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(dma_preserve_allocation_attrs);
+
+void dma_unpreserve_allocation(struct device *dev, u64 state)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_alloc_direct(dev, ops))
+		dma_direct_unpreserve_allocation(dev, state);
+}
+EXPORT_SYMBOL(dma_unpreserve_allocation);
+
+void *dma_restore_allocation_attrs(struct device *dev, size_t size,
+				   dma_addr_t *dma_handle, gfp_t gfp,
+				   unsigned long attrs, u64 state)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	void *cpu_addr = NULL;
+
+	WARN_ON_ONCE(!dev->coherent_dma_mask);
+
+	if (dma_alloc_direct(dev, ops))
+		cpu_addr = dma_direct_restore_allocation(dev, size, dma_handle,
+							 gfp, attrs, state);
+
+	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
+	return cpu_addr;
+}
+EXPORT_SYMBOL(dma_restore_allocation_attrs);
+#endif
+
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs)
 {
-- 
2.55.0.795.g602f6c329a-goog

