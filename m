Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8B01474CC
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774615329; cv=none; b=At0nUAu7VlvA8tt6rwcGCrqfFt4uFeMayT9Zu+hpTfFSfIGOFPWJzQW5f/zjGaBzdVKlHETo+aix4w1POU6KdgSlyl2FCra5nnwtVF1kzzOjh8HpP+Gizn6OWXTlIslR8EvkFpHFEh4hqzQfWhPfJ+Em6FON9mlEFMH5AEeX0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774615329; c=relaxed/simple;
	bh=B3tp398WNbwm1ae+gWHLUuGz3BxoORfZ1NVIHaytnAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=btxP/7SnxYW6Ap4ZrnmVRxguvBjavz1uAvuDyzzppopcEdukKD/DTEGgLmPrWPvcRx2BhVPAbyXoVU0BjNXlvxaPP8IERmDekK4nvZX7A5+fweGjI9JqlfFfQSrQJzzUynKL0U8R/9AWSz2jID3MzI8ZR+X0ORA4BQ541QDKoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klBQ6F/f; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klBQ6F/f"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a27b5ad832so2325268e87.2
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 05:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774615326; x=1775220126; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vnEhmrhTPA7Nd81/VP3XZfiniWMenGZwrrUyIBlvmYM=;
        b=klBQ6F/fqTZIwBzIENCQwrS+MpoTKpWg4Cj9GX2O8verSsNQaaS3cZhJjw3Fw3GOOf
         dLRrNfuclUwzuye+ocPLZInobYTf8GeDIQqXo/QEyb792v2xSa9AtwRVbvkWMBf2DZRS
         bwdu7CmYzsADa3iWH6RVNz8SQVjK86t3BVW5gBtqVyfhSxSVvnw803FMa1YhLoNfNla9
         BX2z3b8zU3FM0pt53+zZvsOcO/TCARIwncyBHDXhO9mBc2ITH0hPn97l5u+s1qG76wVj
         Vy9szC5lpZGo5pLmnAmM//vUcUuCZlhqVuK8dWG64k4gbvrcpKAes5XNXpfuqbJd/T8V
         SvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774615326; x=1775220126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnEhmrhTPA7Nd81/VP3XZfiniWMenGZwrrUyIBlvmYM=;
        b=jGW+bzXcKHeKCQfynzFKbj45qGMvCm1a//LmygJmTDjdBFbV/VbN0k0RNdXkr1YTB5
         bRp8JDxgktrh2SIqqfJLGGh6batgGuI5CoOxz9TERoGTvQOC0r8zPxJfmniCN7LqTvvA
         W7Vw8PdXl73VPo+czW7xixUYoQeWaFY/quYUoVnT3wU/kxKm6oDO3M/qFtTaXbacA62y
         iFjvA5nRUsh9hN5QHArT4ju1J3HYRg+Vbg+nMneRtNrI+iqqOwAJbdUf/TqVGKoWRdz0
         bkVIx8sjs65+6dFEb3CKjiTDz14ADl7l64yNpINUy1iq8u/kso2C2ur90XyPug0XT351
         ANDA==
X-Gm-Message-State: AOJu0YzHGyF/wga/UGWMsayWfXNEDfAA3k+w7/lQW0G73PnMTa54XGfO
	oV+SDEjJyVsfa2i7CI2QpINsXaToW7X/CY82/IhYJeeaBm99GlRHd6zc
X-Gm-Gg: ATEYQzyGhxzyTxxuIZnoa8MwiMOjyogq0C1kRmHEHbTlS+lYI+MMjU9x2UUn9k+nj7G
	q8q5nu5D/+EUCDn97kciXtHzzhgIrcl4DqIpgvLfcw4kOx6BZMknkSr6/eppUrSEFeqkuaPcsdF
	OWq9tiXddHUW45mfX1fZvZMUfbIo/uv59/LDZn257RfeO+yQjJh3aRgfmv0o9NWKgnKBQn1HGZA
	LlykB8UOYBb/O+3fzHIaA98QWXqgf0UY0cY6To/k7J9Vb+aRJFUk18vdZmSXwvLZCiJO20rVXIi
	BkgjYcmG2zifn88m77It0qIV813CVMwOvWvfwOdfRDRILrPSreCcXZSxzzn4YtywaFOtjg1fEf0
	Pi4V+LlrEDR/RNuwB6plI3OXY5/lgiQlxpZou3UoDkaeCYtnfN65A2uTD2JJ7Sne41xvkCXBqTi
	IdUaQWzNtiJ9+RvNj77SjByz4gcPBW0co0xw==
