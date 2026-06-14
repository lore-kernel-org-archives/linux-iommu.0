Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D5238AC8D
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480264; cv=none; b=OtFF94xVtialTJKeYUSw9vMjD2ZnT9oPltfepyYg1sf0Apx2gQK2TOWgHDqfQ2S/vgKn1FHtV4GW5n0AEOfUO8DpH9NQOTVTlJqNS1xLAYJMfUif4Ku5CGuCL/Ct+9DWnQ8ewWJFZWvs0W1u7MuyQaL9dSZKYcnzuwRoW36Y8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480264; c=relaxed/simple;
	bh=pJANR27TCwzM6P7JUjCO8NVSON5V5PQjS7w9IaURvgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OeIbX6zXESSw+cpfkDjujC1ytrwWfD+MZADGcqCDt43Dcq3w/ciZFLTsyG0vCtQJ7r9yAO732NvnxLFj+Vrxqq0ibMFYppOOfBGy272n02/7+eNzZRfMGGaX8fGOquchDQHbXVkUDWmHXHQzbYb6En0YfEKvtN5GIfYTucCXndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olKxy/rG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olKxy/rG"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso3789288a91.1
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480261; x=1782085061; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4jEXc7eb319TzKfJMN/jxkEzmPY1X3dZJzTvkIvfjE=;
        b=olKxy/rGYxeRflaObDP/JPmUF3iH7kEm8fGGQjpv47rdI2a6VvJb+es99KYFn4nzHI
         CvF5L3dXl00YE+9Kj2ItrHa7bk7O9ujTMKV5J4ugTxl8I1Eal4DSOLP1+5QLQXuxf029
         st9qeWUxEjH+S4xj6JWDLdP2a2oO3rsC5eoQ2SUPk4uyOkIHQe50TYlcmaJGNGzSUkQR
         vyO64lwwSU0biHRyKbi8CL8DzZsJJPzvMFuvioCpPHcRS/Cw1Fzc9Gp8EAS5MbvIkKFx
         9N8d9htQxOMYRFKXB74qeYd5fQyEyblnrvPgGVHaXAVhx6Lzn1zdqTV5/ugrJUUSDBSc
         9DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480261; x=1782085061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4jEXc7eb319TzKfJMN/jxkEzmPY1X3dZJzTvkIvfjE=;
        b=nzjFDQ7rMwgmUOvSwr01M9J7Was69rz3iAoNrEJ5VoNPfeJopLI1wG23f+HX1H9Qiu
         P4coRfhX6zc5k85a7Hz+ewayNWzAmIogXbrfpjPIYVB3+FYev8rmLK5uMC6jCw/Xg+sE
         HItdECI28IF6/QKlhpW/xpuA1YqflwT2WznxEt3mAO2+30k5bE8zsm0hwQrAUREGbFWc
         sLd8iNBsO4D0DknOa7QOhrswTPvQYUbhzqFJCNjfY2Hw3uWsfuadOkyZwaX9yIc/v4ym
         JhskxKmCk5CCfCgAhyJ2dYlmOOyEj7b1TkbCo8PhCVvjsqzZnhC6gqg8vmy0mYBhhwmk
         Giuw==
X-Forwarded-Encrypted: i=1; AFNElJ+GtPPwVoBoNZZWL/P3oWoVCIG29T0VW8uhrm7xVI+0WR1KBUIrbTTFlFy7QE1/ezXEvWlHIg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7IJm4b8AqrRM4LHbCMuHfRGQmLT1aH8bzZfFe+I8RGaQD1KdI
	eMrqobhHEYmyT8kfIPTIqxPEyI9OxHdgAbQnnCwBnVatCFIv/YtfQvmyya8hi7eKlt67kSO1oxP
	gaIKBS8Fv2SXlTQ==
