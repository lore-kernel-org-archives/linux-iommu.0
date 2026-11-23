Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409397;
	b=rAKiRnx4qbcsWT2k6v0lFhRhhd6YWezHjX6S9VYXJv3K4WOL9Uv7g0MaUA18LC9aw/Mb
	 JjDVMPoaza4e8TpdRSCVMk3atLEreMaEUpCC+nXFtIrVySV8x5IC7HfLqJpXTktiU8T5j
	 AaHIt7KaikfVJ24bHDD8lWweCG0AYcgN/NoulCI6UOVq1xLOIOA0iXh1qlZdejbNaKeT1
	 kJr82HuQykCcPwzzanYCuFs7Ua6yV2LpK1Df3DJnMqdLMmgS5S5GeL6FCosJntRAgQG9V
	 W5Pk3jlVHpAf3woxZe7EBu0RJPkoP8j+7EMQvRsC5PnvdkX36nS0udUsjbwh1+NdwCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Z8BQO3KrgykwRtgGi0Q1dGoj+G3A1sp7JKxsrHaGsP4=;
	b=q5Ju5uUnf8Qd7iaQYjisCJqSILCiyDeGWHvhNiTdCFa+G1+hPw2iKYS7ulNh/oX7Gkxj
	 FtuHEdQxLioFESGx2a1kv/BOPVeqqUinrpKxxYr6XEort8Y12Nz0gzxyi4IqoCKwLdhhu
	 zEEQm2iygw4tfRc+BM+L0buil+YNLWAY8HJy7fp4e9E5knRl+MrUgObQeS1tI7qWT+Fcz
	 GF6gj6UKm34DG41pdnRyQw7f1HjT6+W36BzpTRSIabNISxlUO15mZ72Wd8a8zctqLOiWU
	 CxI9fKQBPwaivzmVm3j3Wj0Q7Mp/jBRTfNa8YvmtiGlKHyTzdgMySqekF0dg6hPqloA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oO5JsaBt;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F24A606A6A7
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 04:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F24A606A6A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oO5JsaBt
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2f04004edf1so20041945ad.3
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 20:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409396; x=1796014196; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8BQO3KrgykwRtgGi0Q1dGoj+G3A1sp7JKxsrHaGsP4=;
        b=oO5JsaBthMt9lDJQ2PBol2c2Gs0u6w15r89FxvBnbbuSatJ9cik08l6ZPwjQYx1LuV
         +2hqAr55DqbqPphoIYwRkjU38q23Hjos362CMyLDaEEDRF1BJ3A1aaODepGmTg+2YDMz
         K9WUXyqYdtIiMh4LYnBE483EL99iT0JSEWVT6MCsYZ35lQQycdwBD1m/kI317mkABM1I
         VrR38PohHQigCqOgKlaeRR2oNeloWUxYUkgZiBfbk0d9vw6LieQS3RDOZnbzp+unuAMO
         1Mjq2KyVcQeWG33XNdloZ7ikF6EqERGVkfEI4ZI4upujtQwA2xG0uh871SLILJjVBHTH
         QZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409396; x=1796014196;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8BQO3KrgykwRtgGi0Q1dGoj+G3A1sp7JKxsrHaGsP4=;
        b=qYaS3cH9ZSjzzeu6t7UlqstVBuy562UY2QTNdsi7650+7gCOJeKoyeKA5kBnp1Dpkj
         652jH9lbA5vKhOwTmXL87Ypzv5kD82Zn/KUuY5+xOgvx1e1LHH8rQJZ79NdCQVd4z3Zc
         zeiVk9SpHuk4tbpN50hNyA/stnstiMQ2StBnF2MX979gqmCIjLADdlW5TqdZXAAWzW/l
         5Jz/iaM9h5dsYt7/3loo6D/4YZmwxTgu9knq3yfaXyDmcgWovX58CZyjX5djHnfZCi3V
         XzZriHoVgpS1b40ghmPkd7qcDIoAiJGeT9IPsX/Q8sZui053NIhXN4tJ2gsOJXjaUC9l
         HEYA==
