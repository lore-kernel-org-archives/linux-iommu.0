Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1AFC433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 06:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F40664155A;
	Thu,  7 Apr 2022 06:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E1dVweldEOyJ; Thu,  7 Apr 2022 06:26:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9133D41603;
	Thu,  7 Apr 2022 06:26:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7202EC002C;
	Thu,  7 Apr 2022 06:26:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2969C0082
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:26:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E97260C03
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:26:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QF-UXmaOKZJG for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 06:26:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 224B960F7F
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 06:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
 Reply-To:Cc:Content-Type:Content-ID:Content-Description;
 bh=2IoIexP9KUatqgBFxOy/7I+NHAI49FZF4RurFvFzF8Q=; b=dRkCcpStppY1p1mA4NTyeqY2WH
 WGjVmos3Pt8AiHzjYeneEFf/yUcE/cFhkT3+LQ3yZCBILcC6VzrxwEl5I4xiqQdcrDwgE56wOeRhB
 nEEQ+aESNiErM4WmMF+f7+eGSKpUvX5qaRh08aKV82mfWQuSID0MoEonlC9PqSceatL7MgZFCoPIv
 Yqh4zK+C4tRtf00M7OAcURL3mV3pFaoabKsvbWRKSw7NYMsEuoREemKJLt7sc6w2ULrPz4BVIRzR3
 LRsNf0X9bJYI71QmrG9afN34jndNRGk0+dYhahH5UTy+ADoeDnK2Z1Jm2uGfzFtMdRo/7326nrjvN
 op6/qGCg==;
Received: from [2001:4bb8:184:7553:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncLb3-009flH-Uu; Thu, 07 Apr 2022 06:26:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>, Sven Peter <sven@svenpeter.dev>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Yong Wu <yong.wu@mediatek.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 4/4] iommu/arm-smmu-v3: cleanup arm_smmu_dev_{enable,
 disable}_feature
Date: Thu,  7 Apr 2022 08:26:08 +0200
Message-Id: <20220407062608.711392-5-hch@lst.de>
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

Fold the arm_smmu_dev_has_feature arm_smmu_dev_feature_enabled into
the main methods.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 57 ++++++---------------
 1 file changed, 15 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1ea184bbf750a6..8e201c660139ae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2760,58 +2760,27 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	iommu_dma_get_resv_regions(dev, head);
 }
 
-static bool arm_smmu_dev_has_feature(struct device *dev,
-				     enum iommu_dev_features feat)
-{
-	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-
-	if (!master)
-		return false;
-
-	switch (feat) {
-	case IOMMU_DEV_FEAT_IOPF:
-		return arm_smmu_master_iopf_supported(master);
-	case IOMMU_DEV_FEAT_SVA:
-		return arm_smmu_master_sva_supported(master);
-	default:
-		return false;
-	}
-}
-
-static bool arm_smmu_dev_feature_enabled(struct device *dev,
-					 enum iommu_dev_features feat)
-{
-	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
-
-	if (!master)
-		return false;
-
-	switch (feat) {
-	case IOMMU_DEV_FEAT_IOPF:
-		return master->iopf_enabled;
-	case IOMMU_DEV_FEAT_SVA:
-		return arm_smmu_master_sva_enabled(master);
-	default:
-		return false;
-	}
-}
-
 static int arm_smmu_dev_enable_feature(struct device *dev,
 				       enum iommu_dev_features feat)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
-	if (!arm_smmu_dev_has_feature(dev, feat))
-		return -ENODEV;
-
-	if (arm_smmu_dev_feature_enabled(dev, feat))
-		return -EBUSY;
+	if (!master)
+		return -EINVAL;
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
+		if (!arm_smmu_master_iopf_supported(master))
+			return -EINVAL;
+		if (master->iopf_enabled)
+			return -EBUSY;
 		master->iopf_enabled = true;
 		return 0;
 	case IOMMU_DEV_FEAT_SVA:
+		if (!arm_smmu_master_sva_supported(master))
+			return -EINVAL;
+		if (arm_smmu_master_sva_enabled(master))
+			return -EBUSY;
 		return arm_smmu_master_enable_sva(master);
 	default:
 		return -EINVAL;
@@ -2823,16 +2792,20 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
-	if (!arm_smmu_dev_feature_enabled(dev, feat))
+	if (!master)
 		return -EINVAL;
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
+		if (!master->iopf_enabled)
+			return -EINVAL;
 		if (master->sva_enabled)
 			return -EBUSY;
 		master->iopf_enabled = false;
 		return 0;
 	case IOMMU_DEV_FEAT_SVA:
+		if (!arm_smmu_master_sva_enabled(master))
+			return -EINVAL;
 		return arm_smmu_master_disable_sva(master);
 	default:
 		return -EINVAL;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
