Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF06C433E4
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 15:05:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BCD4207BB
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 15:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lk0/XPlr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCD4207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1F51486931;
	Thu, 23 Jul 2020 15:05:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 40JEd65WoQTM; Thu, 23 Jul 2020 15:05:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D5228655C;
	Thu, 23 Jul 2020 15:05:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69E44C004E;
	Thu, 23 Jul 2020 15:05:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50333C004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4C8D689288
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pPwpBaVBCqcV for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 15:05:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4D7C389283
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 15:05:50 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id y10so6779871eje.1
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BfF5mSAeuK6GNmSG6ImiNv8aoTdn7LDUcDTf16UYC0A=;
 b=lk0/XPlr3PKH7Nk45lh8t2O9OdaaB5Zyoq21/6dI6m+zIRUsrXGTfwSmWGrpB6jORX
 RINvO4lyWUN/KGKSRedd4/iFaUMCWxDTfer4DjbZKZolSoCyJT44faUl0fs/g4/GTdua
 ODfq0kthEqQAheIDweOUZeH1LvVNn1yxtGE58sXbMequIAS0w2S5noRx2rlct5jT+Qbo
 M+i1YKkSFHs+Xg0O/4AEkwIGZemKhN7MOw2J/xvrc+k5tgyCdZn4mi339uUUVfOvvUmd
 hnA0dbm23sVasKVoiGgwVI+4cnEo3pIjTWILskSYxzyxQXxvhWUY5XGWGI0OvtTgsbtT
 n8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BfF5mSAeuK6GNmSG6ImiNv8aoTdn7LDUcDTf16UYC0A=;
 b=a4fPCl8Y/TYgsYBmzG9Qfn4sC4avlABh6bM19AACWSlfBrusgzWtbqQ45UTLNyi5y+
 EIv8qjfEhVYaqV0utXiqOggP9SYaoMPIYJSY1nkm87DygVoCad46uRFKdlLgitE8xYLe
 MlRzo6xGotb7GlFAXKuYf51zEmCwBZFrnRCX4pkbPjJ6ArQ6iIj1ssNkC2UWSsHFwv1c
 GzNr2TMEckW86Jk8K/M5vArwrQxyq/5C5F8mimgWkwJD/GlZpghVwojhNbsR4MX4Ry78
 xnUpin937Yja+8ZR/kpkw0R520TX1qVhtxN04/iOWQMC4YAXYqwBhQ9wi9NQ3YCEjP+E
 9tzQ==
X-Gm-Message-State: AOAM531IiGcVf/atjuDp+gYnQNdaWW8zuZXR8SrhtfPHoqR9Rbv6BJEd
 oMTyoa4xuhmu0Fr4a7J37wdIN8PJYxk=
X-Google-Smtp-Source: ABdhPJztenR5csLNhM439x8AXYy3fLBVtK93JFVn5FR0Q2kR3j3ecwgQY1A1tchoy6d2cKjeBZZUsQ==
X-Received: by 2002:a17:906:2616:: with SMTP id
 h22mr4748563ejc.154.1595516748393; 
 Thu, 23 Jul 2020 08:05:48 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id k15sm2145952eji.49.2020.07.23.08.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 08:05:47 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v9 02/13] iommu/ioasid: Add ioasid references
Date: Thu, 23 Jul 2020 16:57:14 +0200
Message-Id: <20200723145724.3014766-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723145724.3014766-1-jean-philippe@linaro.org>
References: <20200723145724.3014766-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, hch@infradead.org,
 zhengxiang9@huawei.com, zhangfei.gao@linaro.org, will@kernel.org
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
index d759e7234e98..fd7a65d4f091 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5139,7 +5139,7 @@ static void auxiliary_unlink_device(struct dmar_domain *domain,
 	domain->auxd_refcnt--;
 
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		ioasid_free(domain->default_pasid);
+		ioasid_put(domain->default_pasid);
 }
 
 static int aux_domain_add_dev(struct dmar_domain *domain,
@@ -5201,7 +5201,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 	spin_unlock(&iommu->lock);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		ioasid_free(domain->default_pasid);
+		ioasid_put(domain->default_pasid);
 
 	return ret;
 }
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 6c87c807a0ab..b078a697c42e 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -546,7 +546,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 		if (mm) {
 			ret = mmu_notifier_register(&svm->notifier, mm);
 			if (ret) {
-				ioasid_free(svm->pasid);
+				ioasid_put(svm->pasid);
 				kfree(svm);
 				kfree(sdev);
 				goto out;
@@ -564,7 +564,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 		if (ret) {
 			if (mm)
 				mmu_notifier_unregister(&svm->notifier, mm);
-			ioasid_free(svm->pasid);
+			ioasid_put(svm->pasid);
 			kfree(svm);
 			kfree(sdev);
 			goto out;
@@ -639,7 +639,7 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
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
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
