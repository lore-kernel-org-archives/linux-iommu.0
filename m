Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F5A3EB7FA
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312620; cv=none; b=beZkpQzNzylxdk5Nd1PkzeDnt5GMX4jobZq0T4C6gQ3CGVIg15y9Q4rATd+EczKX7fd2rXfvfNi+p1LZrCP48MR5m+FGyTAxLbqJZDEiI9zFF9O1STLsW6xYaxELeQnEMIeqsbPG3m6oHk+8HyiRL+Xpf323BE02CKwzwbnEeR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312620; c=relaxed/simple;
	bh=oTPrNsJGn9y9ve7G0JXQaEe3AHZWdcmCD6cOOWFC2jI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TAA/zxWOG9K/zUaxzDGwfnYms2aJh8uWSyKZ8d/34dBsgoXzlXSV63hQDqSVHFeEBS2L84tV7w/iyj993D9zdljKwUTOwxG4BNMx2/KrXUFRI7q+9HFQOR+oqONPyhphiZfPzNjlrCRL+nl/FSQ+Hk+GSc1eDwknfCYvb3zi3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4DRaOEA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4DRaOEA"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7973e22399so4053868a12.0
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312614; x=1777917414; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=97dwBGOJ4jagqgVLDeX5AsU1vRAHIAdmrbC0lOtevyE=;
        b=L4DRaOEAAOeSBOqSrcjK06Rx2zhsbLfRAfZH5oM47o8oi2EQjkAcYXv/y8CP/ed5gv
         AHpIBQTxkntEaM2jNRIRiSeF54sz+hqc6P1+jzHKZtTBQM3GXeh0apd7W183v0Ix4kOe
         YXI21yCnNKRBlVEdDH0P9PfJe7GeGEA3gHE03d7OTFzAW6rePtQcGJDX1lmwS0LN5EGm
         cx6zKg9sr8UGKI9T9d8nsnyEqP3YU6dmwAPzp8wdrBJklQ0A32bmn0Y6Cl9bk/qnG9be
         YpdO/tAvTnQnzvGUU/3uVROvPXEUbz6c4jbqsI+9Mj4oLIsaXY6j367F6kQvKsfy2bOM
         XhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312614; x=1777917414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97dwBGOJ4jagqgVLDeX5AsU1vRAHIAdmrbC0lOtevyE=;
        b=ZJzwSygVk/HrRIANTwyYujYKKfrjkZztVDXKEnwXVsbr3kShU4P442a5hVKxo0yJqn
         xPpu9yrK5QkTMJgFF0EaD9Nqzr2tYSDOdcnrG0yzoKZ6NoYr2LX5AwXS1LsCWJQviRmv
         guvTPyaE/kLD2MnZ6JyrdSDtpduE/0xrfvN1NlLV4oWYBHXe04xt8g73zVvNAp6hj3xG
         N0oi6WQXz8t0nMuXlm5cHTGAskYOUDZ3csgp04ScNJYK7qsTCcZtKmZXG4f5nWugCYP2
         75lGNHnfiUzQ8vgrkUmPIOSO2rg0hDqPtyuejNGyZPwQWzD+NEt8EaRsAgWeOoJtJtIK
         LPxw==
X-Forwarded-Encrypted: i=1; AFNElJ+K454pp4KPO9ioFkyd19l/yxCl8x0srTb4eYVu5f36WlYzyY2Cu4kxSnlNI+1uyrIsLm/pQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVJxUTNR2ek687UHAJlIMFlZC8LJ1hvRlyPW7alJcTblL9+k0s
	bFYoHXijTNr8UXz8vsPUmwcM55JBs9hWqFrEaBQrymoVOlezSBSAaDkg1c606eknU9jGp2pmg8S
	dRv3Nw+HEFVg6jA==
X-Received: from pgbda9.prod.google.com ([2002:a05:6a02:2389:b0:c6e:6f94:b489])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1592:b0:3a2:dd8a:5088 with SMTP id adf61e73a8af0-3a398f4533dmr355326637.51.1777312613917;
 Mon, 27 Apr 2026 10:56:53 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:28 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-12-skhawaja@google.com>
Subject: [PATCH v2 11/16] iommu/vt-d: preserve PASID table of preserved device
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

