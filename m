Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905B39CCE0
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790652155; cv=none; b=pqrCTa0iwd7+Som93bFpuHE3ytqCMoJV89Cuaiecv2+8dIl8Y15rVkBCrJ9tbA9nfYU7n7EwUIvUHh/qjlifQPkkPUGwMhA2CXrTG+ItfXLKzQntC+a4Y3CNwKioaSQ7x3hG47thrg1DMLjAx10kxKW+uNZMxt7gaHkhMvyQUuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790652155; c=relaxed/simple;
	bh=2uWZ4zaZ/v7zYyOa543CiktflOwN+mhMi0SOjznknZU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o+z19Hi/TPkmBeyL+rkS09M468x0PSXO8v0AkeYrB9M8zyyN+WaIotQrjhwjKC8uO/9/yKOa22Bsarms1YIbM1DwM48xREjNTCWlVKHkY1mGPncFPSlImzjP4pqHGOC9F/KxSFwFYdR4wQ07BOLIw+xYq9HQ5xJ61f+eXsBbnwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrZIJ31w; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrZIJ31w"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14373747468so3429422c88.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 20:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790652152; x=1791256952; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4CMsaZlCz3tjiQiZY6VpBfkMdJKm49kmWAtKADYZwJQ=;
        b=OrZIJ31wsxhqWyeYz8hFB5B8PynNOOZPey6bzkVPooGaFjq+RENo7jGNAT2NaaqlGG
         T54HiLt2FEhUyQrXYNpEYCcKDUoqk80W8dnnPQQs84Niz6jeefttK0s326jrHmbwAmYo
         3JvenDUAFZYLiRY0oysWpjUw97FgxLyNSdP6gcTVTRHHbVrPmFkuXAA0Fk7cINJglqgC
         SlOFLoXigs1jVX0l7SP25Rx4Z7VtxHXRRuGyWbcckLyebnhwQ1osR4qO84hKjD1CkNFG
         xDVqryRpZD5fuxMLzoqYznUckyPfSBtB/HzAxagK0NK9wY84cNNsopwgtJLqODuFIt2I
         iL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790652152; x=1791256952;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4CMsaZlCz3tjiQiZY6VpBfkMdJKm49kmWAtKADYZwJQ=;
        b=bmJcMHuNqR2O4UWb5wnxTnsghT+TOaT6tWbE1xLMs4ysY4bT3FnEHtjpI77gcigfaX
         EkCGpujt7dQvt9RZeY4m8UtsfO9wLdZ8Gk18pBcBNIx64rbMJwCYWBObT/EiTTWjWFnZ
         4iCFp9kR9Dd2hvOFJ/Cft2OyACviIOh/CmQcl87ImPBig7moXREUuQK6nwKyDJuGfqAA
         6vLFrUdLo5YJJ6UDxtc+5s+jLjDpst38Zr0kb8aj9S8H7sm+bBKOJpkau69zAM6tWU68
         CB/a8wTkGV+KgRpLaKFMaY+QuokhveDbV/WlJfSUZJQt0Ow35ShrwqRb0pMy/U0iNsQl
         j5FQ==
X-Gm-Message-State: AFuF++nU7ZFchmllsSJGo+6JrcZfIv6DoXOQ73C0nXgj4oU/uD3mSlZa
	Ne9OF3t2b4MButyqdZ52XmzCDRZtO47wNt+0ybf4NfBMNEFg75Q6p/QbtQcS005Fnp8Mi9mP7Em
	Tdb8tTNExuUu0UZtNG1DCpPoyJD6y/4YMvQplq0GguT9xjRtjaTGcH7hkgqxDKyzW5YvkKn0O2X
	urt4v0hqcVj+OtuGtRip9j4y+PRQLc2OF4WaDMupZh2LpnTBVm7GA9zbovB6Mpuw==
