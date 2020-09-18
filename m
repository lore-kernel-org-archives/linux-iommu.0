Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6540C43467
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8072420C56
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oAZ8bRmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8072420C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F906877F2;
	Fri, 18 Sep 2020 10:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cSXlquS6bgoy; Fri, 18 Sep 2020 10:20:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EBC0A877EB;
	Fri, 18 Sep 2020 10:20:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6E5CC0891;
	Fri, 18 Sep 2020 10:20:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A1B9C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 46347877E6
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:19:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t9v-cWI4zujZ for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 10:19:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4D225877E4
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:19:58 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id w1so5577103edr.3
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NnHFC5XKTpaKe9YfsMt4hjeLKauAgpUdMfzWeVe0TxU=;
 b=oAZ8bRmpVbhOgvC6E2cWJiXcfRyzpD+zA1PKoBJNY8KaGsoFTJjJGnGWY+ySFtlM/Y
 WnNiM607f/zQ4VT1Hg3jJ621ZgGNBjUqXNrh1jXc85zIea74I4GnGzZ5P3nswRA/cutA
 nMUfgN3TrABt9WxYksK7noOgtxuzhZNMa0H+MNm7BiLg118j5b0crcXYfDHwYumoJixr
 biAFi/KuBHbuAimDNcym+Irsb/LCECJBMY9sFNYDzlFLbkWGPiYeW5jdgAV326/W0AJ4
 Z5kax4Krs77/m3Ny4iQZ38aD/gUV4ei3lKmkpzYxL19KraycMBTG/OxUOYKBwQVdiAUv
 0+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NnHFC5XKTpaKe9YfsMt4hjeLKauAgpUdMfzWeVe0TxU=;
 b=iRwgZAn935McvNFe5CGEDFlk/fqAM7/85GP2j7IBTb7c/WnLJziV1ItV2wix7ugECF
 qPOBlzRYzxImFP0an9uXFQ5JbskuMz0b5zXJptKb1hpykAzkKGK40p9RcFCn8+KVxRFP
 Nryto7//ml3QRzx/tU7FW95n0jfCMBE/Jb7zvD2XN23ggDd/rA/9LPmDIZWxgP4RFulY
 XEnEB9zg6lx+9VmkoDxv3GroxUBPd7UEqPGrmhNlzOlTZ6uV05tYKQbMH6oHG1+rSWeO
 agSY+xg3qaCP1umEazusu2GBknxjgNjsuMHpQgu7Xb+NpPCmhPo+KVm9ClK31zfGO5pU
 xrBA==
X-Gm-Message-State: AOAM533kVwO3WqRtefwyv9WKd9cgA30BX2HJC9MRiEK+ic1iYq0DZ89w
 y5qwHVIXmQVqsBpynsNm7cA234iSgB5yHeco
X-Google-Smtp-Source: ABdhPJx6pc+mUrZmLwtbyYt+0tM1/1eBZpcIw19D0hcpuHrvjEsvgUzgL7NZ5n2UhlvMPp25uLYDEg==
X-Received: by 2002:a05:6402:b64:: with SMTP id
 cb4mr37728761edb.25.1600424396424; 
 Fri, 18 Sep 2020 03:19:56 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r16sm1940674edc.57.2020.09.18.03.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 03:19:55 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v10 02/13] iommu/ioasid: Add ioasid references
Date: Fri, 18 Sep 2020 12:18:42 +0200
Message-Id: <20200918101852.582559-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918101852.582559-1-jean-philippe@linaro.org>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, zhangfei.gao@linaro.org,
 will@kernel.org
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

Reviewed-by: Eric Auger <eric.auger@redhat.com>
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
index 87b17bac04c2..45d2f5191201 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5158,7 +5158,7 @@ static void auxiliary_unlink_device(struct dmar_domain *domain,
 	domain->auxd_refcnt--;
 
 	if (!domain->auxd_refcnt && domain->default_pasid > 0)
-		ioasid_free(domain->default_pasid);
+		ioasid_put(domain->default_pasid);
 }
 
 static int aux_domain_add_dev(struct dmar_domain *domain,
@@ -5219,7 +5219,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
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
