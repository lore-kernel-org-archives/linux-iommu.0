Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C6EC433FE
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 12:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6BAA60E2F;
	Wed,  4 May 2022 12:40:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BGfqzh9DhJG0; Wed,  4 May 2022 12:40:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D8B3560C2C;
	Wed,  4 May 2022 12:40:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3E27C0039;
	Wed,  4 May 2022 12:40:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A6ADC0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 12:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42C2183F1F
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 12:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cq5xVlUMBIzY for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 12:40:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1AEAE83F1D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 12:40:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22CDD1042;
 Wed,  4 May 2022 05:40:05 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B03A3FA50;
 Wed,  4 May 2022 05:40:04 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH] iommu: Make sysfs robust for non-API groups
Date: Wed,  4 May 2022 13:39:58 +0100
Message-Id: <86ada41986988511a8424e84746dfe9ba7f87573.1651667683.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, will@kernel.org,
 Jan Stancek <jstancek@redhat.com>
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

Groups created by VFIO backends outside the core IOMMU API should never
be passed directly into the API itself, however they still expose their
standard sysfs attributes, so we can still stumble across them that way.
Take care to consider those cases before jumping into our normal
assumptions of a fully-initialised core API group.

Fixes: 3f6634d997db ("iommu: Use right way to retrieve iommu_ops")
Reported-by: Jan Stancek <jstancek@redhat.com>
Tested-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

/me has a vested interest in not going backwards on dev_iommu_ops() :)

 drivers/iommu/iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 29906bc16371..41ea2deaee03 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -510,6 +510,13 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 	list_for_each_entry(device, &group->devices, list) {
 		struct list_head dev_resv_regions;
 
+		/*
+		 * Non-API groups still expose reserved_regions in sysfs,
+		 * so filter out calls that get here that way.
+		 */
+		if (!device->dev->iommu)
+			break;
+
 		INIT_LIST_HEAD(&dev_resv_regions);
 		iommu_get_resv_regions(device->dev, &dev_resv_regions);
 		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
@@ -2977,7 +2984,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
 
-	if (WARN_ON(!group))
+	if (WARN_ON(!group) || !group->default_domain)
 		return -EINVAL;
 
 	if (sysfs_streq(buf, "identity"))
-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
