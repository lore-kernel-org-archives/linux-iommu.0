Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019753115BD
	for <iommu@lists.linux.dev>; Sat,  8 Aug 2026 02:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156053; cv=none; b=QDW1A5THktAbR3vsBDcR0m1wmvW2ZMViAQwNiDa7diBUsHEbb0VgRpIwSDUCjlkBazTddaZRs/X8izAW2fsneN8MLSOshVjI6p36t9dE1ynQ2LDQ5gDnTB58UyblB/7K8y+cpFA5UAjRlv8tDTclO6t2hfnpgalzPS9KSnWfFEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156053; c=relaxed/simple;
	bh=jvAtaf33KgOXHK9/7nLv6w8XxqdOkpv0Sum2Lb0p9fo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R1tJV/q0Y/dEzIJa5y1Rx9l+Txi8KRy1uhtHcRBJBVZFpeygWxICLyMtPsf7gHccDQnwSXoM85joAy4UKvSx/uRQw1+9t0+6wcGdOjRKI93XolErar3V8Eh01qEKqv3dKLur3MUJmL7Y4oaqF2m3osPGKseiyQYoqRBHVOqlujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rK9jkB+u; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rK9jkB+u"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e048a801dso235234b3a.3
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 19:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156050; x=1786760850; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=faplfWrIP34H7dLz69UodmESAw9AFfd4kNZ3huRZCL0=;
        b=rK9jkB+uNULSTmrVzE5VTGn5HTUPu9CwoZCfjopeSz723liVKjNIXww/0W4+vymjLe
         ClKfjwixPL6PcsR/NmXs0cEm3CtWmayU0h9xx9bWc1pf82dAn37MSVTGSGWj2dpCCZDC
         DTEvAud413MUP/9pJhl8UD0nTDiSS5sv1LBnBXiToVRCufQWH5Q5e7dl+SqByJhiTlvf
         FE3lnk96WLIx8VaxSAj8rGGxXojNgJn0hr6VBTsKicrM4CFJKv/s/uuhvhC6B9a78C0C
         MnasJfi3SJMHxpsAG43hqvLx8sVxqUxbUxE8H7CkKk3jilyY4Oe9R4xoLuFit+6g5lSb
         ZoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156050; x=1786760850;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=faplfWrIP34H7dLz69UodmESAw9AFfd4kNZ3huRZCL0=;
        b=qpcYvYrCABSvGVXI8nRtfrLnGJiii3sg+MmzRlMS0o0TGSyMqHW6k6X//RRaEkyB/d
         vyowkt4A2LZnFsTjWOZeUCR/Zd2VINyHsZsWIOsRoa+Nxrv3bm3UR7YAHPMMJO7e0Syd
         LHcmJcMiHpOiGsAwz8bCJPrFdDoQWXZ5DlIMK/De+TAyHyN71sE79GWPe2z932NkJzGI
         BAYy4Ik/jOhSzIyGPDbfsV1wkaU7dRLRcWFdK6a8IVpYjusBiIXrAP3rpQi/YGdnHWyT
         9oOs+jrE64ElxQJiLcyoJp0meT5DvKnc89/kTgduxUm/S+L5kDzeLY9B3CSHaLHxonkS
         q6Pw==
X-Forwarded-Encrypted: i=1; AHgh+RrArqW08jZcx9ZNhPVQDlXhg9kyNF5sO0yyQRNODncQ1KkjnAN2pzQFz651FJ+n6tY91D0rRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyU1JSTCFbrmE6DWF92tqzw36P1WcYWzQohTt1wwUPdf7Bxetyp
	maCRcYC3azsuZEjmngMiWfSQAcIiuNmddYbbiadHcLWYe/FF9AOw0td2NBFlhZ+ZjSMniBVo+li
	6guiilnoOf7XVhw==
