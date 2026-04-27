Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E163E714D
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312603; cv=none; b=IHsB7Ka45jG+bDQjR0MmRYrd60w2gu8FzHcO0dOlHknAwEek/yR2n+7gShssw0g/hKFid8M18Htmp89fTvkj+rl0dlxF/wdOjffBsbvi19hGofgEYnjeBg+6s6XmN/1IDwYP1T4WQJehncZtuX5jskcYo5zH5N+x3amqT3Gs1ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312603; c=relaxed/simple;
	bh=q15qs6nZhSF0kHWLkOId6YAQq8sbxL05KiqiMEEnEtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ep/b/VZlCyXvnvITzv+ir2TWVUC/G5mx3IYXDarR1PZGrbk9ExdeS2ewpICHILVzuFqgOjsTsS0ZV1VfaSCUTA0XhhHnn1NMllUgtaRz5svW1m29vEea5Sh2BOIkTzIx0UIGnbaKh7WPBEm823ORpljAsh48J7i72zEa0wAAjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UoivEmay; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UoivEmay"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c709551ec08so11664344a12.3
        for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312600; x=1777917400; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=whTPzsyNUaOVj8vzDv+mIFDsNyLeuMhgBf5suOl2Xvg=;
        b=UoivEmay7lJbAiuKPJYq8ERgYhLocjbkJmJG6sIrcsGrQ+PZOi3DL2cedhZDU/+rU6
         OWGb0/XrOOp5v10SAXBKjZx9VMdtFsLqupPIy3SjLGauKTlKW4jsnd3mgkw99wvmJN1d
         WsHGDuYjeV9+Xx1HMUt/MzvyBpwbpxwuj9CPfMmgPLFxJbTct1Pp90hrPJ0JuRvrbm14
         NTJoENwhVpShw1iTZLTUeG+IswUgGBeeKEd28Os9D21FtOw9Ih1mOwFZaVDP/79LiTRI
         u9E0luqrOFy9ggb3YgT+XByidOZC26kFMpiN0DiwRoKT0soUO34BEGH/yki33WU0ODux
         RFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312600; x=1777917400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whTPzsyNUaOVj8vzDv+mIFDsNyLeuMhgBf5suOl2Xvg=;
        b=TKuU0BwWUYzyDoHRH+Mu7NEzxZK42D+myvWASNGnVP2lCxwQuScu7JJosfSj71JZyX
         go6UvcLWSyW3ChQ+ranTxxs4+0GkWPDaI+hBXQwK0b56edZ6krgJtanWarOQOJjMK9Pl
         eSX4asl45+rw9W+uC/y9MW0wD8jfXtC+AIF2woMS0k2wji7+ncK5/hZ4jhcB/H8dyKbL
         b4CK/nMPSr6h/qV47xar4D2ntHyGJ1JcT0zae4LoZW+KJcquPmWtRkhR90pDPR78wVYb
         l2AisDS8aEedZaim+hIX63LsNnhPUwW915TZD6NA7MtiG6qZd3Z7daPGzkUOwg0PlKWl
         s5Mg==
X-Forwarded-Encrypted: i=1; AFNElJ9eQoROnUYTisxDj7nWhvwHWT9p9pxRyFMZGpNNs/31xIru5L6biC8Oh2+GOhp/TcFattNu+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpJgfDhEmHFGzMCB/ql3+Q6Km2JSfZsvpZiA/I/ggEzrl8j1ep
	YDWNP9kCJ1UBPWFwUhrgw6qAFyhN7qddalPfUgEMA+2Ou3JvCWo0+g2FyewH+tjg5UX45oKtiTB
	HFLx+P4MhymYOYw==
X-Received: from pfbfm1.prod.google.com ([2002:a05:6a00:2f81:b0:82f:dd9:c650])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3403:b0:82f:7076:cf2b with SMTP id d2e1a72fcca58-834dc2abe81mr7193b3a.40.1777312600058;
 Mon, 27 Apr 2026 10:56:40 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:20 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-4-skhawaja@google.com>
Subject: [PATCH v2 03/16] iommu: Implement IOMMU domain preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

Add IOMMU domain ops that can be implemented by the IOMMU drivers if
they support IOMMU domain preservation across liveupdate. The new IOMMU
domain preserve, unpreserve and restore APIs call these ops to perform
respective live update operations.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c       | 97 ++++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h | 14 +++++
 include/linux/iommu.h            | 13 +++++
 3 files changed, 124 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index a26099b145c3..f71f14518248 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -13,6 +13,9 @@
 #include <linux/iommu.h>
 #include <linux/errno.h>
 
