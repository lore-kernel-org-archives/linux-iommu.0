Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094016;
	b=kDRydl8YArn3rHhjyR+nbORlMgEJGkzv0FlfnBYf3AKMzo8qoS4qjFjb6SzXiW9W/DTT
	 lzCdil2EsjUgaAlYKSeJ/YUM4fC+MEOB+EYRkJKSukhm98Odcan36xf37ArB1OV9Q+e9E
	 SEegfLI3GDumfTd68Z+JjHZhMA0nQ7PN4AdPTg8D1q6KT6w5UFoNem7hDpWbzzaHNzPSI
	 7JvVRXyDI5fvL0Z+J4I/U16clD47HnREsDF/9uq0Ai6UX0pVDJQ0ZH3f6gJmpCRlSSxKi
	 nPSFFUIoOxfgZFoItlStGpl7KrOqai8RWOe49HXhNDK3WnCA/C1IuYW2ImuAyteqGiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UhOenxHkXTJXohukC1vI//PmlFbZZlOM6f8rclEtEAw=;
	b=mJO1wJiB0IyxBnh3a/kxdr+qi866+1c8QsOYXY7BGwGKaliJ5yX2nQ4WqFky8TmjT3sp
	 fRAKgw+Hb0V07D5R1i4jYOk7YOR2WlK3yH9X+Xx57/xiu9P8icgE57zqjadcbMjhwbEnU
	 MB7V8eraT72UUlC+/X5uP1KPG9Aff69/XFwz1bo/3mLjXRmjZCPXrWtjnO0hMdgtznWxj
	 uNbaA1IBrUycmLSkvGSxjui+GBMm26zGTbeSPdvXpzD1Oo4qB4BLIl9qm4aozh5NNzzd7
	 FGyYMx+OZJo2u6KaVEY4EaWYfUPrcgduMeYpyCqBPs+Q3S2FZkue1mOxiLrQ4t1Yvug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dCIOZtnw;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDCD60A2610
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 13:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCDCD60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dCIOZtnw
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso21673965e9.3
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 05:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795094014; x=1795698814; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UhOenxHkXTJXohukC1vI//PmlFbZZlOM6f8rclEtEAw=;
        b=dCIOZtnwl+z6q/CYOI4t2pkU0nI98xCo5Zi/3WnVKo6pC8o/R0J/3dS+nXJqcqJp2/
         0AtEXFo3uV5Bpz2eI/HtsgyonEBvrEkt6o2KWqlnWhOA6IOnT+fmZKnlShkgtzoadupX
         RCxP9kgkMqigdkeSFJPrAOK4pioHKfUhW4QVNs9+M20aXLTxOqQv1mqMlFMNwe2R9j15
         D6qmnW0NftoyzaGkHSiGii6qnIa2uC16iqa4e4lYXlHahzK3QNe/7B/LgIxeoaEp165s
         Otx1e6U5HdAMn50jMmq0bqDqOJyKZDskl8O8ZSm+KCQ0lSDt9+DbMEWRcCCgNIlkg8WY
         byNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795094014; x=1795698814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UhOenxHkXTJXohukC1vI//PmlFbZZlOM6f8rclEtEAw=;
        b=CPYq5YRS0aq9Rz4GIsmRg7Lt/wt7PnPhwsaduRpf+QIEDBNSdG7Lp27MBAezHzZ8bt
         tMRxdkvvapV23AoM28H1RR0WJ8vLFwMc4xx4qf9dkFDX/Xd7V0Lt2PnPkO4FNOYVcNAg
         Rt2YiwLcxqsvQ0Pxbt3veJlqwmRt1LJAshE0DuLtUkVOVTBhQryY3MTVH1AvKNQhlX1L
         Xh1qbUoOa8k00wiU0SV0YtzIV+w96DHnqmvMwqRuCEOg9/PEvrWhV/vQedVlr/j8k+tV
         jZswLDblgNG+rO4VNiEV1WdArXzx/dDH9nZnbjUqD6tfD69xMftAyS5tkmIe5xhKRV9A
         ym1A==
X-Forwarded-Encrypted: i=1; AL+hErHVys4ouCCznRlBS9o0STEwuBvwwoEM9MWNCR8C8+MO7XnKxgCFGwsj+0HwOf9vV/SKKDR8Ug==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Gtdt5iT41lBbGuxhSeIFfu3wSp7THlsYR0hCUfqeEwc/bycB1
	y6eYr2/6uY28mscPek4gxv3ySsF90FLqVomnLb1h+skAw0CT8LxLPjDX
