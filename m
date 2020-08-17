Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58291C433E1
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE9D20657
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FaEuVqLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE9D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ECB531FCB5;
	Mon, 17 Aug 2020 17:18:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nQhnrCWCRiCh; Mon, 17 Aug 2020 17:18:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6FB62204E7;
	Mon, 17 Aug 2020 17:18:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A201C088E;
	Mon, 17 Aug 2020 17:18:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 711E9C088E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 17:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5E91584AC5
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 17:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ziNUtpNbE-ZR for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 17:18:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 56E738484B
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 17:18:32 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id cq28so12899914edb.10
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lTOW9uwv+qYEDVJhCF9HFv11+rgtLlcjXHhKLUxB0e4=;
 b=FaEuVqLpiWC3oRQNYRXsVkoNyQ79Bgik+CvWAKBKiuXc0otw7bOK0wf8kEQ0SBAG72
 ap4YeIRA+extSGktq9dk4TKIyxb54K4kpXaaOiUIcmDCJO62P2Cjx6hcduMsCNl2moLA
 +8TWI7tDrb1vh2Nb84cNfp63rwVq3CBex+zutl3X5hXXDAh5btT/PEycnbC5sFHD71Ct
 39LGJtqkOVJ9qCCItDfZ8kTUCLA3Vt6JuxvsjjL/dSKrZwKYOI0XQhMhIf2LWt2jW1Me
 Fy4WNPLLMttopJN8Rp0BFhijMmStU1SbDaGqmLthER0+oXjoNt03Gz8AG6dsGm3vGClh
 xdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lTOW9uwv+qYEDVJhCF9HFv11+rgtLlcjXHhKLUxB0e4=;
 b=T8rQcJG6RgnmwTcu1QrYK8k43HBETMyXJOls74Ewbs7bBnISgHUUhsqwKGu6kVSabk
 GOaKUQn6zWep2LbkM3SReR4Aswqfd3fbzFl1s2QLphkhfEU4lCs9ptePgt0s2VzSUSEp
 Ql69xCf8wRbMw9GwBQ4gVEp7QYzSxf5OQ0sMIYndBl/BgtkSr0B5l8qwoSaUsfa5t7hR
 zs1z2jKGH+UlzA9uPjZVZirwPuisDKavbywCnQUDq0GbEUFooY5lF0CgB33o/ctOsr/g
 guhJEFLVo9IP+3j+FQTShb4sO4NMA34IGzy6mT3qagl9U07BI+36J9brKzejGLcj9tl0
 ELhw==
X-Gm-Message-State: AOAM532i13qY5p7l3+hvxiQCrUq8UAjyiSsoQ/J+A8gCCSuueUpGc3ea
 P3lUXQoAsYLGWGr8H4oLYf0GOrnUETg8L+G5
X-Google-Smtp-Source: ABdhPJzPAUi3fxQzzPPCjn9BQ/5f4SlQ+HhHi8PNC7nQBu+pMm8xsRshrYL+8HMdvt+Y9pfzai/+RA==
X-Received: by 2002:aa7:c395:: with SMTP id k21mr16286026edq.386.1597684710263; 
 Mon, 17 Aug 2020 10:18:30 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id lc18sm14672502ejb.29.2020.08.17.10.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 10:18:29 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH RESEND v9 02/13] iommu/ioasid: Add ioasid references
Date: Mon, 17 Aug 2020 19:15:48 +0200
Message-Id: <20200817171558.325917-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817171558.325917-1-jean-philippe@linaro.org>
References: <20200817171558.325917-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, zhengxiang9@huawei.com,
 zhangfei.gao@linaro.org, will@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Let IOASID users take references to existing ioasids with ioasid_get().
ioasid_put() drops a reference and only frees the ioasid when its
reference number is zero. It returns true if the ioasid was freed.
For drivers that don't call ioasid_get(), ioasid_put() is the same as
ioasid_free().

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/ioasid.h      | 10 ++++++++--
 drivers/iommu/intel/iommu.c |  4 ++--
 drivers/iommu/intel/svm.c   |  6 +++---
 drivers/iommu/ioasid.c      | 38 +++++++++++++++++++++++++++++++++----
 4 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 6f000d7a0ddc..e9dacd4b9f6b 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -34,7 +34,8 @@ struct ioasid_allocator_ops {
 #if IS_ENABLED(CONFIG_IOASID)
 ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 		      void *private);
