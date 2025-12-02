Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98F2FC02D
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716593; cv=none; b=XyxJoy9dnVTcTqKPWOi0aBaCDkcPdhcAsEjgoiJ6BXYatdpUm66q0n1UIe7o8p4/htKfXpJTq/C5AGgsAiaDOUM1ow3FIOW2D0PintbOUE8VGBoPDqB+fVkFl9B7ZZWhBrECSQS4Y/BgExOgXuABo9XlwXvFC81fU0g62wEQHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716593; c=relaxed/simple;
	bh=AFk5Ea55TAJa45eRFuyCiONTrwUNxTAU7i38Db4LRrk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DCk8t9InbszJvbaJqKYc1XHtcO+9aQzirM7LThk2EjypF0TGGPoBQUXLQ4HkKwPvB5Cb6VojIBJfoczKCR5floMq9yzt0xJevsWwdQVmF6E/2ZQUijYTn1zXPruTLX1LlYPiAapVHCGt8kycgUtxywOuwVwJCYe/0p9LD6Oh+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T8ZJwn/W; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T8ZJwn/W"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34188ba5990so14530966a91.0
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716591; x=1765321391; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hD0KJCE1xNxvrhBxO7YABzs3soKeKORw0maD4NtSyI=;
        b=T8ZJwn/W9nPxwsFNW4i+PqP7/npsb6WDB5WlHwGV5iVUUsnCvYNKP9dSw3g2wvhvG0
         fbny2poWkhMT0mFJ2/FE/rXvsqAYx2jX5CcQbpRnLrmldJjpTLVJcoAdzUZ2DAAwnyAH
         +wTLJgkYbhk9/aOVFQdPjDuVjxRpft4hVmxDG0LS5KorydGKTxNg5zQTeMCsLFnRQaHb
         k3rgNJCndDdJLOlMI6F6jfcjZ6QonKCUcyA1Y7w1WQor9IkN02RUqBjPerOXhktM5XEB
         Rmv4ds0/0ut5C47xCNlU7MvbRcywa5xcohKHchVt35ErwR/UtkHtJJakQ1LAP01j6E3S
         SqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716591; x=1765321391;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hD0KJCE1xNxvrhBxO7YABzs3soKeKORw0maD4NtSyI=;
        b=TNguILphYZSA9POHJYDUNqOf1y3SfW+1r4Y/1soh+Z749m7GPExuNpVwvdxZ828ATI
         QO9kOUzkZdNa2g1dw2RfN4FYnCVlflHVnhEH1Qt5fySl4l4a9vhdzflF5ehS0eWsEUqE
         7f8CyXRc1OEAtfuu8JDXWmpQTUsUCbjoQ2oMkq9AgiDF30pBr9ldkJpq92FpmUTARNn4
         MWMZyFRAweNIqrZOSsXR91MsPhL57uJme4+tphtjUDknzl1t1lGJS42zeW3DeKgCaFsa
         7GONk1spQhGY63lblZny9gw4VGNd5eI2f6bHh0jbvl3BaVNsCDa65RLiFdUkhbKKumru
         VFSg==
X-Forwarded-Encrypted: i=1; AJvYcCX3qdcxNceOb4v1RPrMKBGQeCZBRVrTnAwUr6mZz8fH6wS42QwL+2oh42POT4Dlv9RxXlVUgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOXQec9GEaSQJyE2Aps8o3kGJ7TJHSiXWI+a9odg4Jaxl75mRG
	XywiPNasOz3yen+1CbuJiAyK8kCnGLq38i6yEN51SCjcOc6eGoIEBOnh/EckorOP/FJpiDCQUkv
	VOTNklXSwZ+4aaA==
X-Google-Smtp-Source: AGHT+IG6VnJE2WmZozrveUHuXcYbn7N3t2981lMSNFJifrj+l9b4AV3NPIwPwvCWHKzsPSE9UhaWjjGLlPk0aw==
X-Received: from pjz7.prod.google.com ([2002:a17:90b:56c7:b0:32d:69b3:b7b0])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:180d:b0:32b:c9c0:2a11 with SMTP id 98e67ed59e1d1-349126e21a5mr376280a91.4.1764716591295;
 Tue, 02 Dec 2025 15:03:11 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:34 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-5-skhawaja@google.com>
