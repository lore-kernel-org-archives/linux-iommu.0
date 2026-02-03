Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9922364EA9
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156595; cv=none; b=hive/MRvCI3RP12Vij9kpGaUmtUGqgWxcwGWgtp1EP6YIZdnAROL1O1NAE/IXUL5OSToezt6mhGRWb3fym39uDXENcSUR3xAnvdyzdmrex4DLvMUXYyjYjeHiq44Eootv2Oe6xwePyHGw/QHl6LOnAoNZdzWanp6OcZl1+0MWoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156595; c=relaxed/simple;
	bh=foh5Qr5xp1j1ngJ9RXLNwUIMLFRxhtltxVjGHDfXeik=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IV+Q8r7QxWnL8jjtd8HulIahsbI/DNYjXa5drE+AN1kF6hSb+j0F7lF0xlogn4eT1AFCbtmHc+8dNVdKJTGJtkbiFz2gt9TUZ7CqzddG1+44ZGMsxV++ZE1/Z0L8TwTyQHBgLuAO8qEKCcl+ItcUHaHvAVvuU0ICEmEufpl+mHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QuxTA995; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QuxTA995"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c337cde7e40so3859044a12.1
        for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 14:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770156592; x=1770761392; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eZO2KOvcnbxY94D0A6rezfq3j04mJBbysFnKRo/qQM=;
        b=QuxTA995KVk1OONbibdfgYWMWRXStnIfwcUtRopgnFRzS8qb6FDqe/z53n+0g+XIqP
         nVoKSLhL/wbpfEmgDYiaYqvT5NUfkaUGkSw1HS8jc0TkFJU95SSBpYsKQ8/WCWLyR/Fs
         ivIE0+YL+uOEwjcAw8RrmChapTVNLkD9kNLTFkXhAGu7G1qAvjkjtafpo1tTXc4kLG9d
         1Ux2+2vpFgT9Kq0NY9gvlbbDXJE48HDYVdP0V39JKzKbm6eOZ7XAACsZV6zvKvMvacSF
         3GWiSVuOgqYzVZV0ZMZqH7WsH6NRFDJAFd61gAYwdrYIANBA2Ob/Br4+jvYynRxiXVzU
         Seiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770156592; x=1770761392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eZO2KOvcnbxY94D0A6rezfq3j04mJBbysFnKRo/qQM=;
        b=fcoSg0PWYpdCEPHQ4BHrvyM5Tgl+evu5meNGtGmTb5SzaGirIH+0As34PEEN3rRwEL
         HLo9yGTwJTRBaOejmsbyqF5JYZJdaUQXJxVXv4nQTsttUVZDC9l5t7n/e5HZR0vSGkO8
         HFNWfG4OJz65ZmBn9uoM/FKUQfZ/pR4qS3H2avdhc8h63m1SPFcA8KYzMP1kJ4KiD5u+
         vCSkqNUdXpLgZhWGcyQpuDSHPqQajAi386Y2TosL0+lQ+qQwgm1BlBMx5XocctRnRtPX
         HZseY2h//cNXtX3BRcJKcFdMo9253UF8LWOI5MUZyi3Gr0z33wawaN5Q/BL1UbKJY1BW
         IsKg==
X-Forwarded-Encrypted: i=1; AJvYcCX5zjX6uVDFPZAJdPcEK2wMjuozMk1KWPfTq4GJuoVAoBx3tyQpEj6RB+lIQ6hHwjTbvAM7wQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxS8oGsv/7cp7OBoVh8xiLz3TyhlysQYXvWfnuDLQhUf+zbNIdG
	1EV5G5elEDjTAkZvSlwH365o3GUdx7PxerrM4/VB5Bh/VJbTr0ohNElpib89hjrPByiT6+lU7Dv
	AoeSIZIihbWUUNg==