+#define iommu_max_objs_per_page(_array) \
+	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
+
 static void *iommu_liveupdate_restore_array(u64 array_phys)
 {
 	struct iommu_array_hdr_ser *array_hdr;
@@ -196,3 +199,97 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 	liveupdate_unregister_flb(handler, &iommu_flb);
 }
 EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
+
+static int alloc_object_ser(struct iommu_array_hdr_ser **curr_array_ptr, u64 max_objs)
+{
+	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
+	struct iommu_array_hdr_ser *next_array;
+
+	if (curr_array->nr_objects >= max_objs) {
+		next_array = kho_alloc_preserve(PAGE_SIZE);
+		if (IS_ERR(next_array))
+			return PTR_ERR(next_array);
+
+		curr_array->next_array_phys = virt_to_phys(next_array);
+		*curr_array_ptr = next_array;
+		curr_array = next_array;
+	}
+
+	return curr_array->nr_objects++;
+}
+
+static struct iommu_domain_ser *alloc_iommu_domain_ser(struct iommu_flb_obj *flb)
+{
+	int idx;
+
+	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_domain_array,
+			       iommu_max_objs_per_page(flb->curr_domain_array));
+	if (idx < 0)
+		return ERR_PTR(idx);
+
+	flb->curr_domain_array->objects[idx].hdr.ref_count = 1;
+	return &flb->curr_domain_array->objects[idx];
+}
+
+int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
+{
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_flb_obj *flb_obj;
+	int ret;
+
+	if (!domain->ops->preserve)
+		return -EOPNOTSUPP;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&flb_obj->lock);
+	domain_ser = alloc_iommu_domain_ser(flb_obj);
+	if (IS_ERR(domain_ser))
+		return PTR_ERR(domain_ser);
+
+	ret = domain->ops->preserve(domain, domain_ser);
+	if (ret) {
+		domain_ser->hdr.deleted = true;
+		return ret;
+	}
+
+	domain->preserved_state = domain_ser;
+	*ser = domain_ser;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_domain_preserve);
+
+void iommu_domain_unpreserve(struct iommu_domain *domain)
+{
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_flb_obj *flb_obj;
+	int ret;
+
+	if (!domain->ops->unpreserve)
+		return;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (WARN_ON(ret))
+		return;
+
+	guard(mutex)(&flb_obj->lock);
+
+	if (!domain->preserved_state)
+		return;
+
+	/*
+	 * There is no check for attached devices here. The correctness relies
+	 * on the Live Update Orchestrator's session lifecycle. All resources
+	 * (iommufd, vfio devices) are preserved within a single session. If the
+	 * session is torn down, the .unpreserve callbacks for all files will be
+	 * invoked, ensuring a consistent cleanup without needing explicit
+	 * refcounting for the serialized objects here.
+	 */
+	domain_ser = domain->preserved_state;
+	domain->ops->unpreserve(domain, domain_ser);
+	domain_ser->hdr.deleted = true;
+	domain->preserved_state = NULL;
+}
+EXPORT_SYMBOL_GPL(iommu_domain_unpreserve);
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 3d1c65ed76fa..6019cfc27428 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -12,6 +12,20 @@
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
+void iommu_domain_unpreserve(struct iommu_domain *domain);
+#else
+static inline int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_domain_unpreserve(struct iommu_domain *domain)
+{
+}
+#endif
+
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6f5d1dec3f89..3853a3946733 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/iova_bitmap.h>
+#include <linux/kho/abi/iommu.h>
 #include <uapi/linux/iommufd.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -249,6 +250,10 @@ struct iommu_domain {
 			struct list_head next;
 		};
 	};
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	struct iommu_domain_ser *preserved_state;
+#endif
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -752,6 +757,11 @@ struct iommu_ops {
  *                           specific mechanisms.
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @free: Release the domain after use.
+ * @preserve: Preserve the iommu domain for liveupdate.
+ *            Returns 0 on success, a negative errno on failure.
+ * @unpreserve: Unpreserve the iommu domain that was preserved earlier.
+ * @restore: Restore the iommu domain after liveupdate.
+ *           Returns 0 on success, a negative errno on failure.
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev,
@@ -782,6 +792,9 @@ struct iommu_domain_ops {
 				  unsigned long quirks);
 
 	void (*free)(struct iommu_domain *domain);
+	int (*preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
+	void (*unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
+	int (*restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
 };
 
 /**
-- 
2.54.0.545.g6539524ca2-goog

