Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8FE2248B3
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746055212; cv=none; b=aQY5vhQUQDmyosF0ARrsfYfRigvfUGQxgeF7CI4eQNAnW6etMjMESpvkUQJ0OxsvodvZlH0YEVbFymgU/ZdmXZWU7NMEAI9FtaGlC2+MvDSzU7DKh2EuXb5u66WeJi9rZa8g9M/1D7nLwgFpq+4aP5DSepjOdSOcbDKgTx7VY5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746055212; c=relaxed/simple;
	bh=hNxBmD9EBKRVZnV8TedbtwQMd5tVIldnAb762KJdHcY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FEAGKHS33U3L0/CZyikuIKTublAy+1tMgiWjIyMLmp5b00fAwVYNSUz4dybj6R+kM8dGyLTQw1EzKbPoehPFR/Xkypti9vRSrf4t7gsyWqcWiiAkiXCB7tvpQGZyMY1t7GX5JynwtbiJMqgSWlayWP3VcgkWMRrTfabcAloyIXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFfCwTbM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFfCwTbM"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff8340d547so345875a91.2
        for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 16:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746055210; x=1746660010; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AfjgXcYxCrLXML8qIwR5TnpgzR0FuN4DocvnvlLCV0M=;
        b=iFfCwTbMt2oDkF/lZr1q7GC00LPBuvwbBOd1fHRfrHDeLzIg/TaWIR1H9YQITZ3VQC
         JRfhsQUsKbGCkVzajcqn+7N66qdQx1yrFcHxm3Gx9W413r9vVFzoYTO1KnfiKAE3xSOs
         +uphVmzvdmw5GgYRzVgMCNW8P7qPC9GoDWKjN+rz4qus7Gok4pvTSoCS91M6FXpCeR3p
         ADGY1wgbYogD6izRtSNHVnY8NduxrEbngvxoFz/wKtsYGL60Hs5ENc2jK0G+WESBsesC
         GE8iGPCREeZI96nc6AAtAtJhru4FnTE5iZG2DZaSqpqzLHPZauNmz9bdrDyHQPeWr2gt
         zfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746055210; x=1746660010;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfjgXcYxCrLXML8qIwR5TnpgzR0FuN4DocvnvlLCV0M=;
        b=TP5yWXA/3tz2t2Ss2UR7qWVn/Z7cYgsMOfsk45p2xrqfwDlxszC8OsBO0MSxZMSeQy
         ukhnpJIVIJa3z0DQfitq2FGMRv/7TIJ7a7z+qwUTh3ljOhswzsiw2Jw3dSj/cYy/2NV2
         sMnudGZR9bH7o0McmIE/z12h+tQLP3wzcpJP3yYDPkMIyyQAERDs6HFzHxb664V6xPsG
         nE5sSFDErsKk6wxYC49fcic1fcF0nXvzbaOdPsU8HvSxz5ti9TJFvALAmg4n7GvOvFjL
         dKE+3IyYdmeb6p5Ow1EV1SDfRFW6wvdvEGU76FkeLFoqliVQFSMoAbU/DT2FVYTE1lMR
         sjHA==
X-Gm-Message-State: AOJu0YyoTeE4P94TndFyVI6q8SKPjDxy4rW2yhKTiau4uUSNshDTtuEj
	Shd/W9j7PtLO09/rkOCYVh4xtMXLUxjGo9POrQkz8o36IEIwEt5+vHDnUY+b18NfJE01LfmLONY
	qmsUePQzWzz+Nz4KzAKN/Riao1keIVnLiQa1z239mwlfllpOxcDbRKIBZX2m22gBl2XOUoUBiL9
	WcVOwxGJdy2r8loOqRw61Dc5mIq8kaFnyBD6wl19fcrftdc6DL4ZBE/qnDFw==
