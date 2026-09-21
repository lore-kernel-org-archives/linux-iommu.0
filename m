Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95571286D5E
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 00:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951735; cv=none; b=bVFXe4lfei6rINqxtCJvy4Fzm0Wj7WJPlbTOkwCWrb73QofVU8267ZhvcCP4dvSM7ebCusn/u8fZu7lHpNv4Mf+aJzxIgJJz8ZDPrKmZxrON8aHZ2gdRoPb2mCi0Rwk2DlGBr+pFJT+45SFSHxVww7rexmMkU73o5YE1+I+JNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951735; c=relaxed/simple;
	bh=ArO2m6pL7uO2PhZtrHs0jVCCkvGqo8M4uLzaVIqqEnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hphBMwnei9VO2Cz+LFan3K/ewqlEOY2+vtc3rH2hqpf9d9ePpX+3j6UzihlAj/tETyG4S6CKh3caqQ7o7TSVAmELVGzg18DEUmb0zbneq8CwmEBseoFI5eyxkzDdV++15QClcgaUc8E6peaQIEnr17sr+GDRxUQfhAdE2cqtcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6EAbbkH; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6EAbbkH"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8716b158692so1211590b3a.3
        for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 17:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951728; x=1790556528; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3DQXvWtZKOwtXJHttEiyqacBwQBVqgRl20BjrrSpLfU=;
        b=S6EAbbkHpvNPWDDkETg1+7fB7qMr5WRcEXdYCN9WgTyXevt36YNTFhr/immYSFwhSX
         mnan1XytZ+0/gxUVyitZ8Z+Ey0eUBOeryOwXyCqXHFLBbcgVlPDwkq+6PS7VCs5UZwlJ
         QFlbWD7VSRgZP3kYhAPe6RSoRnLrt5CLTXSmvf0TppM9Rdm6wEaSCCo98ZxbVHpC/skl
         WCYZKjgcGOrKpt3LJCFv+kKnnB97iEzrvldRs5gFe465WhjNSnaNSxxduTcXuu5jC8eS
         HvmJyr2oQBqGls+Fuj8kAoi1l6nhhI+jfXBk8zPJpmMd49inVZOFSuTmp3Ij1EsPYZOF
         mmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951728; x=1790556528;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3DQXvWtZKOwtXJHttEiyqacBwQBVqgRl20BjrrSpLfU=;
        b=NHcsNGuFwzKuFN0BMdPG//CQ3iUxhPY1+Bx8yVZ2pH0NM79S8QpA5nBF68cZhFFura
         G+vDqRv00ORyA9GIJqOrNuwbRtC2+MiOJ96mFlzrptuaZc78tmQoSanSKKmIklIKyXON
         Ju6jniLbtm9XUQ7PNolLu0lI2htLVuG7Cwj/Iufk8MQogZLaqb3onKFLzOPCSoYPS0kT
         eKR0nyXT77f5wZa77LdgT+CehW8gBzraooVRNwy61TiEqgaLLLCwihLC688qojaMfSPe
         oaPLAoD69BmkCL1b0/wCsdDiUZ39sxkcA+eV4kIU0dePqasenwXOn6YSASNNNBM+hbmu
         ah1g==
X-Forwarded-Encrypted: i=1; AKwUvBykfNijkwHjLPOfCFfWDgCc7UQLRIUTNA6vBVeAP/h7flYbDvrHD5WaBthmVPYuRURqGUlIWg==@lists.linux.dev
X-Gm-Message-State: AFuF++lQWKJA+teRvLcabkI+Aq0MwBY8ddtWOROO/4ob/9RhHjwsH+FB
	11n+atcGvOlbQB35qOMzsjqI0iARr2IyxB/gIgGtEJIdII35eEOmFqpOkCCzGDcN0c5dPX1xZn5
	KnR7aJm4M6J1WcQ==
X-Received: from pgvc11.prod.google.com ([2002:a65:618b:0:b0:cc1:c12a:92cf])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:464f:b0:84e:e741:174f with SMTP id d2e1a72fcca58-874db6f7494mr12164945b3a.7.1789951727653;
 Sun, 20 Sep 2026 17:48:47 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:24 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-9-skhawaja@google.com>
Subject: [PATCH v5 08/18] iommu/vt-d: Clear unpreserved context entries during shutdown
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

This is required because during kexec reboot and shutdown the devices do
not go through the release flow, so there might be stale entries in the
root table and context tables. Also note that new unpreserved context
tables for unpreserved devices might have been added after preservation,
so the root table entries for unpreserved context tables also need to
removed.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |  15 +++-
 drivers/iommu/intel/iommu.h      |   5 ++
 drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4bfc2f173010..474c926172c5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1852,6 +1852,14 @@ static int iommu_suspend(void *data)
 
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
 
@@ -2397,8 +2405,11 @@ void intel_iommu_shutdown(void)
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
index 785057236e7c..4feb5bd76b18 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1307,6 +1307,11 @@ int intel_iommu_preserve(struct iommu_device *iommu,
 			 struct iommu_hw_ser *iommu_ser);
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
+void clear_unpreserved_context_entries(struct intel_iommu *iommu);
+#else
+static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 0837bb889fed..501dc0e9cc0a 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -77,6 +77,145 @@ static int preserve_context_table(struct intel_iommu *iommu,
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
+	 *
+	 * The iommu lock is not needed as the context tables are never removed
+	 * and the new ones are not added during shutdown.
+	 */
+	context = iommu_context_addr(info->iommu, bus, devfn, 0);
+	if (context) {
+		/*
+		 * Individual invalidations are not needed as we issue global
+		 * invalidations later once all the cleanups are done.
+		 */
+		context_clear_present(context);
+		__iommu_flush_cache(info->iommu, context, sizeof(*context));
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
+
+	info = dev_iommu_priv_get(dev);
+	if (!info)
+		return 0;
+
+	if (dev_iommu_preserved_state(dev))
+		return 0;
+
+	if (dev_is_pci(dev))
+		pci_for_each_dma_alias(to_pci_dev(dev),
+				       clear_unpreserved_alias_cb, info);
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
+	 * Clear context entries for unpreserved devices because during kexec
+	 * reboot and shutdown the devices do not go through the release flow,
+	 * so there might be stale entries in the root table and context tables.
+	 *
+	 * Note that the error can be ignored as the iterator function does not
+	 * fail.
+	 */
+	iommu_for_each_dev(&iter);
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
+}
+
 static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
 					    struct iommu_hw_ser *ser)
 {
-- 
2.55.0.1082.g2b9226bbc0-goog

