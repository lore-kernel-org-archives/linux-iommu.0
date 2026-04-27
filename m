Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C443E7174
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312602; cv=none; b=UeQB/UQh0NlBawDwj5ek6E7MKX9l30qM9VbF9ojLU9t7VybkpCz3JHMuCwqGP89YGKbqOlsSBbRjXlmR2ofuicZrCvy+qDoLsQz9mMH96gLcYS0krxvCLHPL3bsSE+2AQ1y/CVJJLIZr5zdEgSURl9mgNWe6S3aTiju9hSmXXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312602; c=relaxed/simple;
	bh=ctrvtrGAyi9MTpfTNsXw9ZCn6qKiriUd1jnrJ1XnICg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hj2gMWMdZWNFU4IFIe74tzufOX9X7PIquSmbxibP8smM2P2bLJu9elHUROWi6n5Vx3OvHbzTKpFVIHSJDmdfKZ7M3ygNR3aA8/EUu9hJDC0hb7UMKlYBMIvr8NnFSiTVJ/Dr+MHzuzcbRn+1o/38NN2FJnXuH5dE8eVTUv9hrZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u6kl0vCg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6kl0vCg"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6b0a7164so13876117b3a.0
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312599; x=1777917399; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lc2hfm8nWMzFx1sp/CFolENtCaLymE++tl/Ugr0O7SQ=;
        b=u6kl0vCgcfPDAstekcP6p9xAvEzahNmiH1JdE71b+O9bAZNH02y51uE1zT0mA+G6eb
         HlZwxjM73vmKMMhG1UqtlXcP8KzWcGgJ8UIravfe+jixsjfSDp0FsFLuMKbOfcobAyTZ
         cqflq09ltHjY4ssQ9vNkr0IUIlXrSY0KwqOwzrtnDQSVgnhX61dLLB6CKpQDwR6J7tLB
         xSCPX8CfSayzsOQtQuXURitMm353CYgKkrgxSfH9hGwEhUiwUnlxbLOKU8QWhU91qe+Z
         HuLb0mVUKs/Rwis84DUTD6o/am4HhCJcnMSHpuRcCo019ztXQX/ZfYxXCQjpf06C1DlT
         5cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312599; x=1777917399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lc2hfm8nWMzFx1sp/CFolENtCaLymE++tl/Ugr0O7SQ=;
        b=QbmmNjyXAOolMDQUmbvWWoZF/rLItpoE0F2TZMz8RuQZJLyMlvcgYPLK7HFGFUq+qV
         qit2wY19O/htFbOlexwaGapzH1jBcJod84djXNGZQYjGSt81fOAeKYmPfb3Y2T/GmWI5
         5KX0ddXr+gjCCwg8h0KjUGMnTb6mz9PGj1wPcVWQVgwL3oN069UJqfr1/tLHXlo+byEv
         jIBwvGxLxV6hwLDbr2YPiwqGf7uFQizZmm1jvH575WVtTziuFRhZpQgktTDHt2KWaVCH
         fTbMJlZvrnDeeIllx+JnW1zFGso4isjf5dBQhZRoh/Opjyhtbgr+Vp7AVB36rYKaNs4M
         1WkA==
X-Forwarded-Encrypted: i=1; AFNElJ94KISTipxPSaVvqe6BbzHtm+EjLuWXI4oY8prDMO6Dgkhxv3ufwfZxJRdHlllo846kfkqK2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeTAPsSiDNokE6Exe8LSRvubiVVsQcCCItJ2QqwoKZLl0nzpHU
	SADvWYiHH1gmR+C5phCPNao5Q+IT37yGHa8rM0oLQlAgQNH+gq15MGoQ07Xs8OhiczMgWW6Oion
	Ay7UEv6ebvBIAdQ==
X-Received: from pfbic19.prod.google.com ([2002:a05:6a00:8a13:b0:82f:20ed:8059])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1d83:b0:82f:50cd:e586 with SMTP id d2e1a72fcca58-834dc1b31b8mr30963b3a.13.1777312598418;
 Mon, 27 Apr 2026 10:56:38 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:19 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-3-skhawaja@google.com>
