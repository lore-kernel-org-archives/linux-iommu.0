Return-Path: <SRS0=eKRE=6H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF36C54FCB
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 12:55:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E552077D
	for <iommu@archiver.kernel.org>; Thu, 23 Apr 2020 12:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2T6IS/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E552077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CF8442042D;
	Thu, 23 Apr 2020 12:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S7Xw82VF0fz0; Thu, 23 Apr 2020 12:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CB60E2012D;
	Thu, 23 Apr 2020 12:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA16EC1797;
	Thu, 23 Apr 2020 12:55:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47D7CC0175
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 12:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4266888581
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 12:55:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iKwVNyI9ZDrT for <iommu@lists.linux-foundation.org>;
 Thu, 23 Apr 2020 12:55:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1405488498
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 12:55:27 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id g12so6421435wmh.3
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SgbuLdDP1Mxc0Wy+JF9cWOFI+YrpHFN5Gr1r0SSOMao=;
 b=B2T6IS/gES1zUUVuV5qoXzCO9MyycYQ5RPN6RzfRpRZg3ehcZ64IRCnKZcEyGMpyQ5
 oyucPD2Qaxuh89w4S7V7tASNzB6cTdWTCA0b12cvMf1G5DIk+C0Gg30xlnQpmFP5Vilw
 9LV1X2PUlUl2WIlnP/WH7+fjrRpmlhyUVKRdyaKkAc0IpBZ5/jasHWlGS4wXRXnOHTID
 dJjIf5jYBgOoOneStaGBkmDZOzY12CjZGIBW/+LAO5dQdS8w/SvSkAAnIA+RjJlWWqp6
 wAPd2YgZNG3TtPMyZYapBZpBQ+DiLG9/lbAc8JeGdDQbuMxVZMVznMdCkNJg3L8j2DKs
 U/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SgbuLdDP1Mxc0Wy+JF9cWOFI+YrpHFN5Gr1r0SSOMao=;
 b=OUgMnM7VO6mm3RJXPfE+eV+chUjo4qGMbBem8eF7gYZ8pBZqDIOM3a8HVDb72qiHKK
 dwUGZ9givKzr+R5UrCbrUy0dZTtdeqJ+1waonzAKE+ykJcuZYDKaj08HMi0SnlFogvFr
 pUJ0xeMRXjvN3WGJgLvCYe8Zh1hZ0rXb5Z9cCVPFW95M56jie6jxcPrw1Lqy5Bm62oNa
 r0rdMQNW/+TPTy5R8pPbY2ddNxjXSdGFImi/gxtvkmBPb7g3hCy76vJJdWFoc8Er+jmE
 bcFr7M8Xw6H2XY1nwoK6kqdsWPmEN9mO3hTyWErAM2VBVX1dpfZtJ+hFmNHiDnCiCxX2
 kQXQ==
X-Gm-Message-State: AGi0PuafMssNAzorcRXXYbLaUooiLvX2UZw3aykF0Cj1OCdlJ6O278Av
 vToz0k0aeSvSdtJ/Xe2iaeYF10RiDKI=
X-Google-Smtp-Source: APiQypIZMh8Z66ZJlX50H9mE2uL0b/PplvI+VqDR858LMBD44nhr8z/BmkhEt5gVXXcw/5slV+VOjQ==
X-Received: by 2002:a1c:9cca:: with SMTP id f193mr3954229wme.71.1587646525237; 
 Thu, 23 Apr 2020 05:55:25 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x23sm3482784wmj.6.2020.04.23.05.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 05:55:24 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
	linux-accelerators@lists.ozlabs.org
Subject: [PATCH v2 2/2] iommu: Remove iommu_sva_ops::mm_exit()
Date: Thu, 23 Apr 2020 14:53:30 +0200
Message-Id: <20200423125329.782066-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200423125329.782066-1-jean-philippe@linaro.org>
References: <20200423125329.782066-1-jean-philippe@linaro.org>
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
device drivers. Since they don't stop DMA on mm exit anymore, the PASID
lifetime is extended:

(1) The device driver calls bind(). A PASID is allocated.

  Here any DMA fault is handled by mm, and on error we don't print
  anything to dmesg. Userspace can easily trigger errors by issuing DMA
  on unmapped buffers.

(2) exit_mmap(), for example the process took a SIGKILL. This step
    doesn't happen during normal operations. Remove the pgd from the
    PASID table, since the page tables are about to be freed. Invalidate
    the IOTLBs.

  Here the device may still perform DMA on the address space. Incoming
  transactions are aborted but faults aren't printed out. ATS
  Translation Requests return Successful Translation Completions with
  R=W=0. PRI Page Requests return with Invalid Request.

(3) The device driver stops DMA, possibly following release of a fd, and
    calls unbind(). PASID table is cleared, IOTLB invalidated if
    necessary. The page fault queues are drained, and the PASID is
    freed.

  If DMA for that PASID is still running here, something went seriously
  wrong and errors should be reported.

For now remove iommu_sva_ops entirely. We might need to re-introduce
them at some point, for example to notify device drivers of unhandled
IOPF.

[1] https://lore.kernel.org/linux-iommu/20200306174239.GM31668@ziepe.ca/
[2] https://lore.kernel.org/linux-iommu/4d68da96-0ad5-b412-5987-2f7a6aa796c3@amd.com/

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: tried to clarify the lifetime of the PASID
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
