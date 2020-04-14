Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0366C54FCF
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA0B2075E
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCakNvEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA0B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7EB5687E3C;
	Tue, 14 Apr 2020 17:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zms687ODjAvS; Tue, 14 Apr 2020 17:04:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3DD1587E53;
	Tue, 14 Apr 2020 17:04:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC62C089E;
	Tue, 14 Apr 2020 17:04:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA508C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A677F203A4
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EvG7Pj9WZ5eo for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by silver.osuosl.org (Postfix) with ESMTPS id AFBBE21514
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:26 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id x25so13829723wmc.0
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IomOGED94uQ/sc+mw27XI7cICJqvlx4xPsMfu0J0FYY=;
 b=GCakNvEsC05vdQy4s9DM45xHnKiEYteUAcD7FyLCP/uTecd/VeAwPmTWPNoushPNYV
 RNOeq6evl2T3CwdSNOB3ZpQ8cQguPZLXa9JzggKMQe0IU5xiemwq49jBFoG/HPGeV5jO
 t5dRmLK1E+Zg1wNi1JpDKCqwSf5Ft+LyS2I11G3Rk/AuaDJ9hliSq44RchEHC4khzI/7
 FQ+xSbVGbSikxMid35s3BjzOuv/5EQZX04YWVmmNkddVLvKqNh1lYoDuSClEnEiZ8YjH
 NZ4PeV/mancwfAQfD0talcSAEJdsbDvnh3PrfKQsvpIiQI7cQ+G3rTKfZSYDXsO+GCmi
 Ua2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IomOGED94uQ/sc+mw27XI7cICJqvlx4xPsMfu0J0FYY=;
 b=obSlspJoDdrz/J8HKiMVE3mvK4bn1nhe4qfXSAlPBt75rOQ8zE+RCIYteKYxUTTLbs
 0MfiYF2t0ENw7EOzcjk5JegM9h/u3+BQfjWVF2rsaoDI+Ul89jFiplgBSWy1UDVnzS+4
 yQmEkVAj/+PtWa6klXnHEpvLxdgeap++3HL6zjUR86lTZsvmxhjWGUKSF42IbIEJqcWo
 B2okF7cREByDvAEx1aRZGm6QT+coCrgaLE6QwitIcv82D1+Jv7hrimz0JrjCYWhevZjB
 zxUgrqQOdPg57HI7E0GwVayCzVJj61+Xe5qVEraa6Meg1XoWytUrb/sKZHk/SxMEKded
 HH9w==
X-Gm-Message-State: AGi0PuaIqY+9BPFhl6scxHdE0pUYhKUkb3EDokjsHrQWKsS64gVVgEX9
 MoKNULX9vKd+1nMaSk7522nT8gVSDQ8fWQ==
X-Google-Smtp-Source: APiQypKbiaMvR8TIzKGaRea1UGF3OINaumxymb+GpCM64htK1x8XN0yXUI9IxJx+k4Q82m6PfxgfWw==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr776491wma.108.1586883864753;
 Tue, 14 Apr 2020 10:04:24 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:24 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 05/25] iommu/iopf: Handle mm faults
Date: Tue, 14 Apr 2020 19:02:33 +0200
Message-Id: <20200414170252.714402-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 catalin.marinas@arm.com, robin.murphy@arm.com, jgg@ziepe.ca,
 zhangfei.gao@linaro.org, will@kernel.org, christian.koenig@amd.com
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

When a recoverable page fault is handled by the fault workqueue, find the
associated mm and call handle_mm_fault.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v4->v5: no need to call mmput_async() anymore, since the MMU release()
        doesn't flush the IOPF queue anymore.
---
 drivers/iommu/io-pgfault.c | 77 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 5bba8e6a13be2..fd4244023b33f 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -7,6 +7,7 @@
 
 #include <linux/iommu.h>
 #include <linux/list.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -76,8 +77,57 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
 static enum iommu_page_response_code
 iopf_handle_single(struct iopf_fault *iopf)
 {
-	/* TODO */
-	return -ENODEV;
+	vm_fault_t ret;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned int access_flags = 0;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct iommu_fault_page_request *prm = &iopf->fault.prm;
+	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
+
+	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
+		return status;
+
+	mm = iommu_sva_find(prm->pasid);
+	if (IS_ERR_OR_NULL(mm))
+		return status;
+
+	down_read(&mm->mmap_sem);
+
+	vma = find_extend_vma(mm, prm->addr);
+	if (!vma)
+		/* Unmapped area */
+		goto out_put_mm;
+
+	if (prm->perm & IOMMU_FAULT_PERM_READ)
+		access_flags |= VM_READ;
+
+	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
+		access_flags |= VM_WRITE;
+		fault_flags |= FAULT_FLAG_WRITE;
+	}
+
+	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
+		access_flags |= VM_EXEC;
+		fault_flags |= FAULT_FLAG_INSTRUCTION;
+	}
+
+	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
+		fault_flags |= FAULT_FLAG_USER;
+
+	if (access_flags & ~vma->vm_flags)
+		/* Access fault */
+		goto out_put_mm;
+
+	ret = handle_mm_fault(vma, prm->addr, fault_flags);
+	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
+		IOMMU_PAGE_RESP_SUCCESS;
+
+out_put_mm:
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+
+	return status;
 }
 
 static void iopf_handle_group(struct work_struct *work)
@@ -112,6 +162,29 @@ static void iopf_handle_group(struct work_struct *work)
  *
  * Add a fault to the device workqueue, to be handled by mm.
  *
+ * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
+ * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
+ * expect a response. It may be generated when disabling a PASID (issuing a
+ * PASID stop request) by some PCI devices.
+ *
+ * The PASID stop request is issued by the device driver before unbind(). Once
+ * it completes, no page request is generated for this PASID anymore and
+ * outstanding ones have been pushed to the IOMMU (as per PCIe 4.0r1.0 - 6.20.1
+ * and 10.4.1.2 - Managing PASID TLP Prefix Usage). Some PCI devices will wait
+ * for all outstanding page requests to come back with a response before
+ * completing the PASID stop request. Others do not wait for page responses, and
+ * instead issue this Stop Marker that tells us when the PASID can be
+ * reallocated.
+ *
+ * It is safe to discard the Stop Marker because it is an optimization.
+ * a. Page requests, which are posted requests, have been flushed to the IOMMU
+ *    when the stop request completes.
+ * b. We flush all fault queues on unbind() before freeing the PASID.
+ *
+ * So even though the Stop Marker might be issued by the device *after* the stop
+ * request completes, outstanding faults will have been dealt with by the time
+ * we free the PASID.
+ *
  * Return: 0 on success and <0 on error.
  */
 int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
