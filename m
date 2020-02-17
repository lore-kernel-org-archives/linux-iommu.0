Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56479C34026
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3792820656
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3792820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 23D0D20487;
	Mon, 17 Feb 2020 19:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yzlc-s+oBXH8; Mon, 17 Feb 2020 19:39:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 038422046E;
	Mon, 17 Feb 2020 19:39:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFE51C089F;
	Mon, 17 Feb 2020 19:39:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09231C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D6C3820104
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dbDEL7emmYpZ for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 19:39:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 0C2922042B
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:39:10 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id DFC6C542; Mon, 17 Feb 2020 20:39:06 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 2/5] iommu/vt-d: Move deferred device attachment into helper
 function
Date: Mon, 17 Feb 2020 20:38:55 +0100
Message-Id: <20200217193858.26990-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217193858.26990-1-joro@8bytes.org>
References: <20200217193858.26990-1-joro@8bytes.org>
Cc: jroedel@suse.de, iommu@lists.linux-foundation.org,
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

Move the code that does the deferred device attachment into a separate
helper function.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 80f2332a5466..42cdcce1602e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2529,16 +2529,20 @@ struct dmar_domain *find_domain(struct device *dev)
 	return NULL;
 }
 
-static struct dmar_domain *deferred_attach_domain(struct device *dev)
+static void do_deferred_attach(struct device *dev)
 {
-	if (unlikely(attach_deferred(dev))) {
-		struct iommu_domain *domain;
+	struct iommu_domain *domain;
 
-		dev->archdata.iommu = NULL;
-		domain = iommu_get_domain_for_dev(dev);
-		if (domain)
-			intel_iommu_attach_device(domain, dev);
-	}
+	dev->archdata.iommu = NULL;
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain)
+		intel_iommu_attach_device(domain, dev);
+}
+
+static struct dmar_domain *deferred_attach_domain(struct device *dev)
+{
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
 
 	return find_domain(dev);
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
