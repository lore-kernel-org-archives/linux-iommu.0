Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183B3C2D0EA
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 15:18:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CFD2072A
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 15:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FeeGjAHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CFD2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 80F1F21548;
	Wed,  8 Apr 2020 15:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o2Tqzl+evpps; Wed,  8 Apr 2020 15:18:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 47F3020774;
	Wed,  8 Apr 2020 15:18:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E49BC1AE8;
	Wed,  8 Apr 2020 15:18:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0BE4C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CCDD220774
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NqhMwwA0o0GG for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 15:18:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 3129220450
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 15:18:29 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id f20so288878wmh.3
 for <iommu@lists.linux-foundation.org>; Wed, 08 Apr 2020 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KTNbvMU7aQQx9qJGSH4M5ifR831rELbiUR6t+ttVvkA=;
 b=FeeGjAHQ/nRD3Y0QdkEg9wQDHoQdUzsuxl1n1xXB4cud5R+Qa15XvjqgVLCXHgYvxY
 DNuM05JRsb3uOss+praTJBcbEcjm+p3+iw7INAuxavWn/HzXOmB+67KCwPjhYQIJVvtD
 JCDsemvezg33u7rPBwri6CoalWTuhLZHIKEq8TSdolp9q/YpJmMi8xyjQuN7EYuDXVIA
 RJ9m4yhplVDQfKdaxOQYhNMepZs5BEAooxbD0YgoMRWXXNad8F6oaeEji8GDuEsxlz+a
 nuSaHxE7Drp/nPOfLGk5hQn2GSEFiN9QIWHAMrq11qjjmo+J4gCqJqjVw5kXeZLgHeJ3
 TEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KTNbvMU7aQQx9qJGSH4M5ifR831rELbiUR6t+ttVvkA=;
 b=BBTF3HOQjbQXCul/o95B3XF+VHd5qTJbBrhtA2s4aXOSbfACn6HdxFqUg2Fxm2xHfr
 7wJpCvSQIX3bns4qBubZaBtElR+SMTfglK0hcMnANsxd5N6QeczJx8D2Xls7IJtQb9yU
 SIJ3bacqNTgHSKaRhY9XhtpLVViPZ3JZ4IEC15RfNie1qcVfY4hnq6NU4cA1arG7KKdg
 tI+DE+1oNuqN+xZXoUXnBn5OUjA/owbAYTcToPqKnB6T2IKlZoA6UV4Lw/AULin1vQWH
 GYDSeoBmb28/hdwmHpj7wPvt+zsSSMScqDJX52JGlCQiazq64KEOJLcEiGFjoSDeusQz
 dO5w==
X-Gm-Message-State: AGi0PuYPxKnBpYIdIisK1GfVF1fGzfe7ieJFcYpm4/Gf3D6In3tpdHZJ
 2zHEUzVEbHap3j34KtWRElyZIcKXi/+cuw==
X-Google-Smtp-Source: APiQypJ4yv1s582oVztAXmtD52CmsN7XdkMPmk+61MTa+YdMRm5cP4333/fD9dowV4ke2oxMavEd8A==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr4754500wmi.152.1586354794445; 
 Wed, 08 Apr 2020 07:06:34 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id h2sm6788351wmb.16.2020.04.08.07.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 07:06:34 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
	linux-accelerators@lists.ozlabs.org
Subject: [PATCH 2/2] iommu: Remove iommu_sva_ops::mm_exit()
Date: Wed,  8 Apr 2020 16:04:27 +0200
Message-Id: <20200408140427.212807-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200408140427.212807-1-jean-philippe@linaro.org>
References: <20200408140427.212807-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, arnd@arndb.de,
 gregkh@linuxfoundation.org, jgg@ziepe.ca, zhangfei.gao@linaro.org
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

After binding a device to an mm, device drivers currently need to
register a mm_exit handler. This function is called when the mm exits,
to gracefully stop DMA targeting the address space and flush page faults
to the IOMMU.

