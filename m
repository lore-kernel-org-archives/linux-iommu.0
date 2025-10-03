Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0682DA76B
	for <iommu@lists.linux.dev>; Fri,  3 Oct 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512769; cv=none; b=ne+PMs5tsM80ZZDxyh1YJGZg9nZYZSdrIBjFHc8TC0X49vlViDXe9tt7oTdEioF/TpUtoksDlc21KmjnLFZtILZ/mrv25eLfcD54fVxYpW8D6MplYnZmsMTw0DlW4ljV1VjW7hb0V2oQP+sAZ7E2PA0zqB/wVsDc4lKPnQigD1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512769; c=relaxed/simple;
	bh=s/PYXakXl6KqlrcIvciX5HalUknvMXRiakKCbQm7Wo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E1xLomXTF7j4H1MWPEQAyCXeJneGFeOryQnchDQHzUUfkeRYEaYdUPPsP8DT74JTuHI8xbL1klr7QurXqF/SXgqkTjAvsZbFZRUjFeqUc4l0sE5aRuRN5beVIxoYnwZh3ltT3MVGmkcnq0LvJFSKs2qEoVW1bBbT4NewjRPVSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CEnfUD8T; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEnfUD8T"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e4d34ff05so14582145e9.2
        for <iommu@lists.linux.dev>; Fri, 03 Oct 2025 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759512766; x=1760117566; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zH+wdcZ5EVKOe0qHDw87x4CzKKpCZFkdrN8PVNJB6b4=;
        b=CEnfUD8TPROGnpHDNz3btqV8GjySRV3IZGZbqzVybBo1wbO6f9SWP/aJbwtlZtbNF2
         OioKiQTLquxEUB5D4NdDfqXdLhSRTD36z1ne2OotkXzGZrx162LRHXnwWHi3o7+/Qo/x
         Gkb6woAFL35Ut1J8m3zw21FE2auXDA5/AlrcWEkPGF4p01o81JP/TOE9LB6NAu798EsT
         /I35thoikE3l1jyHwgk5Sgl9IjMDUvC0InwD9EuhYgMYBQD+b0IouoO/EZ99IWk9ntzS
         EnxIVYng7JLVhgvN+qJRr/0pac0lD/drEqjRf6AH3fgDKS5A7R8uGT9a9CJtJS4EozfI
         S6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512766; x=1760117566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zH+wdcZ5EVKOe0qHDw87x4CzKKpCZFkdrN8PVNJB6b4=;
        b=iMUmTT6jDD3uIN0qNxRMWOsCL2DcTYMJS/QCrfZCzJyWMRP474N/hMFX4wA3mp5M5X
         2DorKJY0N8AoXngv/nhfkRpXIt+X4S96YpAxlFbohIWBeqAlhHdGcE5qHfYx9A6/SxyY
         GUOqxIeVnerhwLw8DvaJVaJixjYm+ikSZibRHhIUBagzTiSQiV07swYBOjgFN6W20eGg
         JEmOHxUNflienHy8q+0or3tmTWg3F/hfXxlPER/7yfU3lkCPJv9Fy/IKxMkZBPdTaybs
         UCnfFcX0ymBS7Fy4/W72ZGF9ZVtmo0k415JLfbBS2gaieZ+wThUb2p2smYeAcevbPxGa
         ykFw==
X-Forwarded-Encrypted: i=1; AJvYcCU41wVad8Eay+D12uCJ5dMZnnxrf4YUl6jjlAeVwgnwDGXPiIWJYqPPtahF/a4bQGh4Kaj/Aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyWzl0hYuIktW3f2U3AJOKn2f9KL/LcDCFVFbJJEMAGm9b05EvS
	qrI+ZIqvVnz1svB9je4k5xBAkRqGtBDGErn85dPhC9prpoDs8uRPG+L1ELE1dkw/6YNO8AtZ/yZ
	7xfvthYI5qMu2Uw==
