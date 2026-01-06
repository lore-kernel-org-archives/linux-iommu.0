Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A922322A24
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716536; cv=none; b=V+iESrJ7jZdl9x18G1RwQE93BXKk/PFA8HWjPQV0IAX+ia5ZmhM1+YVHc6X9HYhhzmoT22MGXNEakw4S+oYvvrlMjXhurSea3KsCXEyseoVS3Da2u8x89poK/1m/DiYhR8N0kHYScFcxnYWZ+lspKtClVbennkS83jDDeBCRYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716536; c=relaxed/simple;
	bh=glbTDHGvDwFBEHnbUldbwQlqhce9y5qNPtGN/sZYCLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VzLtyKcxGyCSlMm7YPWC0hgrI/mKQptFswAIvltSarFpzC88M8k0wT7zEoXAwL1yXMZFssMTHMFQb88ArpQQbjPlteCgar2p0b15uRp1s3KdfOhbE8vmLzJeNVLz3dnNV2EkIeHxoj9G0kZ1lkMjJHF5wegwT7D2gFO0OA3gvdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfLaHSMB; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfLaHSMB"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-432488a0ce8so777709f8f.2
        for <iommu@lists.linux.dev>; Tue, 06 Jan 2026 08:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767716529; x=1768321329; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9TPIl5VuYcR9KDL0KJbwZbu6JBkLY0yTLIq8XhKmr0=;
        b=lfLaHSMBpydKkQFiJKjNdD5ou5v7MLC96uy5g+Xuzee34kMZ3TedJ7H1xcqPLapq9w
         jrV4EnhYKsl2eCdIwylTwx7+585UIPeiRZnsIWqaCp2GYBeuQVt78wURLUp4TwBm2p0V
         rVSx/iophyQISTScM0ptCs72Rkw3kxvl5ooA47SYGOU6tf77btvP/Aw3eHdY9IPP3dkX
         3O3HrULTaNlpakgnnnd+4UkMGb6kXFrrCOeEzUuKKY0VhOEgkkNgGNc6GMwGzQWM7tV5
         hjxcDq0qYF1GpqqtAoWMtVylOn0zcygXIG44XZlX7Z2vGNazyPWnlW6miDneFrop6N3/
         RCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716529; x=1768321329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9TPIl5VuYcR9KDL0KJbwZbu6JBkLY0yTLIq8XhKmr0=;
        b=D3qZDcWUwa4fMSIqmQ6ncYS1ULwf3TT3XnK86mdyGZZuGCVHUL1FHr3ZRl+p/0n0Lm
         EKOocwWmShEpMQHd40UbCTf9fZ6pgFZjCXCHuJVSzyBnTjAV8rbIio3C8xbMKGy+nYd/
         NakNI666g0Nlpkjde4CcKmPWvpWo88Ssm+JfGZVDFPKDpj2ykSzYp8enWgUXSCcAtI6s
         4NYYS/s3pGAnTviIB2x2sxCNU5UzaVHFq1tjJZUG/1s5j2xwgK6p0eJKuA5sn2z8T8Hu
         ALww3Q3SPZoE7KY703qJhi1Hc+CnCxzzDhoaCON5MGYF0Bl55UHw6BWR3DMI2OmWI+Dm
         iYHg==
X-Forwarded-Encrypted: i=1; AJvYcCUzgp4oRS0inDatpChO6PztU+fNfxJl/wEaQ87lRLbA/TtgUPj6riee/+QkP2aCg7nJvUbdsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDauRPS+10Xw0tKzxJRtVX0TIWfu4IkBUV2+dvuexo8ylt53Kd
	Nsu0YIBkhdI05V14aLo+Js9X1pK0d0ukyv8m9RqVPsKUxBH8Gn7GjyZVHFtZiihIfMu0rgzWxGN
	e/UQs++k6yksCOw==
X-Google-Smtp-Source: AGHT+IFy+i8fGxYLo74/Wl639U0q0FjjftONRR0904KN3ei1M9EQzH8E63Sfx40UzVwd8PoZyzK8Jn+ZRZaEZQ==
X-Received: from wmot12.prod.google.com ([2002:a05:600c:450c:b0:46f:b153:bfb7])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4705:b0:47d:403e:9cd5 with SMTP id 5b1f17b1804b1-47d7f06feaemr35634635e9.11.1767716529607;
 Tue, 06 Jan 2026 08:22:09 -0800 (PST)
Date: Tue,  6 Jan 2026 16:21:57 +0000
In-Reply-To: <20260106162200.2223655-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260106162200.2223655-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260106162200.2223655-2-smostafa@google.com>
Subject: [PATCH v5 1/4] iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
page_ext.

This config will be used by the IOMMU API to track pages mapped in
the IOMMU to catch drivers trying to free kernel memory that they
still map in their domains, causing all types of memory corruption.

This behaviour is disabled by default and can be enabled using
kernel cmdline iommu.debug_pagealloc.

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
2.52.0.351.gbe84eed79e-goog

