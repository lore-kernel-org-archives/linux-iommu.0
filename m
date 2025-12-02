Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69708305077
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716614; cv=none; b=rofrr7HKhz/au/XHJMdZ7tixyWoeLdb3NsnCfAOwDHvB6WnEhQ6H4RQittYVFp7AMH0I/9alVbFbO7Bdtvf9y+Zj8FTbXqmlKwr68XoYlapT5Bwvp+DaY0g0E/jaf6ZA5sH2hbLOHIkcyuRhdnPI7V/D4DrZT8dLbrqbDLoCt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716614; c=relaxed/simple;
	bh=KY1jCAENzds73jSibtdEvckeq1aC3PSmjlk3rwiYZhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qn7Ta2yEDh3/CHnk++O0fO9ndOBfJ3nPpUOzz+EdXfVk4YlvFPZjWsU4ZznRWJ/6hKfj5GD5Qr2WEggrxXP6IcoSNakBGuID8n9eMgpThkABOGglW9TLQaWF8kmA9VnQhA2f4Wc7QdP1iNWJxX1ssSHxYkAAsGVpxZqdIdgKiFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+11e1HJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+11e1HJ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295952a4dd6so3304905ad.1
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716611; x=1765321411; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASFM5WU8uj7qIqqTRFyOlN4Z5qMVIRe9aLNxE/AiT3g=;
        b=G+11e1HJ6PkioVrq23Ck5kAnHr4csLyD9+snNsBPREq88MBmngIzNkBpHLlrjqAFkM
         YKeVgoOs6os2pIwyuxvlVAfBr6agio5UCXIN+30iqL7OL5AJc+UF4I2NO7+smAvmzXho
         /Y7MPS9Itf4aVV3J1MQmr7naMGUk3138B3lFhWumtel/g8XBi2eFu4IHV1Lo+DCTrA2i
         rRntVdOpYc3fr5wnxl1T7WUNZcKxYYAfMiR+ECEgJyhVa5tYTIQfMZ7SMVOBtTxLMDh3
         8E1Wzlnf+/lrqaoX9EfszdE2HUCvIopQ06gGyd59qOfJS3klL//eFuQIzxBpmH3wVH7X
         yzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716611; x=1765321411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASFM5WU8uj7qIqqTRFyOlN4Z5qMVIRe9aLNxE/AiT3g=;
        b=vsXtcwY1Sx5/GnWZ0dI2qSwbkBkpVfBbQGMEcGCn5aq0O7Eo2BRMAhhoxlBacEyETy
         iFZZ0MxmXyZjN7e0lgkDwPghqrWI8WaZG52L3UhY6geFgdk7aDwolOaOIgR3sCT4B5n/
         /myrguEj3uhmkr5FFngD9Snz38/00WFrhU5k2ODThhJULTkRkZR2A4Qu8lAeQxMEKmaF
         +L1PMN8TtwJupbEarLpd4S7fYZAclo10N6hdU2MW9kobuMDarhXN8Sn4zVYfJTzFLnNZ
         qpOpURti8Q17T31+nkBiuv/IVx5rBd+2dZUdXZPV0mz1TdhUxV4mpgFXd0F12G16sP1c
         JVTw==
X-Forwarded-Encrypted: i=1; AJvYcCUgPk9UWkSi39ym4SCYSpa2QoNSqvHdYxwNSGdIWPAw1Zr2YrPrK5UUVXxZHuPm6MLukVcQFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqKnSsm+veGHu/abJb+YemvS24x0XHTemRcR4yz6LhsUug3wsh
	DGjflXc81Q+6QIe9/+BqR4edgpk4/mcdvlZXlp37FYIcglOvQIDgmWYm9rRnY5mmWPzfxuwuFUa
	QQwU5XOiXs+zhZA==
X-Google-Smtp-Source: AGHT+IEg5NNIUB6X64tEFw5/b+/+7BN0IW2m/iavzJE/zMLhoaJ9lg94QcuL/07M6FzbTXsE+QlaIn2zzDj21g==
X-Received: from plko11.prod.google.com ([2002:a17:902:6b0b:b0:29d:5afa:2c9])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2341:b0:295:96bc:8698 with SMTP id d9443c01a7336-29d67f33102mr3185125ad.19.1764716610737;
 Tue, 02 Dec 2025 15:03:30 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:47 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-18-skhawaja@google.com>