In scalable mode the PASID table is used to fetch the io page tables.
Preserve and restore the PASID table of the preserved devices.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c      |   5 +-
 drivers/iommu/intel/iommu.h      |  12 +++
 drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.c      |   7 +-
 drivers/iommu/intel/pasid.h      |   9 ++
 include/linux/kho/abi/iommu.h    |  13 +++
 6 files changed, 184 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b90757164cd8..6d42051dcf7c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2951,8 +2951,10 @@ static int clear_unpreserve_context_entry_fn(struct device *dev,
 	if (!info)
 		return 0;
 
-	if (dev_is_pci(dev) && dev_iommu_preserved_state(dev))
+	if (dev_is_pci(dev) && dev_iommu_preserved_state(dev)) {
+		pasid_cleanup_preserved_table(dev);
 		return 0;
+	}
 
 	domain_context_clear(info);
 	return 0;
@@ -4013,6 +4015,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.page_response		= intel_iommu_page_response,
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 	.preserve_device	= intel_iommu_preserve_device,
+	.unpreserve_device	= intel_iommu_unpreserve_device,
 	.preserve		= intel_iommu_preserve,
 	.unpreserve		= intel_iommu_unpreserve,
 #endif
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8e37acf7de12..62076a1a0b4d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1290,12 +1290,15 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int intel_iommu_preserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser);
+void intel_iommu_unpreserve_device(struct device *dev,
+				   struct iommu_device_ser *device_ser);
 int intel_iommu_preserve(struct iommu_device *iommu,
 			 struct iommu_hw_ser *iommu_ser);
 void intel_iommu_unpreserve(struct iommu_device *iommu,
 			    struct iommu_hw_ser *iommu_ser);
 void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 					       struct iommu_hw_ser *iommu_ser);
+void pasid_cleanup_preserved_table(struct device *dev);
 #else
 static inline int intel_iommu_preserve_device(struct device *dev,
 					      struct iommu_device_ser *device_ser)
@@ -1303,6 +1306,11 @@ static inline int intel_iommu_preserve_device(struct device *dev,
 	return -EOPNOTSUPP;
 }
 
+static inline void intel_iommu_unpreserve_device(struct device *dev,
+						 struct iommu_device_ser *device_ser)
+{
+}
+
 static inline int intel_iommu_preserve(struct iommu_device *iommu,
 				       struct iommu_hw_ser *iommu_ser)
 {
@@ -1318,6 +1326,10 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
 							     struct iommu_hw_ser *iommu_ser)
 {
 }
+
+static inline void pasid_cleanup_preserved_table(struct device *dev)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 50a63812533f..404b485e97b9 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 
 #include "iommu.h"
+#include "pasid.h"
 #include "../iommu-pages.h"
 
 static void unpreserve_iommu_context_table(struct intel_iommu *iommu, int end)
@@ -140,10 +141,96 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 	iommu_for_each_preserved_device(_restore_used_domain_ids, iommu);
 }
 
+enum pasid_lu_op {
+	PASID_LU_OP_PRESERVE = 1,
+	PASID_LU_OP_UNPRESERVE,
+	PASID_LU_OP_RESTORE,
+	PASID_LU_OP_FREE,
+};
+
+static int pasid_lu_do_op(void *table, enum pasid_lu_op op)
+{
+	int ret = 0;
+
+	switch (op) {
+	case PASID_LU_OP_PRESERVE:
+		ret = iommu_preserve_page(table);
+		break;
+	case PASID_LU_OP_UNPRESERVE:
+		iommu_unpreserve_page(table);
+		break;
+	case PASID_LU_OP_RESTORE:
+		iommu_restore_page(virt_to_phys(table));
+		break;
+	case PASID_LU_OP_FREE:
+		iommu_free_pages(table);
+		break;
+	}
+
+	return ret;
+}
+
+static int pasid_lu_handle_pd(struct pasid_dir_entry *dir, enum pasid_lu_op op)
+{
+	struct pasid_entry *table;
+	int ret;
+
+	/* Only preserve first table for NO_PASID. */
+	table = get_pasid_table_from_pde(&dir[0]);
+	if (!table)
+		return -EINVAL;
+
+	ret = pasid_lu_do_op(table, op);
+	if (ret)
+		return ret;
+
+	ret = pasid_lu_do_op(dir, op);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	if (op == PASID_LU_OP_PRESERVE)
+		pasid_lu_do_op(table, PASID_LU_OP_UNPRESERVE);
+
+	return ret;
+}
+
+void pasid_cleanup_preserved_table(struct device *dev)
+{
+	struct pasid_table *pasid_table;
+	struct pasid_dir_entry *dir;
+	struct pasid_entry *table;
+	size_t dir_size;
+
+	pasid_table = intel_pasid_get_table(dev);
+	if (!pasid_table)
+		return;
+
+	dir = pasid_table->table;
+	table = get_pasid_table_from_pde(&dir[0]);
+	if (!table)
+		return;
+
+	/* Clear everything except the first entry in table. */
+	memset(&table[1], 0, SZ_4K - sizeof(*table));
+
+	/* Use the folio order to calculate the size of Pasid Directory */
+	dir_size = (1 << (folio_order(virt_to_folio(dir)) + PAGE_SHIFT));
+
+	/* Clear everything except the first entry in directory */
+	memset(&dir[1], 0, dir_size - sizeof(struct pasid_dir_entry));
+
+	clflush_cache_range(&table[0], SZ_4K);
+	clflush_cache_range(&dir[0], dir_size);
+}
+
 int intel_iommu_preserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct pasid_table *pasid_table;
