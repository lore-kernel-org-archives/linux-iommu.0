Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBDA2FE06B
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716598; cv=none; b=t3me2uGEEWHE0A0MYqXKTZ+Vi8fxYw8xaKYx/5/ghIZfyuz/7bSJjVJ7oLL6facwYkSHxqt32Z5xidIjGbilTet/6Agf5V1BJ5vfGFdk9o77IpjmEqHyeNYU6FjMWuWshyCw+753lVCK00DVVrJ0CC0t9nEwcv9S4WptUxeGAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716598; c=relaxed/simple;
	bh=ULbb7w3/DoJS6C3vS82w8RNd+7RiFjPM1CAt3aUcOeI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FxOIEuELJrZcscKGF1fgVaXf+q8RcRRLtCShw6ZM/06RzF9gYfYGUvmVPl/hgQSIJtrotbFjSswiIpgLJUyucHE7JLDUhCsKjJcdjImbWU+amqMVlOLqNCu/W7eUwojZRmqYSLl1KxmZKdPSKbTsZFoxNNz7/4pzsyhb9Sojc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4qAxa1lc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4qAxa1lc"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3437b43eec4so8055744a91.3
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716595; x=1765321395; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTpVIxhw3gSn/J7xlrm22d5yrRXDXGIS3cf2bBwoQ4c=;
        b=4qAxa1lc/uh6KNjcRP9zScuJzJnk9hQbPfjSQdv+hTUbTIxKoIE8VMyFkoWxdVQBXS
         mJUWCM6bWTVV76yqxueQQd8eNYs+Tn7rXxiTazhlviai4dtQunGoox38/GZ2hyKXWmCU
         RQk8zoqv07IRaQkenLRpjhDkFIJX9nOs852hJ36EWB9gG0yRJYihjj5/VgTvv8iwwaAK
         PKLSx7Lh/IbyJeyZoja4KHVO8U2slcMrEgzqVJTuFViLtvYvAYIABlHa//cIngOlwSJX
         gsoDIRsTKCm18i0g/uDNQGYiKX5hOUVlhPxL1x1bbSBsErUPdog2s1cXKjYD+dfBfRvh
         kMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716595; x=1765321395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTpVIxhw3gSn/J7xlrm22d5yrRXDXGIS3cf2bBwoQ4c=;
        b=IxImMdbMtW5QWGBPzg1h7jRyKJSF4hgOZ9ghsFPdywxATBV0xjiUr7vXxzRi3QBcv4
         EVqcZgOO8dzKPt8QvWC+SnfXaX6/AczR0R3qrNxohbSM4wBhy9QNByDpGoDB3QEPjGJy
         8VO8gUToZS8qlL5QHuTJd49sVDFJPJWaB9oYd1daU8BYGiM3lpPo/+8qzo9FPjjXXer4
         dTzoNq+w2BWkrZuoZOsY+zP6bXtp9E4fQlkyvPol1cwNJg0mE4rJ5MT1YAbttL+yO3Jn
         tB+JJfuekiRg1tqnT3ZdjFzlPbgOqqhFiZ9/Fk/x9hX6dLA1sTTM78SUyoACORG8E8mC
         ydVw==
X-Forwarded-Encrypted: i=1; AJvYcCXn1JJd//38Ov+GQoqVo84Yodc6xKrxeQjgXmNVnmOtv7C627mGU1DdUFJp5zhiDxr2l8FtOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTQPfcoD2pwihzNVMOKNZxn8aitS6ML3YqRzEZyh84/X8eSxXL
	cf5Ek07EBeebBA/2UNq56ZEmZYqr1DHkObohHfN08xjAapY2B/TMYYHlnrsaPIzX7IpEOx6BRfO
	ectJKCjKn0kblqw==
X-Google-Smtp-Source: AGHT+IHmkBy3pomegCZetYEkRcS2fbDHj0XK2NUpEIw1NB+1JhzqNWEpW/z/YDAVvXt2MKUoUHVAU302Q0gA5A==
X-Received: from pjbjs17.prod.google.com ([2002:a17:90b:1491:b0:341:2141:d814])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:390a:b0:33b:cfae:3621 with SMTP id 98e67ed59e1d1-349126fae11mr263303a91.32.1764716595575;
 Tue, 02 Dec 2025 15:03:15 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:37 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-8-skhawaja@google.com>
Subject: [RFC PATCH v2 07/32] iommu: Add liveupdate FLB for IOMMU state preservation
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

Add a liveupdate FLB for IOMMU state preservation with stub
implementation only. Also add APIs to to register/unregister this FLB
with the iommufd LU file handler.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/Makefile        |   1 +
 drivers/iommu/liveupdate.c    |  60 +++++++++++++++++
 include/linux/iommu-lu.h      |  17 +++++
 include/linux/kho/abi/iommu.h | 119 ++++++++++++++++++++++++++++++++++
 4 files changed, 197 insertions(+)
 create mode 100644 drivers/iommu/liveupdate.c
 create mode 100644 include/linux/iommu-lu.h
 create mode 100644 include/linux/kho/abi/iommu.h

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 8e8843316c4b..f1d740bb3592 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
+obj-$(CONFIG_LIVEUPDATE) += liveupdate.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
new file mode 100644
index 000000000000..93e5691a8c1f
--- /dev/null
+++ b/drivers/iommu/liveupdate.c
@@ -0,0 +1,60 @@
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
+#include <linux/errno.h>
+
+static void iommu_liveupdate_flb_free(struct iommu_lu_flb_obj *obj)
+{
+}
+
+static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
+{
+	return -EOPNOTSUPP;
+}
+
+static void iommu_liveupdate_flb_unpreserve(struct liveupdate_flb_op_args *argp)
+{
+	iommu_liveupdate_flb_free(argp->obj);
+}
+
+static void iommu_liveupdate_flb_finish(struct liveupdate_flb_op_args *argp)
+{
+}
+
+static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
+{
+	return -EOPNOTSUPP;
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
index 000000000000..71ff9b670a0b
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
+	u64 attach_count;
+	struct iommu_domain *restored_domain;
+} __packed;
+
+struct device_domain_iommu_ser {
+	u32 did;
+	u64 domain_phys;
+	u64 iommu_phys;
+};
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
+};
+
+struct iommu_objs_ser {
+	u64 next_objs;
+	u64 nr_objs;
+};
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
+#define MAX_IOMMU_DOMAIN_SERS ((PAGE_SIZE - sizeof(struct iommu_domains_ser)) / sizeof(struct iommu_domain_ser))
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
+};
+
+#endif /* _LINUX_KHO_ABI_IOMMU_H */
-- 
2.52.0.158.g65b55ccf14-goog

