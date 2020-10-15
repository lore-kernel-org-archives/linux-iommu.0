Return-Path: <SRS0=+Hy+=DW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC25C433DF
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 09:03:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9141E2222E
	for <iommu@archiver.kernel.org>; Thu, 15 Oct 2020 09:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9AXKgXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9141E2222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E993A87B86;
	Thu, 15 Oct 2020 09:03:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lB-1zpWP4fUE; Thu, 15 Oct 2020 09:03:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CA5F687B75;
	Thu, 15 Oct 2020 09:03:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A869C07FF;
	Thu, 15 Oct 2020 09:03:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B61DC0051
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:03:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 066B687B75
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xGgvSx07f+Of for <iommu@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 09:03:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E540B87B76
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 09:03:04 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id t21so2299294eds.6
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x6z5xqfcq1Sp2BijtV/eJd8Vk7MAj53+3Nspgxz8YIY=;
 b=W9AXKgXQuRJ69P6P9RwOQBQdA3thwvZ4DuYZl/AnWv+6fsXJnE++gI/+k3F0gqygRL
 S7PWXqmqWlU1D/fpWW2bpxpyWdR2ZL5U/cky16o2xyurM+/xUg9Yn5zCh6zAsxU+4CEf
 UMnSk388/fBsDtGE3YVa/32CCpoIsGRCahY9xl1C3oPWaUuqzHbuPZZ/ffchzaTq1jis
 vtK9m6cz4WAdfPu9UvO2fzCoVhvAI5cr6I5jIITbOelcaEi1ScRBINYLW6fC5TPnLBRu
 7O+MbHrfK6Ls0F08T9uEIN+iPTfy/t4tIqubV5DfUVU+jxVWNTo5HEuuHeJ5YI7D7Yll
 +E0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x6z5xqfcq1Sp2BijtV/eJd8Vk7MAj53+3Nspgxz8YIY=;
 b=K5EczHOGLcDoqg3I+hOp2J9ZU730I5phkqKX5jmPBiLf/fG4XTv9CZvGgDscndRTop
 vOuB1X+89wlJugOsBeq94ojDGtaxkE0RrRf9X2hTwpqJTRodl8Aw6wirqZGYsns9y5SL
 gKO0uHrDeHmW9JCVgu2Wea7ya0p+htuADnb6l6WwgwL76YCcvLLhwR7r5nEnlMlJ0PUT
 67yocwWlJt1RtTAADRr/gYODEKrfJqkAv3absM1ajnjdmDPCOLAijqp3SJ++Cw0U+rG0
 hWD5HIqwqCLZzv8R/KZoths7wz5hICeseHFqzPzk0IZT3QHPhYxp+5aiP5gzS8xq38L9
 ULAw==
X-Gm-Message-State: AOAM533J0CXyD1ojsiv3iMyemYOHqPPTZmiYEitXXN7y9tvbplPdIPka
 KXmKMJhmyZUPSs9B74TMCyDX0A==
X-Google-Smtp-Source: ABdhPJyK8hd+j8uB3o5Q/Dz8Ch3k2aQc6UNBsyR0dpdZSVT9IFPmtHBVJTekYNLCX44gCo6pYyot4Q==
X-Received: by 2002:a50:abc3:: with SMTP id u61mr3257384edc.253.1602752583017; 
 Thu, 15 Oct 2020 02:03:03 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id d12sm1103078ejt.105.2020.10.15.02.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 02:03:02 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
 zhangfei.gao@linaro.org, wangzhou1@hisilicon.com
Subject: [RFC PATCH 2/2] iommu: Add IOMMU_UNBIND_FAULT_PENDING flag
Date: Thu, 15 Oct 2020 11:00:29 +0200
Message-Id: <20201015090028.1278108-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015090028.1278108-1-jean-philippe@linaro.org>
References: <20201015090028.1278108-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 ashok.raj@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, linux-accelerators@lists.ozlabs.org
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

IOMMU drivers only need to flush their PRI queue when faults might be
pending. According to the PCIe spec (quoted below) this only happens
when using the "Stop Marker" method. Otherwise the function waits for
pending faults before signaling to the device driver that it can
unbind().

Add the IOMMU_UNBIND_FAULT_PENDING flags to unbind(), to tell the IOMMU
driver whether it's worth flushing the queue.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h     | 31 +++++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c |  3 ++-
 drivers/iommu/iommu.c     |  5 ++++-
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 26c1358a2a37..fd9630b1240d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -163,6 +163,37 @@ enum iommu_dev_features {
 
 #define IOMMU_PASID_INVALID	(-1U)
 
+/*
+ * Indicate that a device stops using a PASID by issuing a Stop Marker Message.
+ * From PCIe 4.0r1.0, 10.4.1.2 Managing PASID TLP Prefix Usage:
+ *
+ * "To stop without using a Stop Marker Message, the Function shall:
+ *  1. Stop queueing new Page Request Messages for this PASID.
+ *  2. Finish transmitting any multi-page Page Request Messages for this PASID
+ *     (i.e. send the Page Request Message with the L bit Set).
+ *  3. Wait for PRG Response Messages associated any outstanding Page Request
+ *     Messages for the PASID.
+ *  4. Indicate that the PASID has stopped using a device specific mechanism.
+ *     This mechanism must indicate that a Stop Marker Message will not be
+ *     generated.
+ *  To stop with the use of a Stop Marker Message the Function shall:
+ * [1. and 2. are the same]
+ *  3. Internally mark all outstanding Page Request Messages for this PASID as
+ *     stale. PRG Response Messages associated with these requests will return
+ *     Page Request Allocation credits and PRG Index values but are otherwise
+ *     ignored.
+ *  4. Indicate that the PASID has stopped using a device specific mechanism.
+ *     This mechanism must indicate that a Stop Marker Message will be
+ *     generated.
+ *  5. Send a Stop Marker Message to indicate to the host that all subsequent
+ *     Page Request Messages for this PASID are for a new use of the PASID
+ *     value."
+ *
+ * If the device indicates that the Stop Marker Message will be generated, the
+ * device driver should set the IOMMU_UNBIND_FAULT_PENDING flag.
+ */
+#define IOMMU_UNBIND_FAULT_PENDING	(1UL << 0)
+
 #ifdef CONFIG_IOMMU_API
 
 /**
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 700b05612af9..aa1fcb66fa95 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -680,7 +680,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid,
 			 * hard to be as defensive as we might like. */
 			intel_pasid_tear_down_entry(iommu, dev,
 						    svm->pasid, false);
-			intel_svm_drain_prq(dev, svm->pasid);
+			if (flags & IOMMU_UNBIND_FAULT_PENDING)
+				intel_svm_drain_prq(dev, svm->pasid);
 			kfree_rcu(sdev, rcu);
 
 			if (list_empty(&svm->devs)) {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 741c463095a8..eede0592a2c0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2995,7 +2995,10 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
  *
  * Put reference to a bond between device and address space. The device should
  * not be issuing any more transaction for this PASID. All outstanding page
- * requests for this PASID must have been flushed to the IOMMU.
+ * requests for this PASID must have been completed, or flushed to the IOMMU. If
+ * they have not been completed, for example when using a Stop Marker Message to
+ * stop PASID in a PCIe device, then the caller must set the flag
+ * %IOMMU_UNBIND_FAULT_PENDING.
  *
  * Returns 0 on success, or an error value
  */
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
