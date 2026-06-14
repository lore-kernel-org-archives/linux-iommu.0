Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8FE3803E8
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480256; cv=none; b=U9XNvBAmedURqXWHMYTIL1EyILsWdY4I3v7Tq6WaFx7SbxRCisGTh1yiKqDHZKVcjAh+szF+dE6aJJG/5QBsnBU8I+jewOi3INyQ2SEiAysPTf2E5KnMDaAyWUdzhXzCH51L5+xyG1Qr9I2lBvT9JPAz5sckWkXpEhwxO+FTP+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480256; c=relaxed/simple;
	bh=u0j6XRiheniDrp72IFhQbCJaXglYcVebtHPVp/yVTXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=npHi0QaM1OTznilIVNimX5n2GhaZq7NV1RuVP8fzdiqd6oCzTKciTiesL+B/oBZwEdDs5kuVF5a/9COINjXiF6OT8wceylCPoE/KAalh0qlD4MzK2+iiHly1pFEqpWwrse57JIpLPylv3jeroKKEcB6jwZQCxv5D6L0/iTzEksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nx5EPLbH; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nx5EPLbH"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f424d5bso1974463b3a.3
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480254; x=1782085054; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXln37ss5Ikk8xz45fqFwD7l8OdsQwQR5jb4btzwNjQ=;
        b=nx5EPLbHgavx49cs7uS8zFH+jruK/ACJwmsvDHDge9la0SHUA6lmEzwEHYbI70YLBL
         bO1nSzywD4U3dZ2WK4SFDEs7/dp/LgCOdwzejnffX007moz+cDItN6NU9Y++r87/aMDu
         ZADGbDJtusAj4HF6DN3AraAxUl7bx1hketyAj/iYj1TaCd0L9XZTS2akSgL9tUT08CBG
         I0d+owq7w3+mx4gb4Wz2jjUDwT8nqTwAJ84vF3nO9k6cdcu+eWF+c8PsVgIfTUmP5jRs
         d/Ytl376yETq5Z9W5svRTvbTi9qbewMbx70N9qehMsmPg+FOioFVMKAuzRO1lV24tcqt
         6vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480254; x=1782085054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXln37ss5Ikk8xz45fqFwD7l8OdsQwQR5jb4btzwNjQ=;
        b=D7+t7RmiURfxYEBdprmTh8xF2ryDq6qy7/V2LTMa3KDFuQM7qTBhgtyuRPLfdEuqSL
         joeQPjnxGk2sEzx7UAuO/p74U7GbQC67Ni57Io+/wxmlOTlt3u435jkEBThsxep0fENE
         jTc+Mv2C4sG+tqhRp4LVjqlCl5zopWxo9xp89cjWbI86CMuY8roDhG5v7YAPKgZVuiGE
         YON8eIYE2+9XxOuMR5nMXucRZE9fHabIdojYwRpEhPv+F0TunOgDxmMqvXiwKqrLFxXe
         BO9OZMt+vqiPOPYeWSf+YMpUmvl9DEmAPDpmKK4D9n5vpxiSBhAM4CG8uy1rv7GdUB57
         rQlg==
X-Forwarded-Encrypted: i=1; AFNElJ9PzzBLCcOVM+9VotuQCLRFuvIbjVlU06ruLhMA/LUAimpRvmfJqK7wle8zrvUOZWbk0ctu9A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpACxrcWdnUY094r0EDlhcC2ecScqsgsYbCFcbiC/ajO4rsRKF
	C5sceR5RXr/aKB+WdDiBKvjqCTIBUoBlLgmntVpuWpz5ZyIQImg445ONsoxaViw4Y7rrGzxuhjG
	+Q7ll+C+7CSUlcg==
X-Received: from pfbkr18.prod.google.com ([2002:a05:6a00:4b52:b0:842:5944:1f82])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1256:b0:842:68d3:e29f with SMTP id d2e1a72fcca58-844e193a464mr8767666b3a.3.1781480253445;
 Sun, 14 Jun 2026 16:37:33 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:15 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-6-skhawaja@google.com>
Subject: [PATCH v3 05/18] iommu: Implement IOMMU domain preservation
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
 drivers/iommu/liveupdate.c       | 104 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  14 +++++
 include/linux/iommu.h            |   5 ++
 3 files changed, 123 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index 45fae91b43ba..16a0f75a98e3 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -8,11 +8,15 @@
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
@@ -210,3 +214,103 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
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
+	guard(mutex)(&flb_obj->lock);
+	domain_ser = alloc_iommu_domain_ser(flb_obj);
+	if (IS_ERR(domain_ser))
+		return PTR_ERR(domain_ser);
+
+	ret = pt->ops->preserve(pt, domain_ser);
+	if (ret) {
+		domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+		return ret;
+	}
+
+	domain->preserved_state = domain_ser;
+	*ser = domain_ser;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iommu_preserve_domain);
+
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
+	pt->ops->unpreserve(pt, domain_ser);
+	domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+	domain->preserved_state = NULL;
+}
+EXPORT_SYMBOL_GPL(iommu_unpreserve_domain);
diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
index 3d1c65ed76fa..0204e17996b0 100644
--- a/include/linux/iommu-liveupdate.h
+++ b/include/linux/iommu-liveupdate.h
@@ -12,6 +12,20 @@
 #include <linux/liveupdate.h>
 #include <linux/kho/abi/iommu.h>
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
+void iommu_unpreserve_domain(struct iommu_domain *domain);
+#else
+static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommu_unpreserve_domain(struct iommu_domain *domain)
+{
+}
+#endif
+
 int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
 void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e587d4ac4d33..0bea1a57f4be 100644
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
2.54.0.1136.gdb2ca164c4-goog

