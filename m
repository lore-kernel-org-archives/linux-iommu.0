Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90E3ECBE9
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312614; cv=none; b=kD3G/yOLuMuoyn5MqSxA+n/E/kToTDVjzrajL8mw5uj24kb+bz2QKwWXCn+tGW/nniYWu/WItKUhF101zWEQh6HyNn0WOrPXei7n43pq50MmrJjGv65Lc0V/k3ERjO7RzbuEDsALGUGrY1QK8nVMoYz96fkD3XPtOxvHRI+nS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312614; c=relaxed/simple;
	bh=6nBaQ6D2ziNJSypxAJHHLkeMe9q8uznyXgaJVYCSqMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fW/6iLGIkWIUafW9zb2XWDWsfb4sqz/qT/QgNl0/hH/1xFiN3/GRBxXtS2oqI8tlxo05TTiFG26pk+d5GnFbKATrtfLb7LvrXJb0DiwVKPsNTHZ2EXTp5LG6pphcaRtVCCAu5cz9MlpjBGUZwv7PCWnuyj//d/ojBr2zxdoq6iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkYh5enJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkYh5enJ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b258636d16so104542065ad.2
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312611; x=1777917411; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FgepGlIn3dgPdNPVEUVBrz4Xg2AteQ+CTkWl42bZNSE=;
        b=vkYh5enJkr2q4it9MX8TR8yd6+B/h7ayG+SsdVgKt/3mZvcFL+DOyZ4RnemoV0OkZK
         8av+GGbHt0L4plIP0xBts6pQe8nS42PVj7j36obH9w+BuAh/OhuYJhSji1l3tOqR3KGw
         P/ElYqEYRPCQLgMTpIGBWpFHOdn57Y5dApk4xlFYiMX7QhSTnwUQChQvKuhKrxIaH1O1
         Ad6jazC8hNz/IuGOzVec6AWf3+xVhtQ6yTZjXxpU4bUib9ZqdIhEtHiDJEu6xKoIYanK
         ztW4Ir21MXkXihT2bnKt92jyPvNMGu9/MpYxlF3UxMUaD8qj0tFbR2SCEeoFy+kRBqDv
         xDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312611; x=1777917411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgepGlIn3dgPdNPVEUVBrz4Xg2AteQ+CTkWl42bZNSE=;
        b=X57sYoAVw/n1SoEkNgcjaUNlLUHZ+sbkc5A+HvKF3A1FXU44ivC1kFd2fwEsmlDsel
         x+7iohjXJaO4KeVSZ+6dPmrc2wZOpitGEvyr8pzAK6V1CMBf3bfPI90RO2haC5oCGXDG
         Njrzt6mn7gSs6C3RS7y6e/YVb0ce/SKl7myaGJ87VsnoiOhc3iIAEdrVXii/8+oeGsg1
         y37UPlWEqaAiL5fJzJsZgG6c5z4xwakjH9tfUJRlW8+85e1AdEVd7yTKL8mnUqKJbKM2
         p6Dtz8oDSoFM6S96NAtUexO1XAH6A1ix/gHfTHPUWzv7RgLAwluJqCoN9YWjorFJ7zqv
         9Rqg==
X-Forwarded-Encrypted: i=1; AFNElJ93ZPNvJPhgyFOJdaqEJisl/FTNfuW1fjX8N/wxSOFt7XqdkGq4/jm+GNp9txZobfrKhYoVKg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwxIcO5BnOvJwvvQbe4BmULojn4R+agGPvrDptRttb8kmW5MBiD
	IVuHd/xIawd/VcEQ3hTWY+8f3ZMaBo6X/jiloBVkQ9JWKB5PqMbzgPI69Dg4nlDjmHHabBlZTt8
	+jA9MMPvqrMDazA==
X-Received: from plip13.prod.google.com ([2002:a17:903:38cd:b0:2b4:5901:94ba])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3348:b0:2b7:ac66:27ff with SMTP id d9443c01a7336-2b97a933f40mr1685975ad.25.1777312610651;
 Mon, 27 Apr 2026 10:56:50 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:26 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-10-skhawaja@google.com>
Subject: [PATCH v2 09/16] iommu/vt-d: Restore IOMMU state and reclaimed domain ids
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
 drivers/iommu/intel/iommu.c      | 55 ++++++++++++++++++++++--------
 drivers/iommu/intel/iommu.h      |  7 ++++
 drivers/iommu/intel/liveupdate.c | 57 ++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 68fecd4e57fa..4118a0861f38 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -670,10 +670,17 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 #endif
 
 /* iommu handling */
