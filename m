Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543C037C0E3
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156604; cv=none; b=S0GNQ9Z76q2b6U+V3FYzkhrFfVs6liekjM4nTFce2sZz1fMcWKr8WXZJnv7pxG++hCWDwLiDKLT1tDaLgzG3JCaS8TpmebnC+y+F/AyY43vaGvIqJFNoIdIZcJcrxygzOuzxqAQkVBt98hCDLX3rSRPPbCdR0ptv8deqI2NgeaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156604; c=relaxed/simple;
	bh=qPSLNvG5EvI+RYNmb6EVFUAJ74gpknCj2QGMG3t3XLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t+Vyp0aGl/Oxd01cjb4g2R6rCr32+uN4XP1/luSKo5vcrH6DTR0nGcVX/xVtbKV8YGGglUMSkXlNfmbDbj8YyLFML3S0T80hyimW642m6L/1Pj1UnDEnbaQdvcrQN5YmSeMD+Muc/3wioYPIBVjwScqA9RuP2sRRBQRe14xLhPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GZSqhlXI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZSqhlXI"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0a4b748a0so130568615ad.1
        for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 14:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770156602; x=1770761402; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=laeArOoHMmZZpQbmwN1GpGAXEElz6gu2HEz9aEbOa+M=;
        b=GZSqhlXIilePD/jnrZGRPPs/7nRMuo/D4fMnvGDwBIJc8ezsQEfBYzwelyoPmt4H+O
         02VjQjCysNzGf5kNd5cGqHSUqiWvTYgDz+l6k94FI+7M6p4Qf4JGENhXIU3ai94vsZl8
         8ysbQRPypVdBcTl5zIqNp1zRBzP2sBpvFOoESqeZFI0sr4UV/1PRmCAQBWXxJO4NLABZ
         Fx7lmsh/6rJM9+XQcb8XR7hIskeVtNYZDlLwgYe25UEmSJ9XW/traEKb0Pk9NikcKJh5
         ZnMRuXeYSpPep8aj3WTwnRo2eVtlxtNOdg18Ko0cyvvxdBaBLtg9u3r3Jtj0iAWKlYKT
         v7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770156602; x=1770761402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laeArOoHMmZZpQbmwN1GpGAXEElz6gu2HEz9aEbOa+M=;
        b=qlGvWuW3KPedP6Bt/CZkOzt+4tLCJGdCPW5ue8bqPKPiF+FIWy2wvcir+6P24LjYAM
         GK4mqs7lMzZrKOwQET3za8EjOSsGwH218C3RV1wrTkp64F9RSfQ51Yci6W6ytr4a6KvH
         xlD1JN0hLAllhWD1OgSUqUAwGnQP3L4FIsci1ZiZ+XWUiQwQPj4cY6lyhQJbt4zf5cr3
         6/TCu4ze9QIAiVqtAi0CPgZbp6sVHUKdq34QVi63VohtQO7R5wH4YVZDFoNHL6woJAlf
         ExJmpWCVtMvbNAFSVUJC6Ml7rHAh93hvPVSU3R89ITIgjCHUCy9u+2gRUxxHrmmwdtCx
         uENA==
X-Forwarded-Encrypted: i=1; AJvYcCU9qpRYWq7qiTaiJMQedELrAu8EYS+UrM0h3V9ISQm7sHjwiFwkTNaHs8374KxaYDCmpHxmJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgTZ7slIKQLk9U8DnFJn+mSgdeh65R2kENr800xDMqpg91RlY7
	pYILe5br1pDtoioe7WW7sXymE9zAlCv7phbWabs2jHwULPrwHNr4wr1MVMQObf00JpKtNmR8okD
	ho/3oq17jWcp43A==
X-Received: from plbmh14.prod.google.com ([2002:a17:903:9ce:b0:2a0:a0e0:a9c3])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2448:b0:2a8:2c4a:3570 with SMTP id d9443c01a7336-2a933febfb8mr7195225ad.49.1770156601503;
 Tue, 03 Feb 2026 14:10:01 -0800 (PST)
Date: Tue,  3 Feb 2026 22:09:41 +0000
In-Reply-To: <20260203220948.2176157-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260203220948.2176157-1-skhawaja@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203220948.2176157-8-skhawaja@google.com>
Subject: [PATCH 07/14] iommu/vt-d: Restore IOMMU state and reclaimed domain ids
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

During boot fetch the preserved state of IOMMU unit and if found then
restore the state.

