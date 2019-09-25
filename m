Return-Path: <SRS0=izs0=XU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2350C432C2
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 13:23:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29AF21D7C
	for <iommu@archiver.kernel.org>; Wed, 25 Sep 2019 13:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29AF21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F340CE2B;
	Wed, 25 Sep 2019 13:23:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E1E57AF0
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 13:23:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 317D98C0
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 13:23:04 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id D1FFE4D9; Wed, 25 Sep 2019 15:23:01 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/6] iommu/amd: Take domain->lock for complete attach/detach
	path
Date: Wed, 25 Sep 2019 15:22:57 +0200
Message-Id: <20190925132300.3038-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925132300.3038-1-joro@8bytes.org>
References: <20190925132300.3038-1-joro@8bytes.org>
Cc: Filippo Sironi <sironi@amazon.de>, jroedel@suse.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The code-paths before __attach_device() and __detach_device() are called
also access and modify domain state, so take the domain lock there too.
This allows to get rid of the __detach_device() function.

Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 65 ++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 37a9c04fc728..2919168577ff 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2079,27 +2079,13 @@ static void do_detach(struct iommu_dev_data *dev_data)
 static int __attach_device(struct iommu_dev_data *dev_data,
 			   struct protection_domain *domain)
 {
-	unsigned long flags;
-	int ret;
-
-	/* lock domain */
-	spin_lock_irqsave(&domain->lock, flags);
-
-	ret = -EBUSY;
 	if (dev_data->domain != NULL)
-		goto out_unlock;
+		return -EBUSY;
 
 	/* Attach alias group root */
 	do_attach(dev_data, domain);
 
-	ret = 0;
-
-out_unlock:
-
-	/* ready */
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	return ret;
+	return 0;
 }
 
 
@@ -2181,8 +2167,11 @@ static int attach_device(struct device *dev,
 {
 	struct pci_dev *pdev;
 	struct iommu_dev_data *dev_data;
+	unsigned long flags;
 	int ret;
 
+	spin_lock_irqsave(&domain->lock, flags);
+
 	dev_data = get_dev_data(dev);
 
 	if (!dev_is_pci(dev))
@@ -2190,12 +2179,13 @@ static int attach_device(struct device *dev,
 
 	pdev = to_pci_dev(dev);
 	if (domain->flags & PD_IOMMUV2_MASK) {
+		ret = -EINVAL;
 		if (!dev_data->passthrough)
-			return -EINVAL;
+			goto out;
 
 		if (dev_data->iommu_v2) {
 			if (pdev_iommuv2_enable(pdev) != 0)
-				return -EINVAL;
+				goto out;
 
 			dev_data->ats.enabled = true;
 			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
@@ -2219,24 +2209,10 @@ static int attach_device(struct device *dev,
 
 	domain_flush_complete(domain);
 
-	return ret;
-}
-
-/*
- * Removes a device from a protection domain (unlocked)
- */
-static void __detach_device(struct iommu_dev_data *dev_data)
-{
-	struct protection_domain *domain;
-	unsigned long flags;
-
-	domain = dev_data->domain;
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	do_detach(dev_data);
-
+out:
 	spin_unlock_irqrestore(&domain->lock, flags);
+
+	return ret;
 }
 
 /*
@@ -2246,10 +2222,13 @@ static void detach_device(struct device *dev)
 {
 	struct protection_domain *domain;
 	struct iommu_dev_data *dev_data;
+	unsigned long flags;
 
 	dev_data = get_dev_data(dev);
 	domain   = dev_data->domain;
 
+	spin_lock_irqsave(&domain->lock, flags);
+
 	/*
 	 * First check if the device is still attached. It might already
 	 * be detached from its domain because the generic
@@ -2257,12 +2236,12 @@ static void detach_device(struct device *dev)
 	 * our alias handling.
 	 */
 	if (WARN_ON(!dev_data->domain))
-		return;
+		goto out;
 
-	__detach_device(dev_data);
+	do_detach(dev_data);
 
 	if (!dev_is_pci(dev))
-		return;
+		goto out;
 
 	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
 		pdev_iommuv2_disable(to_pci_dev(dev));
@@ -2270,6 +2249,9 @@ static void detach_device(struct device *dev)
 		pci_disable_ats(to_pci_dev(dev));
 
 	dev_data->ats.enabled = false;
+
+out:
+	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
 static int amd_iommu_add_device(struct device *dev)
@@ -2904,13 +2886,18 @@ int __init amd_iommu_init_dma_ops(void)
 static void cleanup_domain(struct protection_domain *domain)
 {
 	struct iommu_dev_data *entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&domain->lock, flags);
 
 	while (!list_empty(&domain->dev_list)) {
 		entry = list_first_entry(&domain->dev_list,
 					 struct iommu_dev_data, list);
 		BUG_ON(!entry->domain);
-		__detach_device(entry);
+		do_detach(entry);
 	}
+
+	spin_unlock_irqrestore(&domain->lock, flags);
 }
 
 static void protection_domain_free(struct protection_domain *domain)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
