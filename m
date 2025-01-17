Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E711F6686
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098083; cv=none; b=pOtMbSfTyET4pXiPeWzio7cAEF0BeGj0GNTfWLvfbz7D1PYUVFHLJ+pK4zs3+zGCP8GYk15PlXN6y5YyUhq8S+loa7ylrcPgB6AEuJJxIqi6aR4UGjTwX69gdOKYPNY5jAYzfMpofx6dEvbMoKLzzJ6tTgHcKbxhrmAOpvdn3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098083; c=relaxed/simple;
	bh=m6M53Z4cZzeyxFN6wZfVGIoihDPyDArBi6BoKqTGKpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tm+5LM/WFslyt/LB6XryXmvnL5Hhfc8vo1slqutKESRCL7QALpUIBnYVK/nM4lCsASX8eCDQ/4xzLA/RELydYkVtn9IaVr/+sUEdBFJvoVz0MB3J3TetaYGlu10mQkA3wmHTEskFH4eyb1bSgzF2e80nbClvk7HOI1608rN1VEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aibMwWEx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aibMwWEx"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2167141dfa1so32057125ad.1
        for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 23:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737098081; x=1737702881; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z63qPrynRXI6BmIjk6C4ixdo98vNllP+HEKWG9XiGhs=;
        b=aibMwWExXoHaIkHYcWNmabjue1Pak7wQ2aLwYmPXpa97jDwjOkPlRiBBPcG5bDZe6C
         5RwZb+RyGWDCEO3B2Yc6hNVbtuV3v4RUKZIayRRJ6A3OVMnTIFD5GQUvnTj8bJpDxFEP
         WeuKmtVNZjPms8cGSVr7aHS2c0XWtK2KqfijAPronYSGl6yw0G/tNnLzfKcDEeeyzvFP
         PdFMGOtRx/Z443JO2vXeDAfxBEi6Q8QH7cVwvVx2XCIGo1oisqCGFIlOuy2dJP8MZmqu
         fUGsaI1aOFg3LkEJP9DNGSQw8J3EY3nRT2egmcDzlA7W2itpQDb9+3HIfONUrgZ9h5WN
         Qhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737098081; x=1737702881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z63qPrynRXI6BmIjk6C4ixdo98vNllP+HEKWG9XiGhs=;
        b=INRm0BX9FPh1mqJb7GkcmQIXvx/g/h63ar6hN8CAGURoyuNLvM5wu/CXW/F/QXFp3f
         L/18gFJFm6EfSxgr5mmVD9z6zO0q5/gABW3n2sWLDWgmph8uGAliJg+eTVJymyuWrO81
         fGc6DxfT5fZ/s/3V+0m7i3r++k4EqsLBxml7zWwnrEBM9RZKuI1vkqi2hOCSQi7L7W6d
         SOF5L3JzfUMzdzvHyj3e3WoxVz0BldEhSIgxKZ9tB7R4uGXlB8962XSmPZs4Y2aq4g0B
         KdLCzyB/2OjFcXfdY9Flp5SlvS41Nm1hIS0q6d/oiimN5H0/PlXjg/UvW+uRGOZ5WdIX
         VCcg==
X-Forwarded-Encrypted: i=1; AJvYcCXAAChBSIgBckaBS35c4+8rdtEgOkBg2hUJoiGcRT5wlVg2AVPWnqhPjj1uux0O4F1Yyc0dXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxwwS4X1j/p0InjVrsPXJTiLZM+Alts0x8ls7b5dvWm3b615dK
	3FR+mIJkhxFQwDTGgIyP35bOx2ZfIA2WQreiQoTkHK0dIbXK9o3N
X-Gm-Gg: ASbGncs9skiIcHjWV1WQLqSRN9EVb6CyhxqTSgroAMVdjCub1PCCmg8utWC6ulfXADB
	vfwpOh9dVfi5V5+On7IPgsL80wxsX6FTfaEKDjHxPGCtRyiSSvXEx4l1CsPwU5eSrpNuQuyougK
	/ENYnL4Hw5Keev8oOADMmalPMNAW5aHm++JBbUOaDhxZeK1A0uHWUQYnTz1mtagj+amN3XgdF3r
	a0ITZ6Xp7lvUVKxlcEMKaCjaVaBc0E1S8TJqHQ8r7kNTCScvIziBZDpHyOmDcYPKW4aMXA=
X-Google-Smtp-Source: AGHT+IHyrjJfXew3SY4reCmWuwNIUXV3f0/kopUDZmb2ECnvrX7cAcZ8TXQwLeGALuBvyCSj4BwVHw==
X-Received: by 2002:a17:902:d58b:b0:215:a034:3bae with SMTP id d9443c01a7336-21c3679d7dfmr22699945ad.18.1737098081136;
        Thu, 16 Jan 2025 23:14:41 -0800 (PST)
