Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A23EBF1E
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312610; cv=none; b=CTWLQATfNjEVpeFbUOJs8hSuYh71lcYj/CLSLykAa6QqQRKov8Fhh80kdqwqC4wq9B3Yqp2+3p3a7m3z1MdMRKJ31wO/J1MbrDhnqKbzvDhYcfmzj4aehvf2PqerTJUoR4gjcpNJoNZINY87yS+unqX5oYYbXS5nJMfI6GLEnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312610; c=relaxed/simple;
	bh=zvHSq93+tpKaW7OQt+4r2WI+TyTJ8+1sdH2d/ivRKrs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=srJm5gam4pIt2oRbzNnG3iE6MFACgcoSpYgete6VcJU6uZK3VQtar8M+YLTVxh4f3wovyJJM59BB6kipyddq3Fp4u4H+CZBB4OyX7HbygYm4bhCg0XRjcctdAbuXmXbTArHZcMTnOihgNktWAtk/kii81BxD0MLzJmzyUdxmHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tP6xdbBR; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tP6xdbBR"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f6610a6c8so5717903b3a.2
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312607; x=1777917407; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8K3iC/lOrqaWhXVr5GgRxK6vf1ZBt3CPZafIcyOF9wU=;
        b=tP6xdbBRge2E0YKFr/y6qkDsKdorVnBAwHIYxV5atka6xTfo7qTvIl5w/eLdu7KB8X
         nci71BK8Y38lLTKQDkGKEIGFUW5z7QUaH2mbWpB4h0MOewIw9H72CiWfANLaVxsIZCGE
         /A2AJ9AE8I6/KVrfKf2nNKmfFciFYobcLlo/cpeInO8H3vEvXqgIElNmB6R/9aHmamcJ
         fmUMXXfDm2tsXtodHtkQ8fqlAcELQHCevtEGP7alPlUhL/aVap2nJoEUnjC2aQfOvur9
         5QrZBiBa5ZKvjkGpmlo9qRkpmmeR7PD33Ls15OyMqYX2r6uU7+J7DiXHsyID80hwbgvo
         3gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312607; x=1777917407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8K3iC/lOrqaWhXVr5GgRxK6vf1ZBt3CPZafIcyOF9wU=;
        b=Be9u1Z1cAT4allvzZYvvJ/o2HxtM0Tluj44mngB4t6BwCx5BBlO+gHafjk26UDxcuH
         gTjiTxOGU9+Evn3drvHDAp09qabtfyzWyHNjEn3KIK6YTwbN2oZlMQh6+gPap5yjpzxO
         vmuyGBgBwcLsVbDoMf5SyH/c9E8beTybqWWTg+7YqcKnnwQKBu0qPbKv6dFIISPcm6n8
         mfylfvEe1F37C2sLflw0jWynSov//baxJZKWNRYrZkNHE51lGVWKOzU1H5Izrh7F2EZF
         dkiHaRvaBYwZz3kIZX7BboMImyNjhAYD5wL2eFlGcZ1Bny2UX8TU9b9XY1n5FieMUX/C
         eWjw==
X-Forwarded-Encrypted: i=1; AFNElJ+X8wqse+aU7FNDrLjVkjoS0vx2PGNAZTVQFYVPuAuOdtipJVwtmvtzlpHb7fpk46AdkHebAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzfVLhMivpNgYF2uSa0HK1EU0YcVqOF8qA2XtKNe9HFGG8t73BA
	S2svU7O4S78x+b2PSM4vt6JuUUtg83wRCcqQVCXwtYT1/eN2zhXPVbsk2F1jJFFOqyMcPvmUtYP
	34WveDdwHx06KJA==
X-Received: from pfay20.prod.google.com ([2002:a05:6a00:1814:b0:829:7f86:623])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4fce:b0:828:d9a1:c5f9 with SMTP id d2e1a72fcca58-834dc28fc76mr10980b3a.33.1777312607168;
 Mon, 27 Apr 2026 10:56:47 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:24 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-8-skhawaja@google.com>
Subject: [PATCH v2 07/16] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
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

Add implementation of the device and iommu presevation in a separate
file. Also set the device and iommu preserve/unpreserve ops in the
struct iommu_ops.

During normal shutdown the iommu translation is disabled. Since the root
table is preserved during live update, it needs to be cleaned up and the
context entries of the unpreserved devices need to be cleared.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                      |   1 +
 drivers/iommu/intel/Makefile     |   1 +
 drivers/iommu/intel/iommu.c      |  52 +++++++++++-
 drivers/iommu/intel/iommu.h      |  28 +++++++
 drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c            |  18 ++++
 include/linux/iommu-liveupdate.h |  10 +++
 include/linux/iommu.h            |  14 ++++
 include/linux/kho/abi/iommu.h    |  18 ++++
 9 files changed, 277 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/intel/liveupdate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 980041955abc..9f5c02c6c8c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13495,6 +13495,7 @@ M:	Samiullah Khawaja <skhawaja@google.com>
 R:	Pranjal Shrivastava <praan@google.com>
 L:	iommu@lists.linux.dev
 S:	Maintained
