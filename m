Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409399;
	b=Sr4IrA4Y0nW1fFKO3n5vGWbCnZE3stdXr+TrSyoW/xksriXYxzqdf0U98fs5hsG1D6Gf
	 t57ewYZ5SL6M61OZgDrQJI96U1nFUZGMS3+vt9drgjAAHmAyx/zFL05z4xZKo3MS+RO73
	 zC0pNaupyNJlNYN+i820eNQ5+20ZuhUE+aDSRn8OuvNNlSjZM2Q+Mg/Pmuzprrm6AoMFu
	 c63aUF8kn1AdKKbeMB5lM9d6gQwp3r2vf3bRvbYAqgCjUiVatK6X3NibhEuh2p8GEihWQ
	 QGypzFX6c13+HYnnhK/wgxQMiDJR92oFkrQdr/vob+houLaMMsNILjDWoNite296Xsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=f4Ufo6TzuQo+4o8APbXdbrHv+9kKEzhVqRPJyGBlCA8=;
	b=HLSHMJbHlCSElgJAMrkBmqe2z+I6R4SA6AvhSlCj4xCkqMHt8Zrq/i+63I8ohp4S13JQ
	 FXrVWkE53mqQaQTvy7wYUPRI1zUI5Ru6vhBsXODPd4fM3X9+mtkg+2uMbZrVuogmKXPrD
	 0vUfTvPu3mSMzobMNa9p0O4cw+f30u9ZZ/MZEDnqB4SRDBUFOWQSyB5ROHp7+xdDiOTCq
	 4/yH6pekF68xflUCLt8JDWErD+tKQlGP+/M3V9uoWYxQoocZaI/QoQZrHimTu7jYyzw3f
	 mTHXEPLwA2vZknXM0z+3hVuohC/wDlCRe2ah1JFvQywq3SrtY6j6DMrY1QTVV6hTNig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iMKcYCt1;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169C960A262D
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 169C960A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iMKcYCt1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2f03a137f6aso25122875ad.3
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 20:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409398; x=1796014198; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4Ufo6TzuQo+4o8APbXdbrHv+9kKEzhVqRPJyGBlCA8=;
        b=iMKcYCt1Yvu8nMdmMqrp1VyVm97z1iEllGXrQQFIBaFTsD54TDGmvdNpxataYjOn1l
         7rTVJZpKscSJy8eSsG7ZGPSQFsU9wqTnZqduXHspJcKSgwDPtKeepWzevroLmSGQjqoh
         Q4omXjcfmDtVY7ZJpuv0gp8wwOOqQKPhKTDgAilQBblYcCLs2aXlBgF8VVEzTsYYTzsR
         +i0AM1XVn1X6xqnj5umAhIKk46fh3pGyvLdyO3ZE5pfnEyKBlvV835RpKFszjWmcy3aW
         UwnVRi5fsJ2TsHAZc4Ze11juD3wk1KSRWm+CjIA9ufVwfDyt6HAUJ/jQw5NT+j90y78U
         c4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409398; x=1796014198;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f4Ufo6TzuQo+4o8APbXdbrHv+9kKEzhVqRPJyGBlCA8=;
        b=a12jvw3AFFDj+njB63EIDLkEYAFnC1OzDh0elHfRvzBQ0BiyoWMkYuDgBx34ON2Fnl
         MQG+j60XP410CwC8ZSsoNz/9eOAsoOqZvGnE/i9v6v7T1TggARe7YPvzE8EajSsuT3S/
         V2y6J67hJSxtc2T7XuO2ejMw0r/pDfj8iZWFZ34jAEEU/H5tCfMIq0JpG68CMUSLHWau
         dwhiqUL+Wlza8Qh18e+rRbcBbvXRDxe5xLg1XMrWwFh+4p36CgMT9ao/8zFDlXmNCuGr
         sspCjSq9eFfNOhbkDZPPfROXtSiixifdCSHYtEj14NRFtnqkTWGOVz3/19oZIQKZAJrq
         b/XQ==
X-Forwarded-Encrypted: i=1; AL+hErH18Z+/GVBpEEOaFtozOagWGGh9e0HionsC9K8Ijxs66yvZVhbU3SJ1t54dEeMLIkZvztrufw==@lists.linux.dev
X-Gm-Message-State: APuU4Z97Vr7AXvf2I8XEcAGhbsUzHV1J5Sf1wP2LanJKA/ZVJ8rJlvbK
	7ATpRlI5X5MNWIZm5Dqb4qXafngPmnixmWD5GoHzL+dd3n/pMORFu2lZ3BNkuZfal9AGvGQCmEg
	r1yeoLa+lF/WmiQ==
X-Received: from plgb9.prod.google.com ([2002:a17:902:d509:b0:2e8:1aeb:b4c9])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:26cf:b0:2ef:ef72:493b with SMTP id d9443c01a7336-2f03f1c3d70mr101039835ad.54.1795409398311;
 Sun, 22 Nov 2026 20:49:58 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:39 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-9-skhawaja@google.com>
Subject: [PATCH v8 08/18] iommu/vt-d: Clear unpreserved context entries during shutdown
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
2.56.1.809.ga0b61035b5-goog

