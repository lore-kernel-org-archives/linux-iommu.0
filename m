Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6683A4F4D
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409016; cv=none; b=XjSxedIDJZwITK1g/QgVQo9effvPPNiRNHFbd/zVQrWhB8pTgs7+I2LE/5thgzMv5n+zHg9O+glz0cxDUXy/lXl2tsx6cF8XBPPBA0nTFbd4Gatz6Hnb0lng6MZdSAEuWFRBpWXQKRgkrmRBr+NWIq9A9/yZAmECvSfcEaWhpO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409016; c=relaxed/simple;
	bh=aVLtfsmeLEMhp2ORt1tnvgbLgSD0YJ90dSkoXHBqBTc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ADVtRY5sB2gGN2qmxR61qFwloGGVzsBOdoNW53Uni1AqzjL4lAVZTD+qCZ+homSe6ukLTIu0FoJmdQ3WGYjroMaAvk2ysLWPszJ6HXPRK2TO1EMTwF40BtHVVBBfFjFnc3vjiyxlI2vC+y6aoWb5iUY6oPsh2MiQUWrnkZ67IVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZzjBArR; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZzjBArR"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-64d264e09c7so10086115a12.0
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 08:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768409013; x=1769013813; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=guvkPBegEDYZPDzaTTld5oNSHvfpDoo/mBDTxGLtjdA=;
        b=RZzjBArR4bbnBGXhlgDlCghuUZXu18B38u7Fa8z+RzqtctxE4KnTzqQnU/cV7ec+2F
         D2RfSUfoSmML/qXfNpmIDR/QKsweWURrw1oNvRBF+XqeIgf1eiCvHjMb2JdeYyraCkPM
         LTOIAM/PXX/f3hcWWodjHaodNHzMOmHnDIJHm9a8kqrh5LBruDUQL5J/FLyhJy+0RjTN
         cn2fi0/AXyAq7B5G9XorwS1QLwA7rfuw0jtrvqFUhfo+t4ol+BSdUJXxiqBrmssrr+Sk
         od4XcLMzsEd/p5cebw/jvmSETTdpEzVCPbTOwdMF1C+owBK1y6mQoT7vEogEevJEiGaQ
         NY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409013; x=1769013813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guvkPBegEDYZPDzaTTld5oNSHvfpDoo/mBDTxGLtjdA=;
        b=ImAuYyhH1LLGWmXE8XLuD489D3XPW0303uYjxQF6zEEVSCp/W16AhUeaLlMNpX/3rf
         6DKhGNjMeNjQveKsq4GzyVMh8kdi5WclM+ry/UpquzzWuewuerEB5zvoP9Gji0HUadSi
         H5jvcPasPp3hqsXC7Zinw5fv/Lydlaqih0xo4uUjl9XRzIeVnYwqWwCRo2jRTqC6j7KH
         Fg9ltuwSfyElHzXZIgW4TonCSyx/8N8Aob3i4EXhCCL1zP47EGi3gLdLbDyrqfskQe2h
         zxM1VR07nru3oI484EtPye+lzpBb/Td/1suvntW/yJbJE59gXjIolB3lXT+It+1xZdrC
         gueA==
X-Forwarded-Encrypted: i=1; AJvYcCV3red7MEeDB8VzYdTJG8+niNUtN6aO/Dx2XRwGJL6v5g+aRnGayX3d1+vLzR20E73fBQKtXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaVuxXuOOpKrvGJL/DVudJQvr//3rWGdgNbsfgblhihuHeO/HX
	G9TRzZqXiQNsHkEFml3FcQ68MTSHHnplkK+CdLjQoMIGw2Z3ukqAGp2KWtqw5QtPcZ/ay8VvSsK
	Or54LMQ6gy7YtNA==
X-Received: from edrl19.prod.google.com ([2002:aa7:c3d3:0:b0:64d:3026:fea6])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:26c8:b0:649:64d3:1554 with SMTP id 4fb4d7f45d1cf-653ec125e44mr2681693a12.15.1768409013075;
 Wed, 14 Jan 2026 08:43:33 -0800 (PST)
Date: Wed, 14 Jan 2026 16:43:20 +0000
In-Reply-To: <20260114164322.787125-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260114164322.787125-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260114164322.787125-4-smostafa@google.com>
Subject: [PATCH v7 3/5] iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, baolu.lu@linux.intel.com, rdunlap@infradead.org, 
	Mostafa Saleh <smostafa@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
- iommu_debug_init: Enable the debug mode if configured by the user.
- iommu_debug_map: Track iommu pages mapped, using physical address.
- iommu_debug_unmap_begin: Track start of iommu unmap operation, with
  IOVA and size.
- iommu_debug_unmap_end: Track the end of unmap operation, passing the
  actual unmapped size versus the tracked one at unmap_begin.

