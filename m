Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283725;
	b=td6wKMHp1rhtZ4mM7t12Qet0i1bFhdrEbF6oU2cYuyaHhAtKVOf9SMY2r75ZORtxlK5m
	 NoUG3qFh9eqn9RmoLZGF2AGZQ8S5Xtg3lqS3TBaopH3ujhkCRqqWezXf35UWCkHHVqIf7
	 y4vDMiqgnYX+wSSIuiPqPWZ79P9+mz0vrzff/hCCmkfNL6lTVncviA+1UU5A9QT0IqV3X
	 vpYRrS8CMCe+xorGLfNnTSFNSYJsuSNqqPvL/Ce07Tu8JGUv2p9HLV9QLpbW2PyovJ6fj
	 mbCUJAJCv1X8C3GW+xgtEj6D981J9pSUQtjq3RcAGCg81uq55WKPQSVxuWx2VKiCFOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=d/ZJmSbLziWaPHP9TrpFmHP7FgsJMXekHS8yBggoQHA=;
	b=Qa+LQg7A7E3a1lxrxOsQV1/kEmp2kh1k4uRsMcRexJWrrB8/Aio7CG94goxFxCOd1i1A
	 AVDA/wLIjbMnPzBv6IWa6jF3sOIH40XlAHFq/UPjWwfOTdGY7uqIxX82cgM6DuwzhVxbM
	 Ol2TYn5Vuaxs5cKh/a+zEEINCcBwwpb2KBlFLicNim50wfB2dxMano2Y7lyRUHhFtMYXp
	 ggj2H10M4luOgXoyMBuezz3587gSgtyZ3szlbM0H2cwlM4p8/LDKGTvcwX8NgDLVx/Bsv
	 2WPITmpWEFCj4FH+9CGE7UzuRzV+AYZiDYZMhFq62e4thY+WdS0MxXkFHSstSXYVdAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DNhlubPh;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ECF606CF27
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 04:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78ECF606CF27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DNhlubPh
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4dab94dc3e7so2959326b6e.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 20:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794283724; x=1794888524; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d/ZJmSbLziWaPHP9TrpFmHP7FgsJMXekHS8yBggoQHA=;
        b=DNhlubPh2n3DWeiPX6R9YQnQ7lVSDUeVk6NVmVFMYU8ZXi3l5CYHhoaDSZ2wcPxAO0
         VGkGWG2gDJXV7OFHIVfAW5ZjVfFjvXSRJkLxGwRZRvKl1MFgBXfvpHMs4yeDYXGLrSNj
         b8x+652YkM4JCF1j+yAvc4oSDuJzDJsKyD/b1oidQHzYynmBw7t0mOH0BxNN5RdCmmrN
         rR5hAWjXlOKTE/uFBN39jtZJASgV0Peg7slb8vEGsag7tnPUK0RbCSk26j7hwKYI5SLC
         u5C3oD97A87HwdG/tpE/od9SckLWhjkbFy9/d/wOdCQhs47hb+9xHRv6CgZ94ZvdIlXC
         Y1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283724; x=1794888524;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d/ZJmSbLziWaPHP9TrpFmHP7FgsJMXekHS8yBggoQHA=;
        b=eTLRFp/skXgk0ACT0pt1nGYHhIUdUJnfuExoCMlHofefS89yE4kCEUvucGA663BdQC
         t1RL1xv3gAO0/bD3PQuluKSVZ0/xzDJlE5VXjqRekNSRd4r9TyeBUM9oIBoWAzYWLCvM
         25wVYjAmtwtX7h6jOYgZPzsFF8ZHuKDi1qa/p4rCOgdsBALwxji8l/QzuF0EMFuOGdyU
         yoRD7YgrffhaalIfPdAuML6XNyFrjVzaiyd2DBlKjPAoTL3WUZfB86rh7T51Qray7gs+
         qVKqskECcIazmKCGARXJ+VLsfZjiNSVzBPZ0Gh+axwI+3bRDrUAU3tZuff9D04OuykCw
         I0JA==
X-Forwarded-Encrypted: i=1; AL+hErFtJB3uy1OZNFcqz96PeUCFoU1PbFcO95saAM7bJmERcwkNLzf8K8qPBw6d4itgWINmCX7gXw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/YzG1HUdPPsQjbstfTeN+iW7bwWDMbZ97B+47An9Z3KcfXSH2W
	5I3/1xm3yFYl0NNw3376iWUsh/6YIOeheFSmU2TwsTcCwsYANnMepoVvcR/2lMdI31E+tB6NsNs
	kKL4s+GCMmB8A7A==
X-Received: from ioy15.prod.google.com ([2002:a05:6602:a10f:b0:9ca:bccb:ca8a])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:250d:b0:4f2:4d2f:7ba with SMTP id 5614622812f47-5683c8d763dmr1118575b6e.8.1794283724102;
 Mon, 09 Nov 2026 20:08:44 -0800 (PST)
