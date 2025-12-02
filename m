Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10630BB80
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716623; cv=none; b=Zp4KhvN+NzIo3Voh9y0NNxDhe/CUucF7unAVL7XQ7fGJLjScH3npE5r2CN7dQDdqstIFwv3T3MPfySwBcqIKijYj1MQxNiB4Oo6HzRmH1Jw49moOJqqLwQq82mAyciCFlyEWttPZ/icYswoHFZ42Aclvaj1VyTABY4WaIcuTh80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716623; c=relaxed/simple;
	bh=5GD10ZU0KhW6zeLHK/hyK2hQghVTgOyKdURXNa1nQY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DskgWKt5BhVTiO2aWi94HhGNBU6ohtswybmWPs62swIspnKL+A7aQVvouIjbRVSIyZRmw2zPgmfAhv8SvOCd0CaDQbCTWWPncu2QR4Cbq2V89e/1dc2s1P/PAiObqNRtSq1sPZjjiO5SuZbgPEYTGmCZhK3lVf5tajVH0VSy4qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xiG4Ng0j; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xiG4Ng0j"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340bc4ef67fso6781182a91.3
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716621; x=1765321421; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fRG4Lrj/9WUyhWaNYVWHNxqEVSERVnybunCSAx6MXk=;
        b=xiG4Ng0jjjX36Q7UoQh4gFI5IgOppRlX9XkOJkHZTyNmcxW9bL9yfLJDmdKNlUmVsR
         eJP6o4jIeMYUaeG7NUxkvOIeTsIhjuPH8aIcL+7hR3pNJm4CXQ+WtBrPT6C8iUck1che
         z2qbSG0mdtQxbzEm2dxcdPWKpR1RFt4oDlnL+K7JY9osTUv1eMyaJCZJgC5UZmeheE5D
         MCg8wq2phwrFxjbqyEyaaEF2YJJerCKjE46OB1sQvzXi9a6zOGvHCAbCnsc0vYLhRxkj
         6AMay2DU+R+bCzMtjARcQDsO7bQzyDHRUoRXQgdp4a/AkwDmJawxQRK9ad5tk6nBWDp8
         ib4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716621; x=1765321421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fRG4Lrj/9WUyhWaNYVWHNxqEVSERVnybunCSAx6MXk=;
        b=Nk//ewMnzTfBKm7m7DXgxAMNh+YEXHaK0onDJ3dlvFgDi+9Xg35wMqLOJ6ZMKtzG9I
         m2RR0Hq75CE51aKStjbf/bbKG8Y8TXGdgs1wDTC2qi4xE0ijyDNy5A/OUGy3Fhv2JNuO
         fWX0A6I8Sg+vYodygwTiRpxLYdqDVV9X41hED/IHGJXk/mZqI90LvSVueZQgkLTVcu92
         agT52aQU3C3VnLT5Sr8199DS8DRjiDKM0lCzIvGGzpRZnvQ68iVd/w1PSX3Wjf74URNS
         ZT/2BuYaVXjA6D1olGFjNcKqnv6X2N4eXwZ6LAEmp7q/agXXDXVIq2oAnIevD+iSaf6v
         OvSA==
X-Forwarded-Encrypted: i=1; AJvYcCU2H9jGpQOzxP52AI3QWWoF8c+84T/cBvmBw7f0LSxw3tMpgX7xGHQ/Fxqmu5PhuNoVy/jtSw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJJBil2XK6dGyzP+YR0eFgZlpOs1HXVcfhuAYN9nrre3t6hxss
	YIaOYjyxqBcvpo06ZVwtCcJ6nXIkcozsTZBj68aS4PPZxNV7pSbxQWJG6R4QKEKp24dX6mmBnVN
	M+p1IdstnCB051g==
X-Google-Smtp-Source: AGHT+IGsuqCnXTY/yfM/J9XhXwgiuCWsZNUKQ4WZHM9VOE70Vn+/1b9na61r8+ZiPT2RVcwfHONXe0xUL01LIQ==
X-Received: from pjbnw12.prod.google.com ([2002:a17:90b:254c:b0:341:8b2e:afe9])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:51cf:b0:340:dcd4:f851 with SMTP id 98e67ed59e1d1-349125cfb65mr391052a91.3.1764716621289;
 Tue, 02 Dec 2025 15:03:41 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:54 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-25-skhawaja@google.com>
