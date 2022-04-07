Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96911C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 06:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49E794155A;
	Thu,  7 Apr 2022 06:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GrssE73PA-zz; Thu,  7 Apr 2022 06:26:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EFEF541603;
	Thu,  7 Apr 2022 06:26:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84A45C0083;
	Thu,  7 Apr 2022 06:26:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C70DAC002F
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8AC3540160
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rgGFcOGxxuip for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:26:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8830940133
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
 Reply-To:Cc:Content-Type:Content-ID:Content-Description;
 bh=q0u1zuis2iM+r72peFTtVQaOYyuHJbqZ8LmuDIob4d0=; b=woIHsKemi7v/eaKr2jmLTYix54
 vqgEdls82vkr9NQQ34OJ5XpKH0bd83/R5SS3vNpDa2La5G9KHiXYa3yZGsWVoIgWmTYgmizbTPv+/
 hTqQSBCwNg2UVil1U/dol/sgaG9Zn+VvkEaSrw+t08OudqKZ+U8Y4qc5q2x13maBOEEwch+CpMzQx
 v7ZWcwgTHVIBjUyLgbe/z5vK6HPadJYWdiHQFMvm+sxcCi4hkwemJjORzaXn09qdFyU5wFvJrWCU5
 BL6N3Gwy7rL++h0PUSv3GDdBn0MSyd7NzoAHt5/8FCn0h0PKaGd4vHqcKyRlnHXiJTolZSFYIuHgn
 gOUpPAAg==;
Received: from [2001:4bb8:184:7553:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncLav-009fjA-R5; Thu, 07 Apr 2022 06:26:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Sven Peter <sven@svenpeter.dev>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Yong Wu <yong.wu@mediatek.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 1/4] iommu: remove the unused dev_has_feat method
Date: Thu,  7 Apr 2022 08:26:05 +0200
Message-Id: <20220407062608.711392-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407062608.711392-1-hch@lst.de>
References: <20220407062608.711392-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

This method is never actually called.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 -
 include/linux/iommu.h                       | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 627a3ed5ee8fd1..d6110271761d4a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2848,7 +2848,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
-	.dev_has_feat		= arm_smmu_dev_has_feature,
 	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9208eca4b0d1ac..79b74fcdd57e63 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -153,8 +153,7 @@ struct iommu_resv_region {
  *			 supported, this feature must be enabled before and
  *			 disabled after %IOMMU_DEV_FEAT_SVA.
  *
- * Device drivers query whether a feature is supported using
- * iommu_dev_has_feature(), and enable it using iommu_dev_enable_feature().
+ * Device drivers enable a feature using iommu_dev_enable_feature().
  */
 enum iommu_dev_features {
 	IOMMU_DEV_FEAT_SVA,
@@ -237,7 +236,6 @@ struct iommu_ops {
 	bool (*is_attach_deferred)(struct device *dev);
 
 	/* Per device IOMMU features */
-	bool (*dev_has_feat)(struct device *dev, enum iommu_dev_features f);
 	bool (*dev_feat_enabled)(struct device *dev, enum iommu_dev_features f);
 	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
 	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
