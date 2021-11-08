Return-Path: <SRS0=5Ucf=P3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A26C433F5
	for <iommu@archiver.kernel.org>; Mon,  8 Nov 2021 06:18:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F139C610D2
	for <iommu@archiver.kernel.org>; Mon,  8 Nov 2021 06:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F139C610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEDD8400C6;
	Mon,  8 Nov 2021 06:18:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQfUMdkY1aEB; Mon,  8 Nov 2021 06:18:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AF0F7400BB;
	Mon,  8 Nov 2021 06:18:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 850D2C0019;
	Mon,  8 Nov 2021 06:18:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F11E8C000E
 for <iommu@lists.linux-foundation.org>; Mon,  8 Nov 2021 06:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CCAC060769
 for <iommu@lists.linux-foundation.org>; Mon,  8 Nov 2021 06:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t6YdxhMQtvAX for <iommu@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 06:18:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4294160756
 for <iommu@lists.linux-foundation.org>; Mon,  8 Nov 2021 06:18:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="219071414"
X-IronPort-AV: E=Sophos;i="5.87,217,1631602800"; d="scan'208";a="219071414"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2021 22:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,217,1631602800"; d="scan'208";a="491091846"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 07 Nov 2021 22:18:13 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/1] iommu: Extend mutex lock scope in iommu_probe_device()
Date: Mon,  8 Nov 2021 14:13:49 +0800
Message-Id: <20211108061349.1985579-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Ashish Mhetre <amhetre@nvidia.com>
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

Extend the scope of holding group->mutex so that it can cover the default
domain check/attachment and direct mappings of reserved regions.

Cc: Ashish Mhetre <amhetre@nvidia.com>
Fixes: 211ff31b3d33b ("iommu: Fix race condition during default domain allocation")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index dd7863e453a5..8b86406b7162 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -288,11 +288,11 @@ int iommu_probe_device(struct device *dev)
 	 */
 	mutex_lock(&group->mutex);
 	iommu_alloc_default_domain(group, dev);
-	mutex_unlock(&group->mutex);
 
 	if (group->default_domain) {
 		ret = __iommu_attach_device(group->default_domain, dev);
 		if (ret) {
+			mutex_unlock(&group->mutex);
 			iommu_group_put(group);
 			goto err_release;
 		}
@@ -300,6 +300,7 @@ int iommu_probe_device(struct device *dev)
 
 	iommu_create_device_direct_mappings(group, dev);
 
+	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
 	if (ops->probe_finalize)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
