Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389334404B
	for <iommu@lists.linux.dev>; Sat,  8 Aug 2026 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156056; cv=none; b=rFY+xkG6xy+UcAG2xro5WllXU/fsZ+qwYDecBkmwk2n4aCcP/IT6ZStufLWon96AXPhkubGERkadpPwyZdJr02PxI7Iy0k79V9qAvbUZWowcHyr0z6kbjRHBsFBuojpon1uxLfkbGmc6kvWgZO2xuLpN+LyaWwWPhh9HjtqpGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156056; c=relaxed/simple;
	bh=wk6QHPnPGRXitZNKbfRkct8Sthtz5L87uullwfFreP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MquLzCHfLqcFCi9xaFHuwhSSeCy5dv7W9BpKsQppIamHEbw7Xxsdl+hd3MEcTkdePC8euP7Pdc92UGfmRaJDsAee8uRAy9PozvrAx/LwFHwuzM/axCwo/Pzk2hXOaCeLG9ifaLE9aOiJBW0Pq7sqbLAVrSt510aFkUOpSuLsMWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imb0GIJl; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imb0GIJl"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8487eb67173so272638b3a.2
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 19:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156053; x=1786760853; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y7TYDjuStqNaV0dla1Hh8haFSR+gC9eBnxSq9JB8Fa8=;
        b=imb0GIJlJiEftf39GFN3nfNcqdoxAb52K2tooMvaTRw9pxFBa6d+mbc1JZosrBVkoY
         kH73eYL6IBriZaKW8VN/PkvuPBW/oIoamgTD6pCg7RxevtVyfY8TqSek731bQygPwI+R
         ZkhllDPrVxzNgcNuG0XgUFajro/xYX5jBthlJkAZ9eLunpXIq5IHiMFya4o4iMH3Em8K
         WxsVUZE+JtveMgYwvWIXm62ShixpKy89yxhrIqlszAOU1Hn6Zss8C+wsCbRbfFBlJAGO
         1asWJGuEJr8W83B+PkzoH9itg0IC4MHRPaz3jgUN4Pic6InhpyzmbfMSt3onksdbT4fp
         VBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156053; x=1786760853;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y7TYDjuStqNaV0dla1Hh8haFSR+gC9eBnxSq9JB8Fa8=;
        b=amzynMriiFoL+trVzVQdhSHBD03KKQIKYNxWJJ/7gegNj+HI682Ai5ROTBAiyX0Kwk
         Jvu1STYeYcNnNfa6XQSD+zAeIkdAadIIfmFRB7Qq13wYnAN5Yfj5eSUOPIkp7jTbHMVQ
         cJ9vSWgCDfYjocS7OWrm3+jsy1vq3jfCm3m5FByp8V/SWCJD178aHoAzwktmk5Ae3Dcu
         YP9Y2KE/G0qyYOjbcqc9yIiRL+Nd+XqoVTgMJRq5VsEjBCcjSX54eDMJD9ChT2sBi4yr
         +p57dEUjjn40Iad6xvvYaPi6UnRcwl41Bd+lVS9siwZSh1tiHCMUodd8T60dvs3kia1a
         uaLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5pMwouGHxU9sJVO6sYGAe7+oaNlF6EvCOpJdPcf/MuZ27PSDObzoreVKG3Wl/5KHmMlCEXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzAlU8fhpMYbsUbddMuOr1lFZRjC4cHJvJ5qk9TbuD8+/jeO/J
	qWZC8x9TIMk9qXBqw4Z6cR+/kR7B7Y/Bs2ZohqSaZrNOkufdiTo3hSpsWUAzo6/WIFDKMtZ6GU4
	3wF2/bFiA/N939A==
X-Received: from pfbga10.prod.google.com ([2002:a05:6a00:620a:b0:847:86fe:e9c2])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:88cd:0:b0:84a:2e5f:d697 with SMTP id d2e1a72fcca58-84f2e12cd51mr25459682b3a.33.1786156052416;
 Fri, 07 Aug 2026 19:27:32 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:15 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-11-skhawaja@google.com>