Subject: [PATCH v2 02/16] iommu: Implement IOMMU Live update FLB callbacks
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
alloc/free helper functions to allocate memory for the IOMMU Live update
FLB object and the serialization structs for device, domain and iommu.

During retrieve, walk through the preserved obj array headers and
restore each folio. Also recreate the FLB obj.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                      |   9 ++
 drivers/iommu/Kconfig            |  12 ++
 drivers/iommu/Makefile           |   1 +
 drivers/iommu/liveupdate.c       | 198 ++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  18 +++
 include/linux/kho/abi/iommu.h    | 218 +++++++++++++++++++++++++++++++
 6 files changed, 456 insertions(+)
 create mode 100644 drivers/iommu/liveupdate.c
 create mode 100644 include/linux/iommu-liveupdate.h
 create mode 100644 include/linux/kho/abi/iommu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 737c5ed1ce38..980041955abc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13490,6 +13490,15 @@ F:	include/linux/iova.h
 F:	include/linux/of_iommu.h
 F:	rust/kernel/iommu/
 
+IOMMU LIVEUPDATE
+M:	Samiullah Khawaja <skhawaja@google.com>
+R:	Pranjal Shrivastava <praan@google.com>
+L:	iommu@lists.linux.dev
+S:	Maintained
+F:	drivers/iommu/liveupdate.c
+F:	include/linux/iommu-liveupdate.h
+F:	include/linux/kho/abi/iommu.h
+
 IOMMUFD
 M:	Jason Gunthorpe <jgg@nvidia.com>
 M:	Kevin Tian <kevin.tian@intel.com>
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f86262b11416..a2f416df3214 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -403,6 +403,18 @@ config IOMMU_DEBUG_PAGEALLOC
 	  line to activate the runtime checks.
 
 	  If unsure, say N.
+
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
 endif # IOMMU_SUPPORT
 
 source "drivers/iommu/generic_pt/Kconfig"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 0275821f4ef9..c333f4a3ada3 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
+obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
new file mode 100644
index 000000000000..a26099b145c3
--- /dev/null
+++ b/drivers/iommu/liveupdate.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#define pr_fmt(fmt)    "iommu: liveupdate: " fmt
+
+#include <linux/kexec_handover.h>
+#include <linux/liveupdate.h>
+#include <linux/iommu-liveupdate.h>
+#include <linux/iommu.h>
+#include <linux/errno.h>
+
+static void *iommu_liveupdate_restore_array(u64 array_phys)
+{
+	struct iommu_array_hdr_ser *array_hdr;
+	void *vaddr = array_phys ? phys_to_virt(array_phys) : NULL;
+
+	while (array_phys) {
+		/*
+		 * Failure to restore preserved IOMMU state is considered fatal.
+		 *
+		 * This is because the IOMMU translations for preserved IOMMUs
+		 * were kept enabled in the previous kernel and the preserved
+		 * devices have their IOMMU domains still present. Not being
+		 * able to restore means that the memory mapped into preserved
+		 * domains might be already corrupted by the preserved devices.
+		 *
+		 * There is no way to confirm the integrity of the memory that
+		 * was mapped. BUG_ON is the safest option at this point.
+		 */
+		BUG_ON(!kho_restore_folio(array_phys));
+		array_hdr = phys_to_virt(array_phys);
+		array_phys = array_hdr->next_array_phys;
+	}
+
+	return vaddr;
+}
+
+static void iommu_liveupdate_unpreserve_free(u64 array_phys)
+{
+	struct iommu_array_hdr_ser *array_hdr;
+
+	while (array_phys) {
+		array_hdr = phys_to_virt(array_phys);
+		array_phys = array_hdr->next_array_phys;
+		kho_unpreserve_free(array_hdr);
+	}
+}
+
+static void iommu_liveupdate_folio_put(u64 array_phys)
+{
+	struct iommu_array_hdr_ser *array_hdr;
+
+	while (array_phys) {
+		array_hdr = phys_to_virt(array_phys);
+		array_phys = array_hdr->next_array_phys;
+		folio_put(virt_to_folio(array_hdr));
+	}
+}
+
+static void iommu_liveupdate_flb_free(struct iommu_flb_obj *obj)
+{
+	if (obj->ser->iommu_domain_array_phys)
+		iommu_liveupdate_unpreserve_free(obj->ser->iommu_domain_array_phys);
+
+	if (obj->ser->device_array_phys)
+		iommu_liveupdate_unpreserve_free(obj->ser->device_array_phys);
+
+	if (obj->ser->iommu_array_phys)
+		iommu_liveupdate_unpreserve_free(obj->ser->iommu_array_phys);
+
+	kho_unpreserve_free(obj->ser);
+	kfree(obj);
+}
+
+static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
+{
+	struct iommu_flb_obj *obj;
+	struct iommu_flb_ser *ser;
+	void *mem;
+
+	/* obj exists only in the current kernel to track preserved state */
+	obj = kzalloc_obj(*obj, GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	mutex_init(&obj->lock);
+
+	/* mem is allocated via KHO and will survive the kexec */
+	mem = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(mem))
+		goto err_free_obj;
+
+	ser = mem;
+	obj->ser = ser;
+
+	mem = kho_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(mem))
+		goto err_free_ser;
+
+	obj->curr_domain_array = mem;
+	ser->iommu_domain_array_phys = virt_to_phys(obj->curr_domain_array);
+
+	mem = kho_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(mem))
+		goto err_free_domains;
+
+	obj->curr_device_array = mem;
+	ser->device_array_phys = virt_to_phys(obj->curr_device_array);
+
+	mem = kho_alloc_preserve(PAGE_SIZE);
+	if (IS_ERR(mem))
+		goto err_free_devices;
+
+	obj->curr_iommu_array = mem;
+	ser->iommu_array_phys = virt_to_phys(obj->curr_iommu_array);
+
+	argp->obj = obj;
+	argp->data = virt_to_phys(ser);
+	return 0;
+
+err_free_devices:
+	kho_unpreserve_free(obj->curr_device_array);
+err_free_domains:
+	kho_unpreserve_free(obj->curr_domain_array);
+err_free_ser:
+	kho_unpreserve_free(obj->ser);
+err_free_obj:
+	kfree(obj);
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
+	struct iommu_flb_obj *obj = argp->obj;
+
+	iommu_liveupdate_folio_put(obj->ser->iommu_domain_array_phys);
+	iommu_liveupdate_folio_put(obj->ser->device_array_phys);
+	iommu_liveupdate_folio_put(obj->ser->iommu_array_phys);
+
+	folio_put(virt_to_folio(obj->ser));
+	kfree(obj);
+}
+
+static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
+{
+	struct iommu_flb_obj *obj;
+	struct iommu_flb_ser *ser;
+
+	obj = kzalloc_obj(*obj, GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	/* Data must be present and valid from the previous kernel */
+	BUG_ON(!kho_restore_folio(argp->data));
+
+	mutex_init(&obj->lock);
+	ser = phys_to_virt(argp->data);
+	obj->ser = ser;
+
+	obj->curr_domain_array = iommu_liveupdate_restore_array(ser->iommu_domain_array_phys);
+	obj->curr_device_array = iommu_liveupdate_restore_array(ser->device_array_phys);
+	obj->curr_iommu_array = iommu_liveupdate_restore_array(ser->iommu_array_phys);
+	argp->obj = obj;
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
+void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
+{
+	liveupdate_unregister_flb(handler, &iommu_flb);
+}
+EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
new file mode 100644
index 000000000000..3d1c65ed76fa
--- /dev/null
+++ b/include/linux/iommu-liveupdate.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#ifndef _LINUX_IOMMU_LIVEUPDATE_H
+#define _LINUX_IOMMU_LIVEUPDATE_H
+
+#include <linux/iommu.h>
+#include <linux/liveupdate.h>
+#include <linux/kho/abi/iommu.h>
+
+int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
+void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
+
+#endif /* _LINUX_IOMMU_LIVEUPDATE_H */
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
new file mode 100644
index 000000000000..37b967820f14
--- /dev/null
+++ b/include/linux/kho/abi/iommu.h
@@ -0,0 +1,218 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2026, Google LLC
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
+ *
+ * Memory Layout of Serialization Structures:
+ * ==========================================
+ *
+ * Each serialized type (IOMMU, Domain, Device) is stored in a linked list of
+ * arrays. The first array is allocated initially. When an array is full, a new
+ * array is allocated and its physical address is stored in the next_array_phys
+ * field of the hdr of the current array.
+ *
+ * Top Level (struct iommu_flb_ser):
+ * +---------------------------+
+ * | - iommu_array_phys        |
+ * | - iommu_domain_array_phys |
+ * | - device_array_phys       |
+ * +---------------------------+
+ *
+ * Each Array contains the serialized objects of the respective type. For
+ * example see below the representation of struct iommu_domain_array_ser.
+ *
+ * +---------------------------+   +---------------------------+
+ * | iommu_domain_array_ser    |-->| iommu_domain_array_ser    |--> NULL
+ * | - hdr.next_array_phys     |   | - hdr.next_array_phys     |
+ * | - hdr.nr_objects          |   | - hdr.nr_objects          |
+ * |                           |   |                           |
+ * | objects[]:                |   | objects[]:                |
+ * | [ iommu_domain_ser ]      |   | [ iommu_domain_ser ]      |
+ * | [ iommu_domain_ser ]      |   | [ iommu_domain_ser ]      |
+ * | ...                       |   | ...                       |
+ * +---------------------------+   +---------------------------+
+ *
+ * Each object in the array starts with a common header (iommu_hdr_ser).
+ * For example, the layout of struct iommu_domain_ser is:
+ *
+ *   +-----------------------------+
+ *   | iommu_domain_ser            |
+ *   | +-------------------------+ |
+ *   | | hdr (iommu_hdr_ser)     | |
+ *   | | - ref_count             | |
+ *   | | - deleted / incoming    | |
+ *   | +-------------------------+ |
+ *   | - top_table_phys          | |
+ *   | - top_level               | |
+ *   | - restored_domain         | |
+ *   +-----------------------------+
+ *
+ * This pattern applies identically to iommu_device_ser and iommu_hw_ser.
+ */
+
+#define IOMMU_LUO_FLB_COMPATIBLE "iommu-liveupdate-v1"
+
+enum iommu_type_ser {
+	IOMMU_INVALID,
+};
+
+/**
+ * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
+ * @ref_count: Reference count for the object
+ * @deleted: Flag indicating if the object is deleted
+ * @incoming: Flag indicating if the object was preserved in previous kernel
+ */
+struct iommu_hdr_ser {
+	u32 ref_count;
+	u32 deleted:1;
+	u32 incoming:1;
+} __packed;
+
+/**
+ * struct iommu_domain_ser - Serialized state of an IOMMU domain
+ * @hdr: Common object header
+ * @top_table_phys: Physical address of the top-level page table
+ * @top_level: Level of the top-level page table
+ * @vasz: Virtual Address Size
+ * @sign_extend: FEAT_SIGN_EXTEND is enabled for this domain
+ * @restored_domain: Pointer to the restored domain (valid only after restore)
+ */
+struct iommu_domain_ser {
+	struct iommu_hdr_ser hdr;
+	u64 top_table_phys;
+	u64 top_level;
+	u32 vasz;
+	u32 sign_extend:1;
+	struct iommu_domain *restored_domain;
+} __packed;
+
+/**
+ * struct iommu_dev_map_ser - Serialized mapping between device, domain,
+ *				    and IOMMU instance.
+ * @attachment_id: ID of the attachment between device and domain.
+ * @domain_phys: Physical address of the domain
+ * @iommu_phys: Physical address of the IOMMU
+ */
+struct iommu_dev_map_ser {
+	u64 attachment_id;
+	u64 domain_phys;
+	u64 iommu_phys;
+} __packed;
+
+/**
+ * struct iommu_device_ser - Serialized state of a device
+ * @hdr: Common object header
+ * @devid: Device ID
+ * @pci_domain_nr: PCI domain number
+ * @domain_iommu_ser: Domain and IOMMU mapping
+ */
+struct iommu_device_ser {
+	struct iommu_hdr_ser hdr;
+	u32 devid;
+	u32 pci_domain_nr;
+	struct iommu_dev_map_ser domain_iommu_ser;
+} __packed;
+
+/**
+ * struct iommu_hw_ser - Serialized state of an IOMMU instance
+ * @hdr: Common object header
+ * @token: Unique token for the IOMMU
+ * @type: IOMMU type serialized state belongs to
+ */
+struct iommu_hw_ser {
+	struct iommu_hdr_ser hdr;
+	u64 token;
+	u64 type;
+} __packed;
+
+/**
+ * struct iommu_array_hdr_ser - Header for an array of serialized objects
+ * @next_array_phys: Physical address of the next array of objects
+ * @nr_objects: Number of objects in the current array
+ */
+struct iommu_array_hdr_ser {
+	u64 next_array_phys;
+	u64 nr_objects;
+} __packed;
+
+/**
+ * struct iommu_hw_array_ser - An array containing serialized IOMMU HWs
+ * @hdr: Array header
+ * @objects: Array of serialized IOMMU devices
+ */
+struct iommu_hw_array_ser {
+	struct iommu_array_hdr_ser hdr;
+	struct iommu_hw_ser objects[];
+} __packed;
+
+/**
+ * struct iommu_domain_array_ser - An array containing serialized domains
+ * @hdr: Array header
+ * @objects: Array of serialized domains
+ */
+struct iommu_domain_array_ser {
+	struct iommu_array_hdr_ser hdr;
+	struct iommu_domain_ser objects[];
+} __packed;
+
+/**
+ * struct iommu_device_array_ser - An array containing serialized devices
+ * @hdr: Array header
+ * @objects: Array of serialized devices
+ */
+struct iommu_device_array_ser {
+	struct iommu_array_hdr_ser hdr;
+	struct iommu_device_ser objects[];
+} __packed;
+
+/**
+ * struct iommu_flb_ser - Top-level serialization structure
+ * @iommu_array_phys: Physical address of the first array of IOMMU HWs
+ * @iommu_domain_array_phys: Physical address of the first array of domains
+ * @device_array_phys: Physical address of the first array of devices
+ */
+struct iommu_flb_ser {
+	u64 iommu_array_phys;
+	u64 iommu_domain_array_phys;
+	u64 device_array_phys;
+} __packed;
+
+/**
+ * struct iommu_flb_obj - FLB object allocated in current kernel pointing to
+ *			  preserved state in FLB
+ * @lock: Mutex protecting the object
+ * @ser: Pointer to the serialized state in FLB
+ * @curr_iommu_array: Pointer to the current array of IOMMU instances
+ * @curr_domain_array: Pointer to the current array of domains
+ * @curr_device_array: Pointer to the current array of devices
+ */
+struct iommu_flb_obj {
+	/* @lock: Protects the serialized objects during concurrent preservation */
+	struct mutex lock;
+	struct iommu_flb_ser *ser;
+
+	struct iommu_hw_array_ser *curr_iommu_array;
+	struct iommu_domain_array_ser *curr_domain_array;
+	struct iommu_device_array_ser *curr_device_array;
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_IOMMU_H */
-- 
2.54.0.545.g6539524ca2-goog

