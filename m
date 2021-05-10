Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEE2C433B4
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 06:54:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6686143B
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 06:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6686143B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2F3C83A58;
	Mon, 10 May 2021 06:54:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUYofUcrDhb5; Mon, 10 May 2021 06:54:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DD888375B;
	Mon, 10 May 2021 06:54:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88BCEC000D;
	Mon, 10 May 2021 06:54:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D41EC0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C13A660A36
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Z4ENGypVGcV for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 06:54:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E792460780
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 06:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=0VMSk2WoZ7U5DtJ0FPU/Vhd6vJz43QHbgxIeBWhNb/I=; b=KFyjDO1zPsK6JPBlXOAElYMkwI
 KQzyEp3R7D5caVRr1N0oJ2D2CUAqaQAoEb4FUeqm6numcnbXvftlVFFu+Qx2DprmftXow1bpkwRpr
 FCw9/Peq73NhBWMt7///LEEBCn58efP6ITA3zURBLg5rt8ivstn41DWHbhzur9273Y7y8SUPr00td
 3G59w9MS8E7jhRNYehv5MASC8AUJBOUJjw5TMYtIX44aHXInsvZI8GnbUVJ3TgDTRzfl14dsv81Ev
 x3NZjmxNebU+sYoOjebp8qey508RCAP6LMXHhiK+b/q5rtLDeIVGwWGgZ5TvjbV7Xw1E6wM435xux
 lwXARPlg==;
Received: from [2001:4bb8:198:fbc8:e179:16d2:93d1:8e1] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lfznu-008Lo5-Bp; Mon, 10 May 2021 06:54:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 1/6] iommu: remove the unused dev_has_feat method
Date: Mon, 10 May 2021 08:54:00 +0200
Message-Id: <20210510065405.2334771-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510065405.2334771-1-hch@lst.de>
References: <20210510065405.2334771-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: kvm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Kirti Wankhede <kwankhede@nvidia.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

This method is never actually called.  Simplify the instance in
intel-iommu that is directly called by inlining the relevant code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  1 -
 drivers/iommu/intel/iommu.c                 | 67 ++-------------------
 include/linux/iommu.h                       |  4 +-
 3 files changed, 7 insertions(+), 65 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54b2f27b81d439..9689563eec0f30 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2666,7 +2666,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
-	.dev_has_feat		= arm_smmu_dev_has_feature,
 	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 708f430af1c440..ba1060f6785119 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5326,72 +5326,18 @@ static int intel_iommu_disable_auxd(struct device *dev)
 	return 0;
 }
 
-/*
- * A PCI express designated vendor specific extended capability is defined
- * in the section 3.7 of Intel scalable I/O virtualization technical spec
- * for system software and tools to detect endpoint devices supporting the
- * Intel scalable IO virtualization without host driver dependency.
- *
- * Returns the address of the matching extended capability structure within
- * the device's PCI configuration space or 0 if the device does not support
- * it.
- */
-static int siov_find_pci_dvsec(struct pci_dev *pdev)
-{
-	int pos;
-	u16 vendor, id;
-
-	pos = pci_find_next_ext_capability(pdev, 0, 0x23);
-	while (pos) {
-		pci_read_config_word(pdev, pos + 4, &vendor);
-		pci_read_config_word(pdev, pos + 8, &id);
-		if (vendor == PCI_VENDOR_ID_INTEL && id == 5)
-			return pos;
-
-		pos = pci_find_next_ext_capability(pdev, pos, 0x23);
-	}
-
-	return 0;
-}
-
-static bool
-intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
-{
-	struct device_domain_info *info = get_domain_info(dev);
-
-	if (feat == IOMMU_DEV_FEAT_AUX) {
-		int ret;
-
-		if (!dev_is_pci(dev) || dmar_disabled ||
-		    !scalable_mode_support() || !pasid_mode_support())
-			return false;
-
-		ret = pci_pasid_features(to_pci_dev(dev));
-		if (ret < 0)
-			return false;
-
-		return !!siov_find_pci_dvsec(to_pci_dev(dev));
-	}
-
-	if (feat == IOMMU_DEV_FEAT_IOPF)
-		return info && info->pri_supported;
-
-	if (feat == IOMMU_DEV_FEAT_SVA)
-		return info && (info->iommu->flags & VTD_FLAG_SVM_CAPABLE) &&
-			info->pasid_supported && info->pri_supported &&
-			info->ats_supported;
-
-	return false;
-}
-
 static int
 intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
 {
 	if (feat == IOMMU_DEV_FEAT_AUX)
 		return intel_iommu_enable_auxd(dev);
 
-	if (feat == IOMMU_DEV_FEAT_IOPF)
-		return intel_iommu_dev_has_feat(dev, feat) ? 0 : -ENODEV;
+	if (feat == IOMMU_DEV_FEAT_IOPF) {
+		struct device_domain_info *info = get_domain_info(dev);
+
+		if (info &&  info->pri_supported)
+			return 0;
+	}
 
 	if (feat == IOMMU_DEV_FEAT_SVA) {
 		struct device_domain_info *info = get_domain_info(dev);
@@ -5552,7 +5498,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
 	.device_group		= intel_iommu_device_group,
-	.dev_has_feat		= intel_iommu_dev_has_feat,
 	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
 	.dev_enable_feat	= intel_iommu_dev_enable_feat,
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf76e..1092a7f967a5e8 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -141,8 +141,7 @@ struct iommu_resv_region {
  *			 supported, this feature must be enabled before and
  *			 disabled after %IOMMU_DEV_FEAT_SVA.
  *
- * Device drivers query whether a feature is supported using
- * iommu_dev_has_feature(), and enable it using iommu_dev_enable_feature().
+ * Device drivers enable a feature using iommu_dev_enable_feature().
  */
 enum iommu_dev_features {
 	IOMMU_DEV_FEAT_AUX,
@@ -256,7 +255,6 @@ struct iommu_ops {
 	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
 
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