Subject: [RFC PATCH v2 04/32] iommufd-lu: Implement basic prepare/cancel/finish/retrieve
 using folios
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

The actual serialization and de-serialization is implemented in
follow up commits.

- On prepare, a single folio is created and preserved to store
  all the structs.
- On cancel, the folio is unpreserved and freed.
- On retrieve, the folio is restored, then an fd with anon_inode
  is created, with data pointing to the folio.
- On finish, the folio is freed.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                             |   1 +
 drivers/iommu/iommufd/iommufd_private.h |   7 ++
 drivers/iommu/iommufd/liveupdate.c      | 113 ++++++++++++++++++++++--
 drivers/iommu/iommufd/main.c            |   2 +-
 include/linux/kho/abi/iommufd.h         |  31 +++++++
 5 files changed, 148 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/kho/abi/iommufd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bb9edf09f0e..bfe646d1c74f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13243,6 +13243,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
 F:	Documentation/userspace-api/iommufd.rst
 F:	drivers/iommu/iommufd/
 F:	include/linux/iommufd.h
+F:	include/linux/kho/abi/iommufd.h
 F:	include/uapi/linux/iommufd.h
 F:	tools/testing/selftests/iommu/
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index b6959ad55ad4..dfe9120aced0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -21,6 +21,9 @@ struct iommu_option;
 struct iommufd_device;
 struct dma_buf_attachment;
 struct dma_buf_phys_vec;
+struct iommufd_lu;
+
+extern const struct file_operations iommufd_fops;
 
 struct iommufd_sw_msi_map {
 	struct list_head sw_msi_item;
@@ -57,6 +60,10 @@ struct iommufd_ctx {
 	/* Compatibility with VFIO no iommu */
 	u8 no_iommu_mode;
 	struct iommufd_ioas *vfio_ioas;
+
+#ifdef CONFIG_LIVEUPDATE
+	struct iommufd_lu *lu;
+#endif
 };
 
 /* Entry for iommufd_ctx::mt_mmap */
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
index d228157b6fed..a9b5956c0dee 100644
--- a/drivers/iommu/iommufd/liveupdate.c
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -2,15 +2,44 @@
 
 #define pr_fmt(fmt) "iommufd: " fmt
 
+#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include <linux/iommufd.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/iommufd.h>
 #include <linux/liveupdate.h>
+#include <linux/mm.h>
 
 #include "iommufd_private.h"
 
 static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct iommufd_ctx *ictx = iommufd_ctx_from_file(args->file);
+	struct iommufd_lu *iommufd_lu;
+	size_t serial_size;
+	void *mem;
+	int rc;
+
+	if (IS_ERR(ictx))
+		return PTR_ERR(ictx);
+
+	serial_size = sizeof(*iommufd_lu);
+
+	mem = kho_alloc_preserve(serial_size);
+	if (!mem) {
+		rc = -ENOMEM;
+		goto err_ctx_put;
+	}
+
+	iommufd_lu = mem;
+
+	args->serialized_data = virt_to_phys(iommufd_lu);
+	iommufd_ctx_put(ictx);
+	return 0;
+
+err_ctx_put:
+	iommufd_ctx_put(ictx);
+	return rc;
 }
 
 static int iommufd_liveupdate_freeze(struct liveupdate_file_op_args *args)
@@ -21,26 +50,100 @@ static int iommufd_liveupdate_freeze(struct liveupdate_file_op_args *args)
 
 static void iommufd_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
+	struct iommufd_ctx *ictx = iommufd_ctx_from_file(args->file);
+
+	if (WARN_ON(IS_ERR(ictx)))
+		return;
+
+	kho_unpreserve_free(phys_to_virt(args->serialized_data));
+	iommufd_ctx_put(ictx);
 }
 
 static int iommufd_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct iommufd_lu *iommufd_lu;