X-Forwarded-Encrypted: i=1; AL+hErHmDLpTBEiLXUNFqfsCyfVc/qZjjz47XjypW7f2riVMvmRZxkeZ4i/g9QbAfOF2qxb3BUxaYQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+sd4a+qdDJRp7dYSNPEIkDOjq7qITRgDCFv215B3L0oWoGj6e1
	sL9kRW7Jbq034Cr+TLb4YUN28wVIj46olyNlG2cxRwnIKzbG1BquRHEReqPf5amU5zvHpnk1rgR
	+/YYPUUtyubNDzQ==
X-Received: from pla14.prod.google.com ([2002:a17:902:ffce:b0:2e8:44b9:5c18])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:24b:b0:2e9:9bac:2e90 with SMTP id d9443c01a7336-2f03f1aa1d0mr89749225ad.65.1795409395769;
 Sun, 22 Nov 2026 20:49:55 -0800 (PST)
Date: Mon, 23 Nov 2026 04:49:36 +0000
In-Reply-To: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261123044949.3610702-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261123044949.3610702-6-skhawaja@google.com>
Subject: [PATCH v8 05/18] iommu: Implement IOMMU domain preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Content-Type: text/plain; charset="UTF-8"

Add IOMMU domain preserve and unpreserve APIs that can be used to
preserve an IOMMU domain across liveupdate. These APIs use the iommupt
preserve and unpreserve ops of the domain to perform the respective live
update operations.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/liveupdate.c       | 119 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  11 +++
 include/linux/iommu.h            |   5 ++
 3 files changed, 135 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index a1f40e242d93..a98f16d11727 100644
--- a/drivers/iommu/liveupdate.c
+++ b/drivers/iommu/liveupdate.c
@@ -37,6 +37,7 @@
 #define pr_fmt(fmt)    "iommu: liveupdate: " fmt
 
 #include <linux/errno.h>
+#include <linux/generic_pt/iommu.h>
 #include <linux/iommu-liveupdate.h>
 #include <linux/iommu.h>
 #include <linux/kexec_handover.h>
@@ -67,6 +68,35 @@ struct iommu_flb_obj {
 	struct iommu_ser_set device_set;
 };
 
+/*
+ * Reserve a new serialized object at the end of the set. The deleted objects
+ * are not reused, so the objects never move and can be referenced by their
+ * physical address.
+ */
+static void *iommu_ser_set_alloc(struct iommu_ser_set *set)
+{
+	struct iommu_hdr_ser *hdr;
+	int ret;
+
+	ret = kho_block_set_grow(&set->bs, set->count + 1);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (!set->count)
+		kho_block_set_it_init(&set->it, &set->bs);
+
+	hdr = kho_block_set_it_reserve_entry(&set->it);
+	if (WARN_ON_ONCE(!hdr))
+		return ERR_PTR(-ENOSPC);
+
+	set->count++;
+	*set->head_pa = kho_block_set_head_pa(&set->bs);
+
+	hdr->ref_count = 1;
+	hdr->size = set->bs.entry_size;
+	return hdr;
+}
+
 /*
  * Restore a set of serialized objects from the previous kernel. The objects
  * are read using the size recorded by the previous kernel in their header.
@@ -239,3 +269,92 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
 	liveupdate_unregister_flb(handler, &iommu_flb);
 }
 EXPORT_SYMBOL_GPL(iommu_liveupdate_unregister_flb);
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
+	if (domain->domain_ser) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	domain_ser = iommu_ser_set_alloc(&flb_obj->domain_set);
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
+	domain->domain_ser = domain_ser;
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
+	if (!domain->domain_ser)
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
+	domain_ser = domain->domain_ser;
+	pt->ops->unpreserve(pt, domain_ser);
+	domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
+	domain->domain_ser = NULL;
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
index ef5043752a36..77f78c88c627 100644
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
+	struct iommu_domain_ser *domain_ser;
+#endif
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
-- 
2.56.1.809.ga0b61035b5-goog

