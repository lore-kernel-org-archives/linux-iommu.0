Return-Path: <SRS0=eEOj=7H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23029C433E3
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 13:01:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26822073B
	for <iommu@archiver.kernel.org>; Mon, 25 May 2020 13:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26822073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id AD766204E0;
	Mon, 25 May 2020 13:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DaEO0jhp2bO3; Mon, 25 May 2020 13:01:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B67E32010A;
	Mon, 25 May 2020 13:01:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2333C0865;
	Mon, 25 May 2020 13:01:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB438C016F
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 13:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C335485FA6
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 13:01:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2V1DWc6-tOPX for <iommu@lists.linux-foundation.org>;
 Mon, 25 May 2020 13:01:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C4C3185FA3
 for <iommu@lists.linux-foundation.org>; Mon, 25 May 2020 13:01:34 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 4D934327; Mon, 25 May 2020 15:01:29 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: Don't take group reference in
 iommu_alloc_default_domain()
Date: Mon, 25 May 2020 15:01:22 +0200
Message-Id: <20200525130122.380-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

The iommu_alloc_default_domain() function takes a reference to an IOMMU
group without releasing it. This causes the group to never be released,
with undefined side effects.

The function has only one call-site, which takes a group reference on
its own, so to fix this leak, do not take another reference in
iommu_alloc_default_domain() and pass the group as a function parameter
instead.

Reference: https://lore.kernel.org/lkml/20200522130145.30067-1-saiprakash.ranjan@codeaurora.org/
Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Fixes: 6e1aa2049154 ("iommu: Move default domain allocation to iommu_probe_device()")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 374b34fd6fac..bf20674769e0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -80,7 +80,8 @@ static bool iommu_cmd_line_dma_api(void)
 	return !!(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API);
 }
 
-static int iommu_alloc_default_domain(struct device *dev);
+static int iommu_alloc_default_domain(struct iommu_group *group,
+				      struct device *dev);
 static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 						 unsigned type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -251,17 +252,17 @@ int iommu_probe_device(struct device *dev)
 	if (ret)
 		goto err_out;
 
+	group = iommu_group_get(dev);
+	if (!group)
+		goto err_release;
+
 	/*
 	 * Try to allocate a default domain - needs support from the
 	 * IOMMU driver. There are still some drivers which don't
 	 * support default domains, so the return value is not yet
 	 * checked.
 	 */
-	iommu_alloc_default_domain(dev);
-
-	group = iommu_group_get(dev);
-	if (!group)
-		goto err_release;
+	iommu_alloc_default_domain(group, dev);
 
 	if (group->default_domain)
 		ret = __iommu_attach_device(group->default_domain, dev);
@@ -1478,15 +1479,11 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
 	return 0;
 }
 
-static int iommu_alloc_default_domain(struct device *dev)
+static int iommu_alloc_default_domain(struct iommu_group *group,
+				      struct device *dev)
 {
-	struct iommu_group *group;
 	unsigned int type;
 
-	group = iommu_group_get(dev);
-	if (!group)
-		return -ENODEV;
-
 	if (group->default_domain)
 		return 0;
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
