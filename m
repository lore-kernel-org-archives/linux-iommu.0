Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5729E117
	for <iommu@lists.linux.dev>; Sat,  8 Aug 2026 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156054; cv=none; b=MF6MYdaeWQCIm9gB37SSLrbGWnrpKlR7/bhT8JDIAHjqp3T3ss4gVgACj8dea+yaRkrmIW0cPSsZ5db2IFeiZ4kFdwz3/DVfx+BGpiXxXYPwA2VA+HdDS7+HhJKlFK1pNpA6B0r3y0f0cTnJCsn1CdJ42KXxMN05uK5gz9eH5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156054; c=relaxed/simple;
	bh=8LD06dIhRCF5PxnDhCscBmnYC0JP1pM0yFq4tq9N8Ds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hoIpJ/zLNd58JVcLyfD5xz2W8DUJ4+gTov9LsI/kDjlyQPnBClxC3QfSP0ki8VC8oEt4Y17djLpBOoN10abRUNs6lbUAv1zuBaIw3n5JUFT7YHKoJN95mqJhsDHZntuwkhduTUtxhtRz0M0jLN+uOC83fIuN39VNtZS/o95WGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/giUuvl; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/giUuvl"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-385d2703b64so2649931a91.1
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 19:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156051; x=1786760851; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JWyLeKilFL2QB6oEmh5/AodCqSOtAK0blBAl1E1VSrM=;
        b=B/giUuvlBBbPiQp004lEUwCdb2Irb/BoFtxTIwRuSzy7BEwQtiz1WIuqQzrf2GfA+R
         9MkO1rFAieETahcZRMgFNYtIMT4qBe6GG2ODwkQXVOtyLvMH3yPPtfltfKONNq5o5uQB
         +F6Wz4VlX/0RMuv3vVaT7e6GgCaVcAq0RU7dsyNuzHjG9mrTNgU7SF/mCIxcncTx8y/U
         E7O570xMUWThU854t/tYx6FG9BRHgJyU9NfwCeCw37lg3cMFyhfRFAMbb2I+ASzHnauN
         XUVMiFj6WdI3wvTpCEK1aEvKPOPCj4WDhqkKPxiGZf/75wmJ7GvjX6jAhIYd7f7ff77z
         Kklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156051; x=1786760851;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JWyLeKilFL2QB6oEmh5/AodCqSOtAK0blBAl1E1VSrM=;
        b=tAdIEAhMlQkbZGS76HzVgaW7uRPttaiKNCbWHLJspj0RgkkRhgWarZMbK/jomg9pwA
         y2GtA+DLVi4A3JLWMJGrZZ3dL/ob+0dZ0NSZD8lxLPTW2y+vP+EVALfrgpT4pP7cB/kR
         3CRyKpl2I2QIVMlbFvqEjP8QDfitnO+3OqbP/+04JquJzup9yc5ZN4bpDrv2aUXMFQJY
         V1+p4O7cLx3uNOKddRsexJ5VZqy/MXbteg2M5ZclFyOKpqyg5VJuVFHy9T5ZscL7zP2R
         lz/n+QPvHyhEo5aA5aRywkp+EGdN0XYs9OVAWpUgW+QCrfVc8+wvcAy0AbPn5kOHE2XH
         fToA==
X-Forwarded-Encrypted: i=1; AHgh+RpjgYR8zBm+bJ4zdmcda9UViQ9P4+gvqAijaEg6pfP+HOUA9oATWJiAikgMSEl9OAU4JyFHJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgwvjJr957kVc6dt/XQrCLTtMWZ5S2VUic6//jgoXuAHaIF524
	qYa5/AJ/sITSvdXk5Kyigs8xVZi6NW6Vy8rSTskwxOGNOty7GW4aa8ZNAd2WMJokZGIzumSbCp+
	fIQlceFOjCTiCrg==
X-Received: from pjbne5.prod.google.com ([2002:a17:90b:3745:b0:390:99da:dad6])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3907:b0:38e:b3fd:d584 with SMTP id 98e67ed59e1d1-392846f10f3mr1369252a91.15.1786156050750;
 Fri, 07 Aug 2026 19:27:30 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:13 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-9-skhawaja@google.com>
Subject: [PATCH v4 08/18] iommu/vt-d: Clear unpreserved context entries during shutdown
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

During normal shutdown the iommu translation is disabled. Since the root
table is preserved during live update, it needs to be cleaned up and the
context entries of the unpreserved devices and root entries for the
unpreserved context tables need to be cleared.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |  15 +++-
 drivers/iommu/intel/iommu.h      |   5 ++
 drivers/iommu/intel/liveupdate.c | 140 +++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index aeae0563dfd0..eca3944d9cf5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1832,6 +1832,14 @@ static int iommu_suspend(void *data)
 
 	iommu_flush_all();
 
+	/*
+	 * Note that IOMMU suspend doesn't affect live update. The state
+	 * preserved during live update is not released and remains valid during
+	 * suspend and reused during IOMMU resume.
+	 *
+	 * Also note deployment of suspend/resume and live updated use case
+	 * should be mostly mutually exclusive.
+	 */
 	for_each_active_iommu(iommu, drhd) {
 		iommu_disable_translation(iommu);
 
@@ -2377,8 +2385,11 @@ void intel_iommu_shutdown(void)
 		/* Disable PMRs explicitly here. */
 		iommu_disable_protect_mem_regions(iommu);
 
-		/* Make sure the IOMMUs are switched off */
-		iommu_disable_translation(iommu);
+		/* Make sure the IOMMUs are switched off if not preserved. */
+		if (iommu_preserved_state(&iommu->iommu))
+			clear_unpreserved_context_entries(iommu);
+		else
+			iommu_disable_translation(iommu);
 	}
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 4906cce1e66e..6c971f04ead3 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1306,6 +1306,7 @@ int intel_iommu_preserve(struct iommu_device *iommu,
 			 struct iommu_hw_ser *iommu_ser);
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
+void clear_unpreserved_context_entries(struct intel_iommu *iommu);
 #else
 static inline int intel_iommu_preserve_device(struct device *dev,
 					      struct iommu_device_ser *device_ser)
