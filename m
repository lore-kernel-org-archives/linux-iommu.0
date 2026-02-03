Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7530937E30A
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156606; cv=none; b=SuXSWYBIMbpvNtNMcR63J9g8wDOiWRjPW3+knzcDYF2QRzW03ZYcgUPmBqdz+T7zmzv6XPeSgqbQTkWHE0hFoNrbjamGHWBcW4iQS3McdUJYCyF3VGzqXOnSZtqxaZTEAwvljffDf5zMD0wG5NFWPyMgafm6qKgsieMzGR+NYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156606; c=relaxed/simple;
	bh=eZGL6r3Vcbmae1XqI15ANHTzSxVGmOogsWKg6UBegc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=goZu2WFtUGR/ZqrMo4kQxoirk32+9ucrEOQpfGBzFFNnkpY7LrA3ugITFquncox6+MnXxAfvJi/Rhx2AKFuxxCSy4ozcBo0CZFCujDQh+3FASqb0TiuZls+tZXAjMVPevo0Bt3BlGF37VAQSvAB9VOyDPWYh8JdGmsHPsNKJh7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DNue8u/r; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNue8u/r"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c549aaa796dso12445385a12.1
        for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 14:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770156605; x=1770761405; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VBDlj4MRkwRVhMDxpPQ8tTAs7Fk9pUNiAoP3hey8V2Y=;
        b=DNue8u/rf9+/J0/OlTMH/3Nf1nsULYHiuo8Ax+s33W2cEmpYA00+35Yugv06OsqMJq
         MUyRJaHvVUk2GX9a9ebPFIJ3D1bjg/9qnOZHUZhF3ffqTPpBtA+KOwkiZjyHEAR8FJoe
         oZGqsvQ/m4wlukCPu7PKoBsa2d8/OIirV8AaqwsO08ktRwqkUvkRPlnBSIfbCA4BxF0k
         TTIcUGLy6VDrypsSGccTxYO2QSO8iwDd51drAZiYK+D8LJIJMLIO1izcIn3phrJtG0Zq
         lvbUnth374Rmv202wWqkuGd3kcaEqQD4aWym1cfjVPhyVrA7QyWFbRqAhWKeEF0NW9OM
         pAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770156605; x=1770761405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBDlj4MRkwRVhMDxpPQ8tTAs7Fk9pUNiAoP3hey8V2Y=;
        b=fXWV+OAASvssEcXbsKpKXPrtETFvpiIlHD8kJaGR86OQwLuAEUEID/p9JxPX8unJBO
         l1MqelWz4FDurPFCgHLNVIMv5UVLlElYKwUxVJlf5+PCG0FqWupM7geSihl4lAV0/dN7
         mgtlCqHynvzpDU3Sp2gkHNss0ySEW8V+AtRpcOgGnEQ9Tq9PSS6O9LsmW9TO8Nk5BqqM
         d5U7hHT5Yucp7kp+PXuUboZrfrT9bxL5VvRs1goYBK67Rw025jscAIUZiOstZ/ucDF+R
         UMTFRwq4jRrXH/riyVLezDkSOh/ri2PMPBP2k/DI3lg1AsTKQrjR/y76AgctrABhFWSk
         qtFw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Ax+jETh0RBYqAoJHSi8qwCjygt5L9C35U/pYD994VlLbY8Lw1nEq7Ccjinz1VlIbz5/xdg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywqv3Bgqr8+W1HP4FfIMzElk/QQxBZYwzQ67hvNgHYbqHPE+Z91
	09I2H8xa3m/AbGNRdAGVFcEP8j6/U8AN38uClh/UYoyvVkopWactWxgTuYXEZlKt/Opc0N+/Ohu
	rgZa1T+LmWwF3/Q==
X-Received: from pge6.prod.google.com ([2002:a05:6a02:2d06:b0:c66:f3a8:71ce])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a10f:b0:393:7891:7ead with SMTP id adf61e73a8af0-393789182dcmr92483637.1.1770156604757;
 Tue, 03 Feb 2026 14:10:04 -0800 (PST)
Date: Tue,  3 Feb 2026 22:09:43 +0000
In-Reply-To: <20260203220948.2176157-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260203220948.2176157-1-skhawaja@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203220948.2176157-10-skhawaja@google.com>
Subject: [PATCH 09/14] iommu/vt-d: preserve PASID table of preserved device
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
 drivers/iommu/intel/iommu.c      |   4 +-
 drivers/iommu/intel/iommu.h      |   5 ++
 drivers/iommu/intel/liveupdate.c | 130 +++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.c      |   7 +-
 drivers/iommu/intel/pasid.h      |   9 +++
 include/linux/kho/abi/iommu.h    |   8 ++
 6 files changed, 160 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 83faad53f247..2d0dae57f5a2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2944,8 +2944,10 @@ static bool __maybe_clean_unpreserved_context_entries(struct intel_iommu *iommu)
 		if (info->iommu != iommu)
 			continue;
 