+	struct iommufd_ctx *ictx;
+	struct folio *folio_lu;
+	struct file *file;
+	int rc;
+
+	folio_lu = kho_restore_folio(args->serialized_data);
+	if (IS_ERR_OR_NULL(folio_lu))
+		return -EFAULT;
+
+	iommufd_lu = folio_address(folio_lu);
+
+	file = anon_inode_create_getfile("iommufd", &iommufd_fops,
+					 NULL, O_RDWR, NULL);
+	if (IS_ERR(file)) {
+		rc = PTR_ERR(file);
+		goto err_folio_put;
+	}
+
+	rc = iommufd_fops.open(file->f_inode, file);
+	if (rc)
+		goto err_fput;
+
+	ictx = iommufd_ctx_from_file(file);
+	if (WARN_ON(IS_ERR(ictx))) {
+		rc = PTR_ERR(ictx);
+		goto err_fput;
+	}
+
+	if (WARN_ON(ictx->lu)) {
+		rc = -EEXIST;
+		goto err_ctx_put;
+	}
+	ictx->lu = iommufd_lu;
+
+	iommufd_ctx_put(ictx);
+
+	args->file = file;
+
+	return 0;
+
+err_ctx_put:
+	iommufd_ctx_put(ictx);
+err_fput:
+	fput(file);
+err_folio_put:
+	folio_put(folio_lu);
+	return rc;
 }
 
 static bool iommufd_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 {
-	return false;
+	if (!args->retrieved || !args->file) {
+		pr_warn("%s: fd not reclaimed\n", __func__);
+		return false;
+	}
+
+	return true;
 }
 
 static void iommufd_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	struct iommufd_lu *iommufd_lu;
+	struct iommufd_ctx *ictx;
+
+	ictx = iommufd_ctx_from_file(args->file);
+	iommufd_lu = ictx->lu;
+	ictx->lu = NULL;
+	iommufd_ctx_put(ictx);
+
+	folio_put(virt_to_folio(iommufd_lu));
 }
 
 static bool iommufd_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
 					    struct file *file)
 {
-	return false;
+	struct iommufd_ctx *ictx = iommufd_ctx_from_file(file);
+
+	if (IS_ERR(ictx))
+		return false;
+
+	iommufd_ctx_put(ictx);
+	return true;
 }
 
 static struct liveupdate_file_ops iommufd_lu_file_ops = {
@@ -54,7 +157,7 @@ static struct liveupdate_file_ops iommufd_lu_file_ops = {
 };
 
 static struct liveupdate_file_handler iommufd_lu_handler = {
-	.compatible = "iommufd-v1",
+	.compatible = IOMMUFD_LUO_COMPATIBLE,
 	.ops = &iommufd_lu_file_ops,
 };
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 18cc4af0a5c4..12601f9ad217 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -610,7 +610,7 @@ static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
 	return rc;
 }
 
-static const struct file_operations iommufd_fops = {
+const struct file_operations iommufd_fops = {
 	.owner = THIS_MODULE,
 	.open = iommufd_fops_open,
 	.release = iommufd_fops_release,
diff --git a/include/linux/kho/abi/iommufd.h b/include/linux/kho/abi/iommufd.h
new file mode 100644
index 000000000000..19d6b61ec3c3
--- /dev/null
+++ b/include/linux/kho/abi/iommufd.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2025, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#ifndef _LINUX_KHO_ABI_IOMMUFD_H
+#define _LINUX_KHO_ABI_IOMMUFD_H
+
+#include <linux/mutex_types.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/**
+ * DOC: IOMMUFD Live Update ABI
+ *
+ * This header defines the ABI for preserving the state of an IOMMUFD file
+ * across a kexec reboot using LUO.
+ *
+ * This interface is a contract. Any modification to any of the serialization
+ * structs defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the IOMMUFD_LUO_COMPATIBLE string.
+ */
+
+#define IOMMUFD_LUO_COMPATIBLE "iommufd-v1"
+
+struct iommufd_lu {
+};
+
+#endif /* _LINUX_KHO_ABI_IOMMUFD_H */
-- 
2.52.0.158.g65b55ccf14-goog

