Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68052C027B
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 00:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951726; cv=none; b=RPok6An5qr77WqwvVF4cgtndAmKPmgo8psSJtpccEImU7yh4LQsD0PMRu2iLUkdSddqB+7e1Zn9aaMlsyaGNBNoq3JMeNJYEcHluFKS7N1n++HWzeDt22qaAS0ilLhcXiMuD4THKhGDiBOhDt9I1J9sRX0c7WEtSKADTMN8HGao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951726; c=relaxed/simple;
	bh=JrBVxQgkB/CBntA4xh0rGxbH3KEFoXKIAsymS8b+Xqw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ny+cp6xj1W1XxUJgjyF/m3jn0jtxHQYWjfwqt4WjQtiOwztcS7MMkwsTOPwFiNsrIMtCA1O6JHHAoNLDrradCfw7EHWgLPw7s4JuNgL4319hjgfKRkWAQiEUyIXl3o06naZznhvdGOsz7NAvzdEoZ6r65sgKDUqcpf3zhfFSPNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBOjy24C; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBOjy24C"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2db8e9fe9c7so35495735ad.0
        for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 17:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951722; x=1790556522; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p3MOa0K8GJJXFbzSXjxcRG0git6pUSRUszMCcW9ffPE=;
        b=NBOjy24CGqVNWK57MTIep4JtB/S1nn+mNolj/huW3w265wbixZ568BgFfFF2INij4r
         O09Z5jzwufd6WDXG0EZwPU9HpkHSNHKjqxrwQHzOo0gQlIArUY39QZ6KJL5dnPPejkjI
         oHtSiLW73zHLnYMmSCp5Tohjx26UKZH35vGZ00DesZHe7qzqaBDDQRkB51dKWCzjAKfv
         bdyCUW7BAnl3iwS8qbc2Vo/FMc0rfsQ1UPqId1o42V0OnbnVSQfgVyARh2+OYpnEtx6s
         zZpnRCtjocxbU5gm5gMBDAweA7YLZV8L8S91nzJxLhL5nY/t9B1ZRM6JE6Ze7MdnjRlg
         kHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951722; x=1790556522;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p3MOa0K8GJJXFbzSXjxcRG0git6pUSRUszMCcW9ffPE=;
        b=jPdYTSF0DEFCA2HzQVYg3ZH9Nz9do2DrDVAMRaamSudrmD+a0je3IqkC86ayX7nD2h
         8LNABHL4yCowXlHQsai4q+P4nMVY/Qwz2W/NTn1U9iFEXUgHoqKC1COBt6h6UXMnl8xi
         rDD2GMx5mDCCm9zHlZChwv7NSHFI5Wal3LHkK/OZouLoJvKvAubirLVW4sp/W5MpoiZH
         WyZ8TZiiyoDNq0OrJbDg7+D/mpgFahmT2/nRRQc8tyX2ydb1ZqnLG79l4HKoJUcjXg9a
         tA3uvwoaeSALCrXqYHm3CaiVVjOidezSt6zBn95g1U+7caPoMVOrrYkpPwMrKlDdS1CB
         oXQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlbw9Ji+TrpyN03WTO/V9ib1FbmoZNKCra/zzH1inv/IJTNNHwvI4F3k4DnQTaGX3ZKpOJEA==@lists.linux.dev
X-Gm-Message-State: AFuF++m7E6/Rx06DJ/CFj4uEJncwJ1zQaE9raKZPyJjnn/KjvPoS79uZ
	6WAHCb09Q1YqMhTUVNpBW475H4iUJDIFK2WE2fxiE20Tn0oacPK46ZqlIz0ENdJKoWCiG1YRz9i
	Gy1gt9m7D9gj48Q==