Received: from tiger.hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2ceb9e71sm9835165ad.70.2025.01.16.23.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 23:14:40 -0800 (PST)
From: Wencheng Yang <east.moutain.yang@gmail.com>
To: 
Cc: Wencheng Yang <east.moutain.yang@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v2] drviers/iommu/amd: support P2P access through IOMMU when SME is enabled
Date: Fri, 17 Jan 2025 15:14:18 +0800
Message-ID: <20250117071423.469880-1-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SME is enabled, memory encryption bit is set in IOMMU page table
pte entry, it works fine if the pfn of the pte entry is memory.
However, if the pfn is MMIO address, for example, map other device's mmio
space to its io page table, in such situation, setting memory encryption
bit in pte would cause P2P failure.

Clear memory encryption bit in io page table if the mapping is MMIO
rather than memory.

Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 7 ++++---
 drivers/iommu/amd/io_pgtable.c      | 2 ++
 drivers/iommu/amd/io_pgtable_v2.c   | 5 ++++-
 drivers/iommu/amd/iommu.c           | 2 ++
 drivers/vfio/vfio_iommu_type1.c     | 4 +++-
 include/uapi/linux/vfio.h           | 1 +
 6 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index fdb0357e0bb9..b0f055200cf3 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -434,9 +434,10 @@
 #define IOMMU_PTE_PAGE(pte) (iommu_phys_to_virt((pte) & IOMMU_PAGE_MASK))
 #define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
 
-#define IOMMU_PROT_MASK 0x03
-#define IOMMU_PROT_IR 0x01
-#define IOMMU_PROT_IW 0x02
+#define IOMMU_PROT_MASK 0x07
+#define IOMMU_PROT_IR   0x01
+#define IOMMU_PROT_IW   0x02
+#define IOMMU_PROT_MMIO 0x04
 
 #define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE	(1 << 2)
 
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index f3399087859f..dff887958a56 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -373,6 +373,8 @@ static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 			__pte |= IOMMU_PTE_IR;
 		if (prot & IOMMU_PROT_IW)
 			__pte |= IOMMU_PTE_IW;
+		if (prot & IOMMU_PROT_MMIO)
+			__pte = __sme_clr(__pte);
 
 		for (i = 0; i < count; ++i)
 			pte[i] = __pte;
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index c616de2c5926..55f969727dea 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -65,7 +65,10 @@ static u64 set_pte_attr(u64 paddr, u64 pg_size, int prot)
 {
 	u64 pte;
 
-	pte = __sme_set(paddr & PM_ADDR_MASK);
+	pte = paddr & PM_ADDR_MASK;
+	if (!(prot & IOMMU_PROT_MMIO))
+		pte = __sme_set(pte);
+
 	pte |= IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
 	pte |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 16f40b8000d7..9194ad681504 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2578,6 +2578,8 @@ static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
 		prot |= IOMMU_PROT_IR;
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
+	if (iommu_prot & IOMMU_MMIO)
+		prot |= IOMMU_PROT_MMIO;
 
 	if (ops->map_pages) {
 		ret = ops->map_pages(ops, iova, paddr, pgsize,
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 50ebc9593c9d..08be1ef8514b 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1557,6 +1557,8 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 		prot |= IOMMU_WRITE;
 	if (map->flags & VFIO_DMA_MAP_FLAG_READ)
 		prot |= IOMMU_READ;
+    if (map->flags & VFIO_DMA_MAP_FLAG_MMIO)
+        prot |= IOMMU_MMIO;
 
 	if ((prot && set_vaddr) || (!prot && !set_vaddr))
 		return -EINVAL;
@@ -2801,7 +2803,7 @@ static int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
 	struct vfio_iommu_type1_dma_map map;
 	unsigned long minsz;
 	uint32_t mask = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE |
-			VFIO_DMA_MAP_FLAG_VADDR;
+			VFIO_DMA_MAP_FLAG_VADDR | VFIO_DMA_MAP_FLAG_MMIO;
 
 	minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index c8dbf8219c4f..68002c8f1157 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1560,6 +1560,7 @@ struct vfio_iommu_type1_dma_map {
 #define VFIO_DMA_MAP_FLAG_READ (1 << 0)		/* readable from device */
 #define VFIO_DMA_MAP_FLAG_WRITE (1 << 1)	/* writable from device */
 #define VFIO_DMA_MAP_FLAG_VADDR (1 << 2)
+#define VFIO_DMA_MAP_FLAG_MMIO (1 << 3)     /* map of mmio */
 	__u64	vaddr;				/* Process virtual address */
 	__u64	iova;				/* IO virtual address */
 	__u64	size;				/* Size of mapping (bytes) */
-- 
2.43.0