X-Received: from pgah15.prod.google.com ([2002:a05:6a02:4e8f:b0:c79:7757:4178])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1808:b0:36b:bec8:94cf with SMTP id 98e67ed59e1d1-37c2bc87071mr8712791a91.9.1781480260992;
 Sun, 14 Jun 2026 16:37:40 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:24 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-15-skhawaja@google.com>
Subject: [PATCH v3 14/18] iommufd: Implement ioctl to mark HWPT for preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

Userspace provides a token to mark the HWPT for preservation. Note that
this token is not the LUO token that is used to preserve the iommufd.
Once all the required HWPT are marked for preservation, the user can
preserve the iommufd into LUO. The iommufd will preserve the HWPTs that
are marked for preservation.

The marked HWPTs are tracked using a new XArray mark protected by a new
liveupdate mutex. This mutex will also be used during iommufd
preservation to protect against any race with the mark preserve ioctl.

The HWPT token will be used during restore to identify this HWPT. The
restoration logic is not implemented and will be added later.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                             |  1 +
 drivers/iommu/iommufd/Makefile          |  2 +
 drivers/iommu/iommufd/iommufd_private.h | 18 ++++++++
 drivers/iommu/iommufd/liveupdate.c      | 56 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  9 ++++
 include/uapi/linux/iommufd.h            | 26 ++++++++++++
 6 files changed, 112 insertions(+)
 create mode 100644 drivers/iommu/iommufd/liveupdate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4dfb56962426..9ef9f2b75d6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13498,6 +13498,7 @@ M:	Samiullah Khawaja <skhawaja@google.com>
 R:	Pranjal Shrivastava <praan@google.com>
 L:	iommu@lists.linux.dev
 S:	Maintained
+F:	drivers/iommu/iommufd/liveupdate.c
 F:	drivers/iommu/liveupdate.c
 F:	include/linux/iommu-liveupdate.h
 F:	include/linux/kho/abi/iommu.h
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 71d692c9a8f4..d765fc10e3b2 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -11,9 +11,11 @@ iommufd-y := \
 	viommu.o
 
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
+iommufd-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
 obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
 
 iommufd_driver-y := driver.o
 obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += iommufd_driver.o
