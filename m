Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D1CC43460
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 16:32:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369BB613AF
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 16:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369BB613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01BE3615F0;
	Fri, 23 Apr 2021 16:32:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kuy3pSDZBt4f; Fri, 23 Apr 2021 16:32:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD0C960674;
	Fri, 23 Apr 2021 16:32:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD7F5C000E;
	Fri, 23 Apr 2021 16:32:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFC1AC001B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF7C484358
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:32:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3JOmT15-L6xu for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 16:32:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D3C2D842FB
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 16:32:01 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id x12so54007507ejc.1
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lxQFozX7f08xU1iuPNW5K35e7ba5gFMB/xlfq4TbD+Q=;
 b=kIAvihWG6rHLgWY7kHJN2x8/gBNag0crjXobi6/gdhYM4vY80679I7ZpOKeFGdAgw8
 bauT/RB6YJ7gFUW2QkMRDA5w39Pv2Zyf+jahAHIeX21Dkixj7T901ZHUWseYXXZGQsnG
 TMXDwnv4vk3JLTIjoPsP3dLmvXz3Z1cgEySkCVX8YgISSZebn6EXlP3Fivc/WIJ3H7rU
 b8mdL8QaKIJr+hPOfMAY4U+wjAoGslshpUTa5sN/7ODL2fjBx33ztBFlYIv6QtZbFOYy
 aE5Rlno01OThlxJot/ovWqvY3QC5K7x19+40UNXklQuUpMh4gmBCh5e5PSXd/ng9xpET
 4JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lxQFozX7f08xU1iuPNW5K35e7ba5gFMB/xlfq4TbD+Q=;
 b=IaEEcUC2DOLFfQ14gy/yfAhZ7iEAF/X/yQexR1CVO3G25WW7Y25kZlP+bhMbnncbqP
 XbpH26dQKuDRLNy85J+NjFaWFZiVfvUty5b1FH15QUWGRcGTHS6RXKQFBJ0Ka4CscVMk
 wDwsRXbxDekY9uwwDHwp5KJwaE9S1peifx+8c747ljv99AkhtBYEf36fOFkSYil670B3
 NjdjKtWHeCQhYKr6HqRWVxBryuJXcAL/eNo+rR/o+a5StHJYedt3+4uCViqqlTpgKPm5
 E5IGk3pi2ggbwl0F/zxDipYxdUBYz0XjABSCOAEGGmq92XUWuIRkAqA5efMczX5qsfM0
 50Uw==
X-Gm-Message-State: AOAM53027NdJTRu4Bpg6kZ+jiaVJQlAK3YuUrSJ3Vtv0M5adHXyIXH0x
 O0O3SI/xnWXXNBSGKiyJAx8=
X-Google-Smtp-Source: ABdhPJz4i8Ne8vIi19Wcr9DGugu9QodJTGEBRss/wSWTTTIhQt3eK5qSDEOq3dofD1Tp8doRGKxW/Q==
X-Received: by 2002:a17:907:9485:: with SMTP id
 dm5mr5186154ejc.194.1619195519944; 
 Fri, 23 Apr 2021 09:31:59 -0700 (PDT)
Received: from localhost ([62.96.65.119])
 by smtp.gmail.com with ESMTPSA id ca1sm5042934edb.76.2021.04.23.09.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Apr 2021 09:31:59 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 5/5] iommu/tegra-smmu: Support managed domains
Date: Fri, 23 Apr 2021 18:32:34 +0200
Message-Id: <20210423163234.3651547-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423163234.3651547-1-thierry.reding@gmail.com>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
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

From: Navneet Kumar <navneetk@nvidia.com>

Allow creating identity and DMA API compatible IOMMU domains. When
creating a DMA API compatible domain, make sure to also create the
required cookie.

Signed-off-by: Navneet Kumar <navneetk@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 47 ++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 6bf7654371c5..40647e1f03ae 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-iommu.h>
 
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
@@ -281,8 +282,11 @@ static bool tegra_smmu_capable(enum iommu_cap cap)
 static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 {
 	struct tegra_smmu_as *as;
+	int ret;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED)
+	if (type != IOMMU_DOMAIN_UNMANAGED &&
+	    type != IOMMU_DOMAIN_DMA &&
+	    type != IOMMU_DOMAIN_IDENTITY)
 		return NULL;
 
 	as = kzalloc(sizeof(*as), GFP_KERNEL);
@@ -291,26 +295,23 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 
 	as->attr = SMMU_PD_READABLE | SMMU_PD_WRITABLE | SMMU_PD_NONSECURE;
 
-	as->pd = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
-	if (!as->pd) {
-		kfree(as);
-		return NULL;
+	if (type == IOMMU_DOMAIN_DMA) {
+		ret = iommu_get_dma_cookie(&as->domain);
+		if (ret)
+			goto free_as;
 	}
 
+	as->pd = alloc_page(GFP_KERNEL | __GFP_DMA | __GFP_ZERO);
+	if (!as->pd)
+		goto put_dma_cookie;
+
 	as->count = kcalloc(SMMU_NUM_PDE, sizeof(u32), GFP_KERNEL);
-	if (!as->count) {
-		__free_page(as->pd);
-		kfree(as);
-		return NULL;
-	}
+	if (!as->count)
+		goto free_pd_range;
 
 	as->pts = kcalloc(SMMU_NUM_PDE, sizeof(*as->pts), GFP_KERNEL);
-	if (!as->pts) {
-		kfree(as->count);
-		__free_page(as->pd);
-		kfree(as);
-		return NULL;
-	}
+	if (!as->pts)
+		goto free_pts;
 
 	spin_lock_init(&as->lock);
 
@@ -320,6 +321,18 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 	as->domain.geometry.force_aperture = true;
 
 	return &as->domain;
+
+free_pts:
+	kfree(as->pts);
+free_pd_range:
+	__free_page(as->pd);
+put_dma_cookie:
+	if (type == IOMMU_DOMAIN_DMA)
+		iommu_put_dma_cookie(&as->domain);
+free_as:
+	kfree(as);
+
+	return NULL;
 }
 
 static void tegra_smmu_domain_free(struct iommu_domain *domain)
@@ -1051,7 +1064,7 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.map = tegra_smmu_map,
 	.unmap = tegra_smmu_unmap,
 	.iova_to_phys = tegra_smmu_iova_to_phys,
-	.get_resv_regions = of_iommu_get_resv_regions,
+	.get_resv_regions = iommu_dma_get_resv_regions,
 	.put_resv_regions = generic_iommu_put_resv_regions,
 	.apply_resv_region = tegra_smmu_apply_resv_region,
 	.of_xlate = tegra_smmu_of_xlate,
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