X-Gm-Gg: AYBFou3HDQp/sohWaQyu9ydqDxLP65eSvVGhTNwJZhg+Vu+c9q5IefUVx91eMqNSez3
	xkTDKyPK2jPKkfsBkIFFk+sIRpt/gsiiUOD6/QDppQdkLrzciZc63swIt+2p48P6sA6tDhPjQ+0
	KxcF8LWcMNwXOB6dnswqPnNiUgiV54pugQU1TQ65xQlIrVq6W+WqfW0xJ+BlMmr/56fjFVNDagM
	3dcADIumPfhwY6dPA7p7FR14KGvlO7FeK/dOoLAISx1T2yrFvGKWKnHzdK5P3I9LHb61AXXBn/b
	3ci0f0Ot5tONlCt/jBMTOO8Mhk6St1SjWyrHfFfVwXKqs+/MMytqk0KCkG94bTKpJWXNWlJiuhh
	qrEnF4iHlv0EjQgIvv6MptaJNWF6HVyeMEJobvk+B8e99o8ImZFciSHu42MDYMpNoxqIzSFOKuk
	pAFpyf6wxTfqKcqFcUAoqkHLcZo/hMdaQezLFJBiMwihk2Ov8Y/5ZyRuE68EHOQLQtV8uQYqKQl
	ifgkoYZXIz+H9rAf7e4h2h91Ed2tPlLMkQeMFZkiTJBPLhL+xGLqw+yZQgJwMZ3iHIR5GpcBXGo
	+DPXsNY3AfGaUOsm/F48pGG6MAxVDp5sDu+t
X-Received: by 2002:a05:600c:1395:b0:4bb:5de1:e92c with SMTP id 5b1f17b1804b1-4bb7da3947emr122657995e9.26.1795094014044;
        Thu, 19 Nov 2026 05:13:34 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:477f:ff00:c2fd:f9b8:4971:d270])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e5edf5sm18258045e9.4.2026.11.19.05.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:13:33 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: ailiop@suse.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH v2 2/2] dma-debug: Remove obsolete mapping dump helper
Date: Thu, 19 Nov 2026 15:13:25 +0200
Message-ID: <8d79f918823590770607279958d16fdd750d5829.1795093513.git.thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795093513.git.thnkslprpt@gmail.com>
References: <cover.1795093513.git.thnkslprpt@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debug_dma_dump_mappings() is only called by the legacy AMD GART IOMMU
leak diagnostic. The helper traverses DMA-debug hash buckets even when
DMA debugging was never initialized.

Remove the helper, its declarations and the GART call. Keep the GART
stack trace for diagnosing IOMMU exhaustion.

Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 arch/x86/kernel/amd_gart_64.c |  1 -
 include/linux/dma-map-ops.h   |  4 ----
 kernel/dma/debug.c            | 33 ---------------------------------
 3 files changed, 38 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index b5f1f031d45b..965844299a1b 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -157,7 +157,6 @@ static void dump_leak(void)
 	dump = 1;
 
 	show_stack(NULL, NULL, KERN_ERR);
-	debug_dma_dump_mappings(NULL);
 }
 #endif
 
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index afaf2c12189b..eb32ed923455 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -418,14 +418,10 @@ static inline void arch_teardown_dma_ops(struct device *dev)
 
 #ifdef CONFIG_DMA_API_DEBUG
 void dma_debug_add_bus(const struct bus_type *bus);
-void debug_dma_dump_mappings(struct device *dev);
 #else
 static inline void dma_debug_add_bus(const struct bus_type *bus)
 {
 }
-static inline void debug_dma_dump_mappings(struct device *dev)
-{
-}
 #endif /* CONFIG_DMA_API_DEBUG */
 
 extern const struct dma_map_ops dma_dummy_ops;
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 6e554dcfc9b9..f1b6f7b9aa14 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -535,39 +535,6 @@ static void active_cacheline_remove(struct dma_debug_entry *entry)
 	spin_unlock_irqrestore(&radix_lock, flags);
 }
 
-/*
- * Dump mappings entries on kernel space for debugging purposes
- */
-void debug_dma_dump_mappings(struct device *dev)
-{
-	int idx;
-	phys_addr_t cln;
-
-	for (idx = 0; idx < HASH_SIZE; idx++) {
-		struct hash_bucket *bucket = &dma_entry_hash[idx];
-		struct dma_debug_entry *entry;
-		unsigned long flags;
-
-		spin_lock_irqsave(&bucket->lock, flags);
-		list_for_each_entry(entry, &bucket->list, list) {
-			if (!dev || dev == entry->dev) {
-				cln = to_cacheline_number(entry);
-				dev_info(entry->dev,
-					 "%s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s attrs=0x%lx\n",
-					 type2name[entry->type], idx,
-					 &entry->paddr, entry->dev_addr,
-					 entry->size, &cln,
-					 dir2name[entry->direction],
-					 maperr2str[entry->map_err_type],
-					 entry->attrs);
-			}
-		}
-		spin_unlock_irqrestore(&bucket->lock, flags);
-
-		cond_resched();
-	}
-}
-
 /*
  * Dump mappings entries on user space via debugfs
  */
-- 
2.43.0

