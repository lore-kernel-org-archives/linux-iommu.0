Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B41C433FE
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 03:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4468C607B5;
	Mon,  7 Feb 2022 03:23:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KD01k8rOPHv1; Mon,  7 Feb 2022 03:23:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 30B946009C;
	Mon,  7 Feb 2022 03:23:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 145B9C0011;
	Mon,  7 Feb 2022 03:23:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08B64C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 03:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E57A5607B5
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 03:23:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qkUkTpi6Qbfn for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 03:23:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BAF1F6009C
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 03:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644204203; x=1675740203;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ko1vpkig3J7tQzgdH/SBKYMxBKnDnGBRY2QLcO+b5Kc=;
 b=TfI6xt37Mg6sjOzn1IRjaYA8MVbBDc/RlO2GLDmHJYi0EKtrixaVruLg
 Fo1toxPuOL2VHitOy7X5A618KNi7b3IVWSYNj02/1bBaxjOnyWfM6oXqj
 bf9d9M0rzfV9B2+jXLLEhfBZ2Zg4pdvdnUsXgS5t60RDRroAdg8AQtHqO
 z58wCMYoDjXNP78leH2E9DybYJTzxd5y/ox2kfvGSopm95H23X382BIwk
 5u1EZFM1ZhNFwPHDAvLHRgtrrSdr0tQD+/XMLkgmfmGGpJoYOeXjEWKUZ
 ElkvE1ew/uMPBqcPXn2FWMAKy1CsKTXC35R9HWR01Yl0jLTm4Xtb9GTXX A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="248397141"
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; d="scan'208";a="248397141"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2022 19:23:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; d="scan'208";a="772650492"
Received: from agabodun-lnx.jf.intel.com ([10.165.21.226])
 by fmsmga005.fm.intel.com with ESMTP; 06 Feb 2022 19:23:22 -0800
From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
To: akeem.g.abodunrin@intel.com, matthew.d.roper@intel.com,
 baolu.lu@linux.intel.com, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] iommu/core: Remove comment reference to
 iommu_dev_has_feature
Date: Sun,  6 Feb 2022 19:23:22 -0800
Message-Id: <20220207032322.16667-1-akeem.g.abodunrin@intel.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, hch@lst.de
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

iommu_dev_has_feature() api has been removed by the commit 262948f8ba573
("iommu: Delete iommu_dev_has_feature()") - So this patch removes comment
about the api to avoid any confusion.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/iommu.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index de0c57a567c8..bea054f2bd4d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -153,8 +153,7 @@ struct iommu_resv_region {
  *			 supported, this feature must be enabled before and
  *			 disabled after %IOMMU_DEV_FEAT_SVA.
  *
- * Device drivers query whether a feature is supported using
- * iommu_dev_has_feature(), and enable it using iommu_dev_enable_feature().
+ * Device drivers enable the feature via iommu_dev_enable_feature().
  */
 enum iommu_dev_features {
 	IOMMU_DEV_FEAT_AUX,
-- 
2.21.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
