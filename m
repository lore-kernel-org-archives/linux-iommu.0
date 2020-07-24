Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A8EC433EA
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5087C22B3F
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5087C22B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 31D2422F05;
	Fri, 24 Jul 2020 01:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1bahMbSqQmoZ; Fri, 24 Jul 2020 01:54:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 39CD422FD5;
	Fri, 24 Jul 2020 01:54:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25E79C004F;
	Fri, 24 Jul 2020 01:54:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ABACC004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 063D687E84
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h1AxqhUNyG3m for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 01:54:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 41FBA87EA3
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:32 +0000 (UTC)
IronPort-SDR: xRH98sO1PnBG26GYyb5bOtaXUoRwNY+q+Jx/kOnMDczJlQo0USrRPiYzuQfjDecnCUfpU9NER4
 rzFFv9VgGB+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="168778779"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="168778779"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 18:54:32 -0700
IronPort-SDR: 2dU7PH/Eh0RpcxIozc8xeemCT/+AxzgeAw+jmlEdyC2yugzF7XXL5PW2y44yZ8vZ5Q9DmbxWZT
 VxbBH7NF+U5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="488576723"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2020 18:54:30 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 04/12] iommu/vt-d: Handle non-page aligned address
Date: Fri, 24 Jul 2020 09:49:17 +0800
Message-Id: <20200724014925.15523-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724014925.15523-1-baolu.lu@linux.intel.com>
References: <20200724014925.15523-1-baolu.lu@linux.intel.com>
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

From: Liu Yi L <yi.l.liu@intel.com>

Address information for device TLB invalidation comes from userspace
when device is directly assigned to a guest with vIOMMU support.
VT-d requires page aligned address. This patch checks and enforce
address to be page aligned, otherwise reserved bits can be set in the
invalidation descriptor. Unrecoverable fault will be reported due to
non-zero value in the reserved bits.

Fixes: 61a06a16e36d8 ("iommu/vt-d: Support flushing more translation cache types")
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index a46d8d4abdb8..93e6345f3414 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1457,9 +1457,26 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
 	 * ECAP.
 	 */
-	desc.qw1 |= addr & ~mask;
-	if (size_order)
+	if (addr & GENMASK_ULL(size_order + VTD_PAGE_SHIFT, 0))
+		pr_warn_ratelimited("Invalidate non-aligned address %llx, order %d\n",
+				    addr, size_order);
+
+	/* Take page address */
+	desc.qw1 = QI_DEV_EIOTLB_ADDR(addr);
+
+	if (size_order) {
+		/*
+		 * Existing 0s in address below size_order may be the least
+		 * significant bit, we must set them to 1s to avoid having
+		 * smaller size than desired.
+		 */
+		desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT - 1,
+					VTD_PAGE_SHIFT);
+		/* Clear size_order bit to indicate size */
+		desc.qw1 &= ~mask;
+		/* Set the S bit to indicate flushing more than 1 page */
 		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
+	}
 
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