Date: Tue, 10 Nov 2026 04:08:17 +0000
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
Message-ID: <20261110040828.1774343-12-skhawaja@google.com>
Subject: [PATCH v7 11/18] iommu/vt-d: Preserve PASID table of preserved device
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

In scalable mode the PASID table is used to fetch the io page tables.
Preserve and restore the PASID table of the preserved devices.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c      |   3 +-
 drivers/iommu/intel/liveupdate.c | 144 +++++++++++++++++++++++++++++--
 drivers/iommu/intel/pasid.c      |  10 ++-
 drivers/iommu/intel/pasid.h      |   8 ++
 include/linux/kho/abi/iommu.h    |  19 ++++
 5 files changed, 176 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a83971368bef..b3402fd9fe75 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3475,7 +3475,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 			goto clear_rbtree;
 		}
 
-		if (!context_copied(iommu, info->bus, info->devfn)) {
+		if (!context_copied(iommu, info->bus, info->devfn) &&
+		    !dev_iommu_restored_state(dev)) {
 			ret = intel_pasid_setup_sm_context(dev);
 			if (ret)
 				goto free_table;
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index d43947879e78..34651698b8e9 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 
 #include "iommu.h"
+#include "pasid.h"
 #include "../iommu-pages.h"
 
 /* 2 tables per bus in scalable mode with upper table at odd bit */
@@ -443,6 +444,69 @@ void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
 		      iommu->name);
 }
 
+enum pasid_lu_op {
+	PASID_LU_OP_PRESERVE = 1,
+	PASID_LU_OP_UNPRESERVE,
+	PASID_LU_OP_RESTORE,
+};
+
+static int pasid_lu_do_op(void *table, enum pasid_lu_op op)
+{
+	int ret = 0;
+
+	switch (op) {
+	case PASID_LU_OP_PRESERVE:
+		ret = iommu_preserve_pages(table);
+		break;
+	case PASID_LU_OP_UNPRESERVE:
+		iommu_unpreserve_pages(table);
+		break;
+	case PASID_LU_OP_RESTORE:
+		iommu_restore_pages(virt_to_phys(table));
+		break;
+	}
+
+	return ret;
+}
+
+static int pasid_lu_handle_pd(struct pasid_dir_entry *dir,
+			      u32 max_pasid, enum pasid_lu_op op)
+{
+	int max_pde = max_pasid >> PASID_PDE_SHIFT;
+	struct pasid_entry *table;
+	int i, ret;
+
+	for (i = 0; i < max_pde; i++) {
+		table = get_pasid_table_from_pde(&dir[i]);
+		if (!table)
+			continue;
+
+		ret = pasid_lu_do_op(table, op);
+		if (ret)
+			goto err;
+	}
+
+	ret = pasid_lu_do_op(dir, op);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	if (op != PASID_LU_OP_PRESERVE)
+		return ret;
+
+	while (i > 0) {
+		table = get_pasid_table_from_pde(&dir[--i]);
+		if (!table)
+			continue;
+
+		pasid_lu_do_op(table, PASID_LU_OP_UNPRESERVE);
+	}
+
+	return ret;
+}
+
 /**
  * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
  * @dev: Target device
@@ -454,6 +518,7 @@ int intel_iommu_preserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct pasid_table *pasid_table;
 	int ret;
 
 	if (!dev_is_pci(dev)) {
@@ -484,6 +549,22 @@ int intel_iommu_preserve_device(struct device *dev,
 
 	device_ser->attachment.attachment_id = domain_id_iommu(info->domain,
 							       info->iommu);
+
+	if (!sm_supported(info->iommu))
+		return 0;
+
+	pasid_table = intel_pasid_get_table(dev);
+	if (!pasid_table)
+		return -EINVAL;
+
+	ret = pasid_lu_handle_pd(pasid_table->table,
+				 pasid_table->max_pasid,
+				 PASID_LU_OP_PRESERVE);
+	if (ret)
+		return ret;
+
+	device_ser->intel.pasid_table = virt_to_phys(pasid_table->table);
+	device_ser->intel.max_pasid = pasid_table->max_pasid;
 	return 0;
 }
 
@@ -495,15 +576,33 @@ int intel_iommu_preserve_device(struct device *dev,
 void intel_iommu_unpreserve_device(struct device *dev,
 				   struct iommu_device_ser *device_ser)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct pasid_table *pasid_table;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	if (!info)
+		return;
+
+	if (!sm_supported(info->iommu))
+		return;
+
 	/*
 	 * The context tables preserved during device preservation, in the
 	 * preserve_device() callback, might be shared with other devices, so
-	 * those are unpreserved in the iommu unpreserve() callback. So this
-	 * callback is kept empty.
-	 *
-	 * Once device PASID tables are preserved, the unpreservation of PASID
-	 * tables will be added here.
+	 * those are unpreserved in the iommu unpreserve() callback.
 	 */
