Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB101F1502
	for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458956; cv=none; b=EzYR4zIDJqNjcq2EL5nOUqgKmA+YQ4EfJFs2MsVRj6LIUiMZahPv/6E0kBRMNqgqDGvihWLKZReFsEDeCJyn93r8m39NIubQZPAd7SHUBAbP9gszr/Y0vfx+OEl7FbLAFSgT4jPdI0MTzcpHUidyyR3yYvsxWyvsnoSuHszq0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458956; c=relaxed/simple;
	bh=nh9WsxIxeYysaVr6MxXvDi1AaHkf78v6tjemOkhShrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNV1k0/KMut5Dzo7QjlQWj7LqN9cI4pM9MPrrrJaATqUm7I1A/Y7knh1VfObHs6T/+P35dS18ANGolALuYxVSVq2VwTPNndWPNYnwJmyoBpfn6bMNhvH8m0uZuIvobrAU+gfApkbl6y0E+naWDXSWG3BOdWvujhCLQkvy6AkNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFg+2iCW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFg+2iCW"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216281bc30fso124775385ad.0
        for <iommu@lists.linux.dev>; Tue, 21 Jan 2025 03:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737458954; x=1738063754; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMeTfRxhl9BwEfA37y5uSqDF2UTPmXajFpszd0Y6s+U=;
        b=SFg+2iCWW9I5uPL4Y8C9onc6csNR6bXe4J+/hXvoVNJLb6FLx/Q2YgXIJU/XxUdg8u
         qKpyGbzngTKm8AmmaB9gFjoWJRxKQ9IFyh0VGR9+jMYu9+FBXPiwp316oisOOpghJF3C
         23G/vhxco5b7MnOn3VY6tpS2vJPO7/3bErEAiZ2jRwkeWpeJwwudWiOk/cQ7I1J//s2O
         XIkpPzo8XEyaKoYVX+QhrNs3vFgwv+ITYIU+I5RAq7+f+pO1pKouYFTkqmckFt6/f/xW
         8g4qY+TWXjydAY61cKlja0xKQH7G0XiOFuHOXOpqSoUB4l4XstwiPRWHirKnRjHVzYUT
         oiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737458954; x=1738063754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMeTfRxhl9BwEfA37y5uSqDF2UTPmXajFpszd0Y6s+U=;
        b=PRqF+OflzaD20RvAtuPVsxA0xkrAcMsTUYh3GWMGPra7DgVTl3M5IzpdqUeZAcbKOO
         FMn+PI0L5c023J0rncl/nWaz2oJJ+rHWErwXt4GKBSOed6PYqPH17S1O3hZBSCqgHJqK
         DtV6pDGBQ3S213MAlRJ3BBFF721MeO3GgxLQ9EYdAbNgUVsLD46mhz+L9kq+j2EhZ8cE
         esdENfJzmxVTEdBGgHdo1biRxdsDjaV4bff0jWzTzeIA1CU8/NVpd2xgt31LUKvAwhrz
         i8YvHPdCw+j3cmF20XYK09BH553EpnQ+1p3wuScN7Rbdr0Q67JEElFrtwxzzWLJ8u2nz
         K9xQ==
X-Gm-Message-State: AOJu0YzMnKlZ1skpkP9iph7sCuK6l9r/UDcvXbkSYTGCyGMxUhgP8sQB
	jC8DYEEZCs5PZFviPsNCoIDTC0GYohU4Bkcg/RW1AaFbjGul1d1xV7PFgc6/mAo=
X-Gm-Gg: ASbGncun6cPYki/cnk58rLjiuMoKzCXPtBpz/30t5616ShUd9n8L3poggpIR6ER2edd
	F4rHxJpbHBYtLBKgHhkHHvpebekHyJeP9pT7SSKpF65UCHKZKVw+5ZJRDjQEXe2NnOsbOMrDzoi
	spHrc7/Xlv7Fjau57jiurKEVEupAy3XPZQHpN7h0Ig1FDeCzgOD+oqawMPNeA0u1ErYcJlBP7Us
	gQ1+MtF3uX0WtShZBnzYHDr1qv432Q/3TkjbCWK6i7JlUpOfKTBrt0iIlDAb+TYpmdLWuRpijKN
	+Y1QyhoK
X-Google-Smtp-Source: AGHT+IHqVYYJ45lIlWyRx33N4odTV9sw1wF9+nrODrrB/LpvgiOepFLlCXIlPAeAhhX+P42rZbOKUw==
X-Received: by 2002:a17:903:1cc:b0:216:2474:3c9f with SMTP id d9443c01a7336-21c357b6a7bmr218434175ad.52.1737458954143;
        Tue, 21 Jan 2025 03:29:14 -0800 (PST)
Received: from tiger.hygon.cn ([112.64.138.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea1fdesm75385965ad.26.2025.01.21.03.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 03:29:12 -0800 (PST)
From: Wencheng Yang <east.moutain.yang@gmail.com>
To: east.moutain.yang@gmail.com,
	alex.williamson@redhat.com,
	jgg@ziepe.ca
Cc: iommu@lists.linux.dev,
	joro@8bytes.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com,
	will@kernel.org
Subject: [PATCH v3 3/3] iommu/amd:Clear encryption bit if the mapping is for device MMIO
Date: Tue, 21 Jan 2025 19:28:36 +0800
Message-ID: <20250121112836.525046-3-east.moutain.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250121112836.525046-1-east.moutain.yang@gmail.com>
References: <CALrP2iW11zHNVWCz3JXjPHxyJ=j3FsVdTGetMoxQvmNZo2X_yQ@mail.gmail.com>
 <20250121112836.525046-1-east.moutain.yang@gmail.com>
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

