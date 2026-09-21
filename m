Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35512D0292
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951735; cv=none; b=FuEWMZkf2tZZ/hCBxK3bXd0qbLoOhYJxaUwZRs7CgM1EKpCHcz1QpLTXXErp2FTGCW/dlmlVfsNeCfb9L7jIkONyz5WtGGd9xgtK7AbwJzc8vYIAvS6/1H2swC+2mi3QUFO6WsqrwzI7Y1XvzGLY6xCafu2qRkfkLFH8NcvpU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951735; c=relaxed/simple;
	bh=bViJJwbrDWXP/RQSx7nYGasTuiaqPBrsxDARAbursxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aTt/nXQzpprZSgATUFq2VVDcncnYVC4X+U98gIwhg5iSol7R8wU25gPeSKvmSJd39evkCapToPQDqCRucFjr7f03WtnU8jlaUBkdt7Qmb5wX/trI23uzHSkmwNMTbwy0wgx80OcJ0A9Qq3oA1fa9Rx4tMkjBKgSso381BrpcVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AB0wWpLk; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AB0wWpLk"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-877ef1457aeso1463077b3a.1
        for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 17:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951732; x=1790556532; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dbOQml2BXHpzMYBrRxpebYsHTJLnApuit/nNvL/j2sY=;
        b=AB0wWpLkeikUnI0xBB8oalPLCcbYVMzkSKXroG5GfJ8i6M2fc/4hTZDlGlzd1r8wZ4
         4D7CWtBifAGholk0kXqKPN2z6QMHCsJ39ErNH5/PkcPZwfCtzf3/DZ79S9HWJu9WhRWp
         dbaF1gP6UvFQDfZu9yKnHgBQflpyKgMM7jMqtpOZXqRAgDfwiCx5OUAPGFFZRxQrYCbV
         dziYdfTWwgS6BrLXZhOclH5mfAD+YphvJxvTXVdouoBg6B6OlCY5+smHzTLyCfVFz3cx
         ZQLbFGVGaOQgi3YFSBZKP8LZAR8cnCUh17w9R6oZVke/GhCvvIzXhb4t2odciHzAwKDm
         ljmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951732; x=1790556532;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dbOQml2BXHpzMYBrRxpebYsHTJLnApuit/nNvL/j2sY=;
        b=ZyVzFFGbCazDMAP3wv2BmxtzoADttN4Vybn3BrKSv+UUOuYVcFB/r1iH6H1R5jQ/bl
         CfafbcJkOx9qP94HkqSfmFMmfb9fw7L2wVSFB9xJS+Fo6I4qyHd0YI3ddERQZff/AN3z
         4Z0Mhs/JoN7YiEQ01QgS1dEn+yewZiOcSPf3lbkPwIcYu98PcCCRTHxvhtfPPabecMRG
         xt6Pgjs5RbZnGSr5rfSwn8TFUL/4TdK6NBMpKQbdYYwR/FA9UVHIW03ccbWs18TtUZOr
         BCu1DSrToTh27Xfs8zjS5rBIGfnAty8SzRO6rs9SUOsOJb5sESB2vPVq2zmwYQbYLYIN
         b8Mg==
X-Forwarded-Encrypted: i=1; AKwUvBzaL4VgbEoh01fUblWmFGEizWDsD3HihMP8O56JupTboRKCbGSwpwMQFHgncJeqDBO1FNoJlQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nILB2hsbQtnIqrJ3RkAlDsdxNNsp1rPy/jVo3OVdgW8IA0PKvQ
	oMAG2tcnMSk8e0bHA1J9ATMOACHTcl5yVmIYFJfeQC6WC3i5dCqJ4Zql+16CKvad+3nxdj7PRiX
	IUtlJ/uJkTRFCwA==
X-Received: from pgax32.prod.google.com ([2002:a05:6a02:2e60:b0:cc4:e5ec:35b9])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e83:b0:874:705d:f639 with SMTP id d2e1a72fcca58-874dd9f6be9mr12281098b3a.27.1789951731594;
 Sun, 20 Sep 2026 17:48:51 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:29 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-14-skhawaja@google.com>
Subject: [PATCH v5 13/18] iommu/vt-d: Preserve PASID table of preserved device
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

In scalable mode the PASID table is used to fetch the io page tables.
Preserve and restore the PASID table of the preserved devices.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++--
 drivers/iommu/intel/pasid.c      |  10 ++-
 drivers/iommu/intel/pasid.h      |   8 ++
 include/linux/kho/abi/iommu.h    |  17 ++++
 4 files changed, 169 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 6e6707eefc8c..b9467fb7195f 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 
 #include "iommu.h"
+#include "pasid.h"
 #include "../iommu-pages.h"
 
 /* 2 tables per bus in scalable mode with upper table at odd bit */
@@ -510,6 +511,69 @@ int intel_iommu_detach_restored_device(struct device *dev)
 	return 0;
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
@@ -521,6 +585,7 @@ int intel_iommu_preserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct pasid_table *pasid_table;
 	int ret;
 
 	if (!dev_is_pci(dev)) {
@@ -543,6 +608,22 @@ int intel_iommu_preserve_device(struct device *dev,
 
 	device_ser->domain_iommu_ser.attachment_id = domain_id_iommu(info->domain,
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
 
@@ -554,15 +635,33 @@ int intel_iommu_preserve_device(struct device *dev,
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
@@ -607,3 +706,35 @@ void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
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
+	BUG_ON(ser->intel.max_pasid != max_pasid);
+
+	if (ser->intel.restored)
+		goto out;
+
+	BUG_ON(pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
+				  ser->intel.max_pasid,
+				  PASID_LU_OP_RESTORE));
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
index 5aaa29da6832..308cd83fd3e3 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -129,6 +129,19 @@ struct iommu_dev_map_ser {
 	u64 iommu_phys;
 } __packed;
 
+/**
+ * struct iommu_device_intel_ser - Intel specific state of serialized device
+ * @restored: Whether the device state is restored
+ * @pasid_table: Physical address of pasid table
+ * @max_pasid: Maximum supported pasid
+ */
+struct iommu_device_intel_ser {
+	u8 restored;
+	u8 padding[7];
+	u64 pasid_table;
+	u64 max_pasid;
+} __packed;
+
 /**
  * struct iommu_device_ser - Serialized state of a device
  * @hdr: Common object header
@@ -136,6 +149,7 @@ struct iommu_dev_map_ser {
  * @pci_domain_nr: PCI domain number
  * @dma_owner_token: Token to identify the DMA owner of this device
  * @domain_iommu_ser: Domain and IOMMU mapping
+ * @intel: Intel specific serialization data
  */
 struct iommu_device_ser {
 	struct iommu_hdr_ser hdr;
@@ -143,6 +157,9 @@ struct iommu_device_ser {
 	u32 pci_domain_nr;
 	u64 dma_owner_token;
 	struct iommu_dev_map_ser domain_iommu_ser;
+	union {
+		struct iommu_device_intel_ser intel;
+	};
 } __packed;
 
 /* There are maximum 256 buses, so maximum 512 context tables */
-- 
2.55.0.1082.g2b9226bbc0-goog

