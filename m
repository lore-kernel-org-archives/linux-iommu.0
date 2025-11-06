Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C14832E6AD
	for <iommu@lists.linux.dev>; Thu,  6 Nov 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447214; cv=none; b=OjRjJ9uIfUGHRmzYC2ZCZLODAk+2ZMtLxMC3bkco7KTOlJNq8UqyYazxotQAkufkKBlSf+JAU1xXMgRTlP8RNCAKfPkTpNmJj9FK5DpU12en0833ByxdOQE43cXb5EUAG/aCEgrFgZ/UIwpZG4L0T51PdT7Of9/ly6syQiwDcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447214; c=relaxed/simple;
	bh=NQFUpooTxwel5bKTK83SG1NYi4wOT9pFGjG9pCWdTI4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aQK0kaeoGOl3VpJwf7KV67Sif1BO9CQuImimi05N9ksnAhpanCLA0gJ9kV01g9wUM9thi6WrFvzdbFD00lwcvcngT/hdllynOkFISBkNfAuYOToHGzXfVtYytKyEFsvzOEA/lQp1kOFvqlhxDYCJ0dmnHP5NDagDVx0U3jGXHUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ec7cMMvg; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ec7cMMvg"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so10449485e9.0
        for <iommu@lists.linux.dev>; Thu, 06 Nov 2025 08:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762447210; x=1763052010; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSiZ7a1SAJCcKkBVDBEHEQqlSOfVk/u+1v4U8UB7ILg=;
        b=ec7cMMvgMTLTf//1BKazpLaJ2w6Fu6nTgcptKhS/n5zQVYRegQ3p1p9FZxAVJOsYyV
         XuMBKespMaYVk5lSucWK89jPH2MrfmqEdJarZuhWBhlXwDaToJdwKyuyYCJqMgh2FBb8
         q5rNi0FIJKeMqskx7brP9GCY2AOr4x8Nkh7c3y0oLyodsDgU8EB82XiAO6K7N7f4YTUn
         Mjzu6uOpgAjDuxWxDBPqu6UtVExkcZ3nteYUOo0OUzbo1R39EbVChcJhCWAH2EoEdwfD
         mTfJDbkK6KBbA/PisVV4jHJj0TYw5Dlt+x1OOy8tk8LAVeIhynhzf5XWCU147qwJdyYJ
         Hr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447211; x=1763052011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSiZ7a1SAJCcKkBVDBEHEQqlSOfVk/u+1v4U8UB7ILg=;
        b=RX79YJpHk02ZIImXnssHi9o0Rv+ciNcoL3dRMeFSuIBNkfdR7gzKODyDogjuxwxXcg
         R0rq8QF3jKJ1kOKJAV3scqS9cqqfgQL70DeVX3l3gW7H/JozWAa5B4l3gFdDUJ9e8DQ6
         y83jRy8Io51hzlKIzytHLoMhAVF9P25Vp68WcT8SAAiPxfKO9bQ0gyb7KbAEHQsyyOFF
         L9I4R7VPBWj4IA8+K+4gp14OwfRxKUTim6C9GRVvQxjTeSryqpc1hIhHySoICl0vq+SL
         qAqLdq1h94/or97s/+UxsV2BaSQWLJ8D6MczmdyooJ8IRv4bZ73hk2b+1JWb8c80mZpg
         n3AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv6Xe1ZoGVFvIrKVPeeCT1sW2sPzUv6skzlZOAs/mDMySa83CuJR1pzfXJGx3vDNbXnSH8pA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzG6tvqT4dEM2FDmI2ZgbvNbotTKoRBO8Ihf8A9KAglbaApGM0K
	M0AzAPxBBSS6Tj41WEZoa080umg8963X/L2B9oc3QCyf73Wt9Z6z9UrvOjVCxfVQI+bYtaIsOpS
	ESn5AvpWqzEC2BQ==
X-Google-Smtp-Source: AGHT+IEulRepKpg83hX8wGoEp36I0gmjB5yebzIOWO3BeWZ0yZNLjb0D/EtrwnuCx8tGevmN/RGY3y+bKKt1iw==
X-Received: from wmnc9.prod.google.com ([2002:a05:600c:1709:b0:477:31ea:6473])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1987:b0:471:56:6f79 with SMTP id 5b1f17b1804b1-4775ce3c5b5mr66270665e9.41.1762447210611;
 Thu, 06 Nov 2025 08:40:10 -0800 (PST)
