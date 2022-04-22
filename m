Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6903DC433F5
	for <iommu@archiver.kernel.org>; Fri, 22 Apr 2022 12:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00F9A83F0F;
	Fri, 22 Apr 2022 12:33:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rgRtj2PaQFwX; Fri, 22 Apr 2022 12:33:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D767F83E3A;
	Fri, 22 Apr 2022 12:33:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8CB7C0039;
	Fri, 22 Apr 2022 12:33:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE867C002D
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 12:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4BFD83F07
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 12:33:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AbnoQqYIzNfJ for <iommu@lists.linux-foundation.org>;
 Fri, 22 Apr 2022 12:33:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id F2C8D83E3A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Apr 2022 12:33:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F29C1576;
 Fri, 22 Apr 2022 05:33:35 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 65CA13F5A1;
 Fri, 22 Apr 2022 05:33:34 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH] iommu: Use dev_iommu_ops() for probe_finalize
Date: Fri, 22 Apr 2022 13:33:27 +0100
Message-Id: <84b891ba40e4cea924ee4ea1167b00e87ad38b18.1650630616.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

The ->probe_finalize hook only runs after ->probe_device succeeds,
so we can move that over to the new dev_iommu_ops() as well.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Another cheeky little one which doesn't need to wait...

 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1b8dcda5fbe4..8825a4628e46 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -315,7 +315,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 int iommu_probe_device(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops;
 	struct iommu_group *group;
 	int ret;
 
@@ -352,6 +352,7 @@ int iommu_probe_device(struct device *dev)
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
+	ops = dev_iommu_ops(dev);
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
 
-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
