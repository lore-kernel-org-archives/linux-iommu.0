Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C972C5517A
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 15:53:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A5A22203
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 15:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sk2Sdvuz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A5A22203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3403F869EB;
	Fri,  6 Nov 2020 15:53:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NIIm2dAe1Fsp; Fri,  6 Nov 2020 15:53:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5C8C8869EC;
	Fri,  6 Nov 2020 15:53:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41D4CC1AD4;
	Fri,  6 Nov 2020 15:53:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40C95C0889
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 29F252E11D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:53:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qItZ1ql0R68H for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 15:53:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 754EC20386
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 15:53:17 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id cq7so1548999edb.4
 for <iommu@lists.linux-foundation.org>; Fri, 06 Nov 2020 07:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ELWmKXkijbiS5Ma0VBZ5sbWqTj8BZEn1XnX8tqwoCMo=;
 b=sk2SdvuzZa6QsSThecsbEOQSwIRiwBZu8rCZ57uy+sc625zUUvlIrfdmylODn0+eRy
 Xn8SAts9FcUuBX5tZ26Kzdp14zfwBdoGxn3SUrt6EslYqhqa+28grJ/hladi3A8pzZaB
 Fw0k5txNF5hBHiodVUIbPyizsUqild3DkpBEGvRBpJGTAlXHfTkCryAXfJiJHvOvp3MC
 EAio6UhpxORgcqHATrOZ+rMA2Oj1+2pj3Rlo3PV7T8DRc8tSwNkbbcSuupyaWutAfWce
 N+mN4FcSwKThrI79enpZnEqAk7kWkt0hzjwTB4Ghk5cnmn0EjqX0KTCt2jv6XgQ5nbFX
 7QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ELWmKXkijbiS5Ma0VBZ5sbWqTj8BZEn1XnX8tqwoCMo=;
 b=e2Xh3DCH7JNoNhDDSE50t+RZfBXsV60cEz32Gz6xhjkndGAuZhSLZ/B+Qtsj457rXZ
 VxKXW3OO/k8nlQ59s0MmSex/BUU0EJoj79EB1wwHv/IVFNy0I7ZGM5QcAIl1t3kYBphU
 bNi0jPbX3z0Nup/E6NrnDdKCHWsyeC0Ole9IHwe5Mu8l2wmHvu6rCwBkVc4gX+Gk+YQS
 zTj68I7e6DhJOc9CIDbi//m0sYQruQkPup9q1hv+s96S7XvSJCEwpy4EMSSXVe4ja7zO
 sLDQfj1J8Td+6JAk9jK6LKGQxeArby5mzV48i6tLi7z8rELDnXFJtNaR/JGpCsz8f+fQ
 fNKg==
X-Gm-Message-State: AOAM531WNL8osoxbIXdgOTJv3AxyB4yBNhk+x0IIoz2sEdjhMb+e6ysD
 MXvJThez9pQCRwbsOUxh38gsDvxCrldkLQ==
X-Google-Smtp-Source: ABdhPJzbDbPDUq6G5kXrXalDD59F6PsWMh3RakrBnB5gfl2A1mhPmFwKosYVkySpHEED3Qr+PBrTnA==
X-Received: by 2002:a50:fd19:: with SMTP id i25mr2576697eds.360.1604677995455; 
 Fri, 06 Nov 2020 07:53:15 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id lz27sm1249262ejb.39.2020.11.06.07.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 07:53:14 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND v10 2/4] iommu/sva: Add PASID helpers
Date: Fri,  6 Nov 2020 16:50:48 +0100
Message-Id: <20201106155048.997886-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201106155048.997886-1-jean-philippe@linaro.org>
References: <20201106155048.997886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 zhangfei.gao@linaro.org, robin.murphy@arm.com
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

