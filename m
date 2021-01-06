Return-Path: <SRS0=DPil=GJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41084C433E0
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 13:39:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4732311A
	for <iommu@archiver.kernel.org>; Wed,  6 Jan 2021 13:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4732311A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A6D24845A3;
	Wed,  6 Jan 2021 13:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AZ9zpqlM7Bg1; Wed,  6 Jan 2021 13:39:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0000384496;
	Wed,  6 Jan 2021 13:39:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2E28C088B;
	Wed,  6 Jan 2021 13:39:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53DAFC013A
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 13:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4361A86FAB
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 13:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ml4P1qIRsTWM for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jan 2021 13:39:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D183787205
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jan 2021 13:39:17 +0000 (UTC)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D9r6L5Dv0zj05V;
 Wed,  6 Jan 2021 21:38:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 21:39:04 +0800
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>
Subject: [PATCH v2 6/6] iommu: Delete iommu_dev_has_feature()
Date: Wed, 6 Jan 2021 21:35:11 +0800
Message-ID: <1609940111-28563-7-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
References: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org
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

Function iommu_dev_has_feature() has never been referenced in the tree,
and there does not appear to be anything coming soon to use it, so delete
it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iommu.c | 11 -----------
 include/linux/iommu.h |  7 -------
 2 files changed, 18 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 20201ef97b8f..91f7871f5a37 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2853,17 +2853,6 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
 /*
  * Per device IOMMU features.
  */
-bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)
-{
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
-
-	if (ops && ops->dev_has_feat)
-		return ops->dev_has_feat(dev, feat);
-
-	return false;
-}
-EXPORT_SYMBOL_GPL(iommu_dev_has_feature);
-
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 72059fcfa108..91d94c014f47 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -626,7 +626,6 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
 int iommu_probe_device(struct device *dev);
 void iommu_release_device(struct device *dev);
 
-bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
 bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
@@ -975,12 +974,6 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
-static inline bool
-iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)
-{
-	return false;
-}
-
 static inline bool
 iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
 {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
