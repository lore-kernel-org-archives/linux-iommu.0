Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4E3314CB
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447213; cv=none; b=DB/3N305i+1YFVztdbhI1aGgz0szrismhYJ9Y/w/cB011VqsKZU1A802qR6m/R67Siqt8NO/LqKaITQERqA1ql3ahdOLmgagxlRVa9YGICsBeSsKgjMT4yyDLsy1Id/9f0wW7FjMOjH55l4qlyFLP+4QIdp+xSyzt9BYrmp0Gm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447213; c=relaxed/simple;
	bh=FoAxF7xHsJFWFTyb3pXeNpXfEV9K4D055QRfjPUOidg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KbrF3LxyjgnSwXoKJK64vZEqxUYsTIWW6V9EkoK8ArdARzEBfaJDPF9MGqp6MZffmn/6ibH+0p8czu7wmE7u3Zj41SAXWD5e3TAHJaVupLY0hHa0hx4o1aVLWfjYgpABrs3pEbSmco1VlZYU38SDmuheCQY7l5EQjzxHv+Mz/vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VyaAugsC; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyaAugsC"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e39567579so5991575e9.0
        for <iommu@lists.linux.dev>; Thu, 06 Nov 2025 08:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762447209; x=1763052009; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGn9S9TG2oeGoFuSE1bVv5EDFMyzjo3ZeltmQ55DAp0=;
        b=VyaAugsCwkKFJZNEMgfBxSTkGmAVmyOFZbAUJC9ZPQZ3fNjfLSz9aMAFluE5daQ1xz
         vq5v8gdeOKKLDjdbgsS+out5ywLTcaaUnWQ7iKk1OR6igYxyAaBrvvi2jjEUIBv7bN2J
         qe5eKSIemI7BLi17g3wyb7P1guOC5X5xflAX2/RVI//pjqXxKvzGmm6G6DcT+I7DNK5Y
         utERAaTCw+v86X6dwQngOcKCYMWeUO+nrkjiTNNIIakrBXGW+QsPPJvv9ob0zcxp6Qi7
         qVYmZx0I+ND/kxCwN4tuqdWGFyNuYhyuAL24N3rPTcIFwBMDJrhntCCnQ8a4OD3Uz6Xj
         sGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447209; x=1763052009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGn9S9TG2oeGoFuSE1bVv5EDFMyzjo3ZeltmQ55DAp0=;
        b=UYVJWXDQcarYlRqHFMg4mYXf1R8sa0IpUQzqCOS/VLX+iKBcCYQ5qery29m0d2sN+s
         BbGG7p+R30NLtQBar01GBd4rtZZtWje+1LQ/fYN6+hso/fcpEj5yg07OI2+peInYWwH6
         AeULJkwIF6DiJ5ZqYZuNkA10w9g/zdYC86H4eXMxr/yJKt4j/xm5mPD/T6Rp/uD7Zg4g
         wPF8UpJfSOBikfO2ttj0YFYWlNFl/KqxTCKjX7tp0k5XGCSUjMuCqJiPaOqNPlKrS4Xa
         5n9A3PwpmLhfvK1LuXTL+Vxf+hB+L1dVtcwRS1uEYaBAUiVvav+Iv69SleZrSqRIEiXS
         LIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5qGtd/3flOU9DrIYW0Dt5i4d5124ZxTHD47eYkooKtCPhXehMuzDS7ClBSB3f05+Vd1bLAA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5oTkfZUje7AKZ8KwcdvzV+130AxKjQsOECOiZgUXYzdzny+Mm
	8JkHrgKU6VoZRsmp+4RWC1jLMJk4yw3ZgwrGY/Xy4WXKAwZn2BEVw/tNyo8HyByp+D1mtTtL+xq
	G3DEB/3iaRGoqAQ==
X-Google-Smtp-Source: AGHT+IGin0gdaVVLFPqJJbxATM/GoLhvdHY35FLM6SzMry8X5z6uv1NEwI1PHMOviV8zQ1+HDeBhnFureuyQHA==
X-Received: from wmcn19.prod.google.com ([2002:a05:600c:c0d3:b0:45f:29fc:83d])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e88:b0:46f:d897:516f with SMTP id 5b1f17b1804b1-4775ce24d3dmr93382575e9.34.1762447209641;
 Thu, 06 Nov 2025 08:40:09 -0800 (PST)
Date: Thu,  6 Nov 2025 16:39:50 +0000
In-Reply-To: <20251106163953.1971067-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251106163953.1971067-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106163953.1971067-2-smostafa@google.com>
Subject: [PATCH v2 1/4] drivers/iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>, Qinxin Xia <xiaqinxin@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
page_ext.
This config will be used by the IOMMU API to track pages mapped in
the IOMMU to catch drivers trying to free kernel memory that they
still map in their domains, causing all types of memory corruption.
This behaviour is disabled by default and can be enabled using
kernel cmdline iommu.debug_pagealloc.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++
 drivers/iommu/Kconfig                         | 15 +++++++++
 drivers/iommu/Makefile                        |  1 +
 drivers/iommu/iommu-debug-pagealloc.c         | 32 +++++++++++++++++++
 include/linux/iommu-debug-pagealloc.h         | 17 ++++++++++
 mm/page_ext.c                                 |  4 +++
 6 files changed, 75 insertions(+)
 create mode 100644 drivers/iommu/iommu-debug-pagealloc.c
 create mode 100644 include/linux/iommu-debug-pagealloc.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6c42061ca20e..9a1c4ac8ba96 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2557,6 +2557,12 @@
 			1 - Bypass the IOMMU for DMA.
 			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
 
+	iommu.debug_pagealloc=
+			[KNL,EARLY] When CONFIG_IOMMU_DEBUG_PAGEALLOC is set, this
+			parameter enables the feature at boot time. By default, it
+			is disabled and the system will work mostly the same as a
+			kernel built without CONFIG_IOMMU_DEBUG_PAGEALLOC.
+
 	io7=		[HW] IO7 for Marvel-based Alpha systems
 			See comment before marvel_specify_io7 in
 			arch/alpha/kernel/core_marvel.c.
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..6b5e9a2d936a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -383,4 +383,19 @@ config SPRD_IOMMU
 
 	  Say Y here if you want to use the multimedia devices listed above.
 
+config IOMMU_DEBUG_PAGEALLOC
+	bool "Debug page memory allocations against IOMMU"
+	depends on DEBUG_PAGEALLOC && IOMMU_API && PAGE_EXTENSION
+	help
+	  This config checks that a page is freed(unmapped) or mapped by the
+	  kernel is not mapped in any IOMMU domain. It can help with debugging
+	  use-after-free or out-of-bound maps from drivers doing DMA through
+	  the IOMMU API.
+	  This santaizer can have false-negative cases where some problems
+	  won't be detected.
+	  Expect overhead when enabling this and enabling the kernel command
+	  line iommu.debug_pagealloc.
+
+	  If unsure, say N here.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 355294fa9033..8f5130b6a671 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) += apple-dart.o
+obj-$(CONFIG_IOMMU_DEBUG_PAGEALLOC) += iommu-debug-pagealloc.o
diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
new file mode 100644
index 000000000000..385c8bfae02b
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
+struct iommu_debug_metadate {
+	atomic_t ref;
+};
+
+static __init bool need_iommu_debug(void)
+{
+	return needed;
+}
+
+struct page_ext_operations page_iommu_debug_ops = {
+	.size = sizeof(struct iommu_debug_metadate),
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
2.51.2.1026.g39e6a42477-goog

