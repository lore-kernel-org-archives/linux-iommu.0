Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79348330D22
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466639; cv=none; b=bkbTFk6PgERgaqVNudN8RJrmNwkiPEsrbGc8SFGZ1YRXgs5SD0HUTlDanxoZ1qyXKyD1xEMVNeqVmBTDvHV0BpjXAWg++AlivEX3wZz/irvAx2Sp1KKY8IqqP4JAErJwmFXb6AisKMdRlGHjwkDw3nj7+0MgSeu975Ms6MOUtbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466639; c=relaxed/simple;
	bh=OvQSPP2jw/fFSL7LjhGRg/VLBAZ7+z7wdrvtVgyUR68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O29CsXzW3ctXeQWr9DlLej6nkbajuRN49yDRzXLPSD4E08nL5Bigbu3EDoMaHTnY4zxe46b4aT238QZ9Lpgh2p326dTXcXTsf97DOHgBjSGO2bhFdyP5YQ+O7+w+ykRJY4BmHskgCb20lNMZi37KpCKTY8eAb5zKtzP9Cnt+qAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lixlzw5q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lixlzw5q"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fda2a389so1725805e9.1
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774466635; x=1775071435; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMfoKT234OWAIu2ygAH4xOQ0BTmCnNSAwf62AjGD0Kg=;
        b=lixlzw5qeQX3kfsjoK+aPUui+iSYqBVvps5za0vhljTZYufsQjTuHTTAJUN6+t/P2B
         2V/5kOAd0WwPMVyO8keLltYlsiKkeSTY2B8wkL1yUEUPbod436gM16l37wSKzDVBlNuy
         b0BCm+lITvr4eG684355S4cSoutGEr+CyhRmVMsMAyiCBt2fgLUIKd2xguzmXv/i5d5c
         AURf2vY+Uvrxiqck18lDn3n7D8Qn2kKffkNBcZQOqZ1iAbesH3twizqt7k/usl9T2i4r
         /NHGn6YECdPj+BRP6boyvjICTYgZgjG9GM+gEKNZ3B0SwqwgzndeY/bIpUVjElw5YfP2
         /elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774466635; x=1775071435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YMfoKT234OWAIu2ygAH4xOQ0BTmCnNSAwf62AjGD0Kg=;
        b=mkQ4z9gSMjBKEuAdOouomCWsqzEKm231Xws/LbRsHGwXLCYpx38swXcYR5MK10JdFf
         Je7vgP3QlueDlNpW59y9rLlpAwSdsgK4tYOQ7+5+50sBSb31TR7j2ozqBlNLjouNOmvF
         +QWadURZFndzSxdE7eCAiWbZlRJOUGG9AfEYN6wJviXqnm0Rn/ECPbsBI9O3r0PEf1ts
         JVmaGGu/fAR/gL9ujstYZvSkWf5PgBmmJIcCVCuBCtJA5N3Jen9AHAOiuwgXeMjln7UQ
         BEtsp8Mo2QL+uTLsKuMFiuYOk8dWr8+E00fzf8e0fDL//nWH8VVSYFY+s1sQdOJ/CQUz
         xPlA==
X-Forwarded-Encrypted: i=1; AJvYcCVG4UJKSveOjW6Y5E7PtLEjHuzNL2JODE442qYusvWEDYJmCcVJLU0EF/Xf/yOgqkpjT2beWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxbzflQ2SB1s1Ttswx38Qf5g4b0uFfABfQ3GoKQCX5NrY5sy8K
	MaQTr4m6BpyTIM7ht8FE3kT/HBfp1tGj69rnX/ETbWMJw0DANMKM4PDXgifBVaTtEWc=
X-Gm-Gg: ATEYQzzPXKwbG49D4ZS9WO0BwsyU7FabYHXuMi63ZBkibKhVyynF56QF1p2phDV9hmI
	0PeRqQ3m3esUXpU5x8C1eLVRtzV+Z+r+a7uRRDApo9RX6P/dw3zwQL2UIrbpZ7gqzvhYx4te3zm
	YqjRIIFva04LEwPUY07BkK5KI3BegAXIpy7R1tPyCn/jm31o43MKJnpA4PZPq1gOLHWSa6fwktU
	jB0i7KoEAaIm9UW2XopkP0b/cXSLMNslbHAPNlvM4yTnUvLPM7mIhdY4Y6+9seucKm5Ly0K/qvO
	lNzcCKmosRJIvnvmaqX3GR2FrUUUdmO/It8e+et84AJ5pI9p62nnTzDZgX+BO2cyrxDKYlXI9NA
	1moy6Y7tNjAVu93jQTt53zmCG0BU4s5IRDjskBCpIZrmdDrnnrnD7BIXDG+z6+yJfI9YOuP5TzH
	CVrE6i2cy5pE5m7QRi/g==
X-Received: by 2002:a05:600c:c4a4:b0:485:1878:7b8c with SMTP id 5b1f17b1804b1-48716056512mr65908275e9.18.1774466634748;
        Wed, 25 Mar 2026 12:23:54 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711702191sm146523035e9.5.2026.03.25.12.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:23:54 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com,
	jstultz@google.com,
	tjmercier@google.com,
	christian.koenig@amd.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	sean.anderson@linux.dev,
	ptesarik@suse.com,
	catalin.marinas@arm.com,
	aneesh.kumar@kernel.org,
	suzuki.poulose@arm.com,
	steven.price@arm.com,
	thomas.lendacky@amd.com,
	john.allen@amd.com,
	ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for shared memory