+
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6ac1965199e9..111f4d42e210 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -44,6 +44,11 @@ struct iommufd_ctx {
 	struct file *file;
 	struct xarray objects;
 	struct xarray groups;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+#define IOMMUFD_OBJ_LIVEUPDATE_MARK XA_MARK_1
+	/* @liveupdate_mutex: Protects the preservation of HWPTs. */
+	struct mutex liveupdate_mutex;
+#endif
 	wait_queue_head_t destroy_wait;
 	struct rw_semaphore ioas_creation_lock;
 	struct maple_tree mt_mmap;
@@ -373,6 +378,10 @@ struct iommufd_hwpt_paging {
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
 	bool nest_parent : 1;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	bool liveupdate_preserve : 1;
+	u64 liveupdate_token;
+#endif
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
 	struct iommufd_sw_msi_maps present_sw_msi;
@@ -706,6 +715,15 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
 			    struct iommufd_vdevice, obj);
 }
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd);
+#else
+static inline int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
+{
+	return -ENOTTY;
+}
+#endif
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
new file mode 100644
index 000000000000..e0d2c4aa2466
--- /dev/null
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#define pr_fmt(fmt) "iommufd: " fmt
+
+#include <linux/file.h>
+#include <linux/iommufd.h>
+#include <linux/liveupdate.h>
+
+#include "iommufd_private.h"
+
+int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_liveupdate_mark_preserve *cmd = ucmd->cmd;
+	struct iommufd_hwpt_paging *hwpt_target;
+	struct iommufd_hwpt_paging *hwpt_paging;
+	struct iommufd_ctx *ictx = ucmd->ictx;
+	struct iommufd_object *obj;
+	unsigned long index;
+	int rc = 0;
+
+	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt_target))
+		return PTR_ERR(hwpt_target);
+
+	mutex_lock(&ictx->liveupdate_mutex);
+
+	xa_lock(&ictx->objects);
+	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
+		if (WARN_ON_ONCE(obj->type != IOMMUFD_OBJ_HWPT_PAGING))
+			continue;
+
+		hwpt_paging = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
+		if (hwpt_paging->liveupdate_token == cmd->hwpt_token) {
+			rc = -EADDRINUSE;
+			goto out_unlock;
+		}
+	}
+
+	__xa_set_mark(&ictx->objects, hwpt_target->common.obj.id, IOMMUFD_OBJ_LIVEUPDATE_MARK);
+
+	if (hwpt_target->liveupdate_token != 0)
+		pr_warn_ratelimited("Overwriting HWPT liveupdate token from: %llu to %llu\n",
+				    hwpt_target->liveupdate_token, cmd->hwpt_token);
+	hwpt_target->liveupdate_token = cmd->hwpt_token;
+
+out_unlock:
+	xa_unlock(&ictx->objects);
+	mutex_unlock(&ictx->liveupdate_mutex);
+	iommufd_put_object(ictx, &hwpt_target->common.obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 8c6d43601afb..0114c1520db4 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -313,6 +313,9 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	init_rwsem(&ictx->ioas_creation_lock);
 	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	xa_init(&ictx->groups);
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	mutex_init(&ictx->liveupdate_mutex);
+#endif
 	ictx->file = filp;
 	mt_init_flags(&ictx->mt_mmap, MT_FLAGS_ALLOC_RANGE);
 	init_waitqueue_head(&ictx->destroy_wait);
@@ -375,6 +378,9 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 	 * iommufd_object_tombstone_user()
 	 */
 	xa_destroy(&ictx->objects);
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	mutex_destroy(&ictx->liveupdate_mutex);
+#endif
 
 	WARN_ON(!xa_empty(&ictx->groups));
 
@@ -420,6 +426,7 @@ union ucmd_buffer {
 	struct iommu_hwpt_alloc hwpt;
 	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
 	struct iommu_hwpt_invalidate cache;
+	struct iommu_hwpt_liveupdate_mark_preserve mark_preserve;
 	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
@@ -493,6 +500,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE, iommufd_hwpt_liveupdate_mark_preserve,
+		 struct iommu_hwpt_liveupdate_mark_preserve, hwpt_token),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index e998dfbd6960..d96a74b43c9d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_HWPT_LU_MARK_PRESERVE = 0x95,
 };
 
 /**
@@ -1347,4 +1348,29 @@ struct iommu_hw_queue_alloc {
 	__aligned_u64 length;
 };
 #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
+
+/**
+ * struct iommu_hwpt_liveupdate_mark_preserve - ioctl(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE)
+ * @size: sizeof(struct iommu_hwpt_liveupdate_mark_preserve)
+ * @hwpt_id: Iommufd object ID of the target HWPT
+ * @hwpt_token: Token to identify this hwpt upon restore
+ *
+ * The target HWPT will be preserved during iommufd preservation.
+ * Only file-based memory mappings (e.g. memfd) are supported for HWPTs marked
+ * for preservation. Mapping anonymous memory into a preserved HWPT will result
+ * in a failure during the preservation phase.
+ *
+ * The hwpt_token is provided by userspace. If userspace enters a token
+ * already in use within this iommufd, -EADDRINUSE is returned from this ioctl.
+ *
+ * Note: There is no 'unmark' operation, so any HWPTs pooled in userspace that
+ * are marked for preservation must be destroyed after use.
+ */
+struct iommu_hwpt_liveupdate_mark_preserve {
+	__u32 size;
+	__u32 hwpt_id;
+	__u64 hwpt_token;
+};
+#define IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_LU_MARK_PRESERVE)
+
 #endif
-- 
2.54.0.1136.gdb2ca164c4-goog

