Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F7C55178
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 01:57:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4436822282
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 01:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4436822282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2C61586B94;
	Wed, 28 Oct 2020 01:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hlvqa2ZUBp8z; Wed, 28 Oct 2020 01:57:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7066186B76;
	Wed, 28 Oct 2020 01:57:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DD80C088B;
	Wed, 28 Oct 2020 01:57:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC63DC0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 01:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D6BD02E122
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 01:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8BBismarNMtr for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 01:57:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id B0B0B2E169
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 01:57:49 +0000 (UTC)
IronPort-SDR: xRL5VRkjlBs/rtSYA2khxwtvIK98INSqvW6rgSHnU1Ql2ZiYSjrVF00xg1W4P6mJ2Q6tzmkm7D
 7SSFkul0rpzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="185942622"
X-IronPort-AV: E=Sophos;i="5.77,425,1596524400"; d="scan'208";a="185942622"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2020 18:57:47 -0700
IronPort-SDR: MyVfOMKMv8kJT/fZ9KwJOg3BP2iv/a1vungdoAXB30byjSkcjBg/StLmP0ldZvkhsGOtZVEhFJ
 zvi4diBzSKMA==
X-IronPort-AV: E=Sophos;i="5.77,425,1596524400"; d="scan'208";a="468554106"
Received: from yisun1-ubuntu2.bj.intel.com ([10.238.145.59])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA;
 27 Oct 2020 18:57:45 -0700
From: Yi Sun <yi.y.sun@linux.intel.com>
To: joro@8bytes.org,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com
Subject: [PATCH v1 2/3] iommu: Fix an issue in iommu_page_response() flags
 check
Date: Wed, 28 Oct 2020 09:36:57 +0800
Message-Id: <1603849018-6578-3-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603849018-6578-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1603849018-6578-1-git-send-email-yi.y.sun@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Yi Sun <yi.y.sun@linux.intel.com>,
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

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

original code fails when LAST_PAGE is set in flags.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 drivers/iommu/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c470f4..053cec3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1200,9 +1200,11 @@ int iommu_page_response(struct device *dev,
 		return -EINVAL;
 
 	if (msg->version != IOMMU_PAGE_RESP_VERSION_1 ||
-	    msg->flags & ~IOMMU_PAGE_RESP_PASID_VALID)
+		!(msg->flags & IOMMU_PAGE_RESP_PASID_VALID)) {
+		dev_warn_ratelimited(dev, "%s:Invalid ver %x: flags %x\n",
+				__func__, msg->version, msg->flags);
 		return -EINVAL;
-
+	}
 	/* Only send response if there is a fault report pending */
 	mutex_lock(&param->fault_param->lock);
 	if (list_empty(&param->fault_param->faults)) {
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