- Reuse the root_table that was preserved in the previous kernel.
- Reclaim the domain ids of the preserved domains for each preserved
  devices so these are not acquired by another domain.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      | 26 +++++++++++++++------
 drivers/iommu/intel/iommu.h      |  7 ++++++
 drivers/iommu/intel/liveupdate.c | 40 ++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c95de93fb72f..8acb7f8a7627 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -222,12 +222,12 @@ static void clear_translation_pre_enabled(struct intel_iommu *iommu)
 	iommu->flags &= ~VTD_FLAG_TRANS_PRE_ENABLED;
 }
 
-static void init_translation_status(struct intel_iommu *iommu)
+static void init_translation_status(struct intel_iommu *iommu, bool restoring)
 {
 	u32 gsts;
 
 	gsts = readl(iommu->reg + DMAR_GSTS_REG);
-	if (gsts & DMA_GSTS_TES)
+	if (!restoring && (gsts & DMA_GSTS_TES))
 		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
 }
 
@@ -670,10 +670,16 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 #endif
 
 /* iommu handling */
-static int iommu_alloc_root_entry(struct intel_iommu *iommu)
+static int iommu_alloc_root_entry(struct intel_iommu *iommu, struct iommu_ser *restored_state)
 {
 	struct root_entry *root;
 
+	if (restored_state) {
+		intel_iommu_liveupdate_restore_root_table(iommu, restored_state);
+		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
+		return 0;
+	}
+
 	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
 	if (!root) {
 		pr_err("Allocating root entry for %s failed\n",
@@ -1614,6 +1620,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 
 static int __init init_dmars(void)
 {
+	struct iommu_ser *iommu_ser = NULL;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	int ret;
@@ -1636,8 +1643,10 @@ static int __init init_dmars(void)
 						   intel_pasid_max_id);
 		}
 
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+
 		intel_iommu_init_qi(iommu);
-		init_translation_status(iommu);
+		init_translation_status(iommu, !!iommu_ser);
 
 		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
 			iommu_disable_translation(iommu);
@@ -1651,7 +1660,7 @@ static int __init init_dmars(void)
 		 * we could share the same root & context tables
 		 * among all IOMMU's. Need to Split it later.
 		 */
-		ret = iommu_alloc_root_entry(iommu);
+		ret = iommu_alloc_root_entry(iommu, iommu_ser);
 		if (ret)
 			goto free_iommu;
 
@@ -2110,15 +2119,18 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
 	struct intel_iommu *iommu = dmaru->iommu;
+	struct iommu_ser *iommu_ser = NULL;
 	int ret;
 
+	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+
 	/*
 	 * Disable translation if already enabled prior to OS handover.
 	 */
-	if (iommu->gcmd & DMA_GCMD_TE)
+	if (!iommu_ser && iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
 
-	ret = iommu_alloc_root_entry(iommu);
+	ret = iommu_alloc_root_entry(iommu, iommu_ser);
 	if (ret)
 		goto out;
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 70032e86437d..d7bf63aff17d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1283,6 +1283,8 @@ int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_se
 void intel_iommu_unpreserve_device(struct device *dev, struct device_ser *device_ser);
 int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
 void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_ser *iommu_ser);
 #else
 static inline int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
 {
@@ -1301,6 +1303,11 @@ static inline int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_
 static inline void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser)
 {
 }
+
+static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+							     struct iommu_ser *iommu_ser)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 82ba1daf1711..6dcb5783d1db 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -73,6 +73,46 @@ static int preserve_iommu_context(struct intel_iommu *iommu)
 	return ret;
 }
 
+static void restore_iommu_context(struct intel_iommu *iommu)
+{
+	struct context_entry *context;
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		context = iommu_context_addr(iommu, i, 0, 0);
+		if (context)
+			BUG_ON(!kho_restore_folio(virt_to_phys(context)));
+
+		if (!sm_supported(iommu))
+			continue;
+
+		context = iommu_context_addr(iommu, i, 0x80, 0);
+		if (context)
+			BUG_ON(!kho_restore_folio(virt_to_phys(context)));
+	}
+}
+
+static int __restore_used_domain_ids(struct device_ser *ser, void *arg)
+{
+	int id = ser->domain_iommu_ser.did;
+	struct intel_iommu *iommu = arg;
+
+	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);
+	return 0;
+}
+
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_ser *iommu_ser)
+{
+	BUG_ON(!kho_restore_folio(iommu_ser->intel.root_table));
+	iommu->root_entry = __va(iommu_ser->intel.root_table);
+
+	restore_iommu_context(iommu);
+	iommu_for_each_preserved_device(__restore_used_domain_ids, iommu);
+	pr_info("Restored IOMMU[0x%llx] Root Table at: 0x%llx\n",
+		iommu->reg_phys, iommu_ser->intel.root_table);
+}
+
 int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-- 
2.53.0.rc2.204.g2597b5adb4-goog

