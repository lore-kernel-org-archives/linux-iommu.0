Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283721;
	b=Q4+Y2J0rOy9yGJ7TfqVONDwCext4CFAvzo+pwtxiBH+Kz/SfqCK67+ROMZM7hPfdrp8Z
	 P5xuwq9gwdiOMmC7XOajlSr1EDxmrH+mbXrVg3rw1KL/f6XAGiCgzi03K/5wPI8OvTE90
	 6UGV92WHogcPFCB3cWRipazMofHytG+2Apzha1WxsCnXE/FWoNQFTC2jOPmtrxXKjYTC2
	 bSL8asLuVGWWlF1tvPobKErYIAcjL53BXe2rcoKYdH05ZZlUcVnEniai1W0Fx02XcKDJE
	 G6IM+gTZqv2ocq6+OrSzob5n6TJ14irh1ENYFUDAQwsHq46+v/KM6Z6SvHU7abMbVFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=irJc0dzTGENekv603h6SGKRdhpy+7WGwJVSqrmPDx38=;
	b=z52D+17BDTHx6Mrj3kjsCHt5WtLd7A0qBKeVIOGUghXAaDc97iM+TXsE7h1hzdvZyErY
	 b+fcvvA/xLN+4dduIsdOIoxhfY1xZ569lgP5XlI6X0nghs32U6fVBx/Kzn6/cqt9Xlxu9
	 r2a9xCU91LG+RhqRn65iBppxglvrLkG3h9CUC0dxX5fOpSmzrYMi8MpxEJRuFZnlLYJ7J
	 u1IHEnI/l/cCInpVcOvbOpH0j1ZWheR5TeMHi2P2iPqNBLVjMKnv7PvA8ssJYInZjd7Hq
	 O750Njf5GIx50yYcx9VGVHXUk1xZdTErseFSjskK/JioI20yzw58CMyQgrDaVsbeN6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hQV9dlzZ;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A3606A33B
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A2A3606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hQV9dlzZ
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-847e2926d94so3166740a34.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 20:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283720; x=1794888520; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=irJc0dzTGENekv603h6SGKRdhpy+7WGwJVSqrmPDx38=;
        b=hQV9dlzZemaK8WhdiFpNV/i/E9TwZPiXAFTBibQYKzLig7L7GB1R1fpkcSeCbmCEVE
         4U95tBUZKd+vwelUksVQwGbbr6r1pf3iBhusMkQDNDGcylz4Us7oqMvRPbKyMXsaYXOp
         2JWMsQC3+zhIlp/CQCivQxNH67REqdDavH0lrTyM5BsOAH1mzBUUhkkqChMnGonw29Y6
         gwMNxq3Cl6Mi+nVBDt8iPeg3hdc9Dm6LA1af0r7QVU8XulWt0r6XHMseG6ASNC1bu4bY
         PuSVT1DZg8z5oO1p5N27aUVqkNFYnauXaKOJZECCBeukam+pIemI2PKEw6qQz7YryROH
         aO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283720; x=1794888520;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=irJc0dzTGENekv603h6SGKRdhpy+7WGwJVSqrmPDx38=;
        b=VBa1nePfBi5WqeC9QreZt0eIH+PbMJjpb9kMq9P7mKbZESkd0T7+UfVxEjaPY/PPUS
         rXiwIav2Hvzm4zfohow0PdVyS9EPnkeDFCA7uXOPbXUsv4pg7oBEMNYbR7OjHri3lVUd
         0xav2fV0Xt5Afw4xMwKE01/Qr19qGqhMX5pLsmuqCMcYjxNVjwMAV6Qy5EZdgaahZTpB
         yMycXeDRwf/jDrKf5eKrfO/I+f9PLB54bKH437L5XTN3IXwdzQ/e4OLoeCl5ZcZ5dOlH
         7cV0wxRfJTRA0p1rZy5diCcGYGluksnCKpDx6Qy6Xl3PJs1Eod/IEh7Dp+ON1kRd3gZ0
         kMzw==
