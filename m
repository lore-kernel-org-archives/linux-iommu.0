Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76A2D2494
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705150; cv=none; b=eWdS/7gvwMn+iwM0McHYoIQivXg1hy9T5fnHJFUFRdWo/andti0GfO7AJUHU0960l+FS++cqMJ+NWkwoWqlIBTYbHm9hKhHf6qsycea+0+j74pYPZPCAB3PH78OXLMkTfqTJsXTTF45GqugqrNkWm1b3cK/2YUoHgpVwuU/zYLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705150; c=relaxed/simple;
	bh=kJU0HHsz8RVc7g1I+1f1X0net62Vn5bTl5/+wnElJ50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iS+XgSR3owQnq39iVOW2bA1kulgI6CJoAqzT+M9yAMI5TJnn1Mtm29bqtwXJJ64SWEGcUVHcUSRD0BKXkaEXZTn8UeAxPzpExxNU3209HFzwxfFscdYsf2E8IoQKV80HId/i0pR3BruPUoYjVey/X7UNI0wbBUgeFDoltZlh4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXTkmNvD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXTkmNvD"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33bda2306c5so5873630a91.0
        for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 19:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705148; x=1762309948; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbaG5t0eQSgPX414bWojxTfff0IaUO9MDOrZ/xFSz38=;
        b=mXTkmNvDarLBatEkD8lpb+c+sc1z2yoBwHx1gT7bmDRpxdb5axbPSKDNhi7sObmGUN
         JSMlIx9QZvoUB1nyfqqA6JWrchGooM7pE/nSZUH8NIlKdySUE/t0AORHvKj8mZ1WJ8zn
         opgjK1dPFfuvQnCbHYqtuGDLFF5+oaggqtONSka2hcXcCNubJVu0+owckqgzn/BxJg2p
         DL7tyi80xZ+NKi3782VNi62EnIQpHSbTawDp4mnU/3/D2AQxJFufAmCBeHZ+tkTW3v6i
         GWpYyCQDkNo8Dk9fKTcG6UBDhFgcR4n0kWfO+rNOzqmLFtP19R0quz9FrzbzKcGqBsgp
         YG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705148; x=1762309948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbaG5t0eQSgPX414bWojxTfff0IaUO9MDOrZ/xFSz38=;
        b=n5Fi98+FcyXHbpLuDLWbav4dECMmihnqR9v/z61eF5DvZW86HjOyXnsmjrYAX0aaU+
         41M0xd/eYEAZaaXsCnk4Pk5JG5ZmEkgzL4FyHPwrEzLTBHf6nvb8Ei6AzSfKcmB4u/BC
         iwun4WvqAv4+YqEQnrBj5bzUiU1Qll6NBjey1ygAz0CACsX0h8lp0GLDsEIlLSH7SqTI
         A+TvjcfxSbrArHaLA9/S90TOsu/36rU8oPOKtOkl6ow9DIIu+8Mkhq04srLDef7v/XPA
         XoNS556yqlrRIgZXaNnkgFcenEXkohMw1JX52+OZQ6/y14HN+5Ao7m6NcAlc5R2QutDe
         lmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSBR9vl4YhtlpEtfQkAY/OmvlRHqo1h4lsG2MWD8Ng9NWW3HjwXa7I8RcjKmQ5A1gM5lqaQg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6DTYEn+PAQuEBx4az9L/FCT9eT4g86Pza+NnPMOOhxycJW0oG
	Imx/B7xb4X8oDyMwwT4HfGAlWSwOoDwV4w8fZ7JykLKnYrhRI0FNQEyw