Subject: [RFC PATCH v2 24/32] iommu/vt-d: restore state of the preserved IOMMU
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

During boot fetch the preserved state of IOMMU unit and if found then
restore the state. Reuse the root_table that was preserved in the
previous kernel.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      | 30 ++++++++++++++++++++++++------
 drivers/iommu/intel/iommu.h      |  2 ++
 drivers/iommu/intel/liveupdate.c | 30 ++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 84fef81ecf4d..888351f91918 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -224,12 +224,12 @@ static void clear_translation_pre_enabled(struct intel_iommu *iommu)
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
 
@@ -672,10 +672,18 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 #endif
 
 /* iommu handling */
-static int iommu_alloc_root_entry(struct intel_iommu *iommu)
+static int iommu_alloc_root_entry(struct intel_iommu *iommu, struct iommu_ser *restored_state)
 {
 	struct root_entry *root;
 
+#if CONFIG_LIVEUPDATE
+	if (restored_state) {
+		intel_iommu_liveupdate_restore_root_table(iommu, restored_state);
+		/* Should not be needed since the entries are already cleaned in last kernel. */
+		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
+		return 0;
+	}
+#endif
 	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
 	if (!root) {
 		pr_err("Allocating root entry for %s failed\n",
@@ -1616,6 +1624,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 
 static int __init init_dmars(void)
 {
+	struct iommu_ser *iommu_ser = NULL;
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	int ret;
@@ -1638,8 +1647,12 @@ static int __init init_dmars(void)
 						   intel_pasid_max_id);
 		}
 
+#if IS_ENABLED(CONFIG_LIVEUPDATE)
+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+#endif
+
 		intel_iommu_init_qi(iommu);
-		init_translation_status(iommu);
+		init_translation_status(iommu, !!iommu_ser);
 
 		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
 			iommu_disable_translation(iommu);
@@ -1653,7 +1666,7 @@ static int __init init_dmars(void)
 		 * we could share the same root & context tables
 		 * among all IOMMU's. Need to Split it later.
 		 */
-		ret = iommu_alloc_root_entry(iommu);
+		ret = iommu_alloc_root_entry(iommu, iommu_ser);
 		if (ret)
 			goto free_iommu;
 
@@ -2112,6 +2125,7 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
 	struct intel_iommu *iommu = dmaru->iommu;
+	struct iommu_ser *iommu_ser = NULL;
 	int ret;
 
 	/*
@@ -2120,7 +2134,11 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	if (iommu->gcmd & DMA_GCMD_TE)
 		iommu_disable_translation(iommu);
 
-	ret = iommu_alloc_root_entry(iommu);
+#if IS_ENABLED(CONFIG_LIVEUPDATE)
+	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
+#endif
+
+	ret = iommu_alloc_root_entry(iommu, iommu_ser);
 	if (ret)
 		goto out;
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1eb60ce1300f..b0c56e27f167 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1283,6 +1283,8 @@ int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_se
 void intel_iommu_unpreserve_device(struct device *dev, struct device_ser *device_ser);
 int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
 void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_ser *iommu_ser);
 bool intel_iommu_liveupdate_clear_context_entries(struct intel_iommu *iommu);
 #endif
 
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 3f8c7f15bc36..140887187084 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -73,6 +73,36 @@ static int preserve_iommu_context(struct intel_iommu *iommu)
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
+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
+					       struct iommu_ser *iommu_ser)
+{
+	BUG_ON(!kho_restore_folio(iommu_ser->intel.root_table));
+	iommu->root_entry = __va(iommu_ser->intel.root_table);
+
+	restore_iommu_context(iommu);
+	pr_info("Restored IOMMU[0x%llx] Root Table at: 0x%llx\n",
+		iommu->reg_phys, iommu_ser->intel.root_table);
+}
+
 int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
-- 
2.52.0.158.g65b55ccf14-goog