X-Received: from pfbdw20.prod.google.com ([2002:a05:6a00:3694:b0:822:4e8c:2c9e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d97:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-8241c1e0874mr788987b3a.23.1770156592036;
 Tue, 03 Feb 2026 14:09:52 -0800 (PST)
Date: Tue,  3 Feb 2026 22:09:35 +0000
In-Reply-To: <20260203220948.2176157-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260203220948.2176157-1-skhawaja@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203220948.2176157-2-skhawaja@google.com>
Subject: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
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

Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
alloc/free helper functions to allocate memory for the IOMMU LU FLB
object and the serialization structs for device, domain and iommu.

During retrieve, walk through the preserved objs nodes and restore each
folio. Also recreate the FLB obj.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/Kconfig         |  11 +++
 drivers/iommu/Makefile        |   1 +
 drivers/iommu/liveupdate.c    | 177 ++++++++++++++++++++++++++++++++++
 include/linux/iommu-lu.h      |  17 ++++
 include/linux/kho/abi/iommu.h | 119 +++++++++++++++++++++++
 5 files changed, 325 insertions(+)
 create mode 100644 drivers/iommu/liveupdate.c
 create mode 100644 include/linux/iommu-lu.h
 create mode 100644 include/linux/kho/abi/iommu.h

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f86262b11416..fdcfbedee5ed 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -11,6 +11,17 @@ config IOMMUFD_DRIVER
 	bool
 	default n
 
+config IOMMU_LIVEUPDATE
+	bool "IOMMU live update state preservation support"
+	depends on LIVEUPDATE && IOMMUFD
+	help
+	  Enable support for preserving IOMMU state across a kexec live update.
+
+	  This allows devices managed by iommufd to maintain their DMA mappings
+	  during kexec base kernel update.
+
+	  If unsure, say N.
+
 menuconfig IOMMU_SUPPORT
 	bool "IOMMU Hardware Support"
 	depends on MMU
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 0275821f4ef9..b3715c5a6b97 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
+obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
new file mode 100644
index 000000000000..6189ba32ff2c
--- /dev/null
+++ b/drivers/iommu/liveupdate.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2025, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#define pr_fmt(fmt)    "iommu: liveupdate: " fmt
+
+#include <linux/kexec_handover.h>
+#include <linux/liveupdate.h>
+#include <linux/iommu-lu.h>
+#include <linux/iommu.h>
+#include <linux/errno.h>
+
+static void iommu_liveupdate_restore_objs(u64 next)
+{
+	struct iommu_objs_ser *objs;
+
+	while (next) {
+		BUG_ON(!kho_restore_folio(next));
+		objs = __va(next);
+		next = objs->next_objs;
+	}
+}
+
+static void iommu_liveupdate_free_objs(u64 next, bool incoming)
+{
+	struct iommu_objs_ser *objs;
+
+	while (next) {
+		objs = __va(next);
+		next = objs->next_objs;
+
+		if (!incoming)
+			kho_unpreserve_free(objs);
+		else
+			folio_put(virt_to_folio(objs));
+	}
+}
+
+static void iommu_liveupdate_flb_free(struct iommu_lu_flb_obj *obj)
+{
+	if (obj->iommu_domains)
+		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, false);
+
+	if (obj->devices)
+		iommu_liveupdate_free_objs(obj->ser->devices_phys, false);
+
+	if (obj->iommus)
+		iommu_liveupdate_free_objs(obj->ser->iommus_phys, false);
+
+	kho_unpreserve_free(obj->ser);
+	kfree(obj);
+}
+
+static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
+{
+	struct iommu_lu_flb_obj *obj;
+	struct iommu_lu_flb_ser *ser;
+	void *mem;
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	mutex_init(&obj->lock);
+	mem = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(mem))
+		goto err_free;
+
+	ser = mem;
+	obj->ser = ser;
+
+	mem = kho_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(mem))
+		goto err_free;
+
+	obj->iommu_domains = mem;
+	ser->iommu_domains_phys = virt_to_phys(obj->iommu_domains);
+
+	mem = kho_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(mem))
+		goto err_free;
+
+	obj->devices = mem;
+	ser->devices_phys = virt_to_phys(obj->devices);
+
+	mem = kho_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(mem))
+		goto err_free;
+
+	obj->iommus = mem;
+	ser->iommus_phys = virt_to_phys(obj->iommus);
+
+	argp->obj = obj;
+	argp->data = virt_to_phys(ser);
+	return 0;
+
+err_free:
+	iommu_liveupdate_flb_free(obj);
+	return PTR_ERR(mem);
+}
+
+static void iommu_liveupdate_flb_unpreserve(struct liveupdate_flb_op_args *argp)
+{
+	iommu_liveupdate_flb_free(argp->obj);
+}
+
+static void iommu_liveupdate_flb_finish(struct liveupdate_flb_op_args *argp)
+{
+	struct iommu_lu_flb_obj *obj = argp->obj;
+
+	if (obj->iommu_domains)
+		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, true);
+
+	if (obj->devices)
+		iommu_liveupdate_free_objs(obj->ser->devices_phys, true);
+
+	if (obj->iommus)
+		iommu_liveupdate_free_objs(obj->ser->iommus_phys, true);
+
+	folio_put(virt_to_folio(obj->ser));
+	kfree(obj);
+}
+
+static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
+{
+	struct iommu_lu_flb_obj *obj;
+	struct iommu_lu_flb_ser *ser;
+
+	obj = kzalloc(sizeof(*obj), GFP_ATOMIC);
+	if (!obj)
+		return -ENOMEM;
+
+	mutex_init(&obj->lock);
+	BUG_ON(!kho_restore_folio(argp->data));
+	ser = phys_to_virt(argp->data);
+	obj->ser = ser;
+
+	iommu_liveupdate_restore_objs(ser->iommu_domains_phys);
+	obj->iommu_domains = phys_to_virt(ser->iommu_domains_phys);
+
+	iommu_liveupdate_restore_objs(ser->devices_phys);
+	obj->devices = phys_to_virt(ser->devices_phys);
+
+	iommu_liveupdate_restore_objs(ser->iommus_phys);
+	obj->iommus = phys_to_virt(ser->iommus_phys);
+
+	argp->obj = obj;
+
+	return 0;
+}
+
+static struct liveupdate_flb_ops iommu_flb_ops = {
+	.preserve = iommu_liveupdate_flb_preserve,
+	.unpreserve = iommu_liveupdate_flb_unpreserve,
+	.finish = iommu_liveupdate_flb_finish,
+	.retrieve = iommu_liveupdate_flb_retrieve,
+};
+
+static struct liveupdate_flb iommu_flb = {
+	.compatible = IOMMU_LUO_FLB_COMPATIBLE,
+	.ops = &iommu_flb_ops,
+};
+
+int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
+{
+	return liveupdate_register_flb(handler, &iommu_flb);
+}
+EXPORT_SYMBOL(iommu_liveupdate_register_flb);
+
+int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
+{
+	return liveupdate_unregister_flb(handler, &iommu_flb);
+}
+EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
new file mode 100644
index 000000000000..59095d2f1bb2
--- /dev/null
+++ b/include/linux/iommu-lu.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2025, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#ifndef _LINUX_IOMMU_LU_H
+#define _LINUX_IOMMU_LU_H
+
+#include <linux/liveupdate.h>
+#include <linux/kho/abi/iommu.h>
+
+int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
+int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
+
+#endif /* _LINUX_IOMMU_LU_H */
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
new file mode 100644
index 000000000000..8e1c05cfe7bb
--- /dev/null
+++ b/include/linux/kho/abi/iommu.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2025, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#ifndef _LINUX_KHO_ABI_IOMMU_H
+#define _LINUX_KHO_ABI_IOMMU_H
+
+#include <linux/mutex_types.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/**
+ * DOC: IOMMU File-Lifecycle Bound (FLB) Live Update ABI
+ *
+ * This header defines the ABI for preserving IOMMU state across kexec using
+ * Live Update File-Lifecycle Bound (FLB) data.
+ *
+ * This interface is a contract. Any modification to any of the serialization
+ * structs defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the IOMMU_LUO_FLB_COMPATIBLE string.
+ */
+
+#define IOMMU_LUO_FLB_COMPATIBLE "iommu-v1"
+
+enum iommu_lu_type {
+	IOMMU_INVALID,
+	IOMMU_INTEL,
+};
+
+struct iommu_obj_ser {
+	u32 idx;
+	u32 ref_count;
+	u32 deleted:1;
+	u32 incoming:1;
+} __packed;
+
+struct iommu_domain_ser {
+	struct iommu_obj_ser obj;
+	u64 top_table;
+	u64 top_level;
+	struct iommu_domain *restored_domain;
+} __packed;
+
+struct device_domain_iommu_ser {
+	u32 did;
+	u64 domain_phys;
+	u64 iommu_phys;
+} __packed;
+
+struct device_ser {
+	struct iommu_obj_ser obj;
+	u64 token;
+	u32 devid;
+	u32 pci_domain;
+	struct device_domain_iommu_ser domain_iommu_ser;
+	enum iommu_lu_type type;
+} __packed;
+
+struct iommu_intel_ser {
+	u64 phys_addr;
+	u64 root_table;
+} __packed;
+
+struct iommu_ser {
+	struct iommu_obj_ser obj;
+	u64 token;
+	enum iommu_lu_type type;
+	union {
+		struct iommu_intel_ser intel;
+	};
+} __packed;
+
+struct iommu_objs_ser {
+	u64 next_objs;
+	u64 nr_objs;
+} __packed;
+
+struct iommus_ser {
+	struct iommu_objs_ser objs;
+	struct iommu_ser iommus[];
+} __packed;
+
+struct iommu_domains_ser {
+	struct iommu_objs_ser objs;
+	struct iommu_domain_ser iommu_domains[];
+} __packed;
+
+struct devices_ser {
+	struct iommu_objs_ser objs;
+	struct device_ser devices[];
+} __packed;
+
+#define MAX_IOMMU_SERS ((PAGE_SIZE - sizeof(struct iommus_ser)) / sizeof(struct iommu_ser))
+#define MAX_IOMMU_DOMAIN_SERS \
+		((PAGE_SIZE - sizeof(struct iommu_domains_ser)) / sizeof(struct iommu_domain_ser))
+#define MAX_DEVICE_SERS ((PAGE_SIZE - sizeof(struct devices_ser)) / sizeof(struct device_ser))
+
+struct iommu_lu_flb_ser {
+	u64 iommus_phys;
+	u64 nr_iommus;
+	u64 iommu_domains_phys;
+	u64 nr_domains;
+	u64 devices_phys;
+	u64 nr_devices;
+} __packed;
+
+struct iommu_lu_flb_obj {
+	struct mutex lock;
+	struct iommu_lu_flb_ser *ser;
+
+	struct iommu_domains_ser *iommu_domains;
+	struct iommus_ser *iommus;
+	struct devices_ser *devices;
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_IOMMU_H */
-- 
2.53.0.rc2.204.g2597b5adb4-goog

