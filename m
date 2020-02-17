Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F44C34028
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D577920578
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D577920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6263920464;
	Mon, 17 Feb 2020 19:39:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zUMDxLmVGKjq; Mon, 17 Feb 2020 19:39:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8D5A920471;
	Mon, 17 Feb 2020 19:39:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70C81C1D81;
	Mon, 17 Feb 2020 19:39:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C03BAC1D81
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A7D2820373
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4aT+G05JBur6 for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 19:39:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 07EC820104
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:39:10 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 106255BB; Mon, 17 Feb 2020 20:39:07 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 3/5] iommu/vt-d: Do deferred attachment in iommu_need_mapping()
Date: Mon, 17 Feb 2020 20:38:56 +0100
Message-Id: <20200217193858.26990-4-joro@8bytes.org>
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

The attachment of deferred devices needs to happen before the check
whether the device is identity mapped or not. Otherwise the check will
return wrong results, cause warnings boot failures in kdump kernels, like

	WARNING: CPU: 0 PID: 318 at ../drivers/iommu/intel-iommu.c:592 domain_get_iommu+0x61/0x70

	[...]

	 Call Trace:
	  __intel_map_single+0x55/0x190
	  intel_alloc_coherent+0xac/0x110
	  dmam_alloc_attrs+0x50/0xa0
	  ahci_port_start+0xfb/0x1f0 [libahci]
	  ata_host_start.part.39+0x104/0x1e0 [libata]

With the earlier check the kdump boot succeeds and a crashdump is written.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 42cdcce1602e..32f43695a22b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2541,9 +2541,6 @@ static void do_deferred_attach(struct device *dev)
 
 static struct dmar_domain *deferred_attach_domain(struct device *dev)
 {
-	if (unlikely(attach_deferred(dev)))
-		do_deferred_attach(dev);
-
 	return find_domain(dev);
 }
 
@@ -3595,6 +3592,9 @@ static bool iommu_need_mapping(struct device *dev)
 	if (iommu_dummy(dev))
 		return false;
 
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
+
 	ret = identity_mapping(dev);
 	if (ret) {
 		u64 dma_mask = *dev->dma_mask;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
