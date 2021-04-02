Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4542C433B4
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:33:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7259C60551
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7259C60551
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 331FF40F0D;
	Fri,  2 Apr 2021 14:33:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cBFVyYO5aBd9; Fri,  2 Apr 2021 14:33:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C54A440F7E;
	Fri,  2 Apr 2021 14:33:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 790C9C0013;
	Fri,  2 Apr 2021 14:33:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DAE7C000B
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E193384BCF
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QM_xKw0l7JRc for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 14:33:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 42BF484BB2
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=i8ncPWCApj/t/hZ33IDsyfWcY+KQkVA6sgGOCcGSJrs=; b=ISZvaMXW6FF7lDU/TTGRKu5lCH
 BW2UU2SrT6+ltA5McGzv2qWETMAC7fCAkJ1qhgSd2AQnC2BWnEMddPgfE3JVL2X7A/5gJb79dwI1M
 cEWVOP44EctmDNc5MuVzo9fKV+INYqQtcSncG56zRRqvRcyGHnnKA4bNtT3AuxNgOnJkrO89L14b8
 5t8BIERsohjPW7u2h4MHQR6l2sp9/OdNOqOlSYaOT6vso+sZ20oBMpSvsBtrJXHBJoAnjBZ+XwBVO
 aZZDpfjBndN43RIagW10U5lf0n43m8yGJwAwsEZbWmf4zxtZom6CyvJTU1cjct0LnVARoKxPBfhFr
 FBqGC2RQ==;
Received: from [2001:4bb8:180:7517:6acc:e698:6fa4:15da] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lSKrN-00FAFT-74; Fri, 02 Apr 2021 14:33:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/4] iommu/amd: remove the unused device errata code
Date: Fri,  2 Apr 2021 16:33:09 +0200
Message-Id: <20210402143312.372386-2-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210402143312.372386-1-hch@lst.de>
References: <20210402143312.372386-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org
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

The device errata mechism is entirely unused, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 -
 drivers/iommu/amd/iommu.c           | 56 ++---------------------------
 include/linux/amd-iommu.h           | 18 ----------
 3 files changed, 3 insertions(+), 72 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 6937e3674a16e2..94c1a7a9876d55 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -693,7 +693,6 @@ struct iommu_dev_data {
 	} ats;				  /* ATS state */
 	bool pri_tlp;			  /* PASID TLB required for
 					     PPR completions */
-	u32 errata;			  /* Bitmap for errata to apply */
 	bool use_vapic;			  /* Enable device to use vapic mode */
 	bool defer_attach;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a69a8b573e40d0..65ef07b048934c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -290,15 +290,6 @@ static bool pci_iommuv2_capable(struct pci_dev *pdev)
 	return true;
 }
 
-static bool pdev_pri_erratum(struct pci_dev *pdev, u32 erratum)
-{
-	struct iommu_dev_data *dev_data;
-
-	dev_data = dev_iommu_priv_get(&pdev->dev);
-
-	return dev_data->errata & (1 << erratum) ? true : false;
-}
-
 /*
  * This function checks if the driver got a valid device from the caller to
  * avoid dereferencing invalid pointers.
@@ -1531,33 +1522,9 @@ static void pdev_iommuv2_disable(struct pci_dev *pdev)
 	pci_disable_pasid(pdev);
 }
 
-/* FIXME: Change generic reset-function to do the same */
-static int pri_reset_while_enabled(struct pci_dev *pdev)
-{
-	u16 control;
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
-	if (!pos)
-		return -EINVAL;
-
-	pci_read_config_word(pdev, pos + PCI_PRI_CTRL, &control);
-	control |= PCI_PRI_CTRL_RESET;
-	pci_write_config_word(pdev, pos + PCI_PRI_CTRL, control);
-
-	return 0;
-}
-
 static int pdev_iommuv2_enable(struct pci_dev *pdev)
 {
-	bool reset_enable;
-	int reqs, ret;
-
-	/* FIXME: Hardcode number of outstanding requests for now */
-	reqs = 32;
-	if (pdev_pri_erratum(pdev, AMD_PRI_DEV_ERRATUM_LIMIT_REQ_ONE))
-		reqs = 1;
-	reset_enable = pdev_pri_erratum(pdev, AMD_PRI_DEV_ERRATUM_ENABLE_RESET);
+	int ret;
 
 	/* Only allow access to user-accessible pages */
 	ret = pci_enable_pasid(pdev, 0);
@@ -1570,16 +1537,11 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 		goto out_err;
 
 	/* Enable PRI */
-	ret = pci_enable_pri(pdev, reqs);
+	/* FIXME: Hardcode number of outstanding requests for now */
+	ret = pci_enable_pri(pdev, 32);
 	if (ret)
 		goto out_err;
 
-	if (reset_enable) {
-		ret = pri_reset_while_enabled(pdev);
-		if (ret)
-			goto out_err;
-	}
-
 	ret = pci_enable_ats(pdev, PAGE_SHIFT);
 	if (ret)
 		goto out_err;
@@ -2597,18 +2559,6 @@ struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(amd_iommu_get_v2_domain);
 
-void amd_iommu_enable_device_erratum(struct pci_dev *pdev, u32 erratum)
-{
-	struct iommu_dev_data *dev_data;
-
-	if (!amd_iommu_v2_supported())
-		return;
-
-	dev_data = dev_iommu_priv_get(&pdev->dev);
-	dev_data->errata |= (1 << erratum);
-}
-EXPORT_SYMBOL(amd_iommu_enable_device_erratum);
-
 int amd_iommu_device_info(struct pci_dev *pdev,
                           struct amd_iommu_device_info *info)
 {
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 450717299928bb..474065ed88a495 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -32,24 +32,6 @@ struct pci_dev;
 extern int amd_iommu_detect(void);
 extern int amd_iommu_init_hardware(void);
 
-/**
- * amd_iommu_enable_device_erratum() - Enable erratum workaround for device
- *				       in the IOMMUv2 driver
- * @pdev: The PCI device the workaround is necessary for
- * @erratum: The erratum workaround to enable
- *
- * The function needs to be called before amd_iommu_init_device().
- * Possible values for the erratum number are for now:
- * - AMD_PRI_DEV_ERRATUM_ENABLE_RESET - Reset PRI capability when PRI
- *					is enabled
- * - AMD_PRI_DEV_ERRATUM_LIMIT_REQ_ONE - Limit number of outstanding PRI
- *					 requests to one
- */
-#define AMD_PRI_DEV_ERRATUM_ENABLE_RESET		0
-#define AMD_PRI_DEV_ERRATUM_LIMIT_REQ_ONE		1
-
-extern void amd_iommu_enable_device_erratum(struct pci_dev *pdev, u32 erratum);
-
 /**
  * amd_iommu_init_device() - Init device for use with IOMMUv2 driver
  * @pdev: The PCI device to initialize
-- 
2.30.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
