Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAE82C234B
	for <iommu@lists.linux.dev>; Fri,  3 Oct 2025 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512770; cv=none; b=ORCPSN0oriC+tPyvBH6252mG8TBTy9Im6Zz/0CX88Z4CFYySHaeHKRdmv6bE9ey/IBZB0tVl3h1JEw6G4NsFoD3mFBi0mzUM6X4fpcf1OtYJ4XXf6B16JN39TQjjSCEJM4clP2glMO0UaAQNqaaj/FxMhMAS/3uKRbqgjJ/jMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512770; c=relaxed/simple;
	bh=h8HRZAYE3mjXSc5Xyx6cIjeKK3BF7I4Fd5OR1DdLMiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u2Ezh1hfxHjL0q+0JtTOffw1IM2EuXuPDl6C8u2w/Qtk1kdW7wmgeEYGmjAwpbLjSxiQ0gfYXcmB1RgLM/Di/SfGy6SACw0VbQPqCqKQbwmEsS5BegBqIE4HoFKfScjDwDWvVtIUGRwlrcLEUUTviLjTusIcMDQWKz3Ew0VKTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Axk/qpcZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Axk/qpcZ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e4fa584e7so11345445e9.0
        for <iommu@lists.linux.dev>; Fri, 03 Oct 2025 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759512767; x=1760117567; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSJf223vDYvCAejMgpz8FoiY2GVLX/OUVEV8AW8P3rE=;
        b=Axk/qpcZCDDX8NyFiTKxZckQ4UKaxunX7fD6PJxRn6jHHrzJJT4KzTJGZHn9uNeoR+
         q8U8ze6nylw8ehyh4k0O0nXMx7I1D3w1zBjD/MHFXEZXL5kqZJCtOyIe+ayZj9Oild4r
         2BBuZMGrZiUvwLQfm1GeoSqFh0bv1o8xTsXLHPm6Weo/pkI/fbdq66aH8TxxLb+skv2y
         ztI21rEQXV4xHOcybxhyl0jRsTTUew1C5IVXNb4vGLNN/YeZ9KXuYZ+5/y5vIleHhyX1
         let0S7jjInkLsCtSGJmGtF3syJU4ONzutiLfTx4L9AXBj6lwd/oWd1XB6M4q+II7npay
         oaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512767; x=1760117567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSJf223vDYvCAejMgpz8FoiY2GVLX/OUVEV8AW8P3rE=;
        b=lD5Eh2FXWbMly/BLb5D2ZjLQGtozzHNiaw8b6WfBDdIxk5dlRUoA95Dwk6s3o1OEx3
         gAweicpMIag6GmqSkkUUcWhjFpei3bB/Rqkyj7vRHPBO8HROz9Yf40+T8ZVVjA7YQ+Ts
         KVmaxmIfxmC8IIMtZBp3t8Fs4GeVfoHKql4H+2eR7OeLHFTIybnJjyepuNZuRjWj38OH
         Mm4ypWF1nxKHLg60mR+IUwSB/Dtor7GY9W6bXrwcmXF5UxKxyMHOw+Dlk/ZwHsfCfnW5
         BxuPE5eCAM0TjPXNOR1ppO5hvjazCehOhVw+NmPCIDIfaJqgbmqXm3Q69UJ9PlCPQRgl
         Lr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT1nDnB1RS3qN1sFhlhhf/YZeiu7Xmfo3XjHDT5meOoaoDkQ8VMzsLvn1BsL2MuN+BcsGpvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWGYmb3chEbYMrTQX0WEdjC6TlDsnnFfLjImTlRaT4YQdidPci
	yc+y8uFrzGgxp3azv5YwZMP5LBPX0L7K2qcvfJ03iwdbPH2QgZYkGyg0jtfCd3z9DiDKePXZc/h
	LpStH8ywSRpiSRw==
X-Google-Smtp-Source: AGHT+IEWfYLAMSMP+OGgRaTAc1dXj7/wh5+WqknFdRddjMd1FN58CkXD5Dr6K3xA5OvV0fh2LeDAOUQkcNX7zw==
X-Received: from wmna4.prod.google.com ([2002:a05:600c:684:b0:46d:6939:1b46])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:37c9:b0:46e:4341:7302 with SMTP id 5b1f17b1804b1-46e71155b8cmr26105425e9.34.1759512767276;
 Fri, 03 Oct 2025 10:32:47 -0700 (PDT)
