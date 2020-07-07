Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C27C433E2
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 23:37:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B162077D
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 23:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B162077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B515B85F7E;
	Tue,  7 Jul 2020 23:37:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kBNPSr64Ga9E; Tue,  7 Jul 2020 23:37:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 78BF385D7E;
	Tue,  7 Jul 2020 23:37:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 447F1C08A5;
	Tue,  7 Jul 2020 23:37:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F3E4C07FF
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 23:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4BBD52152F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 23:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oCzN1YhChStN for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 23:37:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 39F382107F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 23:37:19 +0000 (UTC)
IronPort-SDR: /DPchw8yZ3KXzew3j0RvefIIzy3Wy97NwC8CoHmoQH8uUNuhrKT4l2aii9MepunAetnGwhPp0J
 cuFRVxJoUvTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135949002"
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; d="scan'208";a="135949002"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 16:37:13 -0700
IronPort-SDR: saGIe4FkPyjzymdlPV6AkjjXBgV8h0A2+xaUpttwEPdeQsjfLHIhHhAWnWfnofOI1SGTJbh1WB
 BiAelycxdyGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; d="scan'208";a="323693922"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 07 Jul 2020 16:37:13 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v4 5/5] iommu/vt-d: Remove UAPI version check
Date: Tue,  7 Jul 2020 16:43:49 -0700
Message-Id: <1594165429-20075-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594165429-20075-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1594165429-20075-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
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

IOMMU generic layer already does sanity checks on UAPI data which
include version check. Remove the version check from vendor driver.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 3 +--
 drivers/iommu/intel/svm.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index abd70b618a3f..63fcca4645c9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5383,8 +5383,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	int ret = 0;
 	u64 size = 0;
 
-	if (!inv_info || !dmar_domain ||
-	    inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+	if (!inv_info || !dmar_domain)
 		return -EINVAL;
 
 	if (!dev || !dev_is_pci(dev))
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 713b3a218483..15b36fa0147a 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -240,8 +240,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	if (WARN_ON(!iommu) || !data)
 		return -EINVAL;
 
-	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
-	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
+	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
 		return -EINVAL;
 
 	if (!dev_is_pci(dev))
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