@@ -1328,6 +1329,10 @@ static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
 					  struct iommu_hw_ser *iommu_ser)
 {
 }
+
+static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index ffdcebf2b773..b5aaebeeb5c1 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -77,6 +77,146 @@ static int preserve_context_table(struct intel_iommu *iommu,
 	return 0;
 }
 
+static void clear_unpreserved_context_root_entries(struct intel_iommu *iommu,
+						   struct iommu_hw_ser *ser)
+{
+	struct root_entry *root;
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		root = &iommu->root_entry[i];
+
+		if (!is_context_table_preserved(iommu, ser, i, 0) && (root->lo & 1)) {
+			root->lo = 0;
+			__iommu_flush_cache(iommu,
+					    &root->lo,
+					    sizeof(root->lo));
+		}
+
+		if (!sm_supported(iommu))
+			continue;
+
+		if (!is_context_table_preserved(iommu, ser, i, 0x80) && (root->hi & 1)) {
+			root->hi = 0;
+			__iommu_flush_cache(iommu,
+					    &root->hi,
+					    sizeof(root->hi));
+		}
+	}
+}
+
+static void clear_unpreserved_context(struct device_domain_info *info, u8 bus, u8 devfn)
+{
+	struct context_entry *context;
+
+	/*
+	 * This cleanup is done during shutdown, so it should be fine to only
+	 * clear the entries here and issue one global invalidation later to
+	 * invalidate all cleared entries.
+	 *
+	 * Note that the device IOTLB invalidation for unpreserved devices is
+	 * skipped this way, but that should not be needed as the devices are
+	 * quiesced at this point. This should improve the performance of the
+	 * cleanup process and avoids any invalidation timeouts because drivers
+	 * might have moved devices to D3 state.
+	 */
+	context = iommu_context_addr(info->iommu, bus, devfn, 0);
+	if (context) {
+		context_clear_entry(context);
+		__iommu_flush_cache(info->iommu, context, sizeof(*context));
+	}
+}
+
+static int clear_unpreserved_alias_cb(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct device_domain_info *info = data;
+
+	clear_unpreserved_context(info, PCI_BUS_NUM(alias), alias & 0xff);
+	return 0;
+}
+
+static int clear_unpreserve_context_entry_fn(struct device *dev,
+					     struct iommu_device *iommu_dev,
+					     void *arg)
+{
+	struct device_domain_info *info;
+	struct context_entry *context;
+
+	info = dev_iommu_priv_get(dev);
+	if (!info)
+		return 0;
+
+	if (!dev_is_pci(dev) || !dev_iommu_preserved_state(dev))
+		goto out_unpreserved;
+
+	/*
+	 * PRE use cases are not supported with Live Update and a preservation
+	 * attempt on such domains returns an error. But Intel IOMMU driver
+	 * enables PRE by default on all devices that support it. For preserved
+	 * entries, the PRE needs to be disabled so preserved PCI devices do not
+	 * generate PRQs, during kexec, as translations are kept enabled during
+	 * live update. There is no need to disable these for DMA aliases.
+	 */
+	if (sm_supported(info->iommu)) {
+		context = iommu_context_addr(info->iommu, info->bus, info->devfn, 0);
+		if (context) {
+			context_clear_sm_pre(context);
+			__iommu_flush_cache(info->iommu, context, sizeof(*context));
+		}
+	}
+
+	return 0;
+
+out_unpreserved:
+	if (dev_is_pci(dev))
+		pci_for_each_dma_alias(to_pci_dev(dev),
+					clear_unpreserved_alias_cb, info);
+	else
+		clear_unpreserved_context(info, info->bus, info->devfn);
+
+	return 0;
+}
+
+/**
+ * clear_unpreserved_context_entries() - Clear context entries for unpreserved devices
+ * @iommu: Target IOMMU
+ *
+ * Clear the context entries of unpreserved devices during shutdown before kexec.
+ */
+void clear_unpreserved_context_entries(struct intel_iommu *iommu)
+{
+	struct iommu_dev_iter iter = {
+		.fn = clear_unpreserve_context_entry_fn,
+		.iommu = &iommu->iommu,
+		.arg = NULL,
+
+	};
+
+	/*
+	 * Clear context entries for unpreserved devices.
+	 *
+	 * Note that the error can be ignored as the iterator function does not
+	 * fail.
+	 */
+	iommu_for_each_dev(&iter);
+
+	/* Clear reference to unpreserved context tables */
+	clear_unpreserved_context_root_entries(iommu,
+					       iommu_preserved_state(&iommu->iommu));
+
+	/*
+	 * Some devices might not have teardown/detached properly depending on
+	 * whether a proper device remove is done before kexec is triggered.
+	 * Also unpreserved context tables and entries are removed during
+	 * shutdown. So issue global invalidations to remove references to
+	 * unpreserved tables and entries.
+	 */
+	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
+	if (sm_supported(iommu))
+		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
+	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+}
+
 static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
 					    struct iommu_hw_ser *ser)
 {
-- 
2.55.0.679.g6767b8d81c-goog