X-Forwarded-Encrypted: i=1; AL+hErFYlIoD1aY8oWHfyhXomnTgzI4hDrk/HLeIMEnxAKku+iPWkaGiTGKSQSUYGhEDRmA2sK9azg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9VE00hfPnvrVeZ12N3hXgQH3/83AyiA3ADvNOBX5ehdS99Sen+
	aCx077viE1pNtyUjK4pi9449qSEGNfwNQM7WYFg2aS12TxihanBkh0o7i2Ebt5lYlck8wxKX7AJ
	7KFKl4smb2wNRDg==
X-Received: from iofm3-n1.prod.google.com ([2002:a05:6602:83c3:10b0:9c7:7259:cd7e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:e90:b0:4fb:ac9b:b06a with SMTP id 5614622812f47-5683cd2ca4dmr1176282b6e.48.1794283720171;
 Mon, 09 Nov 2026 20:08:40 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:13 +0000
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
Message-ID: <20261110040828.1774343-8-skhawaja@google.com>
Subject: [PATCH v7 07/18] iommu/vt-d: Clear unpreserved context entries during shutdown
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

During normal shutdown the iommu translation is disabled. Since the root
table is preserved during live update, it needs to be cleaned up and the
context entries of the unpreserved devices and root entries for the
unpreserved context tables need to be cleared.

This is required because during kexec reboot and shutdown the devices do
not go through the release flow, so there might be stale entries in the
root table and context tables. Also note that new unpreserved context
tables for unpreserved devices might have been added after preservation,
so the root table entries for unpreserved context tables also need to be
removed.

Only the translation state of the preserved IOMMU is preserved. The next
kernel sets up its own invalidation queue and fault and page request
interrupts, so disable the invalidation queue and mask these interrupts
during shutdown.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c      |  15 ++-
 drivers/iommu/intel/iommu.h      |   5 +
 drivers/iommu/intel/liveupdate.c | 166 +++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 14bd1ca4fbd5..d31d2d5845e6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1967,6 +1967,14 @@ static int iommu_suspend(void *data)
 
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
 
@@ -2512,8 +2520,11 @@ void intel_iommu_shutdown(void)
 		/* Disable PMRs explicitly here. */
 		iommu_disable_protect_mem_regions(iommu);
 
-		/* Make sure the IOMMUs are switched off */
-		iommu_disable_translation(iommu);
+		/* Make sure the IOMMUs are switched off if not preserved. */
+		if (iommu_preserved_state(&iommu->iommu))
+			intel_iommu_shutdown_preserved(drhd);
+		else
+			iommu_disable_translation(iommu);
 	}
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a6c0ed55db30..92697346c44b 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1316,6 +1316,11 @@ int intel_iommu_preserve(struct iommu_device *iommu,
 			 struct iommu_hw_ser *iommu_ser);
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
+void intel_iommu_shutdown_preserved(struct dmar_drhd_unit *drhd);
+#else
+static inline void intel_iommu_shutdown_preserved(struct dmar_drhd_unit *drhd)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 4f5fc0d227ba..c0c121bc3ea5 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -82,6 +82,172 @@ static int preserve_context_table(struct intel_iommu *iommu,
 	return 0;
 }
 
+static void clear_unpreserved_context_root_entries(struct intel_iommu *iommu,
+						   struct iommu_hw_ser *ser)
+{
+	struct root_entry *root;
+	int i;
+
+	/*
+	 * Individual invalidations for each context table removal are not
+	 * needed as we issue global invalidations later.
+	 */
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
+static void clear_unpreserved_context(struct intel_iommu *iommu, u8 bus, u8 devfn)
+{
+	struct context_entry *context;
+
+	/*
+	 * This cleanup is done during shutdown, so it should be fine to only
+	 * clear the entries here and issue one global invalidation later to
+	 * invalidate all cleared entries.
+	 *
+	 * Note that the device IOTLB invalidation for unpreserved devices is
+	 * skipped this way. This matches the normal kexec reboot, where the
+	 * IOMMU translation is disabled without invalidating the device IOTLBs,
+	 * and the unpreserved devices go through the same flow in the next
+	 * kernel as they do after a normal kexec reboot. Issuing device IOTLB
+	 * invalidations this late during shutdown could also cause invalidation
+	 * timeouts, as drivers might have moved devices to a low power state,
+	 * and would add to the shutdown time.
+	 *
+	 * The iommu lock is not needed as the context tables are never removed
+	 * and the new ones are not added during shutdown.
+	 */
+	context = iommu_context_addr(iommu, bus, devfn, 0);
+	if (context) {
+		/*
+		 * Individual invalidations are not needed as we issue global
+		 * invalidations later once all the cleanups are done.
+		 */
+		context_clear_present(context);
+		__iommu_flush_cache(iommu, context, sizeof(*context));
+		context_clear_entry(context);
+		__iommu_flush_cache(iommu, context, sizeof(*context));
+	}
+}
+
+static int clear_unpreserved_alias_cb(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct intel_iommu *iommu = data;
+
+	clear_unpreserved_context(iommu, PCI_BUS_NUM(alias), alias & 0xff);
+	return 0;
+}
+
+static void intel_iommu_mask_interrupts(struct intel_iommu *iommu)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	writel(DMA_FECTL_IM, iommu->reg + DMAR_FECTL_REG);
+	readl(iommu->reg + DMAR_FECTL_REG);
+	if (ecap_prs(iommu->ecap)) {
+		writel(DMA_FECTL_IM, iommu->reg + DMAR_PECTL_REG);
+		readl(iommu->reg + DMAR_PECTL_REG);
+	}
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+}
+
+/**
+ * intel_iommu_shutdown_preserved() - Shut down a preserved IOMMU before kexec
+ * @drhd: Target DMAR unit
+ *
+ * Clear the context entries of unpreserved devices, and stop the hardware from
+ * using the invalidation queue and interrupts of this kernel. Translation is
+ * left enabled for the preserved devices.
+ */
+void intel_iommu_shutdown_preserved(struct dmar_drhd_unit *drhd)
+{
+	struct intel_iommu *iommu = drhd->iommu;
+	struct pci_dev *pdev = NULL;
+	struct device *tmp;
+	int i;
+
+	/*
+	 * Clear context entries for unpreserved devices because during kexec
+	 * reboot and shutdown the devices do not go through the release flow,
+	 * so there might be stale entries in the root table and context tables.
+	 */
+	for_each_pci_dev(pdev) {
+		struct device *dev = &pdev->dev;
+
+		if (!dev->iommu || dev->iommu->iommu_dev != &iommu->iommu)
+			continue;
+
+		if (dev_iommu_preserved_state(dev))
+			continue;
+
+		pci_for_each_dma_alias(pdev, clear_unpreserved_alias_cb, iommu);
+	}
+
+	/*
+	 * device_lookup_iommu() only accepts non-PCI devices through ACPI
+	 * namespace device scope entries, using the scope bus/devfn. Only PCI
+	 * devices can be preserved, so clear all of these.
+	 */
+	rcu_read_lock();
+	for_each_active_dev_scope(drhd->devices, drhd->devices_cnt, i, tmp) {
+		if (!dev_is_pci(tmp))
+			clear_unpreserved_context(iommu, drhd->devices[i].bus,
+						  drhd->devices[i].devfn);
+	}
+	rcu_read_unlock();
+
+	/*
+	 * New unpreserved context tables for unpreserved devices might have
+	 * been added after preservation, so the root table entries for
+	 * unpreserved context tables need to be removed.
+	 */
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
+
+	/*
+	 * Only the translation state is preserved. The next kernel sets up its
+	 * own invalidation queue, page request queue and fault interrupts, so
+	 * stop the hardware from using the ones of this kernel. This must be
+	 * done after the above invalidations, as they use the invalidation
+	 * queue. Page requests can't be disabled at the IOMMU level while
+	 * translation is enabled, but PRI is not enabled for the preserved
+	 * devices.
+	 */
+	dmar_disable_qi(iommu);
+	intel_iommu_mask_interrupts(iommu);
+}
+
 static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
 					    struct iommu_hw_ser *ser)
 {
-- 
2.56.0.506.g506a7eabc5-goog

