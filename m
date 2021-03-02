Return-Path: <SRS0=VFJV=IA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C00C43381
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 09:35:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D3D64F1E
	for <iommu@archiver.kernel.org>; Tue,  2 Mar 2021 09:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D3D64F1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F9BF4F11E;
	Tue,  2 Mar 2021 09:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dc6tkHgMtIgc; Tue,  2 Mar 2021 09:35:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB7E24F133;
	Tue,  2 Mar 2021 09:35:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26A6FC0012;
	Tue,  2 Mar 2021 09:35:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B45FC0001
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A3C4430C4
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6kqfZj-b7udH for <iommu@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:35:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FFF243069
 for <iommu@lists.linux-foundation.org>; Tue,  2 Mar 2021 09:35:36 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id m1so1944503wml.2
 for <iommu@lists.linux-foundation.org>; Tue, 02 Mar 2021 01:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fAwFmceeI8PT69Qzv7BbL234cbzlwFiSG33CnDCXBuk=;
 b=pVUo6Je1O9n09zMy7XzMnOeoxCf2gwvJSFjHsUpFlcN2ASmVQotVn/P3GJaA2vMsPG
 5Oa73C/bPbSORaAchXIQza2ekIiLHAMzhiBZSlMfN6WbI9De+lb3VRTl3rQ2yQVlngcr
 V2RHEDDpBUjaRbWMvhc/3ySgIrurqPttQruKNTQF2GytX5XdWxpKNvyRtIS3TzMszIvc
 JBZB4CBm0UCJiSKiLxjvSyjWHHMuuOuEHyTWoD+ba6Xp8wX8IFgRMCwyw68DBIQ5z2iC
 eWdpOaKbSD5yQITmiRYw1xTk99A7N0QY50S3SPObJAaXzoV7J2H4ZrpqEenmZmu1CZJM
 pCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fAwFmceeI8PT69Qzv7BbL234cbzlwFiSG33CnDCXBuk=;
 b=q1HPY1sfRqah3hUtIJnt+wdp88ds/M4b6mKryyC3x6hwdrCwKVjZWr3FaoJ/8BYBIO
 /WeMIHL5Vkq50u9aeC3ZCqimQnvdkBECxF3k6XIqISg/g6lpjDmq2vxdDWPRK7+bcnhh
 6NDwOX37UZbVXQMqpkUIECJUFEZnNuXD26XJF5Qvf/gWX4RTNQwRDUJ6tNIigdIof85R
 g4oDGleIJKquW5ulwqG3fUfDyTLm8edu27rlot6E7mQkZ8Di8C/bpNsX5gUVN4pX57Wu
 ElrqyyXOW2OUuRshB9ENXOc0DT89/nKNt9NcH8Z0Q9TdUoboxd9//SbThok9W/XGi8nE
 kQ0w==
X-Gm-Message-State: AOAM532VhLM3rPbeTdJWLMw3p4lSXAsrNlseTliQgRXJk0vGlWhp0Wo8
 BHfJhjU85AkflDP8ePmMFNJ08Q==
X-Google-Smtp-Source: ABdhPJwrpaQozpbifmdBMiCZvNYDUDCjs8CDLKRQmFMc/2Y3eNN20yvyuRxJXyxFUTgbOPqB1BFNww==
X-Received: by 2002:a1c:a504:: with SMTP id o4mr3053405wme.174.1614677734793; 
 Tue, 02 Mar 2021 01:35:34 -0800 (PST)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w131sm1963818wmb.8.2021.03.02.01.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 01:35:34 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v13 04/10] iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
Date: Tue,  2 Mar 2021 10:26:40 +0100
Message-Id: <20210302092644.2553014-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302092644.2553014-1-jean-philippe@linaro.org>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
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
index ee0932307d64..c5c5fd444779 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5343,6 +5343,8 @@ static int siov_find_pci_dvsec(struct pci_dev *pdev)
 static bool
 intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
 {
+	struct device_domain_info *info = get_domain_info(dev);
+
 	if (feat == IOMMU_DEV_FEAT_AUX) {
 		int ret;
 
@@ -5357,13 +5359,13 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
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
@@ -5374,6 +5376,9 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 	if (feat == IOMMU_DEV_FEAT_AUX)
 		return intel_iommu_enable_auxd(dev);
 
+	if (feat == IOMMU_DEV_FEAT_IOPF)
+		return intel_iommu_dev_has_feat(dev, feat) ? 0 : -ENODEV;
+
 	if (feat == IOMMU_DEV_FEAT_SVA) {
 		struct device_domain_info *info = get_domain_info(dev);
 
-- 
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
