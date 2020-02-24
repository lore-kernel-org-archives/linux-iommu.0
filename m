Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B1CC11D35
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A7820CC7
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQ7R/j32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A7820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E40998484C;
	Mon, 24 Feb 2020 18:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3gZtq74oeg5d; Mon, 24 Feb 2020 18:24:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F8CB8476C;
	Mon, 24 Feb 2020 18:24:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B2ECC18DA;
	Mon, 24 Feb 2020 18:24:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 067C5C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0223220519
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nyAOdsDscx0i for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 18:24:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id F0D4220518
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 18:24:37 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id w12so11584550wrt.2
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 10:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5ke1+5YSOcxDNzSzBBGnaN+kOVlCxvSlETx/6pQryQw=;
 b=hQ7R/j32SLrNiw6cB+MKzedjV5jb7wC2uDlPXljxSGn/Mm+e8K6vJRpSEh03PvC4u9
 6SWVO6jkqy8f1MhFEXuwvn5CVzySq1eAR0OMIHnH231Ilx59ro788ZXbVKhAb08vEu3x
 2DRDRX3reoEDjA1nXPvHdhi3NlMMHALRilHOP4FbegQ6bDl+MXF72BSCvs01Iga0ey/V
 lRA5BpuJcyT4Bo+4XEn4NxJCsLV3waRxK/XqqsUDdfn1vY0NKse5RC5ThKKbEOiOSL6S
 WBTlf6zQcjBQmTv4KAcSJKa3LHmn9N03VuV6CMiAjWvmhiZgf7OibmnfYlq8z45tqDXq
 +QmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5ke1+5YSOcxDNzSzBBGnaN+kOVlCxvSlETx/6pQryQw=;
 b=ZkcQo+1jxT8nyvPgyNcYBuIssXj/TJBWUCSoH0Hf86I1EHlM3EjEW7HlQV54oRYm4y
 Qd925EJGXBl4+Y3B2DRYmmu6jvjdm9KeDdCozngXNHOl/tOgTwnXwP9dBQ8KWeYwAdOd
 izGCyzRQk6DR3vERW7faH1HtVJfHxodEmsEkORThh6eOSFw8xRVtKRPfeA/24S+jEnOI
 MVtRQ1U0qHi0KgEiYGNOcv8ck5nGXCWco4CQDw0orHFcfqkYSjbX2XfkRMTC82vKcADj
 h05tjHg6Re+RLE6kft0xB8r7FGFSUKJmbeb/VrpBIll8UqWjl1rwfsOAUFFL9pim/j+T
 dDdQ==
X-Gm-Message-State: APjAAAVZTp1WKot/Utch1qTFyApVWnELjg+iIaWE/aW4DzWZUB9oWIBT
 PofH4WCXQ5Hwt4/gC4u7+mOoZN239ZE=
X-Google-Smtp-Source: APXvYqxKuED5BtGA+H9sncjVVYaPSWdkOdWHekAifEqs9Cn+ZBcftrmVm7FgSaad06EVLWBinDxKzg==
X-Received: by 2002:adf:df83:: with SMTP id z3mr67641748wrl.389.1582568676229; 
 Mon, 24 Feb 2020 10:24:36 -0800 (PST)
Received: from localhost.localdomain
 ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 10:24:35 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org
Subject: [PATCH v4 06/26] iommu/sva: Register page fault handler
Date: Mon, 24 Feb 2020 19:23:41 +0100
Message-Id: <20200224182401.353359-7-jean-philippe@linaro.org>
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

When enabling SVA, register the fault handler. Device driver will register
an I/O page fault queue before or after calling iommu_sva_enable. The
fault queue must be flushed before any io_mm is freed, to make sure that
its PASID isn't used in any fault queue, and can be reallocated. Add
iopf_queue_flush() calls in a few strategic locations.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig     |  1 +
 drivers/iommu/iommu-sva.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index e4a42e1708b4..211684e785ea 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -106,6 +106,7 @@ config IOMMU_DMA
 config IOMMU_SVA
 	bool
 	select IOASID
+	select IOMMU_PAGE_FAULT
 	select IOMMU_API
 	select MMU_NOTIFIER
 
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index bfd0c477f290..494ca0824e4b 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -366,6 +366,8 @@ static void io_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 			dev_WARN(dev, "possible leak of PASID %u",
 				 io_mm->pasid);
 
+		iopf_queue_flush_dev(dev, io_mm->pasid);
+
 		/* unbind() frees the bond, we just detach it */
 		io_mm_detach_locked(bond);
 	}
@@ -442,11 +444,20 @@ static void iommu_sva_unbind_locked(struct iommu_bond *bond)
 
 void iommu_sva_unbind_generic(struct iommu_sva *handle)
 {
+	int pasid;
 	struct iommu_param *param = handle->dev->iommu_param;
 
 	if (WARN_ON(!param))
 		return;
 
+	/*
+	 * Caller stopped the device from issuing PASIDs, now make sure they are
+	 * out of the fault queue.
+	 */
+	pasid = iommu_sva_get_pasid_generic(handle);
+	if (pasid != IOMMU_PASID_INVALID)
+		iopf_queue_flush_dev(handle->dev, pasid);
+
 	mutex_lock(&param->sva_lock);
 	mutex_lock(&iommu_sva_lock);
 	iommu_sva_unbind_locked(to_iommu_bond(handle));
@@ -484,6 +495,10 @@ int iommu_sva_enable(struct device *dev, struct iommu_sva_param *sva_param)
 		goto err_unlock;
 	}
 
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		goto err_unlock;
+
 	dev->iommu_param->sva_param = new_param;
 	mutex_unlock(&param->sva_lock);
 	return 0;
@@ -521,6 +536,7 @@ int iommu_sva_disable(struct device *dev)
 		goto out_unlock;
 	}
 
+	iommu_unregister_device_fault_handler(dev);
 	kfree(param->sva_param);
 	param->sva_param = NULL;
 out_unlock:
-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
