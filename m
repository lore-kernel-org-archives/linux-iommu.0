Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1702C0287
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 05:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122657; cv=none; b=gUUYzRSAmKjEP7MkqPZ1h3fb1urA8NtAIgOXyNjZIzeuPEkR1hQ24HKsOWm+44AIM8h09ZYpffcx9fM1qFl6aBehfulHguToQ3knkCecINbhq42Naigl3u3q+9HTWUJdq8M2J+Z+3p5mRjQ4MwnXDxiyLg7BjHp88LEnBq6Wo/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122657; c=relaxed/simple;
	bh=VRHBseV8q+/R/B0v4LxS/if/aoC+7Nb6x15H0rpCpJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ikQ9+wX++502Jkha0w9f8pIXd+9hsLlafQGuxJCAC+C+tRIjkoGra1JrjrYQAecEu3F3/yiOKICSsU3L0Fnu4KN2apv7e+GljElut+5R7ZyhtlECLEHTyfxGgAXwM2hlMpszMoso9OosvLQhDDWAeMOhUdJq9xVVusUP1FARbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJiHtKHI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJiHtKHI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a0d6f647e2so21774325ad.1
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 21:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766122655; x=1766727455; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVc7S6MGRFGsCbCRv42PvmwxMMf3ng26LOmJbRXLMRA=;
        b=AJiHtKHI2oA54C/K6pdypDldZHI25GA6mHCtprd7RJ3VA31YCgSCzBLiHju/OErxbV
         OeV9TriI3QqPQYQRefj1jkhQLHzhkDnRgrQsT2XzdpIu92P8FhQjXOquNq/yIDvXKL7M
         /inOnqvb7yzvAQiWMIB7D0B4/fDdlxFA1OdnZ8urkaf2LITCiwPpyYfdvsJsOf8DfzHh
         qtAnlobqd4Iy/vT5ndORYYKRs8rXLMqJeG6E7kgRk50r0oBK91rMfD0WtZiawfyszUYD
         S8ALjhDBscfv/whniCZFGAndxyGpJiUQmThiRtX+cm6ARkBJilLt3JDl1aEm0MH5ZCds
         BLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766122655; x=1766727455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVc7S6MGRFGsCbCRv42PvmwxMMf3ng26LOmJbRXLMRA=;
        b=UTpVfcmhQIzX9C37+uhkBRe6gyPN8xX8CJBJ5+csN9fJvk869a2DKFr8bBU4r0o947
         W51SYCKqjF4fiox2C0W4CkJrwNZUqKahv6cRqNL3NeHXKgwigeOoCiAwYOQBzdeH2ByN
         UJ10QJvgWCBJCgS1cTQ4BY8HsUE3c2anC1u86GIVENOwvXu+PQx5eDzj/Q13eQmq1pTA
         hvtxyiKbM+7UevQ4B0HIMnQfXQ48HLrNdYYmLuCe+i3QRF8jxS+w3ZaDwsdZgJiPy4gk
         afJTe4zBDfa7aT1SRKaEvoDwg2N+htK2qATZ98lWiTyaksBi1noDYEotq2JaqjyFtOWT
         7pzA==
X-Forwarded-Encrypted: i=1; AJvYcCUutXUURiwOfoCPU5qg7DNY75pIBhV6L74pDraWMx8RZg8J2VRTW9ceUx7v5Ycyu4Jip/pJsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz65P6Ln7PqA3BKHAVOhnVORYAjsGzBV/x0w3YIRLALqOxxsdc
	rAnnuEsMEdi2szsB6cA7ejJal0vY+dBU6BfdUpMLbNxyPDq7TDv1RDaP
X-Gm-Gg: AY/fxX5pXOldaHADiiAj7LJOx39Pd+OZ+z2r4ep4SQTpE4uow/Xr88HZtdvLdHJd4Qr
	FsKbqeprWNqADH5Pod/Sp+qilb6Hycc8sx+Nn5umM6xlwpYfkMrQRTFlpT5eECq+b3zhPIcQ4sq
	hG8p8dVyblo9urZY+D76oXAhFEK01U7vI2knEVyuZ318cW/qJAuOAl24uO6xdlZTl+2zu/PLI4C
	9uqjg180TinC4/m8FP5MW2aIIDRuwWI++guRgikh7CCbhnqdCMtOFY/laBESoT3T3urX3mEHVaY
	2Tqtiww8gDxsTHdGcPgJxi/VZPaYnxSM/JvOypT9Ag9umM+v1sFaFKyvaYU4w+Znpb3KeOx6kux
	BIuQbGhz9zOAba3zkyu4Zvw3EiDD8bne7yjEIueSTgh7Z+IbfhUiRg/F4fDyhvpz4PdzWKzN17c
	etk6BsbMYRirc5mdK4w24=
X-Google-Smtp-Source: AGHT+IEgIXUAtoilrAdOFUVheL04wY8Hn1GTTg9fp3Bh9Uns3qP+YxFWsnf+ZhkJ6ZTgBwxYZdARhA==
X-Received: by 2002:a17:903:37d0:b0:295:8da5:c634 with SMTP id d9443c01a7336-2a2f2206b52mr14068935ad.9.1766122654548;
        Thu, 18 Dec 2025 21:37:34 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d895sm9930215ad.54.2025.12.18.21.37.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 21:37:34 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	will@kernel.org
Cc: ada.coupriediaz@arm.com,
	anshuman.khandual@arm.com,
	ardb@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maz@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	zhengtangquan@oppo.com
Subject: [PATCH 4/6] arm64: Provide arch_sync_dma_ batched helpers
Date: Fri, 19 Dec 2025 13:36:56 +0800
Message-Id: <20251219053658.84978-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251219053658.84978-1-21cnbao@gmail.com>
References: <20251219053658.84978-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

arch_sync_dma_for_device_batch_add() and
arch_sync_dma_for_cpu_batch_add() batch DMA sync operations,
while arch_sync_dma_batch_flush() waits for their completion
as a group.

On architectures that do not support batching,
arch_sync_dma_for_device_batch_add() and
arch_sync_dma_for_cpu_batch_add() fall back to the non-batched
implementations, and arch_sync_dma_batch_flush() is a no-op.

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
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/mm/dma-mapping.c | 24 ++++++++++++++++++++++++
 include/linux/dma-map-ops.h | 22 ++++++++++++++++++++++
 kernel/dma/Kconfig          |  3 +++
 4 files changed, 50 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 93173f0a09c7..c8adbf21b7bf 100644
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
index 4809204c674c..5ee92c410e3c 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -361,6 +361,28 @@ static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 }
 #endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
 
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+void arch_sync_dma_for_device_batch_add(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
+void arch_sync_dma_for_cpu_batch_add(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
+void arch_sync_dma_batch_flush(void);
+#else
+static inline void arch_sync_dma_for_device_batch_add(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
+{
+	arch_sync_dma_for_device(paddr, size, dir);
+}
+static inline void arch_sync_dma_for_cpu_batch_add(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
+{
+	arch_sync_dma_for_cpu(paddr, size, dir);
+}
+static inline void arch_sync_dma_batch_flush(void)
+{
+}
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

