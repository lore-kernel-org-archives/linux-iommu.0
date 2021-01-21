Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAD6C433E6
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 12:39:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4FA23A1C
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 12:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4FA23A1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 34AA4871CF;
	Thu, 21 Jan 2021 12:39:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ueLxR-jqjH+m; Thu, 21 Jan 2021 12:39:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B8A98871B6;
	Thu, 21 Jan 2021 12:39:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A31ECC08A1;
	Thu, 21 Jan 2021 12:39:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BE5EC013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 03405207A8
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TvCSULu+GdiP for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 12:39:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by silver.osuosl.org (Postfix) with ESMTPS id A8A52204B5
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 12:39:37 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id 7so1605813wrz.0
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 04:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QfRTrz4FGk7QYqRZvdYQ9j81IIMEaiK0cgAthveICn8=;
 b=cQVnXvxX7ce/tzwytyh2JzCq/8Uvcz1sgn8551t6FHNYSocO2Z8CA5Md0RYrty9/sf
 nR6zspWcun7taP7uDmLQGB4dhSWd4vlipzyyro8VdoBvmhAslUAmXXj6+BTkMz0n4g0q
 lSslcyqBhYjQfDWJrU6sXGAkgm3RdOPPyy9Zo47zOtXrWTAC68UoEBDxiMOlMiUlyL5O
 PNB0hOVIM6X+zwo2F+PuCWADDNaEOQPSWdtsEwKwRAWSqpM4RVF9Ykz6/lG4JpCtE3gT
 4ekdEy5fqlNKQzZRRKDBXyC9IQt+M7xT7yIuHJrTNfvc5HSTIPh6fc16Jg7c5b19PamU
 MEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QfRTrz4FGk7QYqRZvdYQ9j81IIMEaiK0cgAthveICn8=;
 b=jPoaC4+xaKzUB6SA201r0GyaexTLGsu+gi8Z/9aDepwAR6NXla/kN9KLLFNECPEpyC
 LQfyAKqur0o0uDDiQyfBWMaGB4fKYjpKLurGRCbSIbE89+p+p/U8d6Ue51i4r8zvYDg4
 wwC0NWJJe8qqZEotPVr8YdO/0beZihac+RmGuptHbBeJqYTwHgiGa1+w/4Fbn1MGrl+a
 ZWX8mFub5WLZCg/gBHlCfaO9E4kgq9pggfi/HZzIcMN5M8z+Bc9zXNTsFATmcB80DHPS
 F1vHBgIasLl9wODJOCmgk4ChmEPzX39mWmz91rDPezyyXSO/3+3pPhY82qIT4QsLwBru
 yA2g==
X-Gm-Message-State: AOAM530V88NeOVcPJ/lfdto+kTTyKi+JsI/n36euyMg5jg1IAle/73Hz
 iErJxAYkOsfhFqfozK8XS7MStQ==
X-Google-Smtp-Source: ABdhPJwSIF4lYkXg0JDArr7VyYpWpZBMJebamCEs4XGcl3wSjZlLaAvAoz8hiztLDcsi8cTAFpm1/g==
X-Received: by 2002:a5d:504d:: with SMTP id h13mr14277328wrt.246.1611232776100; 
 Thu, 21 Jan 2021 04:39:36 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p18sm7979248wmc.31.2021.01.21.04.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 04:39:35 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v10 04/10] iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
Date: Thu, 21 Jan 2021 13:36:18 +0100
Message-Id: <20210121123623.2060416-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121123623.2060416-1-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
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
