Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD7C11D3D
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDAD20CC7
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k7mwUwe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDAD20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E7C4F20414;
	Mon, 24 Feb 2020 18:24:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 36uI0R2nDzP9; Mon, 24 Feb 2020 18:24:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E50B32050F;
	Mon, 24 Feb 2020 18:24:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBCCCC1D89;
	Mon, 24 Feb 2020 18:24:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC970C18DA
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9966286CD7
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4FhpXL5M58hE for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:24:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C50DE86D37
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:35 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id z3so11584479wru.3
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t1PrCtZ92DmYIwAPbSp2v0XRYBlM5YZLGBrm+uzQwJw=;
 b=k7mwUwe4f2eaHon/rtOusNwQtFja3+krXzwRGZ76SMD3QIwZYajs0PGl8nhuOu3e/Q
 1apHjKKThGa9F78oa6DJmFMg6Kv3M0zbTmO8+Eugcb2SS/fYXhJ75yn9RhWShh6+ftqW
 SUfddUdmPp4ujwFKVXozNBlY07/fSNyDISwYswJ30vRiZLJreuqTJ9fsed4djsvvIOny
 CMUJVS9RaKMUHia7+nXA9mZRl4QIa/ovZElpv9c2ACyb/VTFsnCnfWqipmg5gOCNeNSo
 PYeBPGGuW7xmjQCqEwsgxBu69OnvQazgX6XmX1S0LvnK/9wPepXn8vuUv4vl+VoCv6/L
 MvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t1PrCtZ92DmYIwAPbSp2v0XRYBlM5YZLGBrm+uzQwJw=;
 b=oNwiN/S+WSc7amfyj8oDoFA91lgPHlqVGBIV8WFouKQCXRnSEiqEOjC+0YGpcBadSy
 1BvJ+80wQBFYMwSrpGQ4Nh8hVRbDOqPZO8+6LhNN5MMxS5TU9DdrwMNHj3Q6yF/fTpzQ
 023nQG6VzDNp5m8PZcrL7HzQCDjlpffyugs9Jz3emZwwxFSfPiCz7bi44/tSp8KtH8VD
 qZ7UbIn/JR13WlST+lvkk0QcGxG1Sw7KMq/M7Hf72P1f6qjkTBYHgqadgEW7eXZLlzmi
 WGQfO1deWpnWOcyHVg5Xm5zIbn81OptCpoPrTpk/hKLmj4bdunrVwNY84lMekthA8WVt
 z72A==
X-Gm-Message-State: APjAAAV5DsoMqyMlnZLNGtrFwFkMybCyQUV3rnAtFnZXneQ9e7drqZtD
 aRw6rf3D3Gh8HO2vwsF4TGgos1By9EA=
X-Google-Smtp-Source: APXvYqyJoaGCAZwRcxK03cHvWfZ3rPd9BodvC//3q8tPBefjV5p8k/3KCURkzx9rn1YbvnVHRvzLqg==
X-Received: by 2002:adf:e908:: with SMTP id f8mr4337597wrm.37.1582568674081;
 Mon, 24 Feb 2020 10:24:34 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:24:33 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v4 04/26] iommu/sva: Search mm by PASID
Date: Mon, 24 Feb 2020 19:23:39 +0100
Message-Id: <20200224182401.353359-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, kevin.tian@intel.com,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, catalin.marinas@arm.com,
 robin.murphy@arm.com, robh+dt@kernel.org, zhangfei.gao@linaro.org,
 will@kernel.org, christian.koenig@amd.com
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

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

The fault handler will need to find an mm given its PASID. This is the
reason we have an IDR for storing address spaces, so hook it up.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/iommu-sva.c | 19 +++++++++++++++++++
 include/linux/iommu.h     |  9 +++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 64f1d1c82383..bfd0c477f290 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -559,3 +559,22 @@ int iommu_sva_get_pasid_generic(struct iommu_sva *handle)
 	return pasid;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid_generic);
+
+/* ioasid wants a void * argument */
+static bool __mmget_not_zero(void *mm)
+{
+	return mmget_not_zero(mm);
+}
+
+/**
+ * iommu_sva_find() - Find mm associated to the given PASID
+ * @pasid: Process Address Space ID assigned to the mm
+ *
+ * Returns the mm corresponding to this PASID, or an error if not found. A
+ * reference to the mm is taken, and must be released with mmput().
+ */
+struct mm_struct *iommu_sva_find(int pasid)
+{
+	return ioasid_find(&shared_pasid, pasid, __mmget_not_zero);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_find);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e7bc47ba24f8..e52a8731e7a9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1091,6 +1091,15 @@ void iommu_debugfs_setup(void);
 static inline void iommu_debugfs_setup(void) {}
 #endif
 
+#ifdef CONFIG_IOMMU_SVA
+extern struct mm_struct *iommu_sva_find(int pasid);
+#else /* !CONFIG_IOMMU_SVA */
+static inline struct mm_struct *iommu_sva_find(int pasid)
+{
+	return NULL;
+}
+#endif /* !CONFIG_IOMMU_SVA */
+
 #ifdef CONFIG_IOMMU_PAGE_FAULT
 extern int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
 
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
