Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283724;
	b=DpIAr/ymAdJyrEt+n+2euBYs251dVr5svDERycaUce0gkpBWFU9rCGvX+zKaDAyiCWuK
	 J1Y0pZaOiF8GCM9reyx+4mGNPb1MG+7bSD6we/ZGTHijbLhEsFowr60thK8mtXk3RWVWH
	 cu7+McR4RZzW/P1DdOvC4R7cBtnkTa7397I/XVPSTXUoWQm0Kgo1yrIblKhbFOPpoiSyp
	 XpCwKI5Ieq/QgUceBHIau5F4FhOlRzgG3YCldWqQR8lpQPwpbb29wWOUsErl8ayCe2/vV
	 llxxIvYHLoDpyzJODvpZT46G63tk3LBpi1JtoIGLBj/FgleXBgiBBh0Ozw7+QQ1dtDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nI2Rle82Cu32iBDQQwdsnuZ3D0SzI6v5r4jQwcZSosk=;
	b=BwnBqz2z+K0hYViAzcw12P2GBwisCuRN2RBv3RqDwX8cFk3+RAc81LD+6Eih1ezeRbSK
	 YP8eRR6aOVKsvXLkh3TrwxpHa0WhKtz8QJ4f4RV4VuEozXeDs/WvAsP8uAjVqgiayH2yt
	 ySFVDYwAR4U/DErXgnkOhewWk/Vl/CMQygEwOZ9t/8LsPb7YaSlqCsR3HsdF+G4C4fnnh
	 yatg5P8renz2t8uBvUE2I2gtIbr0xX8MDE31d5Yqt0swEcknscic7uHWUytf7CPIlZDWg
	 D33h0l47D+uInL8SoILmL8Lv597jM6Ug+2HQqVT0Xa8Z4CA9TrSepU/ysTBYnwWvVxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mGqWyNFa;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8AB606CF07
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F8AB606CF07
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mGqWyNFa
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c55ba309c2so2021139b6e.1
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 20:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283723; x=1794888523; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nI2Rle82Cu32iBDQQwdsnuZ3D0SzI6v5r4jQwcZSosk=;
        b=mGqWyNFaHnly7YcyL3qWdEvI3E0VuJouIqiO0gHhI2FHQlJPs7MbJuuB69JuCFKMjT
         jK4NsSVd2dZIyCNhMibtN87A7oOsIkxmFJHasfClveCLp3sndZl8o8Rr/SnlikvGu8z7
         TsAKncjt+mgadnIO+5bEn62ZTkTkbh8PTcmLmttZRd8k2HqcbE47kxOyhcZkwD7UKKYn
         HsmCGbSU/suj3mNdhG9tAewSDrd9y0Dy7SKSfLOvtPAptWP40X/2d/yYGZWB1orGtRi+
         VYXTXJLXaxHJJfCeDUMJo8NvVwEXgRgdXa+7c6WI0IolwV0HYhzzEJtg2m0GwjeW/udh
         5A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283723; x=1794888523;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nI2Rle82Cu32iBDQQwdsnuZ3D0SzI6v5r4jQwcZSosk=;
        b=OmB4DQeJDGMa8Z9UfjpwN9l5h1av2C0Y79bhOpfirPICUXOJ35zi3lWqDN1j2co7nn
         7gC+b8/YjrzjQTAgeYyo5kZF+yLaebNTdyOelQ3SI0r47+M1a8mD2A9EiljDqFme6TzQ
         uchy9MKJ+jxjwoCiQIbPKWFAZnqHDkmcq8XeTSbNcaJP5uyR0ewOPhPnub4N2YkCeDTv
         0pG6oGME+2Up2yCtvV7noMq7aqYFT4X170hBnl5VL8q0WH3udvGR+f7gmavTzXeDu1MX
         3vMNgWCjUmsiXccyRU2xJKirz29hMl0TE6UA1lxQR03nbjV/MirsnHmCpHL2/MYi+GMP
         EKGA==
X-Forwarded-Encrypted: i=1; AL+hErFuc6jJFkTmbuss+HaWpMIltBiSiM3ViXeCtK6P56ZrUm4Kqe3T7Dta7BIzpdCghTm+K7AAcQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8p5ZAjRnb3u8IwXY/DCI7ISGnQhXlieIt24g/Te7nWpHtGRn7t
	qk5m1BmltmIPxXvJaTOlssu401NtoCaPXU85bPxI0za8uwzBhjAsIDIHfipNgkX4j7vRPFXCIrp
	9evrIpGZfJcDY7g==
X-Received: from iox14.prod.google.com ([2002:a05:6602:490e:b0:9c4:b9d9:b8b3])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:f0b:b0:4e7:8f9b:1185 with SMTP id 5614622812f47-5683c9e18cbmr1454073b6e.3.1794283722934;
 Mon, 09 Nov 2026 20:08:42 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:16 +0000