We have to do the unmap_begin/end as once pages are unmapped we lose
the information of the physical address.
This is racy, but the API is racy by construction as it uses refcounts
and doesn't attempt to lock/synchronize with the IOMMU API as that will
be costly, meaning that possibility of false negative exists.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 28 +++++++++++++
 drivers/iommu/iommu-priv.h            | 58 +++++++++++++++++++++++++++
 drivers/iommu/iommu.c                 | 11 ++++-
 include/linux/iommu-debug-pagealloc.h |  1 +
 4 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
index 4022e9af7f27..1d343421da98 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -5,11 +5,15 @@
  * IOMMU API debug page alloc sanitizer
  */
 #include <linux/atomic.h>
+#include <linux/iommu.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kernel.h>
 #include <linux/page_ext.h>
 
+#include "iommu-priv.h"
+
 static bool needed;
+DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
 
 struct iommu_debug_metadata {
 	atomic_t ref;
@@ -25,6 +29,30 @@ struct page_ext_operations page_iommu_debug_ops = {
 	.need = need_iommu_debug,
 };
 
+void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
+{
+}
+
+void __iommu_debug_unmap_begin(struct iommu_domain *domain,
+			       unsigned long iova, size_t size)
+{
+}
+
+void __iommu_debug_unmap_end(struct iommu_domain *domain,
+			     unsigned long iova, size_t size,
+			     size_t unmapped)
+{
+}
+
+void iommu_debug_init(void)
+{
+	if (!needed)
+		return;
+
+	pr_info("iommu: Debugging page allocations, expect overhead or disable iommu.debug_pagealloc");
+	static_branch_enable(&iommu_debug_initialized);
+}
+
 static int __init iommu_debug_pagealloc(char *str)
 {
 	return kstrtobool(str, &needed);
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index c95394cd03a7..aaffad5854fc 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -5,6 +5,7 @@
 #define __LINUX_IOMMU_PRIV_H
 
 #include <linux/iommu.h>
+#include <linux/iommu-debug-pagealloc.h>
 #include <linux/msi.h>
 
 static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
@@ -65,4 +66,61 @@ static inline int iommufd_sw_msi(struct iommu_domain *domain,
 int iommu_replace_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid,
 			       struct iommu_attach_handle *handle);
+
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+
+void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
+		       size_t size);
+void __iommu_debug_unmap_begin(struct iommu_domain *domain,
+			       unsigned long iova, size_t size);
+void __iommu_debug_unmap_end(struct iommu_domain *domain,
+			     unsigned long iova, size_t size, size_t unmapped);
+
+static inline void iommu_debug_map(struct iommu_domain *domain,
+				   phys_addr_t phys, size_t size)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_map(domain, phys, size);
+}
+
+static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
+					   unsigned long iova, size_t size)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_unmap_begin(domain, iova, size);
+}
+
+static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
+					 unsigned long iova, size_t size,
+					 size_t unmapped)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_unmap_end(domain, iova, size, unmapped);
+}
+
+void iommu_debug_init(void);
+
+#else
+static inline void iommu_debug_map(struct iommu_domain *domain,
+				   phys_addr_t phys, size_t size)
+{
+}
+
+static inline void iommu_debug_unmap_begin(struct iommu_domain *domain,
+					   unsigned long iova, size_t size)
+{
+}
+
+static inline void iommu_debug_unmap_end(struct iommu_domain *domain,
+					 unsigned long iova, size_t size,
+					 size_t unmapped)
+{
+}
+
+static inline void iommu_debug_init(void)
+{
+}
+
+#endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
+
 #endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2ca990dfbb88..01b062575519 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -232,6 +232,8 @@ static int __init iommu_subsys_init(void)
 	if (!nb)
 		return -ENOMEM;
 
+	iommu_debug_init();
+
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
 		nb[i].notifier_call = iommu_bus_notifier;
 		bus_register_notifier(iommu_buses[i], &nb[i]);
@@ -2562,10 +2564,12 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
 	}
 
 	/* unroll mapping in case something went wrong */
-	if (ret)
+	if (ret) {
 		iommu_unmap(domain, orig_iova, orig_size - size);
-	else
+	} else {
 		trace_map(orig_iova, orig_paddr, orig_size);
+		iommu_debug_map(domain, orig_paddr, orig_size);
+	}
 
 	return ret;
 }
@@ -2627,6 +2631,8 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 
 	pr_debug("unmap this: iova 0x%lx size 0x%zx\n", iova, size);
 
+	iommu_debug_unmap_begin(domain, iova, size);
+
 	/*
 	 * Keep iterating until we either unmap 'size' bytes (or more)
 	 * or we hit an area that isn't mapped.
@@ -2647,6 +2653,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	}
 
 	trace_unmap(orig_iova, size, unmapped);
+	iommu_debug_unmap_end(domain, orig_iova, size, unmapped);
 	return unmapped;
 }
 
diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
index 83e64d70bf6c..a439d6815ca1 100644
--- a/include/linux/iommu-debug-pagealloc.h
+++ b/include/linux/iommu-debug-pagealloc.h
@@ -9,6 +9,7 @@
 #define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
 
 #ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
 
 extern struct page_ext_operations page_iommu_debug_ops;
 
-- 
2.52.0.457.g6b5491de43-goog