-void ioasid_free(ioasid_t ioasid);
+void ioasid_get(ioasid_t ioasid);
+bool ioasid_put(ioasid_t ioasid);
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
@@ -48,10 +49,15 @@ static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 	return INVALID_IOASID;
 }
 
-static inline void ioasid_free(ioasid_t ioasid)
+static inline void ioasid_get(ioasid_t ioasid)
 {
 }
 
+static inline bool ioasid_put(ioasid_t ioasid)
+{
+	return false;
+}
+
 static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 				bool (*getter)(void *))
 {
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e9864e52b0e9..152fc2dc17e0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5149,7 +5149,7 @@ static void auxiliary_unlink_device(struct dmar_domain *domain,
 	domain->auxd_refcnt--;
 
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		ioasid_free(domain->default_pasid);
+		ioasid_put(domain->default_pasid);
 }
 
 static int aux_domain_add_dev(struct dmar_domain *domain,
@@ -5210,7 +5210,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 	spin_unlock(&iommu->lock);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		ioasid_free(domain->default_pasid);
+		ioasid_put(domain->default_pasid);
 
 	return ret;
 }
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 95c3164a2302..50897a2bd1da 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -565,7 +565,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				ioasid_free(svm->pasid);
+				ioasid_put(svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -583,7 +583,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
-			ioasid_free(svm->pasid);
+			ioasid_put(svm->pasid);
 			kfree(svm);
 			kfree(sdev);
 			goto out;
@@ -652,7 +652,7 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
-				ioasid_free(svm->pasid);
+				ioasid_put(svm->pasid);
 				if (svm->mm)
 					mmu_notifier_unregister(&svm->notifier, svm->mm);
 				list_del(&svm->list);
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 0f8dd377aada..50ee27bbd04e 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -2,7 +2,7 @@
 /*
  * I/O Address Space ID allocator. There is one global IOASID space, split into
  * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
- * free IOASIDs with ioasid_alloc and ioasid_free.
+ * free IOASIDs with ioasid_alloc and ioasid_put.
  */
 #include <linux/ioasid.h>
 #include <linux/module.h>
@@ -15,6 +15,7 @@ struct ioasid_data {
 	struct ioasid_set *set;
 	void *private;
 	struct rcu_head rcu;
+	refcount_t refs;
 };
 
 /*
@@ -314,6 +315,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 
 	data->set = set;
 	data->private = private;
+	refcount_set(&data->refs, 1);
 
 	/*
 	 * Custom allocator needs allocator data to perform platform specific
@@ -346,11 +348,34 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 EXPORT_SYMBOL_GPL(ioasid_alloc);
 
 /**
- * ioasid_free - Free an IOASID
+ * ioasid_get - obtain a reference to the IOASID
+ */
+void ioasid_get(ioasid_t ioasid)
+{
+	struct ioasid_data *ioasid_data;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+	if (ioasid_data)
+		refcount_inc(&ioasid_data->refs);
+	else
+		WARN_ON(1);
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_get);
+
+/**
+ * ioasid_put - Release a reference to an ioasid
  * @ioasid: the ID to remove
+ *
+ * Put a reference to the IOASID, free it when the number of references drops to
+ * zero.
+ *
+ * Return: %true if the IOASID was freed, %false otherwise.
  */
-void ioasid_free(ioasid_t ioasid)
+bool ioasid_put(ioasid_t ioasid)
 {
+	bool free = false;
 	struct ioasid_data *ioasid_data;
 
 	spin_lock(&ioasid_allocator_lock);
@@ -360,6 +385,10 @@ void ioasid_free(ioasid_t ioasid)
 		goto exit_unlock;
 	}
 
+	free = refcount_dec_and_test(&ioasid_data->refs);
+	if (!free)
+		goto exit_unlock;
+
 	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
 	/* Custom allocator needs additional steps to free the xa element */
 	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
@@ -369,8 +398,9 @@ void ioasid_free(ioasid_t ioasid)
 
 exit_unlock:
 	spin_unlock(&ioasid_allocator_lock);
+	return free;
 }
-EXPORT_SYMBOL_GPL(ioasid_free);
+EXPORT_SYMBOL_GPL(ioasid_put);
 
 /**
  * ioasid_find - Find IOASID data
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