Date: Wed, 25 Mar 2026 20:23:51 +0100
Message-ID: <20260325192352.437608-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325192352.437608-1-jiri@resnulli.us>
References: <20260325192352.437608-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Current CC designs don't place a vIOMMU in front of untrusted devices.
Instead, the DMA API forces all untrusted device DMA through swiotlb
bounce buffers (is_swiotlb_force_bounce()) which copies data into
shared memory on behalf of the device.

When a caller has already arranged for the memory to be shared
via set_memory_decrypted(), the DMA API needs to know so it can map
directly using the unencrypted physical address rather than bounce
buffering. Following the pattern of DMA_ATTR_MMIO, add
DMA_ATTR_CC_SHARED for this purpose. Like the MMIO case, only the
caller knows what kind of memory it has and must inform the DMA API
for it to work correctly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v4->v5:
- rebased on top od dma-mapping-for-next
- s/decrypted/shared/
v3->v4:
- added some sanity checks to dma_map_phys and dma_unmap_phys
- enhanced documentation of DMA_ATTR_CC_DECRYPTED attr
v1->v2:
- rebased on top of recent dma-mapping-fixes
---
 include/linux/dma-mapping.h | 10 ++++++++++
 include/trace/events/dma.h  |  3 ++-
 kernel/dma/direct.h         | 14 +++++++++++---
 kernel/dma/mapping.c        | 13 +++++++++++--
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 677c51ab7510..db8ab24a54f4 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -92,6 +92,16 @@
  * flushing.
  */
 #define DMA_ATTR_REQUIRE_COHERENT	(1UL << 12)
+/*
+ * DMA_ATTR_CC_SHARED: Indicates the DMA mapping is shared (decrypted) for
+ * confidential computing guests. For normal system memory the caller must have
+ * called set_memory_decrypted(), and pgprot_decrypted must be used when
+ * creating CPU PTEs for the mapping. The same shared semantic may be passed
+ * to the vIOMMU when it sets up the IOPTE. For MMIO use together with
+ * DMA_ATTR_MMIO to indicate shared MMIO. Unless DMA_ATTR_MMIO is provided
+ * a struct page is required.
+ */
+#define DMA_ATTR_CC_SHARED	(1UL << 13)
 
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 63597b004424..31c9ddf72c9d 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -34,7 +34,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
 		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
 		{ DMA_ATTR_MMIO, "MMIO" }, \
 		{ DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, "CACHELINES_OVERLAP" }, \
-		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" })
+		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" }, \
+		{ DMA_ATTR_CC_SHARED, "CC_SHARED" })
 
 DECLARE_EVENT_CLASS(dma_map,
 	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index b86ff65496fc..7140c208c123 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -89,16 +89,24 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 	dma_addr_t dma_addr;
 
 	if (is_swiotlb_force_bounce(dev)) {
-		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
-			return DMA_MAPPING_ERROR;
+		if (!(attrs & DMA_ATTR_CC_SHARED)) {
+			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
+				return DMA_MAPPING_ERROR;
 
-		return swiotlb_map(dev, phys, size, dir, attrs);
+			return swiotlb_map(dev, phys, size, dir, attrs);
+		}
+	} else if (attrs & DMA_ATTR_CC_SHARED) {
+		return DMA_MAPPING_ERROR;
 	}
 
 	if (attrs & DMA_ATTR_MMIO) {
 		dma_addr = phys;
 		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
 			goto err_overflow;
+	} else if (attrs & DMA_ATTR_CC_SHARED) {
+		dma_addr = phys_to_dma_unencrypted(dev, phys);
+		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
+			goto err_overflow;
 	} else {
 		dma_addr = phys_to_dma(dev, phys);
 		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index df3eccc7d4ca..23ed8eb9233e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -157,6 +157,7 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	bool is_mmio = attrs & DMA_ATTR_MMIO;
+	bool is_cc_shared = attrs & DMA_ATTR_CC_SHARED;
 	dma_addr_t addr = DMA_MAPPING_ERROR;
 
 	BUG_ON(!valid_dma_direction(dir));
@@ -168,8 +169,11 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		return DMA_MAPPING_ERROR;
 
 	if (dma_map_direct(dev, ops) ||
-	    (!is_mmio && arch_dma_map_phys_direct(dev, phys + size)))
+	    (!is_mmio && !is_cc_shared &&
+	     arch_dma_map_phys_direct(dev, phys + size)))
 		addr = dma_direct_map_phys(dev, phys, size, dir, attrs, true);
+	else if (is_cc_shared)
+		return DMA_MAPPING_ERROR;
 	else if (use_dma_iommu(dev))
 		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
 	else if (ops->map_phys)
@@ -206,11 +210,16 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	bool is_mmio = attrs & DMA_ATTR_MMIO;
+	bool is_cc_shared = attrs & DMA_ATTR_CC_SHARED;
 
 	BUG_ON(!valid_dma_direction(dir));
+
 	if (dma_map_direct(dev, ops) ||
-	    (!is_mmio && arch_dma_unmap_phys_direct(dev, addr + size)))
+	    (!is_mmio && !is_cc_shared &&
+	     arch_dma_unmap_phys_direct(dev, addr + size)))
 		dma_direct_unmap_phys(dev, addr, size, dir, attrs, true);
+	else if (is_cc_shared)
+		return;
 	else if (use_dma_iommu(dev))
 		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
 	else if (ops->unmap_phys)
-- 
2.51.1