In-Reply-To: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110040828.1774343-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110040828.1774343-11-skhawaja@google.com>
Subject: [PATCH v7 10/18] iommu/vt-d: Restore IOMMU state and reclaimed domain ids
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

During boot fetch the preserved state of IOMMU unit and if found then
restore the state.

- Reuse the root_table that was preserved in the previous kernel.
- Reclaim the domain ids of the preserved domains for each preserved
  devices so these are not acquired by another domain.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |  57 ++++++++++---
 drivers/iommu/intel/iommu.h      |  14 ++++
 drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6c86c155d12b..a83971368bef 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -987,6 +987,8 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 
 static void release_dmar_iommu(struct intel_iommu *iommu)
 {
+	intel_iommu_handle_drhd_restore_failure(iommu);
+
 	/*
 	 * All iommu domains must have been detached from the devices,
 	 * hence there should be no domain IDs in use.
@@ -1452,7 +1454,7 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
  * Returns 0 when the ID is reserved, was already reserved, or cannot be
  * re-assigned, and a negative errno for a genuine allocation failure.
  */
-static int reserve_domain_id(struct intel_iommu *iommu, int did)
+int reserve_domain_id(struct intel_iommu *iommu, int did)
 {
 	int ret;
 
@@ -1743,12 +1745,16 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 
 static int __init init_dmars(void)
 {
+	struct iommu_hw_ser *iommu_ser;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	int ret;
 
 	for_each_iommu(iommu, drhd) {
+		iommu_ser = iommu_get_restored_state(iommu->reg_phys,
+						     IOMMU_SER_TYPE_INTEL);
 		if (drhd->ignored) {
+			intel_iommu_handle_drhd_restore_failure(iommu);
 			iommu_disable_translation(iommu);
 			continue;
 		}
@@ -1766,7 +1772,9 @@ static int __init init_dmars(void)
 		}
 
 		intel_iommu_init_qi(iommu);
-		init_translation_status(iommu);
+
+		if (!iommu_ser)
+			init_translation_status(iommu);
 
 		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
 			iommu_disable_translation(iommu);
@@ -1775,14 +1783,18 @@ static int __init init_dmars(void)
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
@@ -1818,7 +1830,11 @@ static int __init init_dmars(void)
 	 */
 	for_each_active_iommu(iommu, drhd) {
 		iommu_flush_write_buffer(iommu);
-		iommu_set_root_entry(iommu);
+
+		iommu_ser = iommu_get_restored_state(iommu->reg_phys,
+						     IOMMU_SER_TYPE_INTEL);
+		if (!iommu_ser)
+			iommu_set_root_entry(iommu);
 	}
 
 	check_tylersburg_isoch();
@@ -2247,6 +2263,15 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	struct intel_iommu *iommu = dmaru->iommu;
 	int ret;
 
+	/*
+	 * Hot-add of an IOMMU with preserved state is not supported. A
+	 * preserved IOMMU is restored during boot, so it should never get
+	 * here.
+	 */
+	if (WARN_ON(iommu_get_restored_state(iommu->reg_phys,
+					     IOMMU_SER_TYPE_INTEL)))
+		return -EBUSY;
+
 	/*
 	 * Disable translation if already enabled prior to OS handover.
 	 */
@@ -2797,7 +2822,8 @@ int __init intel_iommu_init(void)
 		 * to avoid unnecessary lock order splat.
 		 */
 		up_read(&dmar_global_lock);
-		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
+		if (iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL))
+			intel_iommu_handle_drhd_restore_failure(iommu);
 		down_read(&dmar_global_lock);
 
 		iommu_pmu_register(iommu);
@@ -2808,7 +2834,12 @@ int __init intel_iommu_init(void)
 
 	/* Finally, we enable the DMA remapping hardware. */
 	for_each_iommu(iommu, drhd) {
-		if (!drhd->ignored && !translation_pre_enabled(iommu))
+		/*
+		 * The translation of a restored IOMMU was never disabled, so
+		 * don't touch its GCMD register.
+		 */
+		if (!drhd->ignored && !translation_pre_enabled(iommu) &&
+		    !iommu_get_restored_state(iommu->reg_phys, IOMMU_SER_TYPE_INTEL))
 			iommu_enable_translation(iommu);
 
 		iommu_disable_protect_mem_regions(iommu);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 92697346c44b..633747672c22 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1307,6 +1307,8 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
 	return 0;
 }
 
+int reserve_domain_id(struct intel_iommu *iommu, int did);
+
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int intel_iommu_preserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser);
@@ -1317,10 +1319,22 @@ int intel_iommu_preserve(struct iommu_device *iommu,
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
 void intel_iommu_shutdown_preserved(struct dmar_drhd_unit *drhd);
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_hw_ser *iommu_ser);
+void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu);
 #else
 static inline void intel_iommu_shutdown_preserved(struct dmar_drhd_unit *drhd)
 {
 }