X-Received: from dlbrx25.prod.google.com ([2002:a05:7022:1719:b0:14a:b069:4d4f])
 (user=danielmentz job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:5f1c:b0:149:7f69:a3ad with SMTP id a92af1059eb24-1497f78ea23mr5506267c88.13.1790652151855;
 Mon, 28 Sep 2026 20:22:31 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:22:29 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929032229.3532247-1-danielmentz@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Align memory attributes for
 SMMU-originated accesses
From: Daniel Mentz <danielmentz@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

The SMMU specification defines several types of SMMU-originated memory
accesses, including Stage 1 and Stage 2 translation table walks, stream
table accesses (L1STD and STE fetches), CD table accesses (L1CD and CD
fetches), and queue accesses (CMDQ fetch, EVENTQ write, PRIQ write).

While the memory attributes used for Stage 1 and Stage 2 translation
table walks are configured in io-pgtable-arm based on whether the SMMU
is coherent (ARM_SMMU_FEAT_COHERENCY), the attributes for stream tables,
CD tables, and queues are currently hardcoded to Inner Shareable,
Write-Back.

On non-coherent systems, however, memory for stream tables, CD tables,
and queues is allocated via dma_alloc_coherent() /
dmam_alloc_coherent(), which provides CPU mappings with Normal
Non-Cacheable attributes. Having a non-coherent SMMU access these
buffers with Inner Shareable, Write-Back attributes results in
mismatched memory attributes between the CPU and the SMMU.

Configure the memory attributes for tables and queues in
arm_smmu_device_reset() and arm_smmu_make_cdtable_ste() based on
ARM_SMMU_FEAT_COHERENCY, matching the attributes used for translation
table walks:

- In SMMU_CR1, use Outer Shareable, Non-Cacheable for non-coherent
  SMMUs, while retaining Inner Shareable, Write-Back for coherent SMMUs.
  This applies to stream table accesses as well as queue accesses (CMDQ
  fetch, EVENTQ write, PRIQ write).
- In STE.{S1CIR, S1COR, S1CSH}, use Outer Shareable, Non-Cacheable for
  non-coherent SMMUs, while retaining Inner Shareable, Write-Back
  Read-Allocate for coherent SMMUs. This applies to CD table accesses.

Assisted-by: LLM
Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 37 +++++++++++++++------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122..84cfaeeb4a0d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1881,6 +1881,15 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 {
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 	struct arm_smmu_device *smmu = master->smmu;
+	u64 s1c, s1csh;
+
+	if (smmu->features & ARM_SMMU_FEAT_COHERENCY) {
+		s1c = STRTAB_STE_1_S1C_CACHE_WBRA;
+		s1csh = ARM_SMMU_SH_ISH;
+	} else {
+		s1c = STRTAB_STE_1_S1C_CACHE_NC;
+		s1csh = ARM_SMMU_SH_OSH;
+	}
 
 	memset(target, 0, sizeof(*target));
 	target->data[0] = cpu_to_le64(
@@ -1892,9 +1901,9 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
 
 	target->data[1] = cpu_to_le64(
 		FIELD_PREP(STRTAB_STE_1_S1DSS, s1dss) |
-		FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
-		FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
-		FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
+		FIELD_PREP(STRTAB_STE_1_S1CIR, s1c) |
+		FIELD_PREP(STRTAB_STE_1_S1COR, s1c) |
+		FIELD_PREP(STRTAB_STE_1_S1CSH, s1csh) |
 		((smmu->features & ARM_SMMU_FEAT_STALLS &&
 		  !master->stall_enabled) ?
 			 STRTAB_STE_1_S1STALLD :
@@ -4844,7 +4853,7 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
-	u32 reg, enables;
+	u32 reg, enables, cache, sh;
 
 	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
@@ -4858,12 +4867,20 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 
 	/* CR1 (table and queue memory attributes) */
-	reg = FIELD_PREP(CR1_TABLE_SH, ARM_SMMU_SH_ISH) |
-	      FIELD_PREP(CR1_TABLE_OC, CR1_CACHE_WB) |
-	      FIELD_PREP(CR1_TABLE_IC, CR1_CACHE_WB) |
-	      FIELD_PREP(CR1_QUEUE_SH, ARM_SMMU_SH_ISH) |
-	      FIELD_PREP(CR1_QUEUE_OC, CR1_CACHE_WB) |
-	      FIELD_PREP(CR1_QUEUE_IC, CR1_CACHE_WB);
+	if (smmu->features & ARM_SMMU_FEAT_COHERENCY) {
+		cache = CR1_CACHE_WB;
+		sh = ARM_SMMU_SH_ISH;
+	} else {
+		cache = CR1_CACHE_NC;
+		sh = ARM_SMMU_SH_OSH;
+	}
+
+	reg = FIELD_PREP(CR1_TABLE_SH, sh) |
+	      FIELD_PREP(CR1_TABLE_OC, cache) |
+	      FIELD_PREP(CR1_TABLE_IC, cache) |
+	      FIELD_PREP(CR1_QUEUE_SH, sh) |
+	      FIELD_PREP(CR1_QUEUE_OC, cache) |
+	      FIELD_PREP(CR1_QUEUE_IC, cache);
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR1);
 
 	/* CR2 (random crap) */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