Subject: [PATCH v4 10/18] iommu/vt-d: Restore IOMMU state and reclaimed domain ids
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

During boot fetch the preserved state of IOMMU unit and if found then
restore the state.

- Reuse the root_table that was preserved in the previous kernel.
- Reclaim the domain ids of the preserved domains for each preserved
  devices so these are not acquired by another domain.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      | 111 +++++++++++++++++++------------
 drivers/iommu/intel/iommu.h      |   7 ++
 drivers/iommu/intel/liveupdate.c |  69 +++++++++++++++++++
 3 files changed, 144 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index eca3944d9cf5..42d3ff6db281 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -980,28 +980,30 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-static void disable_dmar_iommu(struct intel_iommu *iommu)
+static void release_dmar_iommu(struct intel_iommu *iommu)
 {
-	/*
-	 * All iommu domains must have been detached from the devices,
-	 * hence there should be no domain IDs in use.
-	 */
-	if (WARN_ON(!ida_is_empty(&iommu->domain_ida)))
-		return;
+	struct iommu_hw_ser *iommu_ser;
 
-	if (iommu->gcmd & DMA_GCMD_TE)
-		iommu_disable_translation(iommu);
-}
+	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+	if (!iommu_ser) {
+		/*
+		 * All iommu domains must have been detached from the devices,
+		 * hence there should be no domain IDs in use.
+		 */
+		WARN_ON(!ida_is_empty(&iommu->domain_ida));
+
+		if ((iommu->gcmd & DMA_GCMD_TE))
+			iommu_disable_translation(iommu);
+	}
 
-static void free_dmar_iommu(struct intel_iommu *iommu)
-{
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
@@ -1612,12 +1614,19 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 
 static int __init init_dmars(void)
 {
+	struct iommu_hw_ser *iommu_ser;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	int ret;
 
 	for_each_iommu(iommu, drhd) {
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
 		if (drhd->ignored) {
+			if (WARN_ON(iommu_ser)) {
+				ret = -EINVAL;
+				goto free_iommu;
+			}
+
 			iommu_disable_translation(iommu);
 			continue;
 		}
@@ -1635,7 +1644,9 @@ static int __init init_dmars(void)
 		}
 
 		intel_iommu_init_qi(iommu);
-		init_translation_status(iommu);
+
+		if (!iommu_ser)
+			init_translation_status(iommu);
 
 		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
 			iommu_disable_translation(iommu);
@@ -1644,14 +1655,18 @@ static int __init init_dmars(void)
 				iommu->name);
 		}
 
-		/*
-		 * TBD:
-		 * we could share the same root & context tables
-		 * among all IOMMU's. Need to Split it later.
-		 */
-		ret = iommu_alloc_root_entry(iommu);
-		if (ret)
-			goto free_iommu;
+		if (iommu_ser) {
+			intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
+		} else {
+			/*
+			 * TBD:
+			 * we could share the same root & context tables
+			 * among all IOMMU's. Need to Split it later.
+			 */
+			ret = iommu_alloc_root_entry(iommu);
+			if (ret)
+				goto free_iommu;
+		}
 
 		if (translation_pre_enabled(iommu)) {
 			pr_info("Translation already enabled - trying to copy translation structures\n");
@@ -1687,7 +1702,10 @@ static int __init init_dmars(void)
 	 */
 	for_each_active_iommu(iommu, drhd) {
 		iommu_flush_write_buffer(iommu);
-		iommu_set_root_entry(iommu);
+
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+		if (!iommu_ser)
+			iommu_set_root_entry(iommu);
 	}
 
 	check_tylersburg_isoch();
@@ -1732,10 +1750,8 @@ static int __init init_dmars(void)
 	return 0;
 
 free_iommu:
-	for_each_active_iommu(iommu, drhd) {
-		disable_dmar_iommu(iommu);
-		free_dmar_iommu(iommu);
-	}
+	for_each_active_iommu(iommu, drhd)
+		release_dmar_iommu(iommu);
 
 	return ret;
 }
@@ -2116,17 +2132,28 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
 	struct intel_iommu *iommu = dmaru->iommu;
