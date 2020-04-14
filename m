Return-Path: <SRS0=5SFN=56=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C745C54FC9
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196C9206A2
	for <iommu@archiver.kernel.org>; Tue, 14 Apr 2020 17:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8kwev4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196C9206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C7C5521514;
	Tue, 14 Apr 2020 17:04:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sF-mM2uUDy1p; Tue, 14 Apr 2020 17:04:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 34E402152E;
	Tue, 14 Apr 2020 17:04:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03FF5C089E;
	Tue, 14 Apr 2020 17:04:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46C33C0172
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 304012154E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F7upkVSSU7Nw for <iommu@lists.linux-foundation.org>;
 Tue, 14 Apr 2020 17:04:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 76AA8203A4
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:25 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id x25so13829645wmc.0
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VGMc5wLgmgx1eLWq9RQ7RG7NMxWRw2tpIDY5WHUtd3w=;
 b=s8kwev4qB+FwMlvJnZIEgUlpsfPv5PqQmyfezwvPiaaBckIACLW3XMkbvKRq6DnKDi
 t2UKqeUTPQYcigtkMp+zlJsyJsWC29+hzyF/YILdw1kem5LX+rUdahvgddngTIewGKPI
 Ls9qOOWbX1+GZLw2eHVDQ0C+3Q+XuIo7i0CpC5yzUkrPvbUvTws6yMxrz4kHGk4gH7S2
 lLF7B3VkEZoHfACdrS90vN31rEj3/80zND2C7VWgfzHYgNywd5gdWfI831crvwFJA6Fr
 T0J9K0/WC/Dm3PeoZXFwuI8vTy1x6RYRQz3w1oY7B7IC5RAT8PsArjVC3oEpvuMEqYG7
 NofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VGMc5wLgmgx1eLWq9RQ7RG7NMxWRw2tpIDY5WHUtd3w=;
 b=MOiWG5sBu1uxXo6Z4ROzT4zF1YcxNriCNiPCsAVPJruJrQ5QexsUf9oMnlb5GYCxIq
 CraHrMy3FnFkbeMU8O8QNOlJJ1lp0BbxEmbSJL51hDDyv9+6XA0G72swYgGxUD5lpYvi
 uIth7UEi8vzno/ZmdzkoS8XuDNKzAj1PrxqBJbemHaYojuNBbHblzow49hldkb0oLttR
 megB16SDn1AZJQyDDrM0zSpBaR/kIlgG/WYyhIeF78U9SkmAupVmw/vyxd9qhQJVnpru
 05qlYAjG5qrie/1nvf9XOR8bIPu85geCumlTcWmfcITJpHHcI1Wbnpqsu1ycvR4miick
 lKog==
X-Gm-Message-State: AGi0Pub1stikKbGZuXiaVPGdoOt/Veh69PoQYRLE4lwvj8MOgvTm4Qcd
 RP1FyEeQL2FkEro2DOwqRbhBlnxNJ2JK8A==
X-Google-Smtp-Source: APiQypL42n0W5SIMAbcNDaJARHcsQO61MSaD9RMrsbqmlsVv6uHGjdhQFjv16aEzCb2QZXgo0ox3nw==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr775518wmc.62.1586883863302;
 Tue, 14 Apr 2020 10:04:23 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 10:04:22 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v5 04/25] iommu/sva: Search mm by PASID
Date: Tue, 14 Apr 2020 19:02:32 +0200
Message-Id: <20200414170252.714402-5-jean-philippe@linaro.org>
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

The fault handler will need to find an mm given its PASID. This is the
reason we have an IDR for storing address spaces, so hook it up.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h     |  9 +++++++++
 drivers/iommu/iommu-sva.c | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5a3d092c2568a..4b9c25d7246d5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1081,6 +1081,15 @@ void iommu_debugfs_setup(void);
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
 
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 7fecc74a9f7d6..b177d6cbf4fff 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -525,3 +525,22 @@ int iommu_sva_get_pasid_generic(struct iommu_sva *handle)
 	return bond->io_mm->pasid;
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
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
