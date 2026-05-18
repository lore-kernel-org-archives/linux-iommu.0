Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC993F20F4
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103983; cv=none; b=tib+ShmNvy06JwfiTru0rX13HgYOYTv3RTh/LJ5GBuelaMV+jsO1tkgdxd/iQ3IuG5adwAht2ywK/Suml5/b87DdByWwuE4xhxwZ1W19AE0JMJ11lu8lPprNfnHJmADZzMnSc+9rlvEefqjO2v8S0OhFDafsdeYTtXVGRxtrw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103983; c=relaxed/simple;
	bh=RJWstnPwMeFt+IyKVb11wv2216Fz1HIRtY5LHVF/Ouc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmPZH9xFxMmJI03xARTGrat8Mr/XxEmBeX5nEWfg9TVWUOjjaP5ioSWnQ0vPPRjT7g+H0DK8EiwyKfFTr7N9yL35CZdEgk5E3UmVGEJn3LR5ZUVnTyo//buWLVdaNkL6fK7Spskx/YZt8hGEE1Bl019u1kuXFCTPR0wRhk0vkLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1hWC1QG; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1hWC1QG"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a8891f0c51so2349308e87.1
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 04:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779103977; x=1779708777; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v5Hzt13YTTWOWMVMt3KTq767/BlWjWJAOzpQdOL+rYk=;
        b=m1hWC1QGGtO8PSsq8kn4Da9aW+b0a9eyiLl7fFUenrt6lnL2DwqLjp82JobrAvtdr1
         nYSGjcGuD5YVCgfCXqUmo79ni5FprG2jYikzNOmczLiL+cxERwqkzKbhJf15FlxB3JNp
         YA7KkUKL+fhKt4BYBU/1XLO6iGXVhEI9lovlXZ3m8vgeje2SsvwQw0iEiRTHFA2mclaf
         MvinO7B+M/0YKeRtPM7Gw1KEaZY5he54q1Xx/hgmDmF9Ih5SA7XTjuMuyXMy2NOd8WCG
         WrpTJ/d/BTxtRC6ELK/zVeoEMrMsHCGBAU+tT4sTZjZbC5OFfQln63OIFHf/PnzCsL21
         yXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779103977; x=1779708777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5Hzt13YTTWOWMVMt3KTq767/BlWjWJAOzpQdOL+rYk=;
        b=JGMZbH9IIQeP09fHyZFss+2+Fd0AMI51J7CklLBxo+iLSeC6WXFLIFOz2926bLSELA
         3sgCksPI4KWZF7ABR1wohos3VbR2rgpcx6ZTmveXfAbd8dAbcLqZhuyU9UKHXbLpqWT3
         +88jG5dhoP/AZgouIEx7o3aNo5MpHulpyVbJaRlaYeBIFXK8MVH3nspW8/s8mCN6YfjH
         jjOXuI8H7+Dc1CPikY/U5YmYgNGnXXw0Rsmw46tBtwVDM0BeUTNg9vXe3QPc5DxAr/dR
         /hIR5CCv00y5qq8Ux7DXvJKUp0zLDD23FzjHEwSUtTq1Y5hq1lQ3E4Tq+XVjiyOTmtf1
         knQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/l36efcSn2K89zu3hi5RS6aA8/9CiP1Aj6qLF6ZxIICss8yRwP4AvhlU9v9FKIas1Nvjnu2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBeQc08v0m8LmxIc5F9R4Oau2lCQ5bDwk0+CPQlcg5d2RHtx1G
	MMKqhxNZz3s9zTAhp1j0s3lJQbrDa/GIgSfvL9dwpJbEyrh4jlY5x9rG
X-Gm-Gg: Acq92OGkr6YFfqEweKLtUE7eHH2PycixZhnDnaokA95RsAcW5xgjY+Tml5CNC7TTZSI
	mWohWPxUTeTqjNCb2RsSTBGgJPjVijwnuhIR5M2bfXyJBkcuzW+FDAIoVZhbaxQ46h7PE/QY/As
	2RsM4OfTUJow5Y3EVSMvBTzYvQrCpvELaDbs1Ezv+OLUpoeNV0IC6AL+NSV0jEcLlwSGA0Nnukd
	0+Omqxndjl80A+MDKGCZSczyHf+H+4UtV07EYiT6AGoXLHmw0X+QDdv+HFaVoYvDxjYJN2L0Tec
	3DFTCpdp4MrrfYM2lHYP1U4jxciJNzYa8wl9P2NQnmOjoM+Dpr2ib1iNaKU3HiGExCyb3wgeRys
	TqWJobl3dcjDZViOncKyaMAlUBQeDibmrmAknqbOrZ3hORMOUE8E2wRl3l4/ZIogcrGsH2nzNui
	mdSPR+xcQ11sA3RqvCa1m/ywKvza4KvATrrHux8U1F7Ww=
X-Received: by 2002:a05:6512:32c6:b0:5a8:8870:70fe with SMTP id 2adb3069b0e04-5aa0e60b31dmr4206317e87.8.1779103976737;
        Mon, 18 May 2026 04:32:56 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958874ffbbsm11403481fa.27.2026.05.18.04.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:32:56 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: m.szyprowski@samsung.com
Cc: hch@lst.de,
	robin.murphy@arm.com,
	djbw@kernel.org,
	akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	harry@kernel.org,
	ming.lei@redhat.com,
	leon@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] dma-debug: skip cacheline overlap tracking on cache-coherent architectures
