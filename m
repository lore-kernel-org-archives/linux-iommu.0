Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2546C1A9F87
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764014904; cv=none; b=dP0DpwhKNmT+zqoI9iPM4Utxsd5Rx6lWZ45IV7Z5VEOBMXBG2TmLMKTyIQI1DcP4E8FY0/ELbMSrnh5wHALT/std8dfZksJEXs5Ro/uLo5qV/BCg5sQfJMLfK/RrZzBffluYJ6KDAZyj92sQiYV2S50PeLBfvEEyVXqrOfssFM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764014904; c=relaxed/simple;
	bh=2qH5glu3RK4jq0FudiZEVYWMd62BIFVjJ1znk/NDeck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JeOzO2NLmLjrif7+UxkuXA0ldBm9YX7vEMUGG9El3ln40xPvkTn3jSXFcV3QSWDgc1L1UFwjLCL6TDlLVMnnXCyu8q2vZrIrx6jxMvqs0V6oivj7j07w9zHa+OVcShrZAZ4JDf0AMb6ocLYCpsNR/7XBml5vPQcjRJ4QKVRp0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y6YLp3R9; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y6YLp3R9"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42b2c8fb84fso2511967f8f.2
        for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 12:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764014899; x=1764619699; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngu03ozlByRiFoMKVX4H/wPPA/ikA9JmIOYfKZmpaLQ=;
        b=y6YLp3R9NO5Sh+MWSaJ2+xzaVoTPw9ejTrtMf1v9PeD3qBM5nQXpBhfC6PvyYvq8JW
         TdGvs1gWjxcGaHaXO69WAFCJ0k1Tsz5hUe0o3FP2AhmYhtBz15DUCsIeTDhKrJkwlk6+
         slLNlLYcy+oSjoksRN21RBWEuYRyP9zHZF6WaUqS1i8ilcKiJayZ63fXTz3Ep/mXwurn
         bDJe3JeCEwjkX4cTF2GKQlQdjYS4sv4eN9F5f6kkpDhOLWNaYTBn+fmgN5hMIzvlEp8g
         lU9MszssW1N8J6aHGCr9F4XX9laU5MrPm0/qBPw1rK8L2EtN8I2pdGdzTJYDeAyH63HK
         0Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764014899; x=1764619699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ngu03ozlByRiFoMKVX4H/wPPA/ikA9JmIOYfKZmpaLQ=;
        b=SJy/c3VxFNDFpC8vEUM0nTh4KEpgSIlIXuH9jhze4HswoVlCbNPcpzZiNcrgvh1hbA
         5AjnXkrM8ZeVyTyw2CO1uBSGM7t3FA3rnHHTH1Eix1Q3BW3jiJF6bydkVWPFQurZAiqZ
         bgV28P0sN8lOA6reAd0ve80/919dPvseE5sKEMErM/wvTz993SjRB1ExKuYxs6r6wYVe
         wTVbpKfPa6otc2qaol6TOlmLMO6G2rDqYSbQli/TpZuJcapx5MS3tTG7Eb7qz1Ky8V2T
         ry0wic5+r4t6SUJeGeONNAJeHstr0vGCsMoGO5YjwzHbY05XmcotPi4UztaaJZL342k0
         4emw==
X-Forwarded-Encrypted: i=1; AJvYcCUCsmVcbtrO+/6nDFj0iS/OyjhqbIMjWN5bDnuMGKnxVogFMoH8n9t9WHiEVwkfF9izSNIBow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd/94FOCnd0X149mBvwhvSteOmMuIlTqf4dgZWCyJVLot5zSf1
	yhJ7NFN0EzfpglgXTiAXENZk1qCKtX0skwh7qFQC2Cvt9Q0iMTORiQjKkGUO23LtOAhew4jDwrA
	YWgjdUwxL8UKQUQ==
X-Google-Smtp-Source: AGHT+IECVEpnx2vzM6OsM8NmV1jTz+svgzK08aynDQT0IzGD5OgDIXmVO/7cpeDrwW2l1WNEm+YJw4E2NM/CVg==
X-Received: from wrqo3.prod.google.com ([2002:a5d:4a83:0:b0:42c:c2d6:28a])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:3106:b0:429:cc1c:c2e with SMTP id ffacd0b85a97d-42e0f1e3499mr164660f8f.1.1764014899687;
 Mon, 24 Nov 2025 12:08:19 -0800 (PST)
Date: Mon, 24 Nov 2025 20:08:09 +0000
In-Reply-To: <20251124200811.2942432-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251124200811.2942432-1-smostafa@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124200811.2942432-3-smostafa@google.com>
Subject: [PATCH v3 2/4] drivers/iommu: Add calls for IOMMU_DEBUG_PAGEALLOC
From: Mostafa Saleh <smostafa@google.com>
To: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: corbet@lwn.net, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	xiaqinxin@huawei.com, Mostafa Saleh <smostafa@google.com>
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

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/iommu-debug-pagealloc.c | 26 +++++++++++++
 drivers/iommu/iommu.c                 | 12 +++++-
 include/linux/iommu-debug-pagealloc.h | 56 +++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu-debug-pagealloc.c b/drivers/iommu/iommu-debug-pagealloc.c
index 4022e9af7f27..5665fd7360e0 100644
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
 
 struct iommu_debug_metadata {
 	atomic_t ref;
@@ -25,6 +27,30 @@ struct page_ext_operations page_iommu_debug_ops = {
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
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 59244c744eab..4d1dc321e400 100644
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
 
+	iommu_debug_unmap_begin(domain, iova, size);
+
 	/*
 	 * Keep iterating until we either unmap 'size' bytes (or more)
 	 * or we hit an area that isn't mapped.
@@ -2629,6 +2636,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	}
 
 	trace_unmap(orig_iova, size, unmapped);
+	iommu_debug_unmap_end(domain, orig_iova, size, unmapped);
 	return unmapped;
 }
 
diff --git a/include/linux/iommu-debug-pagealloc.h b/include/linux/iommu-debug-pagealloc.h
index 83e64d70bf6c..454303ec09c2 100644
--- a/include/linux/iommu-debug-pagealloc.h
+++ b/include/linux/iommu-debug-pagealloc.h
@@ -8,10 +8,66 @@
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
 #endif /* CONFIG_IOMMU_DEBUG_PAGEALLOC */
 
 #endif /* __LINUX_IOMMU_DEBUG_PAGEALLOC_H */
-- 
2.52.0.460.gd25c4c69ec-goog

