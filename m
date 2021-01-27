Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA70C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 15:44:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF7F20848
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 15:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF7F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 06B7A87204;
	Wed, 27 Jan 2021 15:44:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VP1bTvrhUGQf; Wed, 27 Jan 2021 15:44:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F020871F9;
	Wed, 27 Jan 2021 15:44:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01B9DC1E6F;
	Wed, 27 Jan 2021 15:44:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B78FDC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B4169868F8
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5NO+BbrIOiRN for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 15:44:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8F90D8559F
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:41 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id f16so1910090wmq.5
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 07:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2eRhKsVau0r7rYJc5kg9wODttGekaxkRDREYSkG2V3g=;
 b=ivODR+o+zeC+VLJ0NgPRRPEDqKLo115ma74DNu8zGnxMHACyPpvmyq2NbKEY54zWcC
 HMm/wagqjHGCTD9o5sOyQaYdwXrhGcQkH2bd8KUAVmSLDxtP1uQgJJQRingKBA0YhTVP
 sWQ+mMRICXpCezAP6Oj2gsHkGf+PQTmlM6VqnZ2A0kBbV37ha72LnnyjtE1Y1DSOhWUn
 uSlXLg2b3WTL1E3LYGyJUyJOQ3ycX5g0wj/1R/jq2nm0TPNsCHwArjYP5pnIHZKPQdek
 rkX5+FHD4bTJn/ZGAgi+VVGF9SZRHo5GHcqKmqn+22Vc1eUWA9hrfnlUvtNucqx/emx/
 3qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2eRhKsVau0r7rYJc5kg9wODttGekaxkRDREYSkG2V3g=;
 b=bAcefCF4g+R28NDU6iAmCvmtq5WZCaP/p6DUrN20mP9wPaYAWllyYRSu/d0ivRL7Nz
 2A18s6wj3zI8l80GzEevmkPZxy0neaaXXQfleHDD1Eh+fYde9G7QXVgqrxPjs0Nl0APb
 FN2AO4yhGo4ELFFOWcPzEEtQq7JeWfUb55VYzEqruGEdPTTp8qq6UFt/X9HRUG8EE9He
 gUIZvc2acr6o5GTflU+TGhPE4kCw8L+9HWdAVtsQanPmoH9FnZo9t3ViIrK6DJGWXpzk
 CqL/BazCFjHvI5JTu6huilOSgjmU99eRgWj8wHc56D99HESlzQ+GRd/Q9a+kwmYyH/R3
 qJOA==
X-Gm-Message-State: AOAM533iGuXZTB009J/iU5ZjugniCs626mqF+jdRSt4UmyR9L+dKQA97
 ANu0QVoBNdh5XYxS9gO6pIXJ6g==
X-Google-Smtp-Source: ABdhPJxr39fOX5xOKZJ7056iYkfGE0ff9RVjMHP+RXDOKdYYJhUVMNZ134uue8JaYJwiEpNgh/5HrQ==
X-Received: by 2002:a1c:7e4e:: with SMTP id z75mr4860472wmc.168.1611762280149; 
 Wed, 27 Jan 2021 07:44:40 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r13sm3046921wmh.9.2021.01.27.07.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jan 2021 07:44:39 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v12 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
Date: Wed, 27 Jan 2021 16:43:18 +0100
Message-Id: <20210127154322.3959196-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210127154322.3959196-1-jean-philippe@linaro.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: vivek.gautam@arm.com, guohanjun@huawei.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, Arnd Bergmann <arnd@arndb.de>, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 linux-accelerators@lists.ozlabs.org
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

The IOPF (I/O Page Fault) feature is now enabled independently from the
SVA feature, because some IOPF implementations are device-specific and
do not require IOMMU support for PCIe PRI or Arm SMMU stall.

Enable IOPF unconditionally when enabling SVA for now. In the future, if
a device driver implementing a uacce interface doesn't need IOPF
support, it will need to tell the uacce module, for example with a new
flag.

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/misc/uacce/uacce.c | 39 +++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index d07af4edfcac..6db7a98486ec 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -385,6 +385,33 @@ static void uacce_release(struct device *dev)
 	kfree(uacce);
 }
 
+static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
+{
+	if (!(flags & UACCE_DEV_SVA))
+		return flags;
+
+	flags &= ~UACCE_DEV_SVA;
+
+	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF))
+		return flags;
+
+	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
+		iommu_dev_disable_feature(parent, IOMMU_DEV_FEAT_IOPF);
+		return flags;
+	}
+
+	return flags | UACCE_DEV_SVA;
+}
+
+static void uacce_disable_sva(struct uacce_device *uacce)
+{
+	if (!(uacce->flags & UACCE_DEV_SVA))
+		return;
+
+	iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+	iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
+}
+
 /**
  * uacce_alloc() - alloc an accelerator
  * @parent: pointer of uacce parent device
@@ -404,11 +431,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	if (!uacce)
 		return ERR_PTR(-ENOMEM);
 
-	if (flags & UACCE_DEV_SVA) {
-		ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
-		if (ret)
-			flags &= ~UACCE_DEV_SVA;
-	}
+	flags = uacce_enable_sva(parent, flags);
 
 	uacce->parent = parent;
 	uacce->flags = flags;
@@ -432,8 +455,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	return uacce;
 
 err_with_uacce:
-	if (flags & UACCE_DEV_SVA)
-		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+	uacce_disable_sva(uacce);
 	kfree(uacce);
 	return ERR_PTR(ret);
 }
@@ -487,8 +509,7 @@ void uacce_remove(struct uacce_device *uacce)
 	mutex_unlock(&uacce->queues_lock);
 
 	/* disable sva now since no opened queues */
-	if (uacce->flags & UACCE_DEV_SVA)
-		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
+	uacce_disable_sva(uacce);
 
 	if (uacce->cdev)
 		cdev_device_del(uacce->cdev, &uacce->dev);
-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
