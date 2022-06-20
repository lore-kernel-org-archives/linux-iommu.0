Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCABC43334
	for <iommu@archiver.kernel.org>; Mon, 20 Jun 2022 08:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EFCC8315C;
	Mon, 20 Jun 2022 08:22:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EFCC8315C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ng9iqWLI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PgmW-grrydVS; Mon, 20 Jun 2022 08:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B1338317B;
	Mon, 20 Jun 2022 08:22:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B1338317B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20ACCC0032;
	Mon, 20 Jun 2022 08:22:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FF4EC002D
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 08:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D17740AC8
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 08:21:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D17740AC8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Ng9iqWLI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MW7oGDlfe5JL for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:21:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8574740931
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8574740931
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jun 2022 08:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655713318; x=1687249318;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8E2kEq+GCo7Dhht4sPeokQjW9I35j7HibLiiqhyWzLc=;
 b=Ng9iqWLIMzjDI7euSYMYSGGFVj78nmav99CsJnC0F2q8jmEziCXNDxlH
 zRzeJB5OFfPRVQ4nS6cHBL4nF0mg/Lte5LwmsbQfYyc6hYu8xG9ZO2g78
 7/ApZRc810iP8ux40j/9GKctOuB/nxpskMvo6xqf9h6VyVA0oPn9y/r5W
 kuCzTcKYFd/pXBN+IIIBmiU6q0ITXMCrBqIvOvCPgnT06IGNNV4LZiU95
 pGk3hljNMZnHIyau9RNCMEEE6lAmCXIjIiA6+26mYhZc2Kj3keDGn0NXy
 ErvS/Y3W6aOGR9q3IfENyoZlvRfWM4j5IGuDMDiQ0iO9pSnIufqqGLL1x A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278609630"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="278609630"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 01:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="584799278"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 20 Jun 2022 01:21:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Fix RID2PASID setup failure
Date: Mon, 20 Jun 2022 16:17:29 +0800
Message-Id: <20220620081729.4610-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The IOMMU driver shares the pasid table for PCI alias devices. When the
RID2PASID entry of the shared pasid table has been filled by the first
device, the subsequent devices will encounter the "DMAR: Setup RID2PASID
failed" failure as the pasid entry has already been marke as present. As
the result, the IOMMU probing process will be aborted.

This fixes it by skipping RID2PASID setting if the pasid entry has been
populated. This works because the IOMMU core ensures that only the same
IOMMU domain can be attached to all PCI alias devices at the same time.
Therefore the subsequent devices just try to setup the RID2PASID entry
with the same domain, which is negligible.

Fixes: ef848b7e5a6a0 ("iommu/vt-d: Setup pasid entry for RID2PASID support")
Reported-by: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 44016594831d..b9966c01a2a2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2564,7 +2564,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
 		spin_unlock_irqrestore(&iommu->lock, flags);
-		if (ret) {
+		if (ret && ret != -EBUSY) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
 			return ret;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
