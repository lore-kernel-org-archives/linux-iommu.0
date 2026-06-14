Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C9137EFF0
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480263; cv=none; b=CD37zkwLIDCCzowJMq0Z7r/1kFjYvwN1LXYCE8paGERZOvDOjVCoahOCRfj+Po/bu2b8JoDIfd9VfmbURBuUZybbUd1B//qldH5jjP2ze2kypBRo4gfFdEm/em/DxadgELm5vn+aDm3v4xlPapDmx4G9FzsSICb4CV6m6oN8iL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480263; c=relaxed/simple;
	bh=joV69gjacfTcRWrVT6OQq8u8NrBGJA549Sh4ZYyP7Ns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MzQ3uQXURZZjP6GQ2OgtvXEmX3KErmqFMLBu0/8WZW/luXp+z9xqe5o3CkOeVjIdSl36rwqdbjF5cCyB8ueoR/0SnlGTSJKaI0XYdZrJiyXMrw0sMbMSY2oFwLDF5nNgoyyJ9OkzHIyU6GwhLcjT0jZH+XuQj93FTEgpfKTTzNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYrhARfV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYrhARfV"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d98b76d12so1752124a91.2
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 16:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480260; x=1782085060; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nY4FJNVOanhvxXtG88kwftKdSiyXJ7/r90PqLlk19Vc=;
        b=aYrhARfVmF4YspbDl+8MBip08H+MTYnxxd7B5BMx7cVZCRt3MfBADvgo3n7y9/4Kh2
         RWN9q4NRrlmz+GCCmJAdDLjHMiIUVJlAqqrawBnQSSdzl9xquefRk5wApVkv0tIdlkfG
         KYET6Py5d/lZdzz7qC2IO2kIOlYEjzhAxBYVcVNi2VAcaG1NH1YKexD01nym5quRKspg
         3vhG4lobQdhF4L0tu3iQH8LIMHUVUlD/DDM5aDVLqZncnQdHAPB2uaYdvMUvzwFL4wM8
         f4SZwnIFQBlN0UvIQznxpio2+S2dKTWESeOh31yNj2D3pu9iOdO+QTv3W9+Yi7Tnbsae
         kfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480260; x=1782085060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nY4FJNVOanhvxXtG88kwftKdSiyXJ7/r90PqLlk19Vc=;
        b=L60Ph2Fbn4KsIseWNqQ3Q6ekWZdSAmtWUGFH3f0XfFz5XoIBN3SLF4HFNQKRxqVx7R
         iu5JWiAbR79AKHEWLbJJdaAMCTv9RWfolnZ+xFnXALd4LIui7LpdEGak9seFGUiWCOBt
         uo1of0CPRTlqJQ/hwwIaoeJh0TytcMrTdgryFrDNRFXbPGrV9vThHe844UbCBrI+ZPe3
         OXKyzp8FZ9ZOjiw3f4xwl9iuvokg/foYpefoU6mMzGyaiAC+GA7DX6bt/jZyng9Yr9Zm
         PpIdx08W3rI1sPa4W8R946Za5hWSEkZB6KR9wVE6oE3do3UbepmFXjNdEO06kpTOuxT/
         4Ezw==
X-Forwarded-Encrypted: i=1; AFNElJ87NJE6utM+GJS0fxDi2ZWWYL0Az3IpqBJ60Yr/kZTddWrAPu3HPHqJZB79JJFLrZFYRs4i1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBmGZMTdzWQhtU3oSdZSGRm1xAVg/agXNU8vP7v4U599mG2M+3
	DdyXEz7n+euF8XK4bIYHcjN3X171jtCPp9QzJUE1JPIEnb6Fgj210aCWv9FibEfkgCnKMVaHsZ2
	6YreKW6h6kvwoZA==
X-Received: from pjgg16.prod.google.com ([2002:a17:90b:57d0:b0:36b:8132:e6f4])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:48cd:b0:368:9da3:c496 with SMTP id 98e67ed59e1d1-37a0497dc45mr12280978a91.24.1781480260146;
 Sun, 14 Jun 2026 16:37:40 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:23 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-14-skhawaja@google.com>
Subject: [PATCH v3 13/18] iommu/vt-d: preserve PASID table of preserved device
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
 drivers/iommu/intel/liveupdate.c | 57 ++++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.c      |  7 ++--
 drivers/iommu/intel/pasid.h      |  9 +++++
 include/linux/kho/abi/iommu.h    | 13 ++++++++
 4 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 61d864a2e27c..25c940f12955 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 
 #include "iommu.h"
+#include "pasid.h"
 #include "../iommu-pages.h"
 
 /* 2 tables per bus in scalable mode with upper table at odd bit */
@@ -369,6 +370,7 @@ int intel_iommu_preserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct pasid_table *pasid_table;
 	int ret;
 
 	if (!dev_is_pci(dev)) {
@@ -385,9 +387,49 @@ int intel_iommu_preserve_device(struct device *dev,
 
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
+	pasid_lu_handle_pd(pasid_table->table,
+			   pasid_table->max_pasid,
+			   PASID_LU_OP_UNPRESERVE);
+}
+
 int intel_iommu_preserve(struct iommu_device *iommu_dev,
 			 struct iommu_hw_ser *ser)
 {
@@ -418,3 +460,18 @@ void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
 	unpreserve_iommu_context_tables(iommu, ser);
 	iommu_unpreserve_pages(iommu->root_entry);
 }
+
+void *intel_pasid_try_restore_table(struct device *dev, u64 max_pasid)
+{
+	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
+
+	if (!ser || !ser->intel.pasid_table)
+		return NULL;
+
+	BUG_ON(pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
+				  ser->intel.max_pasid,
+				  PASID_LU_OP_RESTORE));
+	BUG_ON(ser->intel.max_pasid < max_pasid);
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
index ad760c497e13..27d1fcd7f7e2 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -127,6 +127,16 @@ struct iommu_dev_map_ser {
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
@@ -139,6 +149,9 @@ struct iommu_device_ser {
 	u32 devid;
 	u32 pci_domain_nr;
 	struct iommu_dev_map_ser domain_iommu_ser;
+	union {
+		struct iommu_device_intel_ser intel;
+	};
 } __packed;
 
 /**
-- 
2.54.0.1136.gdb2ca164c4-goog

