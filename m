Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF6C38398E
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480259; cv=none; b=t141Ww77uf+XzBEoxqPRUJIiMRZrAlszawPtOOGgkrzMubUR7r2pdTrQe30U+oyu6wBbH/WvM0oRayer3st2vgOB2XF7C7Rm33y2xnZmLc+tXBIBHG0Mtdef6eNChdPPNihZ1xKT51bdl7ZDdkaJC78PD9/jltU0IZkku7cqfxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480259; c=relaxed/simple;
	bh=/jzn4vHPGiGXDmiCgKEnxoGezE2gNeA4w0++aRG5NbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HC84U6+7ZqBxfZ8qT4bw/p/U1KVfGaixznIUxHuy1ltxshyU8sajNC2lsA/cWn7S7eKYGSXcU7xd6L4L9mLdge27Of7e4SAEDwejnLsTwVg9+K/dl8MIw8gnCXK1o1UDbaW2qUke28ShedcL597XpI/SGEzKOTl6EFQsHYoWPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J4d4pN1U; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4d4pN1U"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85807671b1so1188348a12.2
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 16:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480256; x=1782085056; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hCWOgCuUam+6oDxi4jEg6+WaDeW7p6QlTv2GvwnY92c=;
        b=J4d4pN1UzbEQ1ltQrEc4+gshrepRwc7N2bfqiVmGiz5u3G4ydGl7nmMecn3WbWXXPS
         k3rkU+YPuPmYV3Pk1wS7zsk7CIkyke1in3MCxi7TNiYv4a1oydx6Lg3JKq2F9LtuKirB
         aokwIbEQoPmATLAHgmlAkwKHAZozmXLYq3NJ2co4LIpOOJJ7j3+2w0V/GIvl7x7A5cR7
         LsSSBzn/LgUA8MZfT9qcXT3CfGh+4RYv1rtK4yRG9RE0eVVZciQis5erqZlJPWFjExY4
         icNXD9RPMRH5kJt3EFccwPyDA+AEXLWjftq+iDdBSJJjHW8op6DjtoQI5U8tk/lRorNK
         qowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480256; x=1782085056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hCWOgCuUam+6oDxi4jEg6+WaDeW7p6QlTv2GvwnY92c=;
        b=U4sDzIoLDWyxJRqD3dmigM8lC2VQ3pPBHuNE3BJ94r9y43DvVo6zrCl46oRWhisqi0
         kxk/YeWcJsA9tpI++4qcZFNeN5dGD6OZ7k1825Ctu1BIqkH0sZ7m6OIjddh3K7NDS/7E
         X4jbQZdLvug6hxYm4YGPPk7q23Mwmro6R3mt6XYKzEIkvnHnx4MTvAM0AEz3+K9HNo+f
         CQ8O+NEveC3RUETLwGsPxJaNV92CcVyNPP9hsuzC6Wq3rYA6le0GA27mdsuUQpdJhF0b
         K4lnXj5HYHwYN3gRBL9l1Gxos3DhwCxmK0EpXVLEh58jlD7qhgVnLkcUgnhlPSj5jb3r
         5B5A==
X-Forwarded-Encrypted: i=1; AFNElJ/+rsHAdB6LVISld1vX95uXGUC9jxgfI0gbBqT5HVh7INdgmJCps3Tk6fL074CFHBk5fK4/6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkR4KuGnKtPfNYfpQjWfEnDXonEjUkGn0LIvgXg2pJ5GLH/wZn
	ehsgGqMfwsk3zPS79tbrkoUHO8zxwMy0TQ4TQuAkddXAXaJp5Nh5TegWaSIbk5yHyxAkNhlZPsj
	8NXlJZpjcjanTaQ==
X-Received: from pga27.prod.google.com ([2002:a05:6a02:4f9b:b0:c79:81bb:79ef])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:431d:b0:3b4:669c:ee32 with SMTP id adf61e73a8af0-3b784026fbemr12891091637.37.1781480256053;
 Sun, 14 Jun 2026 16:37:36 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:18 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-9-skhawaja@google.com>
Subject: [PATCH v3 08/18] iommu/vt-d: clear unpreserved context entries during shutdown
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
 drivers/iommu/intel/iommu.c      |  9 ++--
 drivers/iommu/intel/iommu.h      |  6 +++
 drivers/iommu/intel/liveupdate.c | 74 ++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 715b538e7efe..26258861e3bf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2374,8 +2374,11 @@ void intel_iommu_shutdown(void)
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
 
@@ -2699,7 +2702,7 @@ static int domain_context_clear_one_cb(struct pci_dev *pdev, u16 alias, void *op
  * devices, unbinding the driver from any one of them will possibly leave
  * the others unable to operate.
  */
-static void domain_context_clear(struct device_domain_info *info)
+void domain_context_clear(struct device_domain_info *info)
 {
 	if (!dev_is_pci(info->dev)) {
 		domain_context_clear_one(info, info->bus, info->devfn);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5e0bc17e76bf..561cc4d14912 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1241,6 +1241,7 @@ void cache_tag_flush_all(struct dmar_domain *domain);
 void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			      unsigned long end);
 
+void domain_context_clear(struct device_domain_info *info);
 void intel_context_flush_no_pasid(struct device_domain_info *info,
 				  struct context_entry *context, u16 did);
 
@@ -1293,6 +1294,7 @@ int intel_iommu_preserve(struct iommu_device *iommu,
 			 struct iommu_hw_ser *iommu_ser);
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
+void clear_unpreserved_context_entries(struct intel_iommu *iommu);
 #else
 static inline int intel_iommu_preserve_device(struct device *dev,
 					      struct iommu_device_ser *device_ser)
@@ -1310,6 +1312,10 @@ static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
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
index b5613e4ad43a..aac7aa89a182 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -64,6 +64,80 @@ static int preserve_context_table(struct intel_iommu *iommu,
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
+static int clear_unpreserve_context_entry_fn(struct device *dev,
+					     struct iommu_device *iommu,
+					     void *arg)
+{
+	struct device_domain_info *info;
+
+	info = dev_iommu_priv_get(dev);
+	if (!info)
+		return 0;
+
+	if (dev_is_pci(dev) && dev_iommu_preserved_state(dev))
+		return 0;
+
+	domain_context_clear(info);
+	return 0;
+}
+
+void clear_unpreserved_context_entries(struct intel_iommu *iommu)
+{
+	struct iommu_dev_iter iter = {
+		.fn = clear_unpreserve_context_entry_fn,
+		.iommu = &iommu->iommu,
+		.arg = NULL,
+
+	};
+
+	/* Clear context entries for unpreserved devices */
+	iommu_for_each_dev(&iter);
+
+	/* Clear reference to unpreserved context tables */
+	clear_unpreserved_context_root_entries(iommu,
+					       iommu_preserved_state(&iommu->iommu));
+
+	/*
+	 * Some devices might not have teardown/detached properly depending on
+	 * whether a proper device remove is done before kexec is triggered.
+	 * Also unpreserved context tables are removed during shutdown. So issue
+	 * global invalidations to remove references to unpreserved tables and
+	 * entries.
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
2.54.0.1136.gdb2ca164c4-goog