X-Google-Smtp-Source: AGHT+IFtGBHyQZStuEphw4tf6iEVV6/w6Q6UhS8lVXPJoGU4RpJttYr05TBGMeYbb8Z8cNX1/IWBNJSQJ/hLMnZECw==
X-Received: from pjbqi13.prod.google.com ([2002:a17:90b:274d:b0:2fc:2b96:2d4b])
 (user=danielmentz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1846:b0:2ff:58a4:9db3 with SMTP id 98e67ed59e1d1-30a3446ca02mr7229589a91.35.1746055209801;
 Wed, 30 Apr 2025 16:20:09 -0700 (PDT)
Date: Wed, 30 Apr 2025 23:19:24 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250430231924.1481493-1-danielmentz@google.com>
Subject: [PATCH] iommu/io-pgtable-arm: Support contiguous bit in translation tables
From: Daniel Mentz <danielmentz@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

The contiguous bit in translation table entries can be used as a hint to
SMMU that a group of adjacent translation table entries have consistent
attributes and point to a contiguous and properly aligned output address
range. This enables SMMU to predict the properties of the remaining
translation table entries in the same group without accessing them. It
also allows an SMMU implementation to make more efficient use of its TLB
by using a single TLB entry to cover all translation table entries in
the same group.

In the case of 4KB granule size, there are 16 translation table entries
in one group.

This change sets the contiguous bit for such groups of entries that are
completely covered by a single call to map_pages. As it stands, the code
wouldn't set the contiguous bit if a group of adjacent descriptors is
completed by separate calls to map_pages.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 53 +++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7632c80edea6..07b40e928bb3 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -76,6 +76,7 @@
 
 #define ARM_LPAE_PTE_NSTABLE		(((arm_lpae_iopte)1) << 63)
 #define ARM_LPAE_PTE_XN			(((arm_lpae_iopte)3) << 53)
+#define ARM_LPAE_PTE_CONT		(((arm_lpae_iopte)1) << 52)
 #define ARM_LPAE_PTE_DBM		(((arm_lpae_iopte)1) << 51)
 #define ARM_LPAE_PTE_AF			(((arm_lpae_iopte)1) << 10)
 #define ARM_LPAE_PTE_SH_NS		(((arm_lpae_iopte)0) << 8)
@@ -326,6 +327,27 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
 				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
 }
 
+static int arm_lpae_cont_ptes(int lvl, struct arm_lpae_io_pgtable *data)
+{
+	switch (ARM_LPAE_GRANULE(data)) {
+	case SZ_4K:
+		if (lvl >= 1)
+			return 16;
+		break;
+	case SZ_16K:
+		if (lvl == 2)
+			return 32;
+		else if (lvl == 3)
+			return 128;
+		break;
+	case SZ_64K:
+		if (lvl >= 2)
+			return 32;
+		break;
+	}
+	return 1;
+}
+
 static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
 {
 	for (int i = 0; i < num_entries; i++)
@@ -340,8 +362,30 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 			       unsigned long iova, size_t size, size_t pgcount,
 			       int lvl, arm_lpae_iopte *ptep);
 
+static bool arm_lpae_use_contpte(struct arm_lpae_io_pgtable *data,
+				 unsigned long iova, phys_addr_t paddr,
+				 int lvl, int num_entries, int i)
+{
+	size_t sz = ARM_LPAE_BLOCK_SIZE(lvl, data);
+	int cont_ptes = arm_lpae_cont_ptes(lvl, data);
+	int contmask = cont_ptes - 1;
+	int contpte_addr_mask = sz * cont_ptes - 1;
+	int map_idx_start, tbl_idx;
+
+	if ((paddr & contpte_addr_mask) != (iova & contpte_addr_mask))
+		return false;
+
+	map_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
+	tbl_idx = map_idx_start + i;
+	if (((tbl_idx & contmask) <= i) &&
+	    (tbl_idx < ((map_idx_start + num_entries) & ~contmask)))
+		return true;
+
+	return false;
+}
+
 static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
-				phys_addr_t paddr, arm_lpae_iopte prot,
+				unsigned long iova, phys_addr_t paddr, arm_lpae_iopte prot,
 				int lvl, int num_entries, arm_lpae_iopte *ptep)
 {
 	arm_lpae_iopte pte = prot;
@@ -355,8 +399,9 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
 
 	for (i = 0; i < num_entries; i++)
-		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
-
+		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data) |
+			  (arm_lpae_use_contpte(data, iova, paddr, lvl, num_entries, i) ?
+			  ARM_LPAE_PTE_CONT : 0);
 	if (!cfg->coherent_walk)
 		__arm_lpae_sync_pte(ptep, num_entries, cfg);
 }
@@ -389,7 +434,7 @@ static int arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 			}
 		}
 
-	__arm_lpae_init_pte(data, paddr, prot, lvl, num_entries, ptep);
+	__arm_lpae_init_pte(data, iova, paddr, prot, lvl, num_entries, ptep);
 	return 0;
 }
 
-- 
2.49.0.967.g6a0df3ecc3-goog

