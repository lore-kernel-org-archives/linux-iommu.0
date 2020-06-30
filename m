Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7997C433E1
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:01:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92AB52074D
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AB52074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 60867884ED;
	Tue, 30 Jun 2020 21:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17cx2IY9qn2k; Tue, 30 Jun 2020 21:01:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B1778883DC;
	Tue, 30 Jun 2020 21:01:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FCABC08A6;
	Tue, 30 Jun 2020 21:01:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75F95C0894
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5C0678809D
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:01:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lMceKEHuEJHu for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 21:01:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CAA1286569
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:01:07 +0000 (UTC)
IronPort-SDR: xYWFl/8aoIijSeyUcIrDOlS/TT0fIBos3yhtaDPJPr6aN2xIsTFhujixChxVpKHy/VK2cA5VDr
 wGG4L+dbaljQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="146382047"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="146382047"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 14:01:05 -0700
IronPort-SDR: MIWwdf6O5TXGxxxyWM56abduEscxzDTm2BxsDHsWk5E/tgLmIcRBFSFm5gswxP/d9JiiDDT4GY
 RYdGuRLuSeuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="425337237"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 30 Jun 2020 14:01:05 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 6/7] iommu/vt-d: Warn on out-of-range invalidation address
Date: Tue, 30 Jun 2020 14:07:37 -0700
Message-Id: <1593551258-39854-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

For guest requested IOTLB invalidation, address and mask are provided as
part of the invalidation data. VT-d HW silently ignores any address bits
below the mask. SW shall also allow such case but give warning if
address does not align with the mask. This patch relax the fault
handling from error to warning and proceed with invalidation request
with the given mask.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6a0c62c7395c..88e75be5ea76 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5439,13 +5439,12 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 
 		switch (BIT(cache_type)) {
 		case IOMMU_CACHE_INV_TYPE_IOTLB:
+			/* HW will ignore LSB bits based on address mask */
 			if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
 			    size &&
 			    (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
-				pr_err_ratelimited("Address out of range, 0x%llx, size order %llu\n",
-						   inv_info->addr_info.addr, size);
-				ret = -ERANGE;
-				goto out_unlock;
+				WARN_ONCE(1, "Address out of range, 0x%llx, size order %llu\n",
+					  inv_info->addr_info.addr, size);
 			}
 
 			/*
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