-static int iommu_alloc_root_entry(struct intel_iommu *iommu)
+static int iommu_alloc_root_entry(struct intel_iommu *iommu,
+				  struct iommu_hw_ser *iommu_ser)
 {
 	struct root_entry *root;
 
+	if (iommu_ser) {
+		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
+		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
+		return 0;
+	}
+
 	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
 	if (!root) {
 		pr_err("Allocating root entry for %s failed\n",
@@ -992,15 +999,16 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 		iommu_disable_translation(iommu);
 }
 
-static void free_dmar_iommu(struct intel_iommu *iommu)
+static void free_dmar_iommu(struct intel_iommu *iommu, struct iommu_hw_ser *iommu_ser)
 {
 	if (iommu->copied_tables) {
 		bitmap_free(iommu->copied_tables);
 		iommu->copied_tables = NULL;
 	}
 
-	/* free context mapping */
-	free_context_table(iommu);
+	/* free context mapping if there is no serialized state. */
+	if (!iommu_ser)
+		free_context_table(iommu);
 
 	if (ecap_prs(iommu->ecap))
 		intel_iommu_finish_prq(iommu);
@@ -1611,6 +1619,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 
 static int __init init_dmars(void)
 {
+	struct iommu_hw_ser *iommu_ser = NULL;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	int ret;
@@ -1633,8 +1642,12 @@ static int __init init_dmars(void)
 						   intel_pasid_max_id);
 		}
 
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+
 		intel_iommu_init_qi(iommu);
-		init_translation_status(iommu);
+
+		if (!iommu_ser)
+			init_translation_status(iommu);
 
 		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
 			iommu_disable_translation(iommu);
@@ -1648,7 +1661,7 @@ static int __init init_dmars(void)
 		 * we could share the same root & context tables
 		 * among all IOMMU's. Need to Split it later.
 		 */
-		ret = iommu_alloc_root_entry(iommu);
+		ret = iommu_alloc_root_entry(iommu, iommu_ser);
 		if (ret)
 			goto free_iommu;
 
@@ -1732,8 +1745,12 @@ static int __init init_dmars(void)
 
 free_iommu:
 	for_each_active_iommu(iommu, drhd) {
-		disable_dmar_iommu(iommu);
-		free_dmar_iommu(iommu);
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+
+		if (!iommu_ser)
+			disable_dmar_iommu(iommu);
+
+		free_dmar_iommu(iommu, iommu_ser);
 	}
 
 	return ret;
@@ -2107,15 +2124,19 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
 	struct intel_iommu *iommu = dmaru->iommu;
+	struct iommu_hw_ser *iommu_ser = NULL;
 	int ret;
 
+	/* Use IOMMU HW unit MMIO base to identify the preserved state. */
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
 
@@ -2150,9 +2171,10 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	return 0;
 
 disable_iommu:
-	disable_dmar_iommu(iommu);
+	if (!iommu_ser)
+		disable_dmar_iommu(iommu);
 out:
-	free_dmar_iommu(iommu);
+	free_dmar_iommu(iommu, iommu_ser);
 	return ret;
 }
 
@@ -2160,6 +2182,7 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 {
 	int ret = 0;
 	struct intel_iommu *iommu = dmaru->iommu;
+	struct iommu_hw_ser *iommu_ser;
 
 	if (!intel_iommu_enabled)
 		return 0;
@@ -2169,8 +2192,12 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 	if (insert) {
 		ret = intel_iommu_add(dmaru);
 	} else {
-		disable_dmar_iommu(iommu);
-		free_dmar_iommu(iommu);
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+
+		if (!iommu_ser)
+			disable_dmar_iommu(iommu);
+
+		free_dmar_iommu(iommu, iommu_ser);
 	}
 
 	return ret;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5e0bc17e76bf..b0ec0b471a43 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1293,6 +1293,8 @@ int intel_iommu_preserve(struct iommu_device *iommu,
 			 struct iommu_hw_ser *iommu_ser);
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_hw_ser *iommu_ser);
 #else
 static inline int intel_iommu_preserve_device(struct device *dev,
 					      struct iommu_device_ser *device_ser)
@@ -1310,6 +1312,11 @@ static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
 					  struct iommu_hw_ser *iommu_ser)
 {
 }
+
+static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+							     struct iommu_hw_ser *iommu_ser)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 75fa68b701bf..50a63812533f 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -83,6 +83,63 @@ static int preserve_iommu_context_table(struct intel_iommu *iommu)
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
+static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
+{
+	int id = ser->domain_iommu_ser.attachment_id;
+	struct iommu_hw_ser *iommu_hw_ser;
+	struct intel_iommu *iommu = arg;
+
+	iommu_hw_ser = phys_to_virt(ser->domain_iommu_ser.iommu_phys);
+	if (iommu_hw_ser->type != IOMMU_INTEL)
+		return 0;
+
+	/* Only allocate domain ID from associated IOMMU HW unit */
+	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
+		return 0;
+
+	/*
+	 * This can fail as multiple preserved devices can share the same domain
+	 * ID. Since this is done during DMAR init so these failures can be
+	 * ignored.
+	 */
+	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);
+	return 0;
+}
+
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_hw_ser *iommu_ser)
+{
+	if (!iommu_ser->intel.restored)
+		BUG_ON(!kho_restore_folio(iommu_ser->intel.root_table));
+
+	iommu->root_entry = __va(iommu_ser->intel.root_table);
+
+	if (!iommu_ser->intel.restored)
+		restore_iommu_context(iommu);
+
+	iommu_ser->intel.restored = 1;
+	iommu_for_each_preserved_device(_restore_used_domain_ids, iommu);
+}
+
 int intel_iommu_preserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser)
 {
-- 
2.54.0.545.g6539524ca2-goog