-		if (dev_iommu_preserved_state(&pdev->dev))
+		if (dev_iommu_preserved_state(&pdev->dev)) {
+			pasid_cleanup_preserved_table(&pdev->dev);
 			continue;
+		}
 
 		domain_context_clear(info);
 	}
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 057bd6035d85..d24d6aeaacc0 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1286,6 +1286,7 @@ int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser
 void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
 void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 					       struct iommu_ser *iommu_ser);
+void pasid_cleanup_preserved_table(struct device *dev);
 #else
 static inline int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
 {
@@ -1309,6 +1310,10 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
 							     struct iommu_ser *iommu_ser)
 {
 }
+
+static inline void pasid_cleanup_preserved_table(struct device *dev)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 6dcb5783d1db..53bb5fe3a764 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 
 #include "iommu.h"
+#include "pasid.h"
 #include "../iommu-pages.h"
 
 static void unpreserve_iommu_context(struct intel_iommu *iommu, int end)
@@ -113,9 +114,89 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
 		iommu->reg_phys, iommu_ser->intel.root_table);
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
+	/* Cleanup everything except the first entry. */
+	memset(&table[1], 0, SZ_4K - sizeof(*table));
+	memset(&dir[1], 0, SZ_4K - sizeof(struct pasid_dir_entry));
+
+	clflush_cache_range(&table[0], SZ_4K);
+	clflush_cache_range(&dir[0], SZ_4K);
+}
+
 int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct pasid_table *pasid_table;
+	int ret;
 
 	if (!dev_is_pci(dev))
 		return -EOPNOTSUPP;
@@ -124,11 +205,42 @@ int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_se
 		return -EINVAL;
 
 	device_ser->domain_iommu_ser.did = domain_id_iommu(info->domain, info->iommu);
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
 
 void intel_iommu_unpreserve_device(struct device *dev, struct device_ser *device_ser)
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
+	pasid_table = intel_pasid_get_table(dev);
+	if (!pasid_table)
+		return;
+
+	pasid_lu_handle_pd(pasid_table->table, PASID_LU_OP_UNPRESERVE);
 }
 
 int intel_iommu_preserve(struct iommu_device *iommu_dev, struct iommu_ser *ser)
@@ -172,3 +284,21 @@ void intel_iommu_unpreserve(struct iommu_device *iommu_dev, struct iommu_ser *io
 	iommu_unpreserve_page(iommu->root_entry);
 	spin_unlock(&iommu->lock);
 }
+
+void *intel_pasid_try_restore_table(struct device *dev, u64 max_pasid)
+{
+	struct device_ser *ser = dev_iommu_restored_state(dev);
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
index 3e2255057079..96b9daf9083d 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -60,8 +60,11 @@ int intel_pasid_alloc_table(struct device *dev)
 
 	size = max_pasid >> (PASID_PDE_SHIFT - 3);
 	order = size ? get_order(size) : 0;
-	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
-					1 << (order + PAGE_SHIFT));
+
+	dir = intel_pasid_try_restore_table(dev, max_pasid);
+	if (!dir)
+		dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
+						1 << (order + PAGE_SHIFT));
 	if (!dir) {
 		kfree(pasid_table);
 		return -ENOMEM;
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index b4c85242dc79..e8a626c47daf 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -287,6 +287,15 @@ static inline void pasid_set_eafe(struct pasid_entry *pe)
 
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
index 8e1c05cfe7bb..111a46c31d92 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -50,6 +50,11 @@ struct device_domain_iommu_ser {
 	u64 iommu_phys;
 } __packed;
 
+struct device_intel_ser {
+	u64 pasid_table;
+	u64 max_pasid;
+} __packed;
+
 struct device_ser {
 	struct iommu_obj_ser obj;
 	u64 token;
@@ -57,6 +62,9 @@ struct device_ser {
 	u32 pci_domain;
 	struct device_domain_iommu_ser domain_iommu_ser;
 	enum iommu_lu_type type;
+	union {
+		struct device_intel_ser intel;
+	};
 } __packed;
 
 struct iommu_intel_ser {
-- 
2.53.0.rc2.204.g2597b5adb4-goog