Let IOMMU drivers allocate a single PASID per mm. Store the mm in the
IOASID set to allow refcounting and searching mm by PASID, when handling
an I/O page fault.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig         |  5 ++
 drivers/iommu/Makefile        |  1 +
 drivers/iommu/iommu-sva-lib.h | 15 ++++++
 drivers/iommu/iommu-sva-lib.c | 86 +++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 drivers/iommu/iommu-sva-lib.h
 create mode 100644 drivers/iommu/iommu-sva-lib.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 04878caf6da4..f5ebbdfbf636 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -103,6 +103,11 @@ config IOMMU_DMA
 	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
 
+# Shared Virtual Addressing library
+config IOMMU_SVA_LIB
+	bool
+	select IOASID
+
 config FSL_PAMU
 	bool "Freescale IOMMU support"
 	depends on PCI
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 11f1771104f3..61bd30cd8369 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -27,3 +27,4 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
+obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
new file mode 100644
index 000000000000..b40990aef3fd
--- /dev/null
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SVA library for IOMMU drivers
+ */
+#ifndef _IOMMU_SVA_LIB_H
+#define _IOMMU_SVA_LIB_H
+
+#include <linux/ioasid.h>
+#include <linux/mm_types.h>
+
+int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
+void iommu_sva_free_pasid(struct mm_struct *mm);
+struct mm_struct *iommu_sva_find(ioasid_t pasid);
+
+#endif /* _IOMMU_SVA_LIB_H */
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
new file mode 100644
index 000000000000..bd41405d34e9
--- /dev/null
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helpers for IOMMU drivers implementing SVA
+ */
+#include <linux/mutex.h>
+#include <linux/sched/mm.h>
+
+#include "iommu-sva-lib.h"
+
+static DEFINE_MUTEX(iommu_sva_lock);
+static DECLARE_IOASID_SET(iommu_sva_pasid);
+
+/**
+ * iommu_sva_alloc_pasid - Allocate a PASID for the mm
+ * @mm: the mm
+ * @min: minimum PASID value (inclusive)
+ * @max: maximum PASID value (inclusive)
+ *
+ * Try to allocate a PASID for this mm, or take a reference to the existing one
+ * provided it fits within the [@min, @max] range. On success the PASID is
+ * available in mm->pasid, and must be released with iommu_sva_free_pasid().
+ * @min must be greater than 0, because 0 indicates an unused mm->pasid.
+ *
+ * Returns 0 on success and < 0 on error.
+ */
+int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
+{
+	int ret = 0;
+	ioasid_t pasid;
+
+	if (min == INVALID_IOASID || max == INVALID_IOASID ||
+	    min == 0 || max < min)
+		return -EINVAL;
+
+	mutex_lock(&iommu_sva_lock);
+	if (mm->pasid) {
+		if (mm->pasid >= min && mm->pasid <= max)
+			ioasid_get(mm->pasid);
+		else
+			ret = -EOVERFLOW;
+	} else {
+		pasid = ioasid_alloc(&iommu_sva_pasid, min, max, mm);
+		if (pasid == INVALID_IOASID)
+			ret = -ENOMEM;
+		else
+			mm->pasid = pasid;
+	}
+	mutex_unlock(&iommu_sva_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
+
+/**
+ * iommu_sva_free_pasid - Release the mm's PASID
+ * @mm: the mm
+ *
+ * Drop one reference to a PASID allocated with iommu_sva_alloc_pasid()
+ */
+void iommu_sva_free_pasid(struct mm_struct *mm)
+{
+	mutex_lock(&iommu_sva_lock);
+	if (ioasid_put(mm->pasid))
+		mm->pasid = 0;
+	mutex_unlock(&iommu_sva_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
+
+/* ioasid_find getter() requires a void * argument */
+static bool __mmget_not_zero(void *mm)
+{
+	return mmget_not_zero(mm);
+}
+
+/**
+ * iommu_sva_find() - Find mm associated to the given PASID
+ * @pasid: Process Address Space ID assigned to the mm
+ *
+ * On success a reference to the mm is taken, and must be released with mmput().
+ *
+ * Returns the mm corresponding to this PASID, or an error if not found.
+ */
+struct mm_struct *iommu_sva_find(ioasid_t pasid)
+{
+	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_find);
-- 
2.29.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