+	if (!device_ser->intel.pasid_table)
+		return;
+
+	pasid_table = intel_pasid_get_table(dev);
+	if (!pasid_table)
+		return;
+
+	pasid_lu_handle_pd(pasid_table->table,
+			   pasid_table->max_pasid,
+			   PASID_LU_OP_UNPRESERVE);
 }
 
 /**
@@ -549,3 +648,38 @@ void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
 	unpreserve_iommu_context_tables(iommu, ser);
 	iommu_unpreserve_pages(iommu->root_entry);
 }
+
+/**
+ * intel_pasid_restore_table() - Restore preserved PASID table for a device
+ * @dev: Restored device
+ * @max_pasid: Maximum supported PASID
+ *
+ * Return: Pointer to restored PASID table directory, or NULL if not preserved.
+ */
+void *intel_pasid_restore_table(struct device *dev, u64 max_pasid)
+{
+	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
+
+	if (!ser || !ser->intel.pasid_table)
+		return NULL;
+
+	/*
+	 * MAX PASID of a device should not change as it is read from
+	 * capabilities.
+	 */
+	if (ser->intel.max_pasid != max_pasid)
+		panic("%s: preserved max PASID %llu does not match %llu\n",
+		      dev_name(dev), ser->intel.max_pasid, max_pasid);
+
+	if (ser->intel.restored)
+		goto out;
+
+	if (pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
+			       ser->intel.max_pasid, PASID_LU_OP_RESTORE))
+		panic("%s: failed to restore preserved PASID table\n",
+		      dev_name(dev));
+	ser->intel.restored = 1;
+
+out:
+	return phys_to_virt(ser->intel.pasid_table);
+}
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index e4f24d3f19a6..59cc69383799 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -13,6 +13,7 @@
 #include <linux/cpufeature.h>
 #include <linux/dmar.h>
 #include <linux/iommu.h>
+#include <linux/iommu-liveupdate.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
@@ -60,8 +61,13 @@ int intel_pasid_alloc_table(struct device *dev)
 
 	size = max_pasid >> (PASID_PDE_SHIFT - 3);
 	order = size ? get_order(size) : 0;
-	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
-					1 << (order + PAGE_SHIFT));
+
+	max_pasid = 1 << (order + PAGE_SHIFT + 3);
+	if (dev_iommu_restored_state(dev))
+		dir = intel_pasid_restore_table(dev, max_pasid);
+	else
+		dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
+						1 << (order + PAGE_SHIFT));
 	if (!dir) {
 		kfree(pasid_table);
 		return -ENOMEM;
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 48d3bb6b68de..801768cdea16 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -301,6 +301,14 @@ static inline void pasid_set_eafe(struct pasid_entry *pe)
 
 extern unsigned int intel_pasid_max_id;
 int intel_pasid_alloc_table(struct device *dev);
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+void *intel_pasid_restore_table(struct device *dev, u64 max_pasid);
+#else
+static inline void *intel_pasid_restore_table(struct device *dev, u64 max_pasid)
+{
+	return NULL;
+}
+#endif
 void intel_pasid_free_table(struct device *dev);
 struct pasid_table *intel_pasid_get_table(struct device *dev);
 int intel_pasid_setup_first_level(struct intel_iommu *iommu, struct device *dev,
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
index 95354a12ba1d..08443f6cee6f 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -137,6 +137,21 @@ struct iommu_attachment_ser {
 	u32 padding;
 } __packed;
 
+/**
+ * struct iommu_device_intel_ser - Intel specific state of serialized device
+ * @features: Bitmask of Intel device specific features
+ * @restored: Whether the device state is restored
+ * @pasid_table: Physical address of pasid table
+ * @max_pasid: Maximum supported pasid
+ */
+struct iommu_device_intel_ser {
+	u32 features;
+	u8 restored;
+	u8 padding[3];
+	u64 pasid_table;
+	u64 max_pasid;
+} __packed;
+
 /**
  * struct iommu_device_ser - Serialized state of a device
  * @hdr: Common object header
@@ -146,6 +161,7 @@ struct iommu_attachment_ser {
  * @iommu_phys: Physical address of the serialized IOMMU the device is behind
  * @attachment: Attachment of the device to its domain
  * @reserved: Reserved for future common fields.
+ * @intel: Intel specific serialization data
  */
 struct iommu_device_ser {
 	struct iommu_hdr_ser hdr;
@@ -155,6 +171,9 @@ struct iommu_device_ser {
 	u64 iommu_phys;
 	struct iommu_attachment_ser attachment;
 	u64 reserved[2];
+	union {
+		struct iommu_device_intel_ser intel;
+	};
 } __packed;
 
 /* There are maximum 256 buses, so maximum 512 context tables */
-- 
2.56.0.506.g506a7eabc5-goog

