Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921A35B132
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979096; cv=none; b=G7OsX6vBK8/s02WKpDiSDMHFxDblTY6BU92TlCQPNj6FsPCWO/nm4B9ZHNdMDqaMuxF6s19WnNPYwkK+OTLsVDKvn0zVHGM+sOeCc+GIhmJ6O/J1UZa+xYX+31IsLt8GVQj4AquPTiVYVVYvy6hyi4q1zY452Xjzd7PFxTu2fbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979096; c=relaxed/simple;
	bh=Q41HnTHND56VPHVKcwQtds+kxZQpysksZlYusZI1eY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dHMA2V6MWr1fyZ+x1av2y4g+aGGFG27nIjsShOGKrwUugswi01eWK5ysAPR/zAjUVG6+YInhxtl2fUvJECHm8rDnpqeVnUani9rV0QweFhMNKSIwf5oMZY+gMe7nuhNI1y42iGn+qVtY980/vTTb3fxcB72rBSdoQD5aaI7F5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/toJ+aT; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/toJ+aT"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4776079ada3so43170765e9.1
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 09:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767979093; x=1768583893; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMbvILs8sdDM+X7Y87HU9ypohayabztkjgZL2Mm3bR4=;
        b=d/toJ+aTHcau9LA4kq3HyAt7rtJVojBE4wGQTFd29ZV3wcJZknu2JDL9TsysGTg9x3
         fC63R0AaqPDxt9BEL2TtT2whZHcseLYzYCup0/HC03iUxQeBYCiiKxsGyduuNaTN9o2k
         je0qCv3isiFcVds9PUoeTkCoXOCSG/kiQEo8QHyNLwtaBxSAhIqWocYKAUarGYOQ05FJ
         cBLHkdrBah/2LsDMPCFiY2QtAIc6WszLZ7rZmheTmEclLFmW/bDqhszcA9g1YlC8Clji
         23fSSu3KXCaOv1FLUVDQOqHxHWjR/CxJa9JC35h+1So2B8d5NkadK47Q7RKwDm4AVv+D
         bhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767979093; x=1768583893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMbvILs8sdDM+X7Y87HU9ypohayabztkjgZL2Mm3bR4=;
        b=lPbIAOonpKUclPQ+weJQo/mOrMhPNaCaHNyprsOSs7uny/pM2uPqiHJYxckxd8rYL3
         iYshJzpaVMbLPDY7lPm12p2ooTnN/+I5EwxsJdOE35OVFNba0IYbWkXWCcZuBIclKtSV
         sNJBWRBi6/a/2bIeYYk7ub1tbFekOcpGzXThXNG7pTo5Lz1eMBkFMxnbfvAiq3t+3v8j
         0DO+uxAkprAazwvfn8iXtdHFnI3J/25pgF/xk1CcGmrqV4EH9+89E8uUR/dADDTR5roX
         6oFDDfPKFRkCr+my2AEGJYaqriLaTTnmG6IBgU5v/qPkW4Z8T1uRhhab8VJQoLw50E+j
         TSJw==
X-Forwarded-Encrypted: i=1; AJvYcCUrzGuMRYuDqA3FPRWGJ8Oge6lnoUtiQaNTT0cNHQmfm866xURjLrb+8KuKbwEZYibljjhsAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzRnYcbrQIylboOhsoF7l4LPj6ZB6wmbjZiBmFJ1VnEt5BLVyfn
	mUchd417qay8nd0nLjUxIjbl4o8IdqIivBARNil7ESw9cMXt97sNhRlDTrCmX88bRUujYeduYaT
	YrYUjeQpW6QmKWg==
X-Google-Smtp-Source: AGHT+IFQrKO26j/Md4KslqSM57emYB9l/vej4SFg9X38oEIjTZGmUcvdSgmghLEuHbXJHuTDMuZHlNVKSr6pZw==
X-Received: from wrbdr2.prod.google.com ([2002:a5d:5f82:0:b0:430:f6bf:b2c3])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:103:b0:47d:403e:9cd5 with SMTP id 5b1f17b1804b1-47d84b1fce2mr91839245e9.11.1767979093084;
 Fri, 09 Jan 2026 09:18:13 -0800 (PST)
Date: Fri,  9 Jan 2026 17:18:02 +0000
In-Reply-To: <20260109171805.901995-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260109171805.901995-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260109171805.901995-2-smostafa@google.com>
Subject: [PATCH v6 1/4] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Mostafa Saleh <smostafa@google.com>, "David Hildenbrand (Red Hat)" <david@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
page_ext.

This config will be used by the IOMMU API to track pages mapped in
the IOMMU to catch drivers trying to free kernel memory that they
still map in their domains, causing all types of memory corruption.

