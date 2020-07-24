Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692A4C433E5
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1D52086A
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1D52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 33343881BB;
	Fri, 24 Jul 2020 01:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AbqRqOrmU-9n; Fri, 24 Jul 2020 01:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B514D88204;
	Fri, 24 Jul 2020 01:54:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2328C004E;
	Fri, 24 Jul 2020 01:54:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 142F2C004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0181287EB1
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sD1qmiLAQ2Bf for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 01:54:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 65B6387EA3
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:35 +0000 (UTC)
IronPort-SDR: Bndd4gALE1iPg4zrVJ2oksm9Baxpf/NoZXMvzFLGIdSexsVi0TXCfdTicetHd3S7La3NvkSGqz
 DOSdCHiMCufg==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="168778781"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="168778781"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 18:54:35 -0700
IronPort-SDR: NgAg4vV9RIAGphabA8UY+5fW17KaQ9J629EhhWXKulF+EiX+xFPJ/0i/rAo8Pef+J/ZnuDg75s
 Rtfx9xIK56LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="488576743"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2020 18:54:33 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 06/12] iommu/vt-d: Warn on out-of-range invalidation address
Date: Fri, 24 Jul 2020 09:49:19 +0800
Message-Id: <20200724014925.15523-7-baolu.lu@linux.intel.com>
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

For guest requested IOTLB invalidation, address and mask are provided as
part of the invalidation data. VT-d HW silently ignores any address bits
below the mask. SW shall also allow such case but give warning if
address does not align with the mask. This patch relax the fault
handling from error to warning and proceed with invalidation request
with the given mask.

Fixes: 6ee1b77ba3ac0 ("iommu/vt-d: Add svm/sva invalidate function")
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 281b32b233d8..592869ce2a0f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5453,13 +5453,12 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 
 		switch (BIT(cache_type)) {
 		case IOMMU_CACHE_INV_TYPE_IOTLB:
+			/* HW will ignore LSB bits based on address mask */
 			if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
 			    size &&
 			    (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
-				pr_err_ratelimited("Address out of range, 0x%llx, size order %llu\n",
+				pr_err_ratelimited("User address not aligned, 0x%llx, size order %llu\n",
 						   inv_info->addr_info.addr, size);
-				ret = -ERANGE;
-				goto out_unlock;
 			}
 
 			/*
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