+	int ret;
 
 	if (!dev_is_pci(dev)) {
 		dev_err(dev, "Cannot preserve non-PCI device\n");
@@ -155,9 +242,45 @@ int intel_iommu_preserve_device(struct device *dev,
 
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
+	ret = pasid_lu_handle_pd(pasid_table->table, PASID_LU_OP_PRESERVE);
+	if (ret)
+		return ret;
+
+	device_ser->intel.pasid_table = virt_to_phys(pasid_table->table);
+	device_ser->intel.max_pasid = pasid_table->max_pasid;
 	return 0;
 }
 
+void intel_iommu_unpreserve_device(struct device *dev,
+				   struct iommu_device_ser *device_ser)
+{
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
+	pasid_table = intel_pasid_get_table(dev);
+	if (!pasid_table)
+		return;
+
+	pasid_lu_handle_pd(pasid_table->table, PASID_LU_OP_UNPRESERVE);
+}
+
 int intel_iommu_preserve(struct iommu_device *iommu_dev,
 			 struct iommu_hw_ser *ser)
 {
@@ -194,3 +317,21 @@ void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
 	unpreserve_iommu_context_table(iommu, ROOT_ENTRY_NR);
 	iommu_unpreserve_page(iommu->root_entry);
 }
+
+void *intel_pasid_try_restore_table(struct device *dev, u64 max_pasid)
+{
+	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
+
+	if (!ser)
+		return NULL;
+
+	BUG_ON(pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
+				  PASID_LU_OP_RESTORE));
+	if (WARN_ON_ONCE(ser->intel.max_pasid != max_pasid)) {
+		pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
+				   PASID_LU_OP_FREE);
+		return NULL;
+	}
+
+	return phys_to_virt(ser->intel.pasid_table);
+}
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 89541b74ab8c..5cac8e95f73b 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -60,8 +60,11 @@ int intel_pasid_alloc_table(struct device *dev)
 
 	size = max_pasid >> (PASID_PDE_SHIFT - 3);
 	order = size ? get_order(size) : 0;
-	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
-					1 << (order + PAGE_SHIFT));
+
+	dir = intel_pasid_try_restore_table(dev, 1 << (order + PAGE_SHIFT + 3));
+	if (!dir)
+		dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
+						1 << (order + PAGE_SHIFT));
 	if (!dir) {
 		kfree(pasid_table);
 		return -ENOMEM;
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 48d3bb6b68de..44e673a4ad8f 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -301,6 +301,15 @@ static inline void pasid_set_eafe(struct pasid_entry *pe)
 
 extern unsigned int intel_pasid_max_id;
 int intel_pasid_alloc_table(struct device *dev);
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+void *intel_pasid_try_restore_table(struct device *dev, u64 max_pasid);
+#else
+static inline void *intel_pasid_try_restore_table(struct device *dev,
+						  u64 max_pasid)
+{
+	return NULL;
+}
+#endif
 void intel_pasid_free_table(struct device *dev);
 struct pasid_table *intel_pasid_get_table(struct device *dev);
 int intel_pasid_setup_first_level(struct intel_iommu *iommu, struct device *dev,
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
index 5ffedf0dbd5a..5eeb1e0c9bce 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -119,6 +119,16 @@ struct iommu_dev_map_ser {
 	u64 iommu_phys;
 } __packed;
 
+/**
+ * struct iommu_device_intel_ser - Intel specific state of serialized device
+ * @pasid_table: Physical address of pasid table
+ * @max_pasid: Maximum supported pasid
+ */
+struct iommu_device_intel_ser {
+	u64 pasid_table;
+	u64 max_pasid;
+} __packed;
+
 /**
  * struct iommu_device_ser - Serialized state of a device
  * @hdr: Common object header
@@ -131,6 +141,9 @@ struct iommu_device_ser {
 	u32 devid;
 	u32 pci_domain_nr;
 	struct iommu_dev_map_ser domain_iommu_ser;
+	union {
+		struct iommu_device_intel_ser intel;
+	};
 } __packed;
 
 /**
-- 
2.54.0.545.g6539524ca2-goog