+F:	drivers/iommu/intel/liveupdate.c
 F:	drivers/iommu/liveupdate.c
 F:	include/linux/iommu-liveupdate.h
 F:	include/linux/kho/abi/iommu.h
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
index c3d18cd77d2f..68fecd4e57fa 100644
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
@@ -52,6 +53,8 @@ static int rwbf_quirk;
 
 #define rwbf_required(iommu)	(rwbf_quirk || cap_rwbf((iommu)->cap))
 
+static void clear_unpreserved_context_entries(struct intel_iommu *iommu);
+
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
  * (used when kernel is launched w/ TXT)
@@ -60,8 +63,6 @@ static int force_on = 0;
 static int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
-#define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
-
 /*
  * Take a root_entry and return the Lower Context Table Pointer (LCTP)
  * if marked present.
@@ -2375,8 +2376,11 @@ void intel_iommu_shutdown(void)
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
 
@@ -2899,6 +2903,41 @@ static const struct iommu_dirty_ops intel_second_stage_dirty_ops = {
 	.set_dirty_tracking = intel_iommu_set_dirty_tracking,
 };
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
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
+static void clear_unpreserved_context_entries(struct intel_iommu *iommu)
+{
+	struct iommu_dev_iter iter = {
+		.fn = clear_unpreserve_context_entry_fn,
+		.iommu = &iommu->iommu,
+		.arg = NULL,
+
+	};
+
+	iommu_for_each_dev(&iter);
+}
+#else
+static void clear_unpreserved_context_entries(struct intel_iommu *iommu)
+{
+}
+#endif
+
 static struct iommu_domain *
 intel_iommu_domain_alloc_second_stage(struct device *dev,
 				      struct intel_iommu *iommu, u32 flags)
@@ -3926,6 +3965,11 @@ const struct iommu_ops intel_iommu_ops = {
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
 	.page_response		= intel_iommu_page_response,
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	.preserve_device	= intel_iommu_preserve_device,
+	.preserve		= intel_iommu_preserve,
+	.unpreserve		= intel_iommu_unpreserve,
+#endif
 };
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ef145560aa98..5e0bc17e76bf 100644
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
@@ -1284,6 +1286,32 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
 	return 0;
 }
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int intel_iommu_preserve_device(struct device *dev,
+				struct iommu_device_ser *device_ser);
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
index 000000000000..75fa68b701bf
--- /dev/null
+++ b/drivers/iommu/intel/liveupdate.c
@@ -0,0 +1,139 @@
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
+static void unpreserve_iommu_context_table(struct intel_iommu *iommu, int end)
+{
+	struct context_entry *context;
+	int i;
+
+	for (i = 0; i < end; i++) {
+		context = iommu_context_addr(iommu, i, 0, 0);
+		if (context)
+			iommu_unpreserve_page(context);
+
+		if (!sm_supported(iommu))
+			continue;
+
+		context = iommu_context_addr(iommu, i, 0x80, 0);
+		if (context)
+			iommu_unpreserve_page(context);
+	}
+}
+
+static int preserve_iommu_context_table(struct intel_iommu *iommu)
+{
+	struct context_entry *context;
+	int ret;
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		/*
+		 * Alloc the context tables now to make sure the iommu unit is
+		 * properly preserved. These might stay unused and wastes around
+		 * 32MB max in scalable mode.
+		 */
+		spin_lock(&iommu->lock);
+		context = iommu_context_addr(iommu, i, 0, 1);
+		spin_unlock(&iommu->lock);
+		if (!context) {
+			ret = -ENOMEM;
+			goto error;
+		}
+		ret = iommu_preserve_page(context);
+		if (ret)
+			goto error;
+
+		if (!sm_supported(iommu))
+			continue;
+
+		spin_lock(&iommu->lock);
+		context = iommu_context_addr(iommu, i, 0x80, 1);
+		spin_unlock(&iommu->lock);
+		if (!context) {
+			ret = -ENOMEM;
+			goto error_sm;
+		}
+		ret = iommu_preserve_page(context);
+		if (ret)
+			goto error_sm;
+	}
+
+	return 0;
+
+error_sm:
+	context = iommu_context_addr(iommu, i, 0, 0);
+	iommu_unpreserve_page(context);
+error:
+	unpreserve_iommu_context_table(iommu, i);
+	return ret;
+}
+
+int intel_iommu_preserve_device(struct device *dev,
+				struct iommu_device_ser *device_ser)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	if (!dev_is_pci(dev)) {
+		dev_err(dev, "Cannot preserve non-PCI device\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!info)
+		return -EINVAL;
+
+	device_ser->domain_iommu_ser.attachment_id = domain_id_iommu(info->domain,
+								     info->iommu);
+	return 0;
+}
+
+int intel_iommu_preserve(struct iommu_device *iommu_dev,
+			 struct iommu_hw_ser *ser)
+{
+	struct intel_iommu *iommu;
+	int ret;
+
+	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
+
+	ret = preserve_iommu_context_table(iommu);
+	if (ret)
+		return ret;
+
+	ret = iommu_preserve_page(iommu->root_entry);
+	if (ret) {
+		unpreserve_iommu_context_table(iommu, ROOT_ENTRY_NR);
+		return ret;
+	}
+
+	ser->intel.phys_addr = iommu->reg_phys;
+	ser->intel.root_table = __pa(iommu->root_entry);
+	ser->type = IOMMU_INTEL;
+	ser->token = ser->intel.phys_addr;
+
+	return 0;
+}
+
+void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
+			    struct iommu_hw_ser *iommu_ser)
+{
+	struct intel_iommu *iommu;
+
+	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
+
+	unpreserve_iommu_context_table(iommu, ROOT_ENTRY_NR);
+	iommu_unpreserve_page(iommu->root_entry);
+}
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 782e73a9d45f..0561990f46e3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -307,6 +307,24 @@ void iommu_device_unregister(struct iommu_device *iommu)
 }
 EXPORT_SYMBOL_GPL(iommu_device_unregister);
 