This behaviour is disabled by default and can be enabled using
kernel cmdline iommu.debug_pagealloc.

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++++++
 drivers/iommu/Kconfig                         | 19 +++++++++++
 drivers/iommu/Makefile                        |  1 +
 drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++++
 include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
 mm/page_ext.c                                 |  4 +++
 6 files changed, 82 insertions(+)
 create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
 create mode 100644 include/linux/iommu-debug-pagealloc.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a8d0afde7f85..d484d9d8d0a4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2675,6 +2675,15 @@ Kernel parameters
 			1 - Bypass the IOMMU for DMA.
 			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
 
+	iommu.debug_pagealloc=
+			[KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is set, this
+			parameter enables the feature at boot time. By default, it
+			is disabled and the system behaves the same way as a kernel
+			built without CONFIG_IOMMU_DEBUG_PAGEALLOC.
+			Format: { "0" | "1" }
+			0 - Sanitizer disabled.
+			1 - Sanitizer enabled, expect runtime overhead.
+
 	io7=		[HW] IO7 for Marvel-based Alpha systems
 			See comment before marvel_specify_io7 in
 			arch/alpha/kernel/core_marvel.c.
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 99095645134f..f86262b11416 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -384,6 +384,25 @@ config SPRD_IOMMU
 
 	  Say Y here if you want to use the multimedia devices listed above.
 
+config IOMMU_DEBUG_PAGEALLOC
+	bool "Debug IOMMU mappings against page allocations"
+	depends on DEBUG_PAGEALLOC && IOMMU_API && PAGE_EXTENSION
+	help
+	  This enables a consistency check between the kernel page allocator and
+	  the IOMMU subsystem. It verifies that pages being allocated or freed
+	  are not currently mapped in any IOMMU domain.
+
+	  This helps detect DMA use-after-free bugs where a driver frees a page
+	  but forgets to unmap it from the IOMMU, potentially allowing a device
+	  to overwrite memory that the kernel has repurposed.
+
+	  These checks are best-effort and may not detect all problems.
+
+	  Due to performance overhead, this feature is disabled by default.
+	  You must enable "iommu.debug_pagealloc" from the kernel command
+	  line to activate the runtime checks.
+
+	  If unsure, say N.
 endif # IOMMU_SUPPORT
 
 source "drivers/iommu/generic_pt/Kconfig"
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 8e8843316c4b..0275821f4ef9 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) += apple-dart.o
+obj-$(CONFIG_IOMMU_DEBUG_PAGEALLOC) += iommu-debug-pagealloc.o
diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
new file mode 100644
index 000000000000..4022e9af7f27
--- /dev/null
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 - Google Inc
+ * Author: Mostafa Saleh <smostafa@google.com>
+ * IOMMU API debug page alloc sanitizer
+ */
+#include <linux/atomic.h>
+#include <linux/iommu-debug-pagealloc.h>
+#include <linux/kernel.h>
+#include <linux/page_ext.h>
+
+static bool needed;
+
+struct iommu_debug_metadata {
+	atomic_t ref;
+};
+
+static __init bool need_iommu_debug(void)
+{
+	return needed;
+}
+
+struct page_ext_operations page_iommu_debug_ops = {
+	.size = sizeof(struct iommu_debug_metadata),
+	.need = need_iommu_debug,
+};
+
+static int __init iommu_debug_pagealloc(char *str)
+{
+	return kstrtobool(str, &needed);
+}
+early_param("iommu.debug_pagealloc", iommu_debug_pagealloc);
diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
new file mode 100644
index 000000000000..83e64d70bf6c
--- /dev/null
+++ b/include/linux/iommu-debug-pagealloc.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 - Google Inc
+ * Author: Mostafa Saleh <smostafa@google.com>
+ * IOMMU API debug page alloc sanitizer
+ */
+
+#ifndef __LINUX_IOMMU_DEBUG_PAGEALLOC_H
+#define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
+
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+
+extern struct page_ext_operations page_iommu_debug_ops;
+
+#endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
+
+#endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
diff --git a/mm/page_ext.c b/mm/page_ext.c
index d7396a8970e5..297e4cd8ce90 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -11,6 +11,7 @@
 #include <linux/page_table_check.h>
 #include <linux/rcupdate.h>
 #include <linux/pgalloc_tag.h>
+#include <linux/iommu-debug-pagealloc.h>
 
 /*
  * struct page extension
@@ -89,6 +90,9 @@ static struct page_ext_operations *page_ext_ops[] __initdata = {
 #ifdef CONFIG_PAGE_TABLE_CHECK
 	&page_table_check_ops,
 #endif
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+	&page_iommu_debug_ops,
+#endif
 };
 
 unsigned long page_ext_size;
-- 
2.52.0.457.g6b5491de43-goog

