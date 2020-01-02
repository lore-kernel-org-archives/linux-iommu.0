Return-Path: <SRS0=eP4Y=2X=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB6CC2D0DE
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 00:19:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9701320672
	for <iommu@archiver.kernel.org>; Thu,  2 Jan 2020 00:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9701320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6494285784;
	Thu,  2 Jan 2020 00:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xWc_Xc-hIJhs; Thu,  2 Jan 2020 00:19:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 42B0785712;
	Thu,  2 Jan 2020 00:19:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2755CC1D8A;
	Thu,  2 Jan 2020 00:19:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A492C077D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 00:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2986A85F96
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 00:19:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lFga35dirk+J for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jan 2020 00:19:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7906F854C0
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jan 2020 00:19:43 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Jan 2020 16:19:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,384,1571727600"; d="scan'208";a="244475922"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 01 Jan 2020 16:19:42 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 11/22] iommu/vt-d: Avoid iova flush queue in strict mode
Date: Thu,  2 Jan 2020 08:18:12 +0800
Message-Id: <20200102001823.21976-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102001823.21976-1-baolu.lu@linux.intel.com>
References: <20200102001823.21976-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
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

If Intel IOMMU strict mode is enabled by users, it's unnecessary
to create the iova flush queue.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fb21a7745db2..4631b1796482 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1858,10 +1858,12 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 
 	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
 
-	err = init_iova_flush_queue(&domain->iovad,
-				    iommu_flush_iova, iova_entry_free);
-	if (err)
-		return err;
+	if (!intel_iommu_strict) {
+		err = init_iova_flush_queue(&domain->iovad,
+					    iommu_flush_iova, iova_entry_free);
+		if (err)
+			return err;
+	}
 
 	domain_reserve_special_ranges(domain);
 
@@ -5199,6 +5201,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 {
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
+	int ret;
 
 	switch (type) {
 	case IOMMU_DOMAIN_DMA:
@@ -5215,11 +5218,14 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 			return NULL;
 		}
 
-		if (type == IOMMU_DOMAIN_DMA &&
-		    init_iova_flush_queue(&dmar_domain->iovad,
-					  iommu_flush_iova, iova_entry_free)) {
-			pr_warn("iova flush queue initialization failed\n");
-			intel_iommu_strict = 1;
+		if (!intel_iommu_strict && type == IOMMU_DOMAIN_DMA) {
+			ret = init_iova_flush_queue(&dmar_domain->iovad,
+						    iommu_flush_iova,
+						    iova_entry_free);
+			if (ret) {
+				pr_warn("iova flush queue initialization failed\n");
+				intel_iommu_strict = 1;
+			}
 		}
 
 		domain_update_iommu_cap(dmar_domain);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
