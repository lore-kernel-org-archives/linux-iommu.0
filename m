Return-Path: <SRS0=vxCL=4F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B12C34029
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C950520578
	for <iommu@archiver.kernel.org>; Mon, 17 Feb 2020 19:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C950520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8C1CE20430;
	Mon, 17 Feb 2020 19:39:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mX80bOeCAq8U; Mon, 17 Feb 2020 19:39:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CE2A02047E;
	Mon, 17 Feb 2020 19:39:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3D8CC089F;
	Mon, 17 Feb 2020 19:39:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A626C013E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3695185209
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mex8Vmv5q7X7 for <iommu@lists.linux-foundation.org>;
 Mon, 17 Feb 2020 19:39:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 61D9F85168
 for <iommu@lists.linux-foundation.org>; Mon, 17 Feb 2020 19:39:10 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id BE1CF28C; Mon, 17 Feb 2020 20:39:06 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 1/5] iommu/vt-d: Add attach_deferred() helper
Date: Mon, 17 Feb 2020 20:38:54 +0100
Message-Id: <20200217193858.26990-2-joro@8bytes.org>
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

Implement a helper function to check whether a device's attach process
is deferred.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9dc37672bf89..80f2332a5466 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -762,6 +762,11 @@ static int iommu_dummy(struct device *dev)
 	return dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO;
 }
 
+static bool attach_deferred(struct device *dev)
+{
+	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
+}
+
 /**
  * is_downstream_to_pci_bridge - test if a device belongs to the PCI
  *				 sub-hierarchy of a candidate PCI-PCI bridge
@@ -2510,8 +2515,7 @@ struct dmar_domain *find_domain(struct device *dev)
 {
 	struct device_domain_info *info;
 
-	if (unlikely(dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO ||
-		     dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO))
+	if (unlikely(attach_deferred(dev) || iommu_dummy(dev)))
 		return NULL;
 
 	if (dev_is_pci(dev))
@@ -2527,7 +2531,7 @@ struct dmar_domain *find_domain(struct device *dev)
 
 static struct dmar_domain *deferred_attach_domain(struct device *dev)
 {
-	if (unlikely(dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO)) {
+	if (unlikely(attach_deferred(dev))) {
 		struct iommu_domain *domain;
 
 		dev->archdata.iommu = NULL;
@@ -6133,7 +6137,7 @@ intel_iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
 					   struct device *dev)
 {
-	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
+	return attach_deferred(dev);
 }
 
 static int
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
