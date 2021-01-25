Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D96C433DB
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 11:08:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B13229EF
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 11:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B13229EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C234687453;
	Mon, 25 Jan 2021 11:08:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id juDntfRh+HXk; Mon, 25 Jan 2021 11:08:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 32DD48745F;
	Mon, 25 Jan 2021 11:08:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 204C7C1E6F;
	Mon, 25 Jan 2021 11:08:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFC7CC013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 11:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D95562E132
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 11:08:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dBi40ZH93ZXE for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 11:08:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by silver.osuosl.org (Postfix) with ESMTPS id 6A96E20476
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 11:08:48 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id s24so10253235wmj.0
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 03:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0HAbfAEz8TnDqiVsICUxE3hnnLknlvV/GMLCZp7lxlM=;
 b=rSVIjdC8auMNf3CzZHMj2V5f//KBePOMSE1xJsfhrdqnk+R7tLKov8OtTs4OoGyGCz
 tAhzdrunXOWEUWgI/eb8yjnFbAsLVxgel2IAvs86EletOyYtNUovgXfYIV/Mx1Fi3mdR
 7+g6OkoWx1rQ61ah5fpmX3QQHoF8QWYU4/iT+iSly7H2QW+JG+Gv4HbeLoheGKRPUKjf
 SOCKdkQlMv+MModmy88QGqNISODCenboQjcS5OLpyPGnhdTdQnAug522uBBWgWOHnUoc
 SiOrsSKcq9FBUMUmBZvZT7pj6bYmnWHY2BJjKW8gIDFP/J+hu+5xrm+Atpu14Y4SUVc2
 cHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0HAbfAEz8TnDqiVsICUxE3hnnLknlvV/GMLCZp7lxlM=;
 b=qaSTngJXr7zwUqqsba6WB4RudSmn+357kcRzEOsKbUPCakLxPDfacnraNLRjSriEsA
 SqnQ46Ja6ZKhfDy5AazRNp1+/ts2kkfx6PpBNxL9k2RGXyXMvXwAiBjxvyDHWZWak30R
 c3OgXJpNYrryo5zVyMHyDraztAltKuD5zkTlXK1Vfl8+SNc4BfwlCSYwIkCjPJTk2M74
 505frfzyPfv5RPYwEbuV13GMXDED4Db19P9ZS4p0SLeiTp08qOdoo4NmUZfWxsEY19Lx
 cf1kb0KC0ujcE2EbSCyfDQ2x/4wUgSjiUJTw1gBxcM3Lg4rZKfUXPWc9s0iJAHdmbW17
 wmkg==
X-Gm-Message-State: AOAM5308IoVjhEOetg8lx5M/vDWUwnPIV2RIHg00CZLl6lWXt6BYH0mA
 o7C4FXSutyafRBEOs8Y0Oag0Vg==
X-Google-Smtp-Source: ABdhPJxW3kalVcKronU/Bq3GDFRBFh6XnccMSbY4dwqLUi+K5Jm1MMI2u1qjVqMNJzzSkl044nm5ug==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr2104533wmb.155.1611572926856; 
 Mon, 25 Jan 2021 03:08:46 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u6sm16636014wro.75.2021.01.25.03.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 03:08:46 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v11 04/10] iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
Date: Mon, 25 Jan 2021 12:06:45 +0100
Message-Id: <20210125110650.3232195-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210125110650.3232195-1-jean-philippe@linaro.org>
References: <20210125110650.3232195-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: vivek.gautam@arm.com, guohanjun@huawei.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-acpi@vger.kernel.org,
 zhangfei.gao@linaro.org, lenb@kernel.org, devicetree@vger.kernel.org,
 kevin.tian@intel.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 David Woodhouse <dwmw2@infradead.org>, rjw@rjwysocki.net,
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

Allow drivers to query and enable IOMMU_DEV_FEAT_IOPF, which amounts to
checking whether PRI is enabled.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f665322a0991..c777bd94df5d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5330,6 +5330,8 @@ static int siov_find_pci_dvsec(struct pci_dev *pdev)
 static bool
 intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 {
+	struct device_domain_info *info = get_domain_info(dev);
+
 	if (feat == IOMMU_DEV_FEAT_AUX) {
 		int ret;
 
@@ -5344,13 +5346,13 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 		return !!siov_find_pci_dvsec(to_pci_dev(dev));
 	}
 
-	if (feat == IOMMU_DEV_FEAT_SVA) {
-		struct device_domain_info *info = get_domain_info(dev);
+	if (feat == IOMMU_DEV_FEAT_IOPF)
+		return info && info->pri_supported;
 
+	if (feat == IOMMU_DEV_FEAT_SVA)
 		return info && (info->iommu->flags & VTD_FLAG_SVM_CAPABLE) &&
 			info->pasid_supported && info->pri_supported &&
 			info->ats_supported;
-	}
 
 	return false;
 }
@@ -5361,6 +5363,9 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 	if (feat == IOMMU_DEV_FEAT_AUX)
 		return intel_iommu_enable_auxd(dev);
 
+	if (feat == IOMMU_DEV_FEAT_IOPF)
+		return intel_iommu_dev_has_feat(dev, feat) ? 0 : -ENODEV;
+
 	if (feat == IOMMU_DEV_FEAT_SVA) {
 		struct device_domain_info *info = get_domain_info(dev);
 
-- 
2.30.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