X-Gm-Gg: ASbGncuPHt//Fa5d6xSD7DTFPH6bdJlAIPZByHd1MpqXpbfTh2ZP6oOPfkp2MteJQaQ
	jblkiWQzcC0AfsrefytQ6lXDFpNQNmq2OrP6fi7JUvxfrMJsGsgmVelkBoM6ht6PWpB447gHszv
	kLDu3eyTn/X6Qn/YjhMkBLieBFM4dkGiWRzJHL1k+fFHRo/k2MYT3Npdl2GA5WDo1CBRQ+woDOo
	flx6mrrvzlQP5rVNagaRZU5gsDVZjwroPfEh67Mf/qXkxbaet2mNK6JQ/j4l3F3oeyjWbx4Lpnk
	eArJHn+DSrxCGe8kOO/JIdeqnE28PHw83Msnk9L1CX67nbb9LanFQwOwpNte1l50Ye7mTiQitkp
	MTDEKQN9W7crUy9jhnhHDY/H9OaVEhEuhHDFv19s/VzrtOIyfaQKOQl9rUl7nnwPRxBhvzlJyn0
	ORxAiAHHt1IRDrMZZZZZd6VU5dj8VjiXoQZ2DoLIVsBSqAU9riFS1yshAWfg==
X-Google-Smtp-Source: AGHT+IHJ74P6d7A+INVwA98f5iJflbVrWJao3lGug3xK3l6qx0+mauB/rdLhpcHFC1X7v1I1yEMgnw==
X-Received: by 2002:a17:90b:4a4b:b0:33b:b0d6:6bc2 with SMTP id 98e67ed59e1d1-3403a2f2219mr1197121a91.30.1761705148273;
        Tue, 28 Oct 2025 19:32:28 -0700 (PDT)
Received: from localhost.localdomain ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81a4afsm13649518a91.19.2025.10.28.19.32.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 19:32:27 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Barry Song <v-songbaohua@oppo.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [RFC PATCH 4/5] arm64: Provide arch_sync_dma_ batched helpers
Date: Wed, 29 Oct 2025 10:31:14 +0800
Message-Id: <20251029023115.22809-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251029023115.22809-1-21cnbao@gmail.com>
References: <20251029023115.22809-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

arch_sync_dma_for_device_batch_add() and arch_sync_dma_for_cpu_batch_add()
batch the DMA sync operations, and arch_sync_dma_batch_flush() waits for
their completion all together.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/mm/dma-mapping.c | 24 ++++++++++++++++++++++++
 include/linux/dma-map-ops.h |  8 ++++++++
 kernel/dma/Kconfig          |  3 +++
 4 files changed, 36 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6663ffd23f25..1ecf8a1c2458 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -112,6 +112,7 @@ config ARM64
 	select ARCH_SUPPORTS_SCHED_CLUSTER
 	select ARCH_SUPPORTS_SCHED_MC
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+	select ARCH_WANT_BATCHED_DMA_SYNC
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index b2b5792b2caa..9ac1ddd1bb9c 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -31,6 +31,30 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 	dcache_inval_poc(start, start + size);
 }
 
+void arch_sync_dma_for_device_batch_add(phys_addr_t paddr, size_t size,
+			      enum dma_data_direction dir)
+{
+	unsigned long start = (unsigned long)phys_to_virt(paddr);
+
+	dcache_clean_poc_nosync(start, start + size);
+}
+
+void arch_sync_dma_for_cpu_batch_add(phys_addr_t paddr, size_t size,
+			   enum dma_data_direction dir)
+{
+	unsigned long start = (unsigned long)phys_to_virt(paddr);
+
+	if (dir == DMA_TO_DEVICE)
+		return;
+
+	dcache_inval_poc_nosync(start, start + size);
+}
+
+void arch_sync_dma_batch_flush(void)
+{
+	dsb(sy);
+}
+
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
 	unsigned long start = (unsigned long)page_address(page);
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 10882d00cb17..8fcd0a9c1f39 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -367,6 +367,14 @@ static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 }
 #endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
 
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+void arch_sync_dma_for_device_batch_add(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
+void arch_sync_dma_for_cpu_batch_add(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
+void arch_sync_dma_batch_flush(void);
+#endif
+
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 void arch_sync_dma_for_cpu_all(void);
 #else
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 31cfdb6b4bc3..2785099b2fa0 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -78,6 +78,9 @@ config ARCH_HAS_DMA_PREP_COHERENT
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
+config ARCH_WANT_BATCHED_DMA_SYNC
+	bool
+
 #
 # Select this option if the architecture assumes DMA devices are coherent
 # by default.
-- 
2.39.3 (Apple Git-146)

