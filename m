Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350E1C433E0
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 15:44:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7B82080D
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 15:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7B82080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7FC90228B0;
	Wed, 27 Jan 2021 15:44:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VuA+iSNPd-E7; Wed, 27 Jan 2021 15:44:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D6A00226F3;
	Wed, 27 Jan 2021 15:44:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D096BC08A1;
	Wed, 27 Jan 2021 15:44:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B52FC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5A90185F4D
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bxw2LcK0Q6Q7 for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 15:44:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 636B985B0D
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 15:44:40 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id m13so2371391wro.12
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 07:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0HAbfAEz8TnDqiVsICUxE3hnnLknlvV/GMLCZp7lxlM=;
 b=ad/j4aBI/T3WQEdCN+D6UAssRoPtamKNCApTqJ4FK8vTOMCdUIsdNHY5IzN6j1WbgY
 +8re948rFqrdclQrOU+JQ7TK+1NZcyhl5Aw0t9A0R1Lxy2hKotqfrnQ/TcKW9OYoflRv
 aCDaEnJAJO/9z9KFs4OidYWk8o/9ptYrG9b6u4M/reWw2gwF1+9/jnnx8yRw4vkuau5W
 1o19RF+k1Mb91K5dJ4y+iYEQG9SvHHUf4d0+zb3Lxt4NOo2rs2euYSb+wQGCwe6OEE3C
 1352Mdoft0AYtZ72LLDVh3bk+vfGO2y3Vj5eB8jtgQZy7Kor4+bbXI2vnPnyWLGJuU2b
 VWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0HAbfAEz8TnDqiVsICUxE3hnnLknlvV/GMLCZp7lxlM=;
 b=RFPelvmEQgC+3sSTwiMC93HCl/PJbVWHcLuZEQowDoeczB5ZdjvM4ZfTsuiK6TG7nh
 PfZ1rV00UyB7xUEs8FqdoyW6EqR3KQJqg3rbr9H+qFU1qX3LcTQUC15U8uorXmb0EFKY
 ke2/t8EF3VcES4bnI6BdrEmovlrYP25StbGAbLhLrmVrj6Jp7SAilwRDJQweBUDRbHAx
 xRgCN+ahS4vsJF4+i+PoerKui5EDSa3rAzTnb3SJXxs70lr6EjXsya3W6scvLNuF5gz0
 +DyDmIcrFq0rFGQYUVDvVZwx+YnJMKxFpcV5ZmQGodvcJXLXKGdROSCKKuVC8ix5quGf
 scWw==
X-Gm-Message-State: AOAM532sbqTFMmIcibkbrWJuuHalmCWBh2zujzjnPXNMg5rK3zgq43VR
 wGWq4JqLCT7Yqc3yL6hv29qPIQ==
X-Google-Smtp-Source: ABdhPJxbp7bo3QjbnBits7bgWrNsTaylW9bW8JBsHqc833dGFAfY18iRqP1/Sk6YqyELC3Kkzp0OAA==
X-Received: by 2002:adf:fc8a:: with SMTP id g10mr12217200wrr.189.1611762278786; 
 Wed, 27 Jan 2021 07:44:38 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r13sm3046921wmh.9.2021.01.27.07.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jan 2021 07:44:38 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v12 04/10] iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
Date: Wed, 27 Jan 2021 16:43:17 +0100
Message-Id: <20210127154322.3959196-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210127154322.3959196-1-jean-philippe@linaro.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
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
