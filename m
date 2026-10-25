Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894781;
	b=Op1Q3w3x1Q5yM4Wi7woOFPAcWmSw1/zUg3bdN3JEKryX6tsi6jgeMNR8OHIfe5qtesZR
	 d8/yW/CoVYZg8+UFTHNWbDyApleQEyCRGmfQ/hbE9ECdc722ymkqYAcB1jf6ekSAbmMNx
	 fQw7FBp093KqGs14khvP4HAnDVPgasB7LRReQF+Jnyw7lCR8LGvsjlve3q483+iORD/Om
	 6n1koyfQsISz+ssaGgRGCon18DgorUhW7O07+5mQwwfnJ2TgFt5W+AYX/QvIVabeUdd1g
	 /UjqiUmuA4QKwO6I5e6CeBTmGGwAO2nAEgBmuxEWYfnAWiUdDAeuq1DKv4je+5UzTGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+2Os6yiEPKdQRtk/lj/KD93xvCJ6S77nrEmN+NnidqE=;
	b=x4iU6Y0omy7hxkZ9wmACtYZuNtLPg09jZ+XEGk4cjrQtaeocpBy464Zj1Xs/aEjDmnRh
	 l+6J4n9eyFJdY+l8rfnDQCMS/tHZN+VJjGM39rJzSAlZvYnXfMk49bTWOCncS4V00fRKY
	 PL6oQ7QBDxPLwxwD55ukfHstZSr/v7S/PSIRhokM5i3du4XXL+pSlBzSXP1dF9O6P4IxJ
	 JbyLk1BhI1BbluvPos6w+MJKuZiY4GJU2TO3nd2DZLZ/AIQT3DOkisjIrYsjrjKqR0+tv
	 PmQ7wT0bhFRmxzNil+hR52eIHMbQer1gOnjVVDBno0YLVy150F0EORdQtuXWiUhuapw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rwxYxAlC;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B660A263E
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 02:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B8B660A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rwxYxAlC
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ada6ccd402so1746694a91.2
        for <iommu@lists.linux.dev>; Sat, 24 Oct 2026 19:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792894780; x=1793499580; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2Os6yiEPKdQRtk/lj/KD93xvCJ6S77nrEmN+NnidqE=;
        b=rwxYxAlCoCzqXnDHfI3qg77Muvx5RnPc/BCw79l8rrOv7N16j3062ic+2u4lj5coxr
         2ogeVdQcFYwf+GVRq3L1KiCdRU80+9iMc8irqMh1eU45alTAFDiJN//fQUsNj2peCS0q
         yQXlnoBFoZ9Q/4LffemEpklZgVVk4Py8bzEJNTH0XyUuOX3upSjipf9MJytvAohc7O9y
         fLJuCOE2IqFYa0rCk7+bi47enF41Y3bNXpk/qRdhBaUPqu1s0MKwRPieqgnZWNd/N9sP
         TutzkYM+STlkf+dsWSv0QYBj4RD7PjrRLr6/LuOK4zTDaq+k+XfWK9ZfFWixXaYOlyhQ
         tDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894780; x=1793499580;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+2Os6yiEPKdQRtk/lj/KD93xvCJ6S77nrEmN+NnidqE=;
        b=XCPk2Fh8y2/NPtY+WRtiDbq22ijbh49LAgG2AQBUY+RIeSqwZ0WslLGIX/0hiwoyoJ
         EVSLC7eqDs2R/xswV+Nn7NsxxcSNACuB7A1FSPU/x7ySNEx+qBZgRwdkjJ/Fu15uNdhu
         KIqoTWX/xHygXOYSm6R3ka6coxLPqm/9KJ751TCIPqhVDBH0gxkNQ5lcWA4/H1xTGBVC
         Vk5i5YGZTpWFOLcA98V9qeeirr3Py+S3dx6gBE0ZLHqIUrHQGNTufxiOZcDqvKBwzN+Y
         lAOMMRzxCmbN4ytSUSVKMSNkeE44kQPFtFS3corLdjCHTjUUHAteOdvmDO4vjO5qcI/E
         dacA==
X-Forwarded-Encrypted: i=1; AKwUvBxzklMbOH6YLBxYwbBZx3NFh5jItDBNxA7Lt97SzUoVBXg3mQd5hm07l08XjZ09Ds8p9OokiA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIowwHJgO6qmmBWSAlxPiHhN/mDOxswjEE1zqmOGMM1Qf/Jh+6m
	EGvF07KH4AdNPjI3/sI9P8ZybYeWene0j93dQQWpI8HALKPmAgTrbzRCoANdaRlZfx4Bu8jdDG/
	sOOQ8O+Lfg//1Rg==
X-Received: from pgmd15.prod.google.com ([2002:a63:1d4f:0:b0:cd6:9a2a:632d])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e18d:b0:3a7:9045:fe29 with SMTP id 98e67ed59e1d1-3ade9b2cf0fmr2771900a91.4.1792894779501;
 Sat, 24 Oct 2026 19:19:39 -0700 (PDT)
Date: Sun, 25 Oct 2026 02:19:15 +0000
In-Reply-To: <20261025021930.674647-1-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261025021930.674647-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261025021930.674647-5-skhawaja@google.com>
Subject: [PATCH v6 04/18] iommu: Implement IOMMU domain preservation
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

Add IOMMU domain ops that can be implemented by the IOMMU drivers if
they support IOMMU domain preservation across liveupdate. The new IOMMU
domain preserve, unpreserve and restore APIs call these ops to perform
respective live update operations.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/liveupdate.c       | 119 +++++++++++++++++++++++++++++++
 include/linux/iommu-liveupdate.h |  11 +++
 include/linux/iommu.h            |   5 ++
 3 files changed, 135 insertions(+)

diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
index c8f51acd74b2..b7eda5615189 100644
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
 EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
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
index 95e32c78dcb7..71e73c5181b5 100644
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
2.56.0.257.gf7497c7d27-goog