X-Received: by 2002:a05:6512:6c8:b0:5a2:5b88:a8a3 with SMTP id 2adb3069b0e04-5a2ab92854fmr1015552e87.31.1774615325628;
        Fri, 27 Mar 2026 05:42:05 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2a063efbasm1336127e87.14.2026.03.27.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 05:42:04 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-mm@kvack.org,
	harry@kernel.org,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	stern@rowland.harvard.edu,
	linux@roeck-us.net,
	andy.shevchenko@gmail.com,
	hch@lst.de,
	Jeff.kirsher@gmail.com,
	catalin.marinas@arm.com,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] dma-debug: suppress cacheline overlap warning when arch has no DMA alignment requirement
Date: Fri, 27 Mar 2026 17:41:56 +0500
Message-ID: <20260327124156.24820-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_DMA_API_DEBUG is enabled, the DMA debug infrastructure
tracks active mappings per cacheline and warns if two different DMA
mappings share the same cacheline ("cacheline tracking EEXIST,
overlapping mappings aren't supported").

On x86_64, ARCH_KMALLOC_MINALIGN defaults to 8, so small kmalloc
allocations (e.g. the 8-byte hub->buffer and hub->status in the USB
hub driver) frequently land in the same 64-byte cacheline.  When both
are DMA-mapped, this triggers a false positive warning.

This has been reported repeatedly since v5.14 (when the EEXIST check
was added) across various USB host controllers and devices including
xhci_hcd with USB hubs, USB audio devices, and USB ethernet adapters.

The cacheline overlap is only a real concern on architectures that
require DMA buffer alignment to cacheline boundaries (i.e. where
ARCH_DMA_MINALIGN >= L1_CACHE_BYTES).  On architectures like x86_64
where dma_get_cache_alignment() returns 1, the hardware is
cache-coherent and overlapping cacheline mappings are harmless.

Suppress the EEXIST warning when dma_get_cache_alignment() is less
than L1_CACHE_BYTES, indicating the architecture does not require
cacheline-aligned DMA buffers.

Verified with a kernel module reproducer that performs two kmalloc(8)
allocations back-to-back and DMA-maps both:

  Before: allocations share a cacheline, EEXIST fires within ~50 pairs
  After:  same cacheline pair found, but no warning emitted

Fixes: 2b4bbc6231d7 ("dma-debug: report -EEXIST errors in add_dma_entry")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215740
Suggested-by: Harry Yoo <harry@kernel.org>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v1 -> v2:
  - Moved fix from include/linux/slab.h (ARCH_KMALLOC_MINALIGN)
    to kernel/dma/debug.c per Harry Yoo's suggestion.
  - Instead of forcing cacheline-aligned allocations, suppress
    the warning when the architecture has no DMA alignment
    requirement (dma_get_cache_alignment() < L1_CACHE_BYTES).

v1: https://lore.kernel.org/all/20260327055846.248829-1-mikhail.v.gavrilov@gmail.com/

Reproducer module that triggers the bug reliably:
  https://bugzilla.kernel.org/attachment.cgi?id=309769

 kernel/dma/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 0677918f06a8..1a725edbbbf6 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -615,6 +615,7 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 	} else if (rc == -EEXIST &&
 		   !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 		   !(entry->is_cache_clean && overlap_cache_clean) &&
+		   dma_get_cache_alignment() >= L1_CACHE_BYTES &&
 		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
 		     is_swiotlb_active(entry->dev))) {
 		err_printk(entry->dev, entry,
-- 
2.53.0

