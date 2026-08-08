Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858772C08D0
	for <iommu@lists.linux.dev>; Sat,  8 Aug 2026 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156051; cv=none; b=d9az1tna64EVrENoPWXZEPKsMYBaMYAVcUAfdqY7AmUK3fBggMcIig88i+OauZzIbkYRcLxJMxIw5scKzD7ycS4aMCJNPudby4eucgY4+GcUPLSFx+lgpognG6aBb5pAAKSJ9Gp7br6MjUEAncoWEwE/CsxL5njaE5axUnTNn68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156051; c=relaxed/simple;
	bh=fhk3tPEKYK70yHq83uGQxFERkBIfSWxRBBUyrYlU6Ng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B2xENGvh5wKalUp4pFzfukyynCo4e8Or5n7lJbiBITf19v+yy6q+rnUd9o2yGz9DKCnTA/snNtzfZ3FBz8tNKokqNKtRJfEoKKA43PYbQYJUKbS/lEK1th+o44LIvujfnar8FWqxlMd0OdUAM23mJD/NKc+0fVCl5YlrFYEtrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OO7vfgpg; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OO7vfgpg"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce8a76df2dso3841175ad.2
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 19:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156049; x=1786760849; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=28qmOMx/uK4R41ddih2a6ZaZB/4h2AxBQZFAswYH37U=;
        b=OO7vfgpgWcZQ9f4Z/ESuaBUKn7iC6/jlaxeMjJx1U3V4RAEnB6YMopONmfbUQQwD+5
         394HvqhPmPQjZ+sCe7cFPZBt0D3w4YhG/IH9ASYbfTQrsIB7F/HXIppBMVmiW9wFZtvx
         sf2xdFaEnyYnRN6utZVIbVWBJLY8U9+M+x1htTIlpjFY9mYiUcxf2I13W/SGaexl3Ktx
         BzHjK+GoJTwLW6NQ0T4tcSt8swLQDnP2Y83ADQv2F3P7+PbhOR9L4VBB3R7srMH3f6ac
         UnHqhCrEBqaepwF+Jpmeo7v5bhVqMWzY6EomPrr8N1mgHchV9J6z113sQR0GY/k1ibjO
         n3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156049; x=1786760849;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=28qmOMx/uK4R41ddih2a6ZaZB/4h2AxBQZFAswYH37U=;
        b=ca0xyHkjuBZ8wfAmW2IoI6DWi82jzG7NBVfCChO0dzNAHfW9QFGGsqX3p/GWspNz0n
         qoR1NRYD6QToExJbMqm2gB1IhNDcqjZEV79k1P8pJMEq3TbeOvNN6X5XbtmZjLNABEtt
         7BKK/T5iWIcYuPCQZLgHEOjAVwvyAHk4w5HhnNb/MhicOrkNqRY7drOGfj9iEFGUX2SF
         JiXHpyKsCJizn1oyBp/TVlTqlLnAxQ6E/nSHmhvayBJRqLVbV34sC4fOw81XY3ItYHbZ
         80RZpphl2u3CD8U3UBG/JmpzC0W1jVGqMPGiK3y5Erouef8Nz39ezVMvTyzAh/qoMVnJ
         X3HQ==
X-Forwarded-Encrypted: i=1; AHgh+RrydICe2WPU3kFIlCHbIjmxPmw3StR2LOw8lHKtzeLz3fWAbI8G1B5DBzN4W15wiGdBFCzqgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpYf8vCuKkBBfrWLqJ4TOAe179d97sx3ssm9Vfoa7gWoSKUe5z
	nIS/XPbh7RQy3+wO0WhXTp88Wu7ad7stoAHIFd6R0D7f1FExM68RXL8Qzfb43cpZwuNEep+1gJz
	jATpWWDJcGXXCEw==
X-Received: from plxj5.prod.google.com ([2002:a17:902:da85:b0:2bd:34d1:ea8])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1666:b0:2cf:c543:2c7e with SMTP id d9443c01a7336-2d0ca767b5fmr284943765ad.10.1786156048245;
 Fri, 07 Aug 2026 19:27:28 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:10 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-6-skhawaja@google.com>