Subject: [RFC PATCH v2 17/32] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Add implementation of the device and iommu presevation in a separate
file. Also set the device and iommu preserve/unpreserve ops in the
struct iommu_ops

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/Makefile     |   1 +
 drivers/iommu/intel/iommu.c      |   6 +-
 drivers/iommu/intel/iommu.h      |   9 +++
 drivers/iommu/intel/liveupdate.c | 127 +++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/intel/liveupdate.c

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index ada651c4a01b..58922d580c79 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
 obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
+obj-$(CONFIG_LIVEUPDATE) += liveupdate.o
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d745f833d8b5..3f69a073b2d8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -60,8 +60,6 @@ static int force_on = 0;
 static int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
-#define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
-
 /*
  * Take a root_entry and return the Lower Context Table Pointer (LCTP)
  * if marked present.
@@ -3909,6 +3907,10 @@ const struct iommu_ops intel_iommu_ops = {
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
 	.page_response		= intel_iommu_page_response,
+	.preserve_device	= intel_iommu_preserve_device,
+	.unpreserve_device	= intel_iommu_unpreserve_device,
+	.preserve		= intel_iommu_preserve,
+	.unpreserve		= intel_iommu_unpreserve,
 };
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 25c5e22096d4..ea88c86030bb 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -557,6 +557,8 @@ struct root_entry {
 	u64     hi;
 };
 
+#define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
+
 /*
  * low 64 bits:
  * 0: present
@@ -1276,6 +1278,13 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
 	return 0;
 }
 
+#ifdef CONFIG_LIVEUPDATE
+int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser);
+void intel_iommu_unpreserve_device(struct device *dev, struct device_ser *device_ser);
+int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
+void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
new file mode 100644
index 000000000000..491075802e4b
--- /dev/null
+++ b/drivers/iommu/intel/liveupdate.c
@@ -0,0 +1,127 @@
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
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "iommu.h"
+#include "../iommu-pages.h"
+
+static void unpreserve_iommu_context(struct intel_iommu *iommu, int end)
+{
+	struct context_entry *context;
+	int i;
+
+	if (end < 0)
+		end = ROOT_ENTRY_NR;
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
+static int preserve_iommu_context(struct intel_iommu *iommu)
+{
+	struct context_entry *context;
+	int ret;
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		context = iommu_context_addr(iommu, i, 0, 0);
+		if (context) {
+			ret = iommu_preserve_page(context);
+			if (ret)
+				goto error;
+		}
+
+		if (!sm_supported(iommu))
+			continue;
+
+		context = iommu_context_addr(iommu, i, 0x80, 0);
+		if (context) {
+			ret = iommu_preserve_page(context);
+			if (ret)
+				goto error_sm;
+		}
+	}
+
+	return 0;
+
+error_sm:
+	context = iommu_context_addr(iommu, i, 0, 0);
+	iommu_unpreserve_page(context);
+error:
+	unpreserve_iommu_context(iommu, i);
+	return ret;
+}
+
+int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
+	if (!dev_is_pci(dev))
+		return -EOPNOTSUPP;
+
+	if (!info)
+		return -EINVAL;
+
+	device_ser->domain_iommu_ser.did = domain_id_iommu(info->domain, info->iommu);
+
+	/* TODO: Add support preservation of PASIDs. */
+	return 0;
+}
+
+void intel_iommu_unpreserve_device(struct device *dev, struct device_ser *device_ser)
+{
+}
+
+int intel_iommu_preserve(struct iommu_device *iommu_dev, struct iommu_ser *ser)
+{
+	struct intel_iommu *iommu;
+	int ret;
+
+	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
+
+	spin_lock(&iommu->lock);
+	ret = preserve_iommu_context(iommu);
+	if (ret)
+		goto err;
+
+	ret = iommu_preserve_page(iommu->root_entry);
+	if (ret) {
+		unpreserve_iommu_context(iommu, -1);
+		goto err;
+	}
+
+	ser->intel.phys_addr = iommu->reg_phys;
+	ser->intel.root_table = __pa(iommu->root_entry);
+	ser->type = IOMMU_INTEL;
+	ser->token = ser->intel.phys_addr;
+	spin_unlock(&iommu->lock);
+
+	return 0;
+err:
+	spin_unlock(&iommu->lock);
+	return ret;
+}
+
+void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser)
+{
+}
-- 
2.52.0.158.g65b55ccf14-goog

