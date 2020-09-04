Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C314C433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:01:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055982074D
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 16:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tb1Sd+n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055982074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 892A9203AF;
	Fri,  4 Sep 2020 16:01:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NwMhUocsrasn; Fri,  4 Sep 2020 16:01:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A740B2010B;
	Fri,  4 Sep 2020 16:01:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86E80C0052;
	Fri,  4 Sep 2020 16:01:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4B59C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A7FBC203AF
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E1v-vi56iEpv for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 16:01:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by silver.osuosl.org (Postfix) with ESMTPS id A230D2010B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 16:01:54 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id g128so7578862iof.11
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ls6xTeazp01VU5rx1tZcn8CZ6m3ZwOm0FhCvNs4H/UM=;
 b=tb1Sd+n9qybC0+ro/HdiC+RBRiJc3INwSffhtqG6iMH+37s6uZXFul1N9db1cLf0O+
 W0rjcAJiucucmVQfVxG2MUkMAVBzL72kxYXPDM94Y8Eog3yqNAhbIBZ0SvhdqCqHjDss
 eqJnjUevNWz0I2ajfvSEgBRETGT0byopb7rb3HjelVEJIa/NYG7qIZZfDuUsq9UT8H2o
 wmlglYCueMqRUyXl0caryl5xIGgDggZeBNuaZUM8AtvG0YPJM0pCBnwyWbzDQmzoIDUC
 8377oUebGf4yS6DRCQMoNRh9frdfOYrnjbWjR3K67Znyzlh8ybqe7mNP7I9znqOGTQSk
 sGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ls6xTeazp01VU5rx1tZcn8CZ6m3ZwOm0FhCvNs4H/UM=;
 b=JtZgjHb19Uq2lDIvDvpTRsTa9ufomK/SyyF/ZbCJE9iUeGGe+eb7a7eAgHYM5rbU8G
 Zx5q4KmqAtsBEKwtx1tZVP73BRPrUl08paZVkENLDMyzVdIMMJNdtGBze2nSVAFkBgSS
 9SVWHQ79xPKVKYlvA1B2yM4JHpQYgQtTBGn02MZD5u/KW93LulLVHtsbyGkaTjtFEsgA
 ZGrvzccYlRM6sPO1/dHsZxOkwiUWLBxLb8jgk50SEMkusHruUNA7E2P8rQlwgZyQ/UmP
 PJNVT6yHbsmubh+sKT/hmUsrPVsS9R7wvRi/ucbYTJyTCQiFhA0Q5fcONZjb8sv9qDc9
 P6jw==
X-Gm-Message-State: AOAM5317lgSbWuaOl44tHsQRoU7PNmMxZE+NXxFqI1OltGAOP2y7Une9
 S2T/M5n6eC5EgGdfrOoBFlMmlyrhDq1B/g==
X-Google-Smtp-Source: ABdhPJyL88SwYtdr8vsyF/Q0nFNgzaGMkmnx++yP3wUNifIJQkEY1cF7fewzAafVU/vEqfUIMi+MHg==
X-Received: by 2002:ac8:17af:: with SMTP id o44mr9239269qtj.343.1599234921881; 
 Fri, 04 Sep 2020 08:55:21 -0700 (PDT)
Received: from localhost.localdomain
 (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
 by smtp.gmail.com with ESMTPSA id v18sm4724473qtq.15.2020.09.04.08.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 08:55:21 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Jordan Crouse <jcrouse@codeaurora.org>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH v3 6/8] iommu/arm-smmu: Add impl hook for inherit boot mappings
Date: Fri,  4 Sep 2020 15:55:11 +0000
Message-Id: <20200904155513.282067-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Sibi Sankar <sibis@codeaurora.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

Add a new operation to allow platform implementations to inherit any
stream mappings from the boot loader.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- New patch/interface

 drivers/iommu/arm/arm-smmu/arm-smmu.c | 11 ++++++-----
 drivers/iommu/arm/arm-smmu/arm-smmu.h |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index eb5c6ca5c138..4c4d302cd747 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -85,11 +85,6 @@ static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 		pm_runtime_put_autosuspend(smmu->dev);
 }
 
-static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct arm_smmu_domain, domain);
-}
-
 static struct platform_driver arm_smmu_driver;
 static struct iommu_ops arm_smmu_ops;
 
@@ -2188,6 +2183,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	if (smmu->impl->inherit_mappings) {
+		err = smmu->impl->inherit_mappings(smmu);
+		if (err)
+			return err;
+	}
+
 	if (smmu->version == ARM_SMMU_V2) {
 		if (smmu->num_context_banks > smmu->num_context_irqs) {
 			dev_err(dev,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 235d9a3a6ab6..f58164976e74 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -378,6 +378,11 @@ struct arm_smmu_domain {
 	struct iommu_domain		domain;
 };
 
+static inline struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct arm_smmu_domain, domain);
+}
+
 struct arm_smmu_master_cfg {
 	struct arm_smmu_device		*smmu;
 	s16				smendx[];
@@ -442,6 +447,7 @@ struct arm_smmu_impl {
 	int (*alloc_context_bank)(struct arm_smmu_domain *smmu_domain,
 				  struct arm_smmu_device *smmu,
 				  struct device *dev, int start);
+	int (*inherit_mappings)(struct arm_smmu_device *smmu);
 };
 
 #define INVALID_SMENDX			-1
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