Date: Fri,  3 Oct 2025 17:32:27 +0000
In-Reply-To: <20251003173229.1533640-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251003173229.1533640-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003173229.1533640-3-smostafa@google.com>
Subject: [RFC PATCH 2/4] drivers/iommu: Add calls for iommu debug
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add calls for the new iommu debug config IOMMU_DEBUG_PAGEALLOC:
- iommu_debug_init: Enable the debug mode if configured by the user.
- iommu_debug_map: Track iommu pages mapped, using physical address.
- iommu_debug_unmap: Track iommu pages unmapped, using IO virtual
  address.
- iommu_debug_remap: Track iommu pages, already mapped using IOVA.

We have to do the unmap/remap as once pages are unmapped we lose the
information of the physical address.
This is racy, but the API is racy by construction as it uses refcounts
and doesn't attempt to lock/synchronize with the IOMMU API as that will
be costly, meaning that possibility of false negative exists.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug.c | 23 +++++++++++++++++++++++
 drivers/iommu/iommu.c       | 21 +++++++++++++++++++--
 include/linux/iommu-debug.h |  6 ++++++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-debug.c b/drivers/iommu/iommu-debug.c
index 297a35137b38..607f1fcf2235 100644
--- a/drivers/iommu/iommu-debug.c
+++ b/drivers/iommu/iommu-debug.c
@@ -5,11 +5,13 @@
  * IOMMU API santaizers and debug
  */
 #include <linux/atomic.h>
+#include <linux/iommu.h>
 #include <linux/iommu-debug.h>
 #include <linux/kernel.h>
 #include <linux/page_ext.h>
 
 static bool needed;
+static DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
 
 struct iommu_debug_metadate {
 	atomic_t ref;
@@ -25,6 +27,27 @@ struct page_ext_operations page_iommu_debug_ops = {
 	.need = need_iommu_debug,
 };
 
+void iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
+{
+}
+
+void iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
+{
+}
+
+void iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size)
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
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 060ebe330ee1..56c89636a33c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/host1x_context_bus.h>
 #include <linux/iommu.h>
+#include <linux/iommu-debug.h>
 #include <linux/iommufd.h>
 #include <linux/idr.h>
 #include <linux/err.h>
@@ -231,6 +232,9 @@ static int __init iommu_subsys_init(void)
 	if (!nb)
 		return -ENOMEM;
 
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+	iommu_debug_init();
+#endif
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
 		nb[i].notifier_call = iommu_bus_notifier;
 		bus_register_notifier(iommu_buses[i], &nb[i]);
@@ -2518,10 +2522,14 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
 	}
 
 	/* unroll mapping in case something went wrong */
-	if (ret)
+	if (ret) {
 		iommu_unmap(domain, orig_iova, orig_size - size);
-	else
+	} else {
 		trace_map(orig_iova, orig_paddr, orig_size);
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+		iommu_debug_map(domain, orig_paddr, orig_size);
+#endif
+	}
 
 	return ret;
 }
@@ -2583,6 +2591,10 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 
 	pr_debug("unmap this: iova 0x%lx size 0x%zx\n", iova, size);
 
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+	iommu_debug_unmap(domain, iova, size);
+#endif
+
 	/*
 	 * Keep iterating until we either unmap 'size' bytes (or more)
 	 * or we hit an area that isn't mapped.
@@ -2602,6 +2614,11 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 		unmapped += unmapped_page;
 	}
 
+#ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
+	if (unmapped < size)
+		iommu_debug_remap(domain, iova, size - unmapped);
+#endif
+
 	trace_unmap(orig_iova, size, unmapped);
 	return unmapped;
 }
diff --git a/include/linux/iommu-debug.h b/include/linux/iommu-debug.h
index a9c11855c4ed..8d3ea661660f 100644
--- a/include/linux/iommu-debug.h
+++ b/include/linux/iommu-debug.h
@@ -11,6 +11,12 @@
 #ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
 
 extern struct page_ext_operations page_iommu_debug_ops;
+struct iommu_domain;
+
+void iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size);
+void iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size);
+void iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size);
+void iommu_debug_init(void);
 
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
 
-- 
2.51.0.618.g983fd99d29-goog

