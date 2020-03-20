Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BE9C43333
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 23:22:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31012072D
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 23:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31012072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 73236876BA;
	Fri, 20 Mar 2020 23:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AVKRtn4x11BF; Fri, 20 Mar 2020 23:22:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E1D4D875BC;
	Fri, 20 Mar 2020 23:22:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C33C3C089E;
	Fri, 20 Mar 2020 23:22:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F5FFC07FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 23:22:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7D54D2549D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 23:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cIh2W2Jhrx5g for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 23:22:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 27BE9255F6
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 23:22:02 +0000 (UTC)
IronPort-SDR: VWjxYi95qEZPvbPLbsvYyLTXqxH9ngo5ZdAN6MDJS65Vg0CatqD2XNqV4878SUtigR7GnDhsC2
 orZkkW0uoHew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 16:22:01 -0700
IronPort-SDR: sFqZaL8OHLTqINBQ8R4AfRkHxYiK58VJg4zXN5l0QpKwK2U64koOB4ZwUyF92xUe1eVcokkofF
 i01FrZlFbm6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,286,1580803200"; d="scan'208";a="418877231"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 20 Mar 2020 16:22:01 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Lu Baolu" <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH V10 04/11] iommu/vt-d: Use helper function to skip agaw for SL
Date: Fri, 20 Mar 2020 16:27:34 -0700
Message-Id: <1584746861-76386-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
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

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 191508c7c03e..9bdb7ee228b6 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -544,17 +544,11 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
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
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
