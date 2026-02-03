Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63C37F72E
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156608; cv=none; b=uCTcYKLzpuHSXFwEkTvUdCgYGUvP9FFjSt438JMIvzlZ4knadR0wmOSMw8xO2qRpKFwFu6VPSWMnJ37PiHeiQae8VKy3yExYS4Pi8t2Xy3lwhr+2dqIElvVbXXOm5nODuv2grUoeSU2KGFwdaEmmbNfgFI8C1N79bue1KtlzTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156608; c=relaxed/simple;
	bh=L1gdkrfZpzHvz4nOMEwGAj6a2f4hvV7aHXOYdOFvgIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P+f66EnJszTsnBygocWE/BV+CaysC3Qf2J6KuotTgNkd8AgfwXdkw7BkEwt60BpEse20r6JZb7wuFezFwT5iGiSbIbbKdzy2j9PIvCEZ+1XOUramGpWKCoAwY/z4FAu69OzRdxddG3YCyzXwxSmFGZBQT4tADCBljxBpBiPvm5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZfDFu8o; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZfDFu8o"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c67e92aad79so2204131a12.0
        for <iommu@lists.linux.dev>; Tue, 03 Feb 2026 14:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770156606; x=1770761406; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FO4QdmXutfGlvqQphmse6DQSnrpdmmMLD/ha8Ivm6lo=;
        b=TZfDFu8obKy80ghgj41QIR+08Zb9YziNy84FPnwYGWSVVR8OeE/K8DUxwPian29SYU
         OlQc50iATSiG6qGjRJQccIpqFyC7kZPIO5MAtpyRvSV9P7HL3qHOBvMBudI5t6NtP9fn
         0uM3HPNF9AMau/KY9x20QvfSujlEO4thqu+YbESFQVqfzhzavkbPUI4yCU/qplBGtyHg
         RvmeuabjTacze+9hOlneYADZLDeegMJhL+Jfw8QdRVNeWgV/bKOo4lXlRsev0JCVWO4x
         t1LZOHjHD2FlCv/CZzMEfNElyOoMo2CJMEc0/yL6XRYwon54dIMvkpX05Ue/EqbiO+qM
         TAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770156606; x=1770761406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FO4QdmXutfGlvqQphmse6DQSnrpdmmMLD/ha8Ivm6lo=;
        b=HakgIpPomNfdtvpGzMuUMpOHr+SGa1p7/F7C9xm4qPAkk7WnovuqYz0GYScXT67gv8
         L9iiFhFfgBSAKmOkRorZyWggDL91SiyLf5iiI6s56dgV5zfh/2PpKPgoZyM//0g2a8Qv
         UIOoJxWWzKRIX8DNdCi+O/y0EfYBB8msR78CeHfnt/c6hH3hTUjAzKBE3CNKkaCIb6Bl
         3RL/G56B/W1pFv9LqsJcB6PgPRl0WOL5uU3602r8jMsAVRmZ8xUKVGa1fJOgfaowoMom
         1J9pnonsngzOrx93djDnaU9szBviEBhB7nPxjuV6IDG5J7EnUIpijUe3okPzQCPFeSqt
         3aKg==
X-Forwarded-Encrypted: i=1; AJvYcCXTZady6NRVMEYrP2xLlM8np3DOS+NmeAIP7LYiNo0aQUE07W1EqEJLApmBBOf+syOPFtGxVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzi/bAxYhTk1yTABBFK3zd4O3iI3yfsqroDPspvVwo6GRkHV3nc
	AYGML6oI2fBWC1o4aNKmR3CkY1s2LliYC2PJv0FD+jmZBvE/PaMMKYyLilf3xtBDomdWX9h4Es0
	ciuHdPqDVNlf8cw==
X-Received: from pgct9.prod.google.com ([2002:a05:6a02:5289:b0:c61:3a73:1448])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9185:b0:366:58cc:b74b with SMTP id adf61e73a8af0-393720cfdddmr834146637.21.1770156606372;
 Tue, 03 Feb 2026 14:10:06 -0800 (PST)
Date: Tue,  3 Feb 2026 22:09:44 +0000
In-Reply-To: <20260203220948.2176157-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260203220948.2176157-1-skhawaja@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203220948.2176157-11-skhawaja@google.com>
Subject: [PATCH 10/14] iommufd-lu: Implement ioctl to let userspace mark an
 HWPT to be preserved
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: YiFei Zhu <zhuyifei@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

From: YiFei Zhu <zhuyifei@google.com>