+	struct iommu_hw_ser *iommu_ser;
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
-	if (ret)
-		goto out;
+	if (iommu_ser) {
+		if (WARN_ON(dmaru->ignored))
+			return -EINVAL;
+
+		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
+	} else {
+		ret = iommu_alloc_root_entry(iommu);
+		if (ret)
+			goto out;
+	}
 
 	intel_svm_check(iommu);
 
@@ -2145,23 +2172,23 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (ecap_prs(iommu->ecap)) {
 		ret = intel_iommu_enable_prq(iommu);
 		if (ret)
-			goto disable_iommu;
+			goto out;
 	}
 
 	ret = dmar_set_interrupt(iommu);
 	if (ret)
-		goto disable_iommu;
+		goto out;
+
+	if (!iommu_ser)
+		iommu_set_root_entry(iommu);
 
-	iommu_set_root_entry(iommu);
 	iommu_enable_translation(iommu);
 
 	iommu_disable_protect_mem_regions(iommu);
 	return 0;
 
-disable_iommu:
-	disable_dmar_iommu(iommu);
 out:
-	free_dmar_iommu(iommu);
+	release_dmar_iommu(iommu);
 	return ret;
 }
 
@@ -2175,12 +2202,10 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 	if (iommu == NULL)
 		return -EINVAL;
 
-	if (insert) {
+	if (insert)
 		ret = intel_iommu_add(dmaru);
-	} else {
-		disable_dmar_iommu(iommu);
-		free_dmar_iommu(iommu);
-	}
+	else
+		release_dmar_iommu(iommu);
 
 	return ret;
 }
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6c971f04ead3..b33a12528066 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1307,6 +1307,8 @@ int intel_iommu_preserve(struct iommu_device *iommu,
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
 void clear_unpreserved_context_entries(struct intel_iommu *iommu);
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_hw_ser *iommu_ser);
 #else
 static inline int intel_iommu_preserve_device(struct device *dev,
 					      struct iommu_device_ser *device_ser)
@@ -1333,6 +1335,11 @@ static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
 static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
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
index b5aaebeeb5c1..480eab2d966b 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -273,6 +273,75 @@ static int preserve_iommu_context_tables(struct device_domain_info *info)
 	return 0;
 }
 
+static void restore_iommu_context(struct intel_iommu *iommu)
+{
+	struct context_entry *context;
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		context = iommu_context_addr(iommu, i, 0, 0);
+		if (context)
+			iommu_restore_pages(virt_to_phys(context));
+
+		if (!sm_supported(iommu))
+			continue;
+
+		context = iommu_context_addr(iommu, i, 0x80, 0);
+		if (context)
+			iommu_restore_pages(virt_to_phys(context));
+	}
+}
+
+static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
+{
+	int id = ser->domain_iommu_ser.attachment_id;
+	struct iommu_hw_ser *iommu_hw_ser;
+	struct intel_iommu *iommu = arg;
+
+	if (WARN_ON(!ser->domain_iommu_ser.iommu_phys))
+		return 0;
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
+/**
+ * intel_iommu_liveupdate_restore_root_table() - Restore root table and reclaim domain IDs
+ * @iommu: Target IOMMU
+ * @iommu_ser: Serialized IOMMU hardware state from previous kernel
+ *
+ * Restores the preserved root table and context tables for the IOMMU hardware
+ * instance across Live Update, and reclaims all domain IDs previously allocated
+ * to preserved devices so they are not reused.
+ */
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_hw_ser *iommu_ser)
+{
+	if (!iommu_ser->intel.restored)
+		iommu_restore_pages(iommu_ser->intel.root_table);
+
+	iommu->root_entry = __va(iommu_ser->intel.root_table);
+
+	if (!iommu_ser->intel.restored)
+		restore_iommu_context(iommu);
+
+	iommu_ser->intel.restored = 1;
+	BUG_ON(iommu_for_each_preserved_device(_restore_used_domain_ids, iommu));
+}
+
 /**
  * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
  * @dev: Target device
-- 
2.55.0.679.g6767b8d81c-goog

