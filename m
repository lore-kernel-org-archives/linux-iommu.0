Return-Path: <SRS0=oi3Z=63=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325FAC433E1
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 22:51:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F119206F5
	for <iommu@archiver.kernel.org>; Wed, 13 May 2020 22:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F119206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D0DD32275F;
	Wed, 13 May 2020 22:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iO+D6CWz1aXU; Wed, 13 May 2020 22:51:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E242822703;
	Wed, 13 May 2020 22:51:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7A27C088B;
	Wed, 13 May 2020 22:51:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 877F4C016F
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 22:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6F6DB885A9
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 22:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aa6m6kTXAuNK for <iommu@lists.linux-foundation.org>;
 Wed, 13 May 2020 22:51:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9662288544
 for <iommu@lists.linux-foundation.org>; Wed, 13 May 2020 22:51:08 +0000 (UTC)
IronPort-SDR: zLMWsRe9z6ZwFRdD9V8ndkDzo/6PLNxENKSTycIuPtGt5NHKg6ILu+l+2pWdP5O/wO+LURKuR5
 QgRKXIJZCuCw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2020 15:51:08 -0700
IronPort-SDR: 5/q55Vhu7CU2c72Uw9srlVCKRxwGlGLoe+vpSVXXVjL4fn9dLp8IYUAMflvbDrwcGHNnPGgP8w
 AlIIKly94RZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; d="scan'208";a="251905960"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
 by fmsmga007.fm.intel.com with ESMTP; 13 May 2020 15:51:06 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu: Remove functions that support private domain
Date: Wed, 13 May 2020 15:47:21 -0700
Message-Id: <20200513224721.20504-1-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
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

After moving iommu_group setup to iommu core code [1][2] and removing
private domain support in vt-d [3], there are no users for functions such
as iommu_request_dm_for_dev(), iommu_request_dma_domain_for_dev() and
request_default_domain_for_dev(). So, remove these functions.

[1] commit dce8d6964ebd ("iommu/amd: Convert to probe/release_device()
    call-backs")
[2] commit e5d1841f18b2 ("iommu/vt-d: Convert to probe/release_device()
    call-backs")
[3] commit 327d5b2fee91 ("iommu/vt-d: Allow 32bit devices to uses DMA
    domain")

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 drivers/iommu/iommu.c | 65 -------------------------------------------
 include/linux/iommu.h | 12 --------
 2 files changed, 77 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4050569188be..374b34fd6fac 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2536,71 +2536,6 @@ struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
 }
 EXPORT_SYMBOL_GPL(iommu_alloc_resv_region);
 
-static int
-request_default_domain_for_dev(struct device *dev, unsigned long type)
-{
-	struct iommu_domain *domain;
-	struct iommu_group *group;
-	int ret;
-
-	/* Device must already be in a group before calling this function */
-	group = iommu_group_get(dev);
-	if (!group)
-		return -EINVAL;
-
-	mutex_lock(&group->mutex);
-
-	ret = 0;
-	if (group->default_domain && group->default_domain->type == type)
-		goto out;
-
-	/* Don't change mappings of existing devices */
-	ret = -EBUSY;
-	if (iommu_group_device_count(group) != 1)
-		goto out;
-
-	ret = -ENOMEM;
-	domain = __iommu_domain_alloc(dev->bus, type);
-	if (!domain)
-		goto out;
-
-	/* Attach the device to the domain */
-	ret = __iommu_attach_group(domain, group);
-	if (ret) {
-		iommu_domain_free(domain);
-		goto out;
-	}
-
-	/* Make the domain the default for this group */
-	if (group->default_domain)
-		iommu_domain_free(group->default_domain);
-	group->default_domain = domain;
-
-	iommu_create_device_direct_mappings(group, dev);
-
-	dev_info(dev, "Using iommu %s mapping\n",
-		 type == IOMMU_DOMAIN_DMA ? "dma" : "direct");
-
-	ret = 0;
-out:
-	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
-	return ret;
-}
-
-/* Request that a device is direct mapped by the IOMMU */
-int iommu_request_dm_for_dev(struct device *dev)
-{
-	return request_default_domain_for_dev(dev, IOMMU_DOMAIN_IDENTITY);
-}
-
-/* Request that a device can't be direct mapped by the IOMMU */
-int iommu_request_dma_domain_for_dev(struct device *dev)
-{
-	return request_default_domain_for_dev(dev, IOMMU_DOMAIN_DMA);
-}
-
 void iommu_set_default_passthrough(bool cmd_line)
 {
 	if (cmd_line)
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7cfd2dddb49d..78a26ae5c2b6 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -482,8 +482,6 @@ extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern void generic_iommu_put_resv_regions(struct device *dev,
 					   struct list_head *list);
-extern int iommu_request_dm_for_dev(struct device *dev);
-extern int iommu_request_dma_domain_for_dev(struct device *dev);
 extern void iommu_set_default_passthrough(bool cmd_line);
 extern void iommu_set_default_translated(bool cmd_line);
 extern bool iommu_default_passthrough(void);
@@ -804,16 +802,6 @@ static inline int iommu_get_group_resv_regions(struct iommu_group *group,
 	return -ENODEV;
 }
 
-static inline int iommu_request_dm_for_dev(struct device *dev)
-{
-	return -ENODEV;
-}
-
-static inline int iommu_request_dma_domain_for_dev(struct device *dev)
-{
-	return -ENODEV;
-}
-
 static inline void iommu_set_default_passthrough(bool cmd_line)
 {
 }
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