+static int _iommu_for_each_dev_cb(struct device *dev, void *data)
+{
+	struct iommu_dev_iter *iter = data;
+
+	if (dev->iommu && dev->iommu->iommu_dev == iter->iommu)
+		return iter->fn(dev, iter->iommu, iter->arg);
+
+	return 0;
+}
+
+void iommu_for_each_dev(struct iommu_dev_iter *iter)
+{
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
+		bus_for_each_dev(iommu_buses[i], NULL, iter,
+				 _iommu_for_each_dev_cb);
+}
+EXPORT_SYMBOL_GPL(iommu_for_each_dev);
+
 #if IS_ENABLED(CONFIG_IOMMUFD_TEST)
 void iommu_device_unregister_bus(struct iommu_device *iommu,
 				 const struct bus_type *bus,
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 279c7ab04f09..c9d75c6b3be9 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -33,6 +33,11 @@ void iommu_domain_unpreserve(struct iommu_domain *domain);
 int iommu_preserve_device(struct iommu_domain *domain,
 			  struct device *dev, u64 *preserved_state);
 void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);
+
+static inline void *iommu_preserved_state(struct iommu_device *iommu)
+{
+	return iommu->outgoing_preserved_state;
+}
 #else
 static inline void *dev_iommu_preserved_state(struct device *dev)
 {
@@ -57,6 +62,11 @@ static inline int iommu_preserve_device(struct iommu_domain *domain,
 static inline void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
 {
 }
+
+static inline void *iommu_preserved_state(struct iommu_device *iommu)
+{
+	return NULL;
+}
 #endif
 
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1c424b32c5fc..999be5127c65 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1207,6 +1207,20 @@ static inline void *dev_iommu_priv_get(struct device *dev)
 
 void dev_iommu_priv_set(struct device *dev, void *priv);
 
+typedef int (*iommu_dev_iter_fn)(struct device *dev,
+				 struct iommu_device *iommu, void *arg);
+
+/**
+ * struct iommu_dev_iter - Iterator for devices attached to an IOMMU
+ */
+struct iommu_dev_iter {
+	struct iommu_device *iommu;
+	iommu_dev_iter_fn fn;
+	void *arg;
+};
+
+void iommu_for_each_dev(struct iommu_dev_iter *iter);
+
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
index 37b967820f14..5ffedf0dbd5a 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -73,6 +73,7 @@
 
 enum iommu_type_ser {
 	IOMMU_INVALID,
+	IOMMU_INTEL,
 };
 
 /**
@@ -132,16 +133,33 @@ struct iommu_device_ser {
 	struct iommu_dev_map_ser domain_iommu_ser;
 } __packed;
 
+/**
+ * struct iommu_intel_ser - Serialized state of an Intel IOMMU instance
+ * @restored: Whether IOMMU state is restored
+ * @phys_addr: Physical address of the IOMMU register base
+ * @root_table: Physical address of the root entry table
+ */
+struct iommu_intel_ser {
+	u8 restored;
+	u8 padding[7];
+	u64 phys_addr;
+	u64 root_table;
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
2.54.0.545.g6539524ca2-goog