Date: Mon, 18 May 2026 16:32:51 +0500
Message-ID: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma-debug cacheline overlap tracking emits two distinct warnings
when multiple DMA mappings share a cacheline:

  1. add_dma_entry() calls err_printk("cacheline tracking EEXIST,
     overlapping mappings aren't supported\n") on every -EEXIST from
     active_cacheline_insert().

  2. active_cacheline_inc_overlap() calls WARN_ONCE("exceeded %d
     overlapping mappings of cacheline %pa\n", ...) when the 3-bit
     per-cacheline overlap counter in the dma_active_cacheline radix
     tree would saturate past ACTIVE_CACHELINE_MAX_OVERLAP (= 7).

Commit 3d48c9fd78dd ("dma-debug: suppress cacheline overlap warning
when arch has no DMA alignment requirement") suppressed (1) on
architectures where hardware bus snooping makes cacheline-overlapping
DMA mappings safe.  The same reasoning applies to (2): the tracking is
pure overhead on those architectures, and (2) still fires under real
workloads, e.g. heavy NVMe block I/O on x86_64:

  DMA-API: exceeded 7 overlapping mappings of cacheline 0x...
  WARNING: kernel/dma/debug.c:465 at add_dma_entry+0x394/0x410
  Call Trace:
   add_dma_entry+...
   debug_dma_map_phys+...
   dma_map_phys+...
   blk_dma_map_iter_start+...
   nvme_map_data+...

The block layer routinely produces nine or more concurrent in-flight
mappings whose buffers share a single cacheline.  On hardware-coherent
systems this is harmless, but it saturates the tag-based overlap
counter and produces a splat indistinguishable from a real driver bug.

Extend the gate to skip the cacheline overlap tracking entirely on
cache-coherent architectures, mirroring the DMA_TO_DEVICE early-return
that already exists for the same "tracking is unnecessary" reason.  The
helper dma_debug_cacheline_tracking_needed() captures the condition and
is symmetric to the existing add_dma_entry() check.

The same DMA_BOUNCE_UNALIGNED_KMALLOC + SWIOTLB suppression that
commit 03521c892bb8 ("dma-debug: don't report false positives with
DMA_BOUNCE_UNALIGNED_KMALLOC") added to (1) applies here for the same
reason: unaligned kmalloc buffers are bounced through aligned swiotlb
buffers, so the original cacheline overlap never reaches DMA.  The
helper preserves both suppression conditions.

Reproducer (out-of-tree module): map a single 8-byte buffer with
dma_map_single(..., DMA_BIDIRECTIONAL) nine times in a row.  The 9th
call deterministically fires the WARN_ONCE on an unfixed kernel; with
this patch applied no warning is emitted regardless of the number of
overlapping mappings.

Without this patch (n_maps=9):
  DMA-API: exceeded 7 overlapping mappings of cacheline 0x00000000071d7dbe
  WARNING: kernel/dma/debug.c:465 at add_dma_entry+0x39e/0x410
  [...]

With this patch (n_maps=1000):
  dma_debug_overlap_repro: 1000/1000 mappings active
  [no warning]

Link: https://lore.kernel.org/all/ZwxzdWmYcBK27mUs@fedora/
Fixes: 3b7a6418c749 ("dma debug: account for cachelines and read-only mappings in overlap tracking")
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 kernel/dma/debug.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 1a725edbbbf6..2d1609b9d362 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -474,6 +474,35 @@ static int active_cacheline_dec_overlap(phys_addr_t cln)
 	return active_cacheline_set_overlap(cln, --overlap);
 }
 
+/*
+ * Whether cacheline-overlap tracking is meaningful for @dev.
+ *
+ * Mirrors the suppression conditions add_dma_entry() already applies to
+ * the sibling "cacheline tracking EEXIST" err_printk:
+ *
+ *  - On architectures with hardware DMA cache coherence
+ *    (dma_get_cache_alignment() < L1_CACHE_BYTES, e.g. x86_64) bus
+ *    snooping makes overlapping cacheline mappings safe.
+ *
+ *  - With CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC and an active SWIOTLB,
+ *    unaligned kmalloc buffers are bounced through aligned swiotlb
+ *    buffers, so the original cacheline overlap never reaches DMA.
+ *    See commit 03521c892bb8 ("dma-debug: don't report false positives
+ *    with DMA_BOUNCE_UNALIGNED_KMALLOC").
+ *
+ * In both cases tracking is pure overhead and produces false-positive
+ * WARN_ONCEs.
+ */
+static bool dma_debug_cacheline_tracking_needed(struct device *dev)
+{
+	if (dma_get_cache_alignment() < L1_CACHE_BYTES)
+		return false;
+	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+	    is_swiotlb_active(dev))
+		return false;
+	return true;
+}
+
 static int active_cacheline_insert(struct dma_debug_entry *entry,
 				   bool *overlap_cache_clean)
 {
@@ -490,6 +519,9 @@ static int active_cacheline_insert(struct dma_debug_entry *entry,
 	if (entry->direction == DMA_TO_DEVICE)
 		return 0;
 
+	if (!dma_debug_cacheline_tracking_needed(entry->dev))
+		return 0;
+
 	spin_lock_irqsave(&radix_lock, flags);
 	rc = radix_tree_insert(&dma_active_cacheline, cln, entry);
 	if (rc == -EEXIST) {
@@ -516,6 +548,9 @@ static void active_cacheline_remove(struct dma_debug_entry *entry)
 	if (entry->direction == DMA_TO_DEVICE)
 		return;
 
+	if (!dma_debug_cacheline_tracking_needed(entry->dev))
+		return;
+
 	spin_lock_irqsave(&radix_lock, flags);
 	/* since we are counting overlaps the final put of the
 	 * cacheline will occur when the overlap count is 0.
-- 
2.54.0