Subject: [PATCH v4 05/18] iommu: Implement IOMMU domain preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add IOMMU domain ops that can be implemented by the IOMMU drivers if
they support IOMMU domain preservation across liveupdate. The new IOMMU
domain preserve, unpreserve and restore APIs call these ops to perform
respective live update operations.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c       | 128 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  11 +++
 include/linux/iommu.h            |   5 ++
 3 files changed, 144 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 803d99c0a1f2..a5131e1243e4 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -37,11 +37,15 @@
 #define pr_fmt(fmt)    "iommu: liveupdate: " fmt
 
 #include <linux/errno.h>
+#include <linux/generic_pt/iommu.h>
 #include <linux/iommu-liveupdate.h>
 #include <linux/iommu.h>
 #include <linux/kexec_handover.h>
 #include <linux/liveupdate.h>
 
+#define iommu_max_objs_per_page(_array) \
+	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
+
 struct iommu_flb_obj {
 	struct mutex lock;
 	struct iommu_flb_ser *ser;
@@ -256,3 +260,127 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 	liveupdate_unregister_flb(handler, &iommu_flb);
 }
 EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
+
+static int alloc_object_ser(void **curr_array_ptr, u64 max_objs)
+{
+	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
+	struct iommu_array_hdr_ser *next_array;
+
+	/*
+	 * The objects marked as deleted are not reused to avoid traversal of
+	 * linked-list and arrays.
+	 */
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
+	idx = alloc_object_ser((void **) &flb->curr_domain_array,
+			       iommu_max_objs_per_page(flb->curr_domain_array));
+	if (idx < 0)
+		return ERR_PTR(idx);
+
+	flb->curr_domain_array->objects[idx].hdr.ref_count = 1;
+	return &flb->curr_domain_array->objects[idx];
+}
+
+/**
+ * iommu_preserve_domain() - Preserve an IOMMU domain across live update
+ * @domain: Domain to preserve
+ * @ser: Pointer to receive the virtual serialized domain state handle
+ *
+ * Return: 0 on success, or negative error code.
+ */
+int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
+{
+	struct pt_iommu *pt = iommupt_from_domain(domain);
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_flb_obj *flb_obj;
+	int ret;
+
+	if (!pt || !pt->ops->preserve || !pt->ops->unpreserve)
+		return -EOPNOTSUPP;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (ret)
+		return ret;
+
+	mutex_lock(&flb_obj->lock);
+	if (domain->preserved_state) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	domain_ser = alloc_iommu_domain_ser(flb_obj);
+	if (IS_ERR(domain_ser)) {
+		ret = PTR_ERR(domain_ser);
+		goto out_unlock;
+	}
+
+	ret = pt->ops->preserve(pt, domain_ser);
+	if (ret) {
+		domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		goto out_unlock;
+	}
+
+	domain->preserved_state = domain_ser;
+	*ser = domain_ser;
+	ret = 0;
+out_unlock:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_outgoing(&iommu_flb);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_domain);
+
+/**
+ * iommu_unpreserve_domain() - Unpreserve a preserved IOMMU domain
+ * @domain: Domain to unpreserve
+ */
+void iommu_unpreserve_domain(struct iommu_domain *domain)
+{
+	struct pt_iommu *pt = iommupt_from_domain(domain);
+	struct iommu_domain_ser *domain_ser;
+	struct iommu_flb_obj *flb_obj;
+	int ret;
+
+	if (WARN_ON(!pt || !pt->ops->unpreserve))
+		return;
+
+	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
+	if (WARN_ON(ret))
+		return;
+
+	mutex_lock(&flb_obj->lock);
+	if (!domain->preserved_state)
+		goto out_unlock;
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
+	pt->ops->unpreserve(pt, domain_ser);
+	domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+	domain->preserved_state = NULL;
+out_unlock:
+	mutex_unlock(&flb_obj->lock);
+	liveupdate_flb_put_outgoing(&iommu_flb);
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_domain);
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 4755ab3cd67a..caa9778eee2d 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -15,6 +15,8 @@
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
+int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
+void iommu_unpreserve_domain(struct iommu_domain *domain);
 #else
 static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
 {
@@ -24,5 +26,14 @@ static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *
 static inline void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 {
 }
+
+static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_domain(struct iommu_domain *domain)
+{
+}
 #endif
 #endif /* _LINUX_IOMMU_LIVEUPDATE_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d20aa6f6863a..291f1e1227b0 100644
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
-- 
2.55.0.679.g6767b8d81c-goog

