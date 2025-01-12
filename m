Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5C14900F
	for <iommu@lists.linux.dev>; Sun, 12 Jan 2025 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736668165; cv=none; b=iIEdHVrmXgsyznfwRyi9e1zAgObli1YO/cwgZaX1fzZpQq/sRrY2lbVON34xjZbSGleqxEJsiKFSe7PvS6h5x6wPaXiTgryW/99uGgQT3TJQv89oPadyLeEA3pfclFroNa3bE7ltRfxT0+N+/SYqeelwCtBkNUi1rkRzWr69404=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736668165; c=relaxed/simple;
	bh=cNi9vhf9bGsIwHgm7dOKJB7hausRE69NcKHC5yezuYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MHtmiOJ6lVFEs2NVHCoGUa9LcyxSDRtsAknE+KR4SHqOpODkXCLsnMOMySmymm3DubcqvL4YxuYiE2KSszbu61WAwcMoqaYjxryvPaFq9cqlBsKrlldPCCVFuS6KdNuWoH8/xE65jNatiWr3LPDBGJmFaXVqwZQ+fiMPW8TAW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXWmUDg3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXWmUDg3"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-216401de828so53943425ad.3
        for <iommu@lists.linux.dev>; Sat, 11 Jan 2025 23:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736668163; x=1737272963; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gcU6OrSCKgDwFj8OIVqMhgOivSwgFqlZg2dJEdDSXwc=;
        b=XXWmUDg335NR1O1ON0pDc3iIk/zI8ZuMkoUilE3HFXa/5dh13bEVfh8QoelvTle6I0
         n24SZiInmq7nVFC5kzA1AMneztCwxYSXnxD1WtRz0jZGSZdFNDE3T92PvaKvBU3LreVN
         N/sakwXIUk0R2qTJLEPFKYhq/DNUK2CK1ARF2zKNKES2QGWXqMKrl+yUJWCACpIzO9cr
         yQg+w35n+m4pb+s0C5FNPDDaTYYZiSJT8RAZyOQdbQPc07wSrsHzdCrCTaFxNZxSg7/4
         HihAyC+v5raTwVx7oPk7MV49vaxR6jC2/upzvlWEKOtunEuPAurebJ2pD/tEdvy7EFg5
         ijtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736668163; x=1737272963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcU6OrSCKgDwFj8OIVqMhgOivSwgFqlZg2dJEdDSXwc=;
        b=uFklvXp2kpymBbfuMBXfU5z268fEGLnIY0tANB7nZdefmcD3X9pIkcjU+fjCQgWPAf
         /EgVjNLE71nF3oX5HjESmIwxIqCDR0aMthrTGNVReXEXBS8AKGRd3HuYSpGUWUlyk3EE
         YgndYpTQHOYP2M5ccgF7j0ynRBdOUCBPdLThZmXII/erQIVeX1WpfPZZT9Y839rGaCIE
         ppmTMIC2TMRzRfcsllcdoVAM+Nnbl72t6Rcc7xxJ0XwqmDKK5YPc54W9PUbdhiYkT3Wb
         w14KejHIW1MBj94I1k6cfsQogGInOFgCpJtjT2VIfHoIlaD5sVWys4/0N5yuOj3oAdga
         EVMg==
X-Forwarded-Encrypted: i=1; AJvYcCVgWBn4VCtujYNCid/EAfwNeZv4BmZOY68erpcNHwsgqk90yzpU6i3OAp0Nh3Fm1PSDG6H78Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBtXd4tb/CNkuBo8H3qEowbuRTXicQrJADMFeXO9Xrq0aAC/p4
	GvOMABo1YWLKjy4NzqGuxfs6TVZOAvghCPcNIZozquL2TmjNiUS6
X-Gm-Gg: ASbGncuMNVdO6sJVeDIjCGoOgE1PV/H7Pe89YYZbbU5x/djbkLr+EBl8pkTI4QGyr6p
	r2j4VwRJb7TxY6x6iEEYDCZBPaUcFZtVYG2YxCcA4dopuTBv3f2s5YPSqF3I25fesGRfQBJq5Y3
	y3ywoMNKNp5A+wVQt83eT2FAesBMdKNxHXtBf4RY38p3snuPej/XjDvI6M1KQZWxJht5mNsO5iI
	RhroQ9U8IgszabOA8U6EOUSMjgAATevgHUwu1B2OchiJ/g2bRh1FEnXBLP66RW5wQuKy+g=
X-Google-Smtp-Source: AGHT+IFiHOZe64qhLb/veCLSRYGclr19x6jZ3sYxwuFoZpr0eA5JOkfIF30+U6Ck+eUHZBNY5AX52Q==
X-Received: by 2002:a05:6a20:841b:b0:1e1:ae9a:6316 with SMTP id adf61e73a8af0-1e88d09cbbbmr32490659637.35.1736668162964;
        Sat, 11 Jan 2025 23:49:22 -0800 (PST)
Received: from tiger.hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4054947csm3867812b3a.29.2025.01.11.23.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 23:49:22 -0800 (PST)
From: Wencheng Yang <east.moutain.yang@gmail.com>
To: 
Cc: Wencheng Yang <east.moutain.yang@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drviers/iommu/amd: support P2P access through IOMMU when SME is enabled
Date: Sun, 12 Jan 2025 15:45:35 +0800
Message-ID: <20250112074539.381848-1-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When SME is enabled, SME bit is set in IOMMU page table pte entry,
it works fine if the pfn of the pte entry is memory. However, if
the pfn is MMIO address, for example, map other device's mmio
space to its io page table, in such situation, setting SME bit
in pte would cause P2P failure.

Clear SME bit in io page table if the mapping is MMIO rather
than memory.

Signed-off-by: Wencheng Yang <east.moutain.yang@gmail.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 7 ++++---
 drivers/iommu/amd/io_pgtable.c      | 2 ++
 drivers/iommu/amd/io_pgtable_v2.c   | 5 ++++-
 drivers/iommu/amd/iommu.c           | 2 ++
 4 files changed, 12 insertions(+), 4 deletions(-)

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
-- 
2.43.0

