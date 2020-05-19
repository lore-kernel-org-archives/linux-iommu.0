Return-Path: <SRS0=kGUL=7B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBE0C433DF
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 13:28:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9600B207D8
	for <iommu@archiver.kernel.org>; Tue, 19 May 2020 13:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9600B207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6FCC786103;
	Tue, 19 May 2020 13:28:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5NUF51MdjYSg; Tue, 19 May 2020 13:28:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AD29085E77;
	Tue, 19 May 2020 13:28:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95876C0881;
	Tue, 19 May 2020 13:28:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A0F7C0176
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 13:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2B03E22640
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 13:28:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jlkSQdrCe80J for <iommu@lists.linux-foundation.org>;
 Tue, 19 May 2020 13:28:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 62A8421553
 for <iommu@lists.linux-foundation.org>; Tue, 19 May 2020 13:28:36 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 7785F386; Tue, 19 May 2020 15:28:33 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu: Don't call .probe_finalize() under group->mutex
Date: Tue, 19 May 2020 15:28:24 +0200
Message-Id: <20200519132824.15163-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Cc: Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

The .probe_finalize() call-back of some IOMMU drivers calls into
arm_iommu_attach_device(). This function will call back into the
IOMMU core code, where it tries to take group->mutex again, resulting
in a deadlock.

As there is no reason why .probe_finalize() needs to be called under
that mutex, move it after the lock has been released to fix the
deadlock.

Cc: Yong Wu <yong.wu@mediatek.com>
Reported-by: Yong Wu <yong.wu@mediatek.com>
Fixes: deac0b3bed26 ("iommu: Split off default domain allocation from group assignment")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 629d209b8e88..d5d9fcbc9714 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1683,17 +1683,8 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 static int iommu_group_do_dma_attach(struct device *dev, void *data)
 {
 	struct iommu_domain *domain = data;
-	const struct iommu_ops *ops;
-	int ret;
-
-	ret = __iommu_attach_device(domain, dev);
-
-	ops = domain->ops;
-
-	if (ret == 0 && ops->probe_finalize)
-		ops->probe_finalize(dev);
 
-	return ret;
+	return __iommu_attach_device(domain, dev);
 }
 
 static int __iommu_group_dma_attach(struct iommu_group *group)
@@ -1702,6 +1693,21 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
 					  iommu_group_do_dma_attach);
 }
 
+static int iommu_group_do_probe_finalize(struct device *dev, void *data)
+{
+	struct iommu_domain *domain = data;
+
+	if (domain->ops->probe_finalize)
+		domain->ops->probe_finalize(dev);
+
+	return 0;
+}
+
+static void __iommu_group_dma_finalize(struct iommu_group *group)
+{
+	__iommu_group_for_each_dev(group, group->default_domain,
+				   iommu_group_do_probe_finalize);
+}
 static int iommu_do_create_direct_mappings(struct device *dev, void *data)
 {
 	struct iommu_group *group = data;
@@ -1754,6 +1760,8 @@ int bus_iommu_probe(struct bus_type *bus)
 
 		if (ret)
 			break;
+
+		__iommu_group_dma_finalize(group);
 	}
 
 	return ret;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