+
+static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+							     struct iommu_hw_ser *iommu_ser)
+{
+}
+
+static inline void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index c0c121bc3ea5..d43947879e78 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -304,6 +304,145 @@ static int preserve_iommu_context_tables(struct device_domain_info *info)
 	return 0;
 }
 
+static int restore_context_table(struct intel_iommu *iommu,
+				 struct iommu_hw_ser *ser,
+				 u8 bus, u8 devfn, u64 root_val)
+{
+	bool present = root_val & 1;
+
+	/*
+	 * The root entries of unpreserved context tables are cleared during
+	 * shutdown, so the preserved bitmap must match the present bits.
+	 */
+	if (is_context_table_preserved(iommu, ser, bus, devfn) != present)
+		return -EINVAL;
+
+	if (present)
+		iommu_restore_pages(root_val & VTD_PAGE_MASK);
+
+	return 0;
+}
+
+static int restore_iommu_context(struct intel_iommu *iommu,
+				 struct iommu_hw_ser *ser)
+{
+	struct root_entry *root;
+	int ret;
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		root = &iommu->root_entry[i];
+
+		ret = restore_context_table(iommu, ser, i, 0, root->lo);
+		if (ret)
+			return ret;
+
+		if (!sm_supported(iommu))
+			continue;
+
+		ret = restore_context_table(iommu, ser, i, 0x80, root->hi);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
+{
+	int id = ser->attachment.attachment_id;
+	struct iommu_hw_ser *iommu_hw_ser;
+	struct intel_iommu *iommu = arg;
+
+	if (WARN_ON(!ser->iommu_phys))
+		return 0;
+
+	iommu_hw_ser = phys_to_virt(ser->iommu_phys);
+	if (iommu_hw_ser->type != IOMMU_SER_TYPE_INTEL)
+		return 0;
+
+	/* Only allocate domain ID from associated IOMMU HW unit */
+	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
+		return 0;
+
+	/* An out of range domain ID means the preserved state is corrupt. */
+	if (id < 0 || id >= iommu->max_domain_id)
+		return -EINVAL;
+
+	return reserve_domain_id(iommu, id);
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
+ *
+ * The preserved devices keep doing DMA through the preserved translation
+ * tables, so a failure to restore them is fatal.
+ */
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_hw_ser *iommu_ser)
+{
+	u64 rtaddr;
+	u32 gsts;
+	int ret;
+
+	/*
+	 * The kernel command line might have changed across kexec, e.g.
+	 * intel_iommu=sm_off, so make sure the preserved tables are in the
+	 * format this kernel is going to use.
+	 */
+	if (iommu_ser->intel.sm_enabled != sm_supported(iommu))
+		panic("%s: preserved scalable mode %u does not match current %u\n",
+		      iommu->name, iommu_ser->intel.sm_enabled,
+		      sm_supported(iommu));
+
+	/*
+	 * The preserved devices are still translated by the hardware, so it
+	 * must be using the preserved root table.
+	 */
+	gsts = readl(iommu->reg + DMAR_GSTS_REG);
+	rtaddr = readq(iommu->reg + DMAR_RTADDR_REG);
+	if (!(gsts & DMA_GSTS_TES) ||
+	    (rtaddr & VTD_PAGE_MASK) != iommu_ser->intel.root_table ||
+	    !!(rtaddr & DMA_RTADDR_SMT) != !!iommu_ser->intel.sm_enabled)
+		panic("%s: hardware state does not match preserved state (GSTS 0x%x, RTADDR 0x%llx)\n",
+		      iommu->name, gsts, rtaddr);
+
+	iommu_restore_pages(iommu_ser->intel.root_table);
+	iommu->root_entry = phys_to_virt(iommu_ser->intel.root_table);
+
+	ret = restore_iommu_context(iommu, iommu_ser);
+	if (ret)
+		panic("%s: failed to restore preserved context tables\n",
+		      iommu->name);
+
+	ret = iommu_for_each_restored_device(_restore_used_domain_ids, iommu);
+	if (ret)
+		panic("%s: failed to reclaim preserved domain IDs: %d\n",
+		      iommu->name, ret);
+}
+
+/**
+ * intel_iommu_handle_drhd_restore_failure() - Handle DRHD restore failure
+ * @iommu: Target IOMMU
+ */
+void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
+{
+	/*
+	 * The preserved devices keep doing DMA through the preserved
+	 * translation tables, so a failure to restore and register the IOMMU
+	 * is fatal.
+	 */
+	if (iommu_get_restored_state(iommu->reg_phys, IOMMU_SER_TYPE_INTEL))
+		panic("%s: failed to restore IOMMU with preserved state\n",
+		      iommu->name);
+}
+
 /**
  * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
  * @dev: Target device
-- 
2.56.0.506.g506a7eabc5-goog