Date: Thu,  6 Nov 2025 16:39:51 +0000
In-Reply-To: <20251106163953.1971067-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251106163953.1971067-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Message-ID: <20251106163953.1971067-3-smostafa@google.com>
Subject: [PATCH v2 2/4] drivers/iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	Mostafa Saleh <smostafa@google.com>, Qinxin Xia <xiaqinxin@huawei.com>
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
Tested-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 23 ++++++++++++
 drivers/iommu/iommu.c                 | 14 ++++++-
 include/linux/iommu-debug-pagealloc.h | 54 +++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
index 385c8bfae02b..a6a2f844b09d 100644
--- a/drivers/iommu/iommu-debug-pagealloc.c
+++ b/drivers/iommu/iommu-debug-pagealloc.c
@@ -5,11 +5,13 @@
  * IOMMU API debug page alloc sanitizer
  */
 #include <linux/atomic.h>
+#include <linux/iommu.h>
 #include <linux/iommu-debug-pagealloc.h>
 #include <linux/kernel.h>
 #include <linux/page_ext.h>
 
 static bool needed;
+DEFINE_STATIC_KEY_FALSE(iommu_debug_initialized);
 
 struct iommu_debug_metadate {
 	atomic_t ref;
@@ -25,6 +27,27 @@ struct page_ext_operations page_iommu_debug_ops = {
 	.need = need_iommu_debug,
 };
 
+void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys, size_t size)
+{
+}
+
+void __iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
+{
+}
+
+void __iommu_debug_remap(struct iommu_domain *domain, unsigned long iova, size_t size)
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
index 59244c744eab..f374ac0fdf95 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/host1x_context_bus.h>
 #include <linux/iommu.h>
+#include <linux/iommu-debug-pagealloc.h>
 #include <linux/iommufd.h>
 #include <linux/idr.h>
 #include <linux/err.h>
@@ -231,6 +232,8 @@ static int __init iommu_subsys_init(void)
 	if (!nb)
 		return -ENOMEM;
 
+	iommu_debug_init();
+
 	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
 		nb[i].notifier_call = iommu_bus_notifier;
 		bus_register_notifier(iommu_buses[i], &nb[i]);
@@ -2544,10 +2547,12 @@ int iommu_map_nosync(struct iommu_domain *domain, unsigned long iova,
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
@@ -2609,6 +2614,8 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 
 	pr_debug("unmap this: iova 0x%lx size 0x%zx\n", iova, size);
 
+	iommu_debug_unmap(domain, iova, size);
+
 	/*
 	 * Keep iterating until we either unmap 'size' bytes (or more)
 	 * or we hit an area that isn't mapped.
@@ -2628,6 +2635,9 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 		unmapped += unmapped_page;
 	}
 
+	if (unmapped < size)
+		iommu_debug_remap(domain, iova, size - unmapped);
+
 	trace_unmap(orig_iova, size, unmapped);
 	return unmapped;
 }
diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
index 83e64d70bf6c..180446d6d86f 100644
--- a/include/linux/iommu-debug-pagealloc.h
+++ b/include/linux/iommu-debug-pagealloc.h
@@ -8,10 +8,64 @@
 #ifndef __LINUX_IOMMU_DEBUG_PAGEALLOC_H
 #define __LINUX_IOMMU_DEBUG_PAGEALLOC_H
 
+struct iommu_domain;
+
 #ifdef CONFIG_IOMMU_DEBUG_PAGEALLOC
 
+DECLARE_STATIC_KEY_FALSE(iommu_debug_initialized);
+
 extern struct page_ext_operations page_iommu_debug_ops;
 
+void __iommu_debug_map(struct iommu_domain *domain, phys_addr_t phys,
+		       size_t size);
+void __iommu_debug_unmap(struct iommu_domain *domain, unsigned long iova,
+			 size_t size);
+void __iommu_debug_remap(struct iommu_domain *domain, unsigned long iova,
+			 size_t size);
+
+static inline void iommu_debug_map(struct iommu_domain *domain,
+				   phys_addr_t phys, size_t size)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_map(domain, phys, size);
+}
+
+static inline void iommu_debug_unmap(struct iommu_domain *domain,
+				     unsigned long iova, size_t size)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_unmap(domain, iova, size);
+}
+
+static inline void iommu_debug_remap(struct iommu_domain *domain,
+				     unsigned long iova, size_t size)
+{
+	if (static_branch_unlikely(&iommu_debug_initialized))
+		__iommu_debug_remap(domain, iova, size);
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
+static inline void iommu_debug_unmap(struct iommu_domain *domain,
+				     unsigned long iova, size_t size)
+{
+}
+
+static inline void iommu_debug_remap(struct iommu_domain *domain,
+				     unsigned long iova, size_t size)
+{
+}
+
+static inline void iommu_debug_init(void)
+{
+}
+
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
 
 #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
-- 
2.51.2.1026.g39e6a42477-goog