Userspace provides a token, which will then be used at restore to
identify this HWPT. The restoration logic is not implemented and will be
added later.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/iommufd/Makefile          |  1 +
 drivers/iommu/iommufd/iommufd_private.h | 13 +++++++
 drivers/iommu/iommufd/liveupdate.c      | 49 +++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |  2 +
 include/uapi/linux/iommufd.h            | 19 ++++++++++
 5 files changed, 84 insertions(+)
 create mode 100644 drivers/iommu/iommufd/liveupdate.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 71d692c9a8f4..c3bf0b6452d3 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
 
 iommufd_driver-y := driver.o
 obj-$(CONFIG_IOMMUFD_DRIVER_CORE) += iommufd_driver.o
+obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index eb6d1a70f673..6424e7cea5b2 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -374,6 +374,10 @@ struct iommufd_hwpt_paging {
 	bool auto_domain : 1;
 	bool enforce_cache_coherency : 1;
 	bool nest_parent : 1;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	bool lu_preserve : 1;
+	u32 lu_token;
+#endif
 	/* Head at iommufd_ioas::hwpt_list */
 	struct list_head hwpt_item;
 	struct iommufd_sw_msi_maps present_sw_msi;
@@ -707,6 +711,15 @@ iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
 			    struct iommufd_vdevice, obj);
 }
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd);
+#else
+static inline int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
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
index 000000000000..ae74f5b54735
--- /dev/null
+++ b/drivers/iommu/iommufd/liveupdate.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) "iommufd: " fmt
+
+#include <linux/file.h>
+#include <linux/iommufd.h>
+#include <linux/liveupdate.h>
+
+#include "iommufd_private.h"
+
+int iommufd_hwpt_lu_set_preserve(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_lu_set_preserve *cmd = ucmd->cmd;
+	struct iommufd_hwpt_paging *hwpt_target, *hwpt;
+	struct iommufd_ctx *ictx = ucmd->ictx;
+	struct iommufd_object *obj;
+	unsigned long index;
+	int rc = 0;
+
+	hwpt_target = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
+	if (IS_ERR(hwpt_target))
+		return PTR_ERR(hwpt_target);
+
+	xa_lock(&ictx->objects);
+	xa_for_each(&ictx->objects, index, obj) {
+		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
+			continue;
+
+		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
+
+		if (hwpt == hwpt_target)
+			continue;
+		if (!hwpt->lu_preserve)
+			continue;
+		if (hwpt->lu_token == cmd->hwpt_token) {
+			rc = -EADDRINUSE;
+			goto out;
+		}
+	}
+
+	hwpt_target->lu_preserve = true;
+	hwpt_target->lu_token = cmd->hwpt_token;
+
+out:
+	xa_unlock(&ictx->objects);
+	iommufd_put_object(ictx, &hwpt_target->common.obj);
+	return rc;
+}
+
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 5cc4b08c25f5..e1a9b3051f65 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -493,6 +493,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 __reserved),
 	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
 		 struct iommu_viommu_alloc, out_viommu_id),
+	IOCTL_OP(IOMMU_HWPT_LU_SET_PRESERVE, iommufd_hwpt_lu_set_preserve,
+		 struct iommu_hwpt_lu_set_preserve, hwpt_token),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 2c41920b641d..25d8cff987eb 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_HWPT_LU_SET_PRESERVE = 0x95,
 };
 
 /**
@@ -1299,4 +1300,22 @@ struct iommu_hw_queue_alloc {
 	__aligned_u64 length;
 };
 #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
+
+/**
+ * struct iommu_hwpt_lu_set_preserve - ioctl(IOMMU_HWPT_LU_SET_PRESERVE)
+ * @size: sizeof(struct iommu_hwpt_lu_set_preserve)
+ * @hwpt_id: Iommufd object ID of the target HWPT
+ * @hwpt_token: Token to identify this hwpt upon restore
+ *
+ * The target HWPT will be preserved during iommufd preservation.
+ *
+ * The hwpt_token is provided by userspace. If userspace enters a token
+ * already in use within this iommufd, -EADDRINUSE is returned from this ioctl.
+ */
+struct iommu_hwpt_lu_set_preserve {
+	__u32 size;
+	__u32 hwpt_id;
+	__u32 hwpt_token;
+};
+#define IOMMU_HWPT_LU_SET_PRESERVE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_LU_SET_PRESERVE)
 #endif
-- 
2.53.0.rc2.204.g2597b5adb4-goog

