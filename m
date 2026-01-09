Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5566B366546
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979101; cv=none; b=STyEvQN+lDB9tQMm28RnDU6SWgOb/EgXF0vK9ckEeFD1Gyn02pRW4vr8YHZa03vCcMPZm2rvwGiXdpD1RAkqASKOVLmjcZZU5RmxknZatB/AW3WVEXXnvZxY/qJSV3dFbWvd/fp4cPhGfcDEz7R+9qfdwa/J70Gw8uqsJwIeMcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979101; c=relaxed/simple;
	bh=aVLtfsmeLEMhp2ORt1tnvgbLgSD0YJ90dSkoXHBqBTc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WcPayyFtPv5w8KAZPm20zWz9nHqNiUKFiVQzr0lIMUEV6puzF79jKuiEl2QwD6kIBNs7lGAGHtVzyigBz7e9xnj26YKPJfygAn+mh1XssZuS5nWcHj4ProAhezDYdzuD7ZhDGzqbgo4aqV4UBiCq/u00zOyhALtYdfo8UqgiG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uscszqvn; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uscszqvn"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so44667485e9.0
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 09:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767979094; x=1768583894; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=guvkPBegEDYZPDzaTTld5oNSHvfpDoo/mBDTxGLtjdA=;
        b=uscszqvn+3m2VCkx4EesPn+Zg/wkIFWD8eSeq53jfpZjDwVPTQxzE8C5rtECG7W+Eb
         e1djLVUkC4x3srOkfbubUlUEAzudGe1UhpIgBvb1NGXUUGwEoePJRen+xfeifkS82YFw
         xL6yikrxUoM6Z5wFz1yNDP9cTthJLlQnQUqc/lXqr4pn6mZO4MesbMCp3x/QxHQKjgFR
         a8a8g+A0HNkbTze2y0gcy2YP/fOFOEuv/vroEMj/ZTwNEEAR5pxUex/gRPx3PmCDPSF/
         89sTAngMoMPcRbteUmG3kJWaO+Xdqmntse7xg/mR3waHl035B694zVKjEVFAgj3Iqqg/
         nhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767979094; x=1768583894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guvkPBegEDYZPDzaTTld5oNSHvfpDoo/mBDTxGLtjdA=;
        b=XbNKM0jQzIAqGIpYOzmaAOFU5Qt6fRrYhTdgxYBvjCHuicNv3MtbkVV0e+lATQvDSk
         dog22Bl03sJ7+ufWwkPVbOgztHoiH6m97eOwg6qV+RfN5/WVnSvJ+NZNqvPmxqSpnfog
         rCl1hqV7S3LQn4WCCrSzl2qDn5sRIKMJLOSMZeZF/xhZL+SE6FvHrV9IwXye1dhpN8iU
         r+k9jJGZHXkToE7M0cW68NJkoDceapEPnXJusnNzmcDREYJv4KlV9oaLW22wLsw7sHTG
         6HQAUdE6SLylkOFjrt0VSIbwVy1UXtic6nhUz349ohEORXr0ZJtP0PHKbbGfyjR57bGq
         FtuA==
X-Forwarded-Encrypted: i=1; AJvYcCVa1C30fDj+T8fR0O4nW0p0S7xS3+9cus+i3YWVeytGahP10NGEmnrIlYPq9MupWiDn7wntkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YydeL8YGPl+aAdUTiEOYPOUxmqRQraYcMU3WJmryia+qaHbPNHS
	BHB0QxWMiO++rqoZY6Y4LcDeV/0DU5uoGUAkCjdA6+ezmzInXSHAhnAySiuO07UUYKWEqgA/1Bt
	r2Hn2DcM+70xUow==
X-Google-Smtp-Source: AGHT+IEBrg+YqeYEJ2M7D0lJnTSEa6qXe7po9KhFZWeBWPF3GO7tA7upEM5MN29g/F3xM/Fg51UOl4g9PnWT0Q==
X-Received: from wmgf14.prod.google.com ([2002:a05:600c:154e:b0:477:9dee:b5d5])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d19:b0:47d:5089:a476 with SMTP id 5b1f17b1804b1-47d84b386fdmr138392485e9.31.1767979094365;
 Fri, 09 Jan 2026 09:18:14 -0800 (PST)
Date: Fri,  9 Jan 2026 17:18:03 +0000
In-Reply-To: <20260109171805.901995-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260109171805.901995-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260109171805.901995-3-smostafa@google.com>
Subject: [PATCH v6 2/4] iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
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