X-Received: from plcr5.prod.google.com ([2002:a17:903:145:b0:2df:4e6f:dbe5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ffce:b0:2dd:ad74:ac7d with SMTP id d9443c01a7336-2ddb1ba3a91mr151523875ad.24.1789951721813;
 Sun, 20 Sep 2026 17:48:41 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:18 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-3-skhawaja@google.com>
Subject: [PATCH v5 02/18] iommu: Implement IOMMU Live update FLB callbacks
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
 drivers/iommu/liveupdate.c       | 253 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  28 ++++
 include/linux/kho/abi/iommu.h    | 212 ++++++++++++++++++++++++++
 6 files changed, 515 insertions(+)
 create mode 100644 drivers/iommu/liveupdate.c
 create mode 100644 include/linux/iommu-liveupdate.h
 create mode 100644 include/linux/kho/abi/iommu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b62a0b8a48c..2114b50412ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13715,6 +13715,15 @@ F:	include/linux/iova.h
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
index 6e07bd69467a..56a96d22cc8b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -405,6 +405,18 @@ config IOMMU_DEBUG_PAGEALLOC
 	  line to activate the runtime checks.
 
 	  If unsure, say N.
+
+config IOMMU_LIVEUPDATE
+	bool "IOMMU live update state preservation support"
+	depends on LIVEUPDATE && IOMMUFD && 64BIT
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
index 2f05725eaab1..a775fb526e91 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
+obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
new file mode 100644
index 000000000000..b644f4792532
--- /dev/null
+++ b/drivers/iommu/liveupdate.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+/**
+ * DOC: IOMMU Live Update
+ *
+ * The IOMMU subsystem participates in the Live Update process to preserve its
+ * IOMMU domains and IOMMU specific state of preserved devices.
+ *
+ * File-Lifecycle-Bound (FLB) Data
+ * ===============================
+ *
+ * Preserved state of IOMMU HW needs to be restored during boot when the IOMMU is
+ * initialized and registered. The preserved IOMMU domains also need to be
+ * restored and associated with the preserved devices early during boot. For
+ * this reason, IOMMU subsystem uses LUO File-Lifecycle-Bound Data to store some
+ * state globally.
+ *
+ * During preservation of IOMMUFD into LUO, some of the state is stored in the
+ * IOMMU FLB so it can be restored during boot. Once the FDs are retrieved from LUO
+ * the restored state can be reassociated with the relevant IOMMUFDs.
+ *
+ * The FLB also contains the state of IOMMU HW that might be shared between
+ * multiple devices, domains and iommufds. This is restored early during boot
+ * and no re-association of this state is needed later.
+ *
+ * As the state is preserved using KHO, the FLB handler callbacks are called by
+ * LUO only when the KHO is enabled. So there is no need to check whether KHO is
+ * enabled in the callback implementation.
+ *
+ */
+
+#define pr_fmt(fmt)    "iommu: liveupdate: " fmt
+
+#include <linux/errno.h>
+#include <linux/iommu-liveupdate.h>
+#include <linux/iommu.h>
+#include <linux/kexec_handover.h>
+#include <linux/liveupdate.h>
+
+struct iommu_flb_obj {
+	struct mutex lock;
+	struct iommu_flb_ser *ser;
+
+	struct iommu_hw_array_ser *curr_iommu_array;
+	struct iommu_domain_array_ser *curr_domain_array;
+	struct iommu_device_array_ser *curr_device_array;
+};
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
+	iommu_liveupdate_unpreserve_free(obj->ser->iommu_domain_array_phys);
+	iommu_liveupdate_unpreserve_free(obj->ser->device_array_phys);
+	iommu_liveupdate_unpreserve_free(obj->ser->iommu_array_phys);
+
+	kho_unpreserve_free(obj->ser);
+	mutex_destroy(&obj->lock);
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
+	ser->version = IOMMU_LUO_FLB_VERSION;
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
+	mutex_destroy(&obj->lock);
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
+	mutex_destroy(&obj->lock);
+	kfree(obj);
+}
+
+static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
+{
+	struct iommu_flb_obj *obj;
+	struct iommu_flb_ser *ser;
+
+	obj = kzalloc_obj(*obj, GFP_KERNEL);
+	if (!obj) {
+		/*
+		 * If retrieve fails, the finish path won't be called as
+		 * can_finish() will fail, preventing the restore.
+		 */
+		return -ENOMEM;
+	}
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
+	.retrieve = iommu_liveupdate_flb_retrieve,
+	.finish = iommu_liveupdate_flb_finish,
+};
+
+static struct liveupdate_flb iommu_flb = {
+	.compatible = IOMMU_LUO_FLB_COMPATIBLE,
+	.ops = &iommu_flb_ops,
+};
+
+/**
+ * iommu_liveupdate_register_flb() - Register IOMMU Live Update FLB
+ * @handler: Live Update file handler to associate FLB with
+ *
+ * Register a Live Update FLB for IOMMU state preservation with the file
+ * handler.
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
+{
+	return liveupdate_register_flb(handler, &iommu_flb);
+}
+EXPORT_SYMBOL(iommu_liveupdate_register_flb);
+
+/**
+ * iommu_liveupdate_unregister_flb() - Unregister IOMMU Live Update FLB
+ * @handler: Live Update file handler to associate FLB with
+ */
+void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
+{
+	liveupdate_unregister_flb(handler, &iommu_flb);
+}
+EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
new file mode 100644
index 000000000000..4755ab3cd67a
--- /dev/null
+++ b/include/linux/iommu-liveupdate.h
@@ -0,0 +1,28 @@
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
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
+void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
+#else
+static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
+{
+	return 0;
+}
+
+static inline void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
+{
+}
+#endif
+#endif /* _LINUX_IOMMU_LIVEUPDATE_H */
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
new file mode 100644
index 000000000000..aa42085409e5
--- /dev/null
+++ b/include/linux/kho/abi/iommu.h
@@ -0,0 +1,212 @@
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
+ * incrementing the version number in IOMMU_LUO_FLB_VERSION.
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
+#define IOMMU_LUO_FLB_COMPATIBLE "iommu-liveupdate"
+#define IOMMU_LUO_FLB_VERSION 1
+
+/**
+ * enum iommu_type_ser - Type of the IOMMU being preserved
+ * @IOMMU_INVALID: Invalid type of IOMMU
+ *
+ * IOMMU type is stored in the IOMMU HW state to differentiate between various
+ * IOMMU HWs.
+ */
+enum iommu_type_ser {
+	IOMMU_INVALID,
+};
+
+#define IOMMU_SER_FLAG_DELETED	(1 << 0)
+#define IOMMU_SER_FLAG_INCOMING	(1 << 1)
+
+/**
+ * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
+ * @ref_count: Reference count for the object
+ * @flags: Bitmask of IOMMU_SER_FLAG_* flags indicating object state
+ */
+struct iommu_hdr_ser {
+	u32 ref_count;
+	u32 flags;
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
+	u8 sign_extend;
+	u8 padding[3];
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
+ * @dma_owner_token: Token to identify the DMA owner of this device
+ * @domain_iommu_ser: Domain and IOMMU mapping
+ */
+struct iommu_device_ser {
+	struct iommu_hdr_ser hdr;
+	u32 devid;
+	u32 pci_domain_nr;
+	u64 dma_owner_token;
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
+	u64 version;
+	u64 iommu_array_phys;
+	u64 iommu_domain_array_phys;
+	u64 device_array_phys;
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_IOMMU_H */
-- 
2.55.0.1082.g2b9226bbc0-goog