This is deemed too complex for the MMU release() notifier, which may be
triggered by any mmput() invocation, from about 120 callsites [1]. The
upcoming SVA module has an example of such complexity: the I/O Page
Fault handler would need to call mmput_async() instead of mmput() after
handling an IOPF, to avoid triggering the release() notifier which would
in turn drain the IOPF queue and lock up.

Another concern is the DMA stop function taking too long, up to several
minutes [2]. For some mmput() callers this may disturb other users. For
example, if the OOM killer picks the mm bound to a device as the victim
and that mm's memory is locked, if the release() takes too long, it
might choose additional innocent victims to kill.

To simplify the MMU release notifier, don't forward the notification to
device drivers. They don't need to stop DMA and drain page faults
anymore in the release() path. IOMMU drivers still remove the pgd and
invalidate IOTLBs, but they don't need to drain the IOPF queues anymore.
The PASID isn't freed as soon as the mm exits, it is held until the
device driver stops DMA and calls unbind.

Similarly to accessing invalid mappings:
* Incoming DMA transactions are aborted but not reported.
* ATS Translation Requests return Successful Translation Completions
  with R=W=0.
* PRI Page Requests return with Invalid Request.

For now remove iommu_sva_ops entirerly. We might need to re-introduce
them at some point, for example to notify device drivers of unhandled
IOPF.

[1] https://lore.kernel.org/linux-iommu/20200306174239.GM31668@ziepe.ca/
[2] https://lore.kernel.org/linux-iommu/4d68da96-0ad5-b412-5987-2f7a6aa796c3@amd.com/

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h | 30 ------------------------------
 drivers/iommu/iommu.c | 11 -----------
 2 files changed, 41 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7ef8b0bda6951..bd330d6343b78 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -53,8 +53,6 @@ struct iommu_fault_event;
 
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
-typedef int (*iommu_mm_exit_handler_t)(struct device *dev, struct iommu_sva *,
-				       void *);
 typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault *, void *);
 
 struct iommu_domain_geometry {
@@ -171,25 +169,6 @@ enum iommu_dev_features {
 
 #define IOMMU_PASID_INVALID	(-1U)
 
-/**
- * struct iommu_sva_ops - device driver callbacks for an SVA context
- *
- * @mm_exit: called when the mm is about to be torn down by exit_mmap. After
- *           @mm_exit returns, the device must not issue any more transaction
- *           with the PASID given as argument.
- *
- *           The @mm_exit handler is allowed to sleep. Be careful about the
- *           locks taken in @mm_exit, because they might lead to deadlocks if
- *           they are also held when dropping references to the mm. Consider the
- *           following call chain:
- *           mutex_lock(A); mmput(mm) -> exit_mm() -> @mm_exit() -> mutex_lock(A)
- *           Using mmput_async() prevents this scenario.
- *
- */
-struct iommu_sva_ops {
-	iommu_mm_exit_handler_t mm_exit;
-};
-
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -605,7 +584,6 @@ struct iommu_fwspec {
  */
 struct iommu_sva {
 	struct device			*dev;
-	const struct iommu_sva_ops	*ops;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
@@ -653,8 +631,6 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm,
 					void *drvdata);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
-int iommu_sva_set_ops(struct iommu_sva *handle,
-		      const struct iommu_sva_ops *ops);
 int iommu_sva_get_pasid(struct iommu_sva *handle);
 
 #else /* CONFIG_IOMMU_API */
@@ -1058,12 +1034,6 @@ static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
 {
 }
 
-static inline int iommu_sva_set_ops(struct iommu_sva *handle,
-				    const struct iommu_sva_ops *ops)
-{
-	return -EINVAL;
-}
-
 static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2b471419e26c3..dfed12328c032 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2637,17 +2637,6 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
-int iommu_sva_set_ops(struct iommu_sva *handle,
-		      const struct iommu_sva_ops *sva_ops)
-{
-	if (handle->ops && handle->ops != sva_ops)
-		return -EEXIST;
-
-	handle->ops = sva_ops;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iommu_sva_set_ops);
-
 int iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
