Return-Path: <SRS0=HSJZ=5V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC12C2BA1A
	for <iommu@archiver.kernel.org>; Sun,  5 Apr 2020 08:34:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27CF20659
	for <iommu@archiver.kernel.org>; Sun,  5 Apr 2020 08:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27CF20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D172C875CD;
	Sun,  5 Apr 2020 08:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VSsF4XuMREB3; Sun,  5 Apr 2020 08:34:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C54A0875AD;
	Sun,  5 Apr 2020 08:34:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3F38C1AE2;
	Sun,  5 Apr 2020 08:34:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C1ADC0177
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:34:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4A5F820429
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:34:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k+OPp7F6n18g for <iommu@lists.linux-foundation.org>;
 Sun,  5 Apr 2020 08:34:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by silver.osuosl.org (Postfix) with ESMTPS id EBE5F20242
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 08:34:10 +0000 (UTC)
IronPort-SDR: FzQqQJ9PJ1j9FsKfS55jbPA+oqFcqyHXioNVRTGBXV9Mq5Z84OT1riHDx5IonLleQUjev9O42I
 tGiABOMeqHhg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2020 01:34:10 -0700
IronPort-SDR: 8MX1r/qCgsaVFl24nU3vl/g/r8i9YPxleBYGzqOMHysVhysofK/DQSv27sGbQVqh1rjYgLHGBs
 93BR+jDKsF0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,347,1580803200"; d="scan'208";a="397179367"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by orsmga004.jf.intel.com with ESMTP; 05 Apr 2020 01:34:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 09/19] iommu/vt-d: Use a helper function to skip agaw for SL
Date: Sun,  5 Apr 2020 16:30:43 +0800
Message-Id: <20200405083053.17865-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200405083053.17865-1-baolu.lu@linux.intel.com>
References: <20200405083053.17865-1-baolu.lu@linux.intel.com>
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

An Intel iommu domain uses 5-level page table by default. If the
iommu that the domain tries to attach supports less page levels,
the top level page tables should be skipped. Add a helper to do
this so that it could be used in other places.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 22b30f10b396..d9cea3011b58 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -499,6 +499,25 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	return 0;
 }
 
+/*
+ * Skip top levels of page tables for iommu which has less agaw
+ * than default. Unnecessary for PT mode.
+ */
+static inline int iommu_skip_agaw(struct dmar_domain *domain,
+				  struct intel_iommu *iommu,
+				  struct dma_pte **pgd)
+{
+	int agaw;
+
+	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
+		*pgd = phys_to_virt(dma_pte_addr(*pgd));
+		if (!dma_pte_present(*pgd))
+			return -EINVAL;
+	}
+
+	return agaw;
+}
+
 /*
  * Set up the scalable mode pasid entry for second only translation type.
  */
@@ -522,17 +541,11 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 		return -EINVAL;
 	}
 
-	/*
-	 * Skip top levels of page tables for iommu which has less agaw
-	 * than default. Unnecessary for PT mode.
-	 */
 	pgd = domain->pgd;
-	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
-		pgd = phys_to_virt(dma_pte_addr(pgd));
-		if (!dma_pte_present(pgd)) {
-			dev_err(dev, "Invalid domain page table\n");
-			return -EINVAL;
-		}
+	agaw = iommu_skip_agaw(domain, iommu, &pgd);
+	if (agaw < 0) {
+		dev_err(dev, "Invalid domain page table\n");
+		return -EINVAL;
 	}
 
 	pgd_val = virt_to_phys(pgd);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