X-Received: from pfst18.prod.google.com ([2002:aa7:8f92:0:b0:848:8d8a:9463])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d54:b0:847:926c:582c with SMTP id d2e1a72fcca58-84f2e01410emr29472131b3a.29.1786156049909;
 Fri, 07 Aug 2026 19:27:29 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:12 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-8-skhawaja@google.com>
Subject: [PATCH v4 07/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
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

Add implementation of the device and iommu presevation in a separate
file. Also set the device and iommu preserve/unpreserve ops in the
struct iommu_ops.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                      |   8 ++
 drivers/iommu/intel/Makefile     |   1 +
 drivers/iommu/intel/iommu.c      |   9 +-
 drivers/iommu/intel/iommu.h      |  35 +++++
 drivers/iommu/intel/liveupdate.c | 220 +++++++++++++++++++++++++++++++
 include/linux/kho/abi/iommu.h    |  25 ++++
 6 files changed, 296 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/intel/liveupdate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 25707398426a..2ed856ab0501 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13132,6 +13132,14 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	drivers/iommu/intel/
 
+INTEL IOMMU LIVEUPDATE (VT-d)
+M:	Samiullah Khawaja <skhawaja@google.com>
+M:	Lu Baolu <baolu.lu@linux.intel.com>
+L:	iommu@lists.linux.dev
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
+F:	drivers/iommu/intel/liveupdate.c
+
 INTEL IPU3 CSI-2 CIO2 DRIVER
 M:	Yong Zhi <yong.zhi@intel.com>
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index ada651c4a01b..d38fc101bc35 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
 obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
+obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 849d06dfe1ae..aeae0563dfd0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -16,6 +16,7 @@
 #include <linux/crash_dump.h>
 #include <linux/dma-direct.h>
 #include <linux/dmi.h>
+#include <linux/iommu-liveupdate.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
@@ -60,8 +61,6 @@ static int force_on = 0;
 static int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
-#define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
-
 /*
  * Take a root_entry and return the Lower Context Table Pointer (LCTP)
  * if marked present.
@@ -3931,6 +3930,12 @@ const struct iommu_ops intel_iommu_ops = {
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
 	.page_response		= intel_iommu_page_response,
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	.preserve_device	= intel_iommu_preserve_device,
+	.unpreserve_device	= intel_iommu_unpreserve_device,
+	.preserve		= intel_iommu_preserve,
+	.unpreserve		= intel_iommu_unpreserve,
+#endif
 };
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 775f1c4ae346..4906cce1e66e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -552,6 +552,8 @@ struct root_entry {
 	u64     hi;
 };
 
+#define ROOT_ENTRY_NR (VTD_PAGE_SIZE / sizeof(struct root_entry))
+
 /*
  * low 64 bits:
  * 0: present
@@ -1295,6 +1297,39 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
 	return 0;
 }
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int intel_iommu_preserve_device(struct device *dev,
+				struct iommu_device_ser *device_ser);
+void intel_iommu_unpreserve_device(struct device *dev,
+				   struct iommu_device_ser *device_ser);
+int intel_iommu_preserve(struct iommu_device *iommu,
+			 struct iommu_hw_ser *iommu_ser);
+void intel_iommu_unpreserve(struct iommu_device *iommu,
+			    struct iommu_hw_ser *iommu_ser);
+#else
+static inline int intel_iommu_preserve_device(struct device *dev,
+					      struct iommu_device_ser *device_ser)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void intel_iommu_unpreserve_device(struct device *dev,
+						 struct iommu_device_ser *device_ser)
+{
+}
+
+static inline int intel_iommu_preserve(struct iommu_device *iommu,
+				       struct iommu_hw_ser *iommu_ser)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
+					  struct iommu_hw_ser *iommu_ser)
+{
+}
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
new file mode 100644
index 000000000000..ffdcebf2b773
--- /dev/null
+++ b/drivers/iommu/intel/liveupdate.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#define pr_fmt(fmt)    "DMAR: liveupdate: " fmt
+
+#include <linux/kexec_handover.h>
+#include <linux/liveupdate.h>
+#include <linux/iommu-liveupdate.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "iommu.h"
+#include "../iommu-pages.h"
+
+/* 2 tables per bus in scalable mode with upper table at odd bit */
+#define CONTEXT_TABLE_PRESERVED_BIT(bus, devfn) ((bus << 1) + (devfn >> 7))
+static bool is_context_table_preserved(struct intel_iommu *iommu,
+				       struct iommu_hw_ser *ser,
+				       u8 bus, u8 devfn)
+{
+	return test_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
+			(unsigned long *)&ser->intel.context_tables_bitmap[0]);
+}
+
+static void unpreserve_context_table(struct intel_iommu *iommu,
+				     struct iommu_hw_ser *ser,
+				     u8 bus, u8 devfn)
+{
+	struct context_entry *context;
+
+	/*
+	 * In the Intel IOMMU driver, context tables are never freed once they
+	 * are allocated during runtime, as they can be shared across multiple
+	 * devices. So taking the iommu lock here to protect against concurrent
+	 * allocations inside iommu_context_addr() should be enough. Once the
+	 * address is read, it is safe to use it without holding the lock.
+	 */
+	spin_lock(&iommu->lock);
+	context = iommu_context_addr(iommu, bus, devfn, 0);
+	spin_unlock(&iommu->lock);
+	if (context && is_context_table_preserved(iommu, ser, bus, devfn)) {
+		iommu_unpreserve_pages(context);
+		clear_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
+			  (unsigned long *)&ser->intel.context_tables_bitmap[0]);
+	}
+}
+
+static int preserve_context_table(struct intel_iommu *iommu,
+				  struct iommu_hw_ser *ser,
+				  u8 bus, u8 devfn)
+{
+	struct context_entry *context;
+	int ret;
+
+	spin_lock(&iommu->lock);
+	context = iommu_context_addr(iommu, bus, devfn, 0);
+	spin_unlock(&iommu->lock);
+
+	/*
+	 * Intel IOMMU context tables are never freed by the driver once
+	 * allocated. It is safe to access the context pointer outside of the
+	 * iommu->lock.
+	 */
+	if (context && !is_context_table_preserved(iommu, ser, bus, devfn)) {
+		ret = iommu_preserve_pages(context);
+		if (ret)
+			return ret;
+
+		set_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
+			(unsigned long *)&ser->intel.context_tables_bitmap[0]);
+	}
+
+	return 0;
+}
+
+static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
+					    struct iommu_hw_ser *ser)
+{
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		unpreserve_context_table(iommu, ser, i, 0);
+
+		if (!sm_supported(iommu))
+			continue;
+
+		unpreserve_context_table(iommu, ser, i, 0x80);
+	}
+}
+
+static int preserve_iommu_context_tables(struct device_domain_info *info)
+{
+	struct iommu_hw_ser *iommu_ser;
+	struct intel_iommu *iommu;
+	int ret;
+	int i;
+
+	/* IOMMU for this device should already preserved.*/
+	iommu = info->iommu;
+	iommu_ser = iommu_preserved_state(&iommu->iommu);
+	if (!iommu_ser)
+		return -EINVAL;
+
+	/*
+	 * We could do preservation of context tables only for the bus of this
+	 * device, but these devices can have PCI aliases, so context tables for
+	 * those will also require preservation. Also unpreserve would require
+	 * some kind of refcounting where the context table will only be
+	 * unpreserved when the last device associated with it is unpreserved.
+	 *
+	 * This introduces unnecessary complication with minimum benefits as the
+	 * unpreserved context tables will probably be recreated by the next
+	 * kernel as these are all active devices. We follow simpler approach by
+	 * just preserving the currently active context tables.
+	 */
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		ret = preserve_context_table(iommu, iommu_ser, i, 0);
+		if (ret)
+			return ret;
+
+		if (!sm_supported(iommu))
+			continue;
+
+		ret = preserve_context_table(iommu, iommu_ser, i, 0x80);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
+ * @dev: Target device
+ * @device_ser: Struct to populate with serialized device state
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int intel_iommu_preserve_device(struct device *dev,
+				struct iommu_device_ser *device_ser)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	int ret;
+
+	if (!dev_is_pci(dev)) {
+		dev_err(dev, "Cannot preserve non-PCI device\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	if (!info || !info->domain)
+		return -EINVAL;
+
+	ret = preserve_iommu_context_tables(info);
+	if (ret)
+		return ret;
+
+	device_ser->domain_iommu_ser.attachment_id = domain_id_iommu(info->domain,
+								     info->iommu);
+	return 0;
+}
+
+/**
+ * intel_iommu_unpreserve_device() - Intel IOMMU callback to unpreserve device state
+ * @dev: Target device
+ * @device_ser: Struct containing serialized device state
+ */
+void intel_iommu_unpreserve_device(struct device *dev,
+				   struct iommu_device_ser *device_ser)
+{
+}
+
+/**
+ * intel_iommu_preserve() - Intel IOMMU callback to preserve hardware state
+ * @iommu_dev: Generic IOMMU device handle
+ * @ser: Struct to populate with serialized hardware state
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int intel_iommu_preserve(struct iommu_device *iommu_dev,
+			 struct iommu_hw_ser *ser)
+{
+	struct intel_iommu *iommu;
+	int ret;
+
+	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
+
+	ret = iommu_preserve_pages(iommu->root_entry);
+	if (ret)
+		return ret;
+
+	ser->intel.phys_addr = iommu->reg_phys;
+	ser->intel.root_table = __pa(iommu->root_entry);
+	ser->type = IOMMU_INTEL;
+	ser->token = ser->intel.phys_addr;
+
+	return 0;
+}
+
+/**
+ * intel_iommu_unpreserve() - Intel IOMMU callback to unpreserve hardware state
+ * @iommu_dev: Generic IOMMU device handle
+ * @ser: Struct containing serialized hardware state
+ */
+void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
+			    struct iommu_hw_ser *ser)
+{
+	struct intel_iommu *iommu;
+
+	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
+
+	unpreserve_iommu_context_tables(iommu, ser);
+	iommu_unpreserve_pages(iommu->root_entry);
+}
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
index 7641a86684e2..430c42bf9561 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -81,6 +81,7 @@
  */
 enum iommu_type_ser {
 	IOMMU_INVALID,
+	IOMMU_INTEL,
 };
 
 #define IOMMU_SER_FLAG_DELETED	(1 << 0)
@@ -142,16 +143,40 @@ struct iommu_device_ser {
 	struct iommu_dev_map_ser domain_iommu_ser;
 } __packed;
 
+
+/* There are maximum 256 buses, so maximum 512 context tables */
+#define VTD_PRESERVED_BITMAP_LONGS  DIV_ROUND_UP(512, BITS_PER_LONG_LONG)
+
+/**
+ * struct iommu_intel_ser - Serialized state of an Intel IOMMU instance
+ * @restored: Whether IOMMU state is restored
+ * @phys_addr: Physical address of the IOMMU register base
+ * @root_table: Physical address of the root entry table
+ * @context_tables_bitmap: Bitmap representing the context tables that are
+ * preserved.
+ */
+struct iommu_intel_ser {
+	u8 restored;
+	u8 padding[7];
+	u64 phys_addr;
+	u64 root_table;
+	u64 context_tables_bitmap[VTD_PRESERVED_BITMAP_LONGS];
+};
+
 /**
  * struct iommu_hw_ser - Serialized state of an IOMMU instance
  * @hdr: Common object header
  * @token: Unique token for the IOMMU
  * @type: IOMMU type serialized state belongs to
+ * @intel: Intel specific serialization data
  */
 struct iommu_hw_ser {
 	struct iommu_hdr_ser hdr;
 	u64 token;
 	u64 type;
+	union {
+		struct iommu_intel_ser intel;
+	};
 } __packed;
 
 /**
-- 
2.55.0.679.g6767b8d81c-goog