X-Google-Smtp-Source: AGHT+IGYvWG9xmF2kfRie55mVv+1GfRjdSpkjQnJcV3+O9KPqIxqc19jwTdv3Ui/FR4E11nQtZ5ZDpq1J3nuCg==
X-Received: from wmbz22.prod.google.com ([2002:a05:600c:c096:b0:46e:6a75:2910])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a343:b0:459:d451:3364 with SMTP id 5b1f17b1804b1-46e71144103mr28980925e9.24.1759512766152;
 Fri, 03 Oct 2025 10:32:46 -0700 (PDT)
Date: Fri,  3 Oct 2025 17:32:26 +0000
In-Reply-To: <20251003173229.1533640-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251003173229.1533640-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003173229.1533640-2-smostafa@google.com>
Subject: [RFC PATCH 1/4] drivers/iommu: Add page_ext for IOMMU_DEBUG_PAGEALLOC
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new config IOMMU_DEBUG_PAGEALLOC, which registers new data to
page_ext.
This config will be used by the IOMMU API to track pages mapped in
the IOMMU to catch drivers trying to free kernel memory that they
still map in their domains, causing all types of memory corruption.
This behaviour is disabled by default and can be enabled using
kernel cmdline iommu.debug_pagealloc.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++
 drivers/iommu/Kconfig                         | 14 ++++++++
 drivers/iommu/Makefile                        |  1 +
 drivers/iommu/iommu-debug.c                   | 32 +++++++++++++++++++
 include/linux/iommu-debug.h                   | 17 ++++++++++
 mm/page_ext.c                                 |  4 +++
 6 files changed, 74 insertions(+)
 create mode 100644 drivers/iommu/iommu-debug.c
 create mode 100644 include/linux/iommu-debug.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 74ca438d2d6d..b2691a5527dd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2539,6 +2539,12 @@
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
index 70d29b14d851..5b40ec9b6e04 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -383,4 +383,18 @@ config SPRD_IOMMU
 
 	  Say Y here if you want to use the multimedia devices listed above.
 
+config IOMMU_DEBUG_PAGEALLOC
+	bool "Debug page memory allocations against IOMMU"
+	depends on DEBUG_PAGEALLOC && IOMMU_API && PAGE_EXTENSION
+	help
+		This config checks when a page is freed by the kernel
+		it's not mapped in any IOMMU domain. It can help with
+		debugging use-after-free from driver doing DMA.
+		This santaizer can have false-negative cases where some
+		problems won't be detected.
+		Expect overhead when enabling this + enabling the kernel
+		command line iommu.debug_pagealloc.
+
+		If unsure, say N here.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 355294fa9033..c834d3f70dfc 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) += apple-dart.o
+obj-$(CONFIG_IOMMU_DEBUG_PAGEALLOC) += iommu-debug.o
\ No newline at end of file
diff --git a/drivers/iommu/iommu-debug.c b/drivers/iommu/iommu-debug.c
new file mode 100644
index 000000000000..297a35137b38
--- /dev/null
+++ b/drivers/iommu/iommu-debug.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 - Google Inc
+ * Author: Mostafa Saleh <smostafa@google.com>
+ * IOMMU API santaizers and debug
+ */
+#include <linux/atomic.h>
+#include <linux/iommu-debug.h>
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
diff --git a/include/linux/iommu-debug.h b/include/linux/iommu-debug.h
new file mode 100644
index 000000000000..a9c11855c4ed
--- /dev/null
+++ b/include/linux/iommu-debug.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 - Google Inc
+ * Author: Mostafa Saleh <smostafa@google.com>
+ * IOMMU API santaizers and debug
+ */
+
+#ifndef __LINUX_IOMMU_DEBUG_H
+#define __LINUX_IOMMU_DEBUG_H
+
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+
+extern struct page_ext_operations page_iommu_debug_ops;
+
+#endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
+
+#endif /* __LINUX_IOMMU_DEBUG_H */
diff --git a/mm/page_ext.c b/mm/page_ext.c
index d7396a8970e5..37c764a55a0f 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -11,6 +11,7 @@
 #include <linux/page_table_check.h>
 #include <linux/rcupdate.h>
 #include <linux/pgalloc_tag.h>
+#include <linux/iommu-debug.h>
 
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
2.51.0.618.g983fd99d29-goog

