Return-Path: <SRS0=RzN/=OQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A6EC433EF
	for <iommu@archiver.kernel.org>; Sun, 26 Sep 2021 11:49:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C465F610A2
	for <iommu@archiver.kernel.org>; Sun, 26 Sep 2021 11:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C465F610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 98E7740214;
	Sun, 26 Sep 2021 11:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PuV0YOMXGkYl; Sun, 26 Sep 2021 11:49:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2DF8D40278;
	Sun, 26 Sep 2021 11:49:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07B99C000F;
	Sun, 26 Sep 2021 11:49:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D1DDC000D
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 11:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2DE5402FD
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 11:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fqhkr8tYAG3H for <iommu@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 11:49:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1171C402EF
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 11:49:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10118"; a="222450222"
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; d="scan'208";a="222450222"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2021 04:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; d="scan'208";a="475640118"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 26 Sep 2021 04:49:18 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 3/3] iommu/vt-d: Use second level for GPA->HPA translation
Date: Sun, 26 Sep 2021 19:45:35 +0800
Message-Id: <20210926114535.923263-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926114535.923263-1-baolu.lu@linux.intel.com>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

The IOMMU VT-d implementation uses the first level for GPA->HPA translation
by default. Although both the first level and the second level could handle
the DMA translation, they're different in some way. For example, the second
level translation has separate controls for the Access/Dirty page tracking.
With the first level translation, there's no such control. On the other
hand, the second level translation has the page-level control for forcing
snoop, but the first level only has global control with pasid granularity.

This uses the second level for GPA->HPA translation so that we can provide
a consistent hardware interface for use cases like dirty page tracking for
live migration.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index dc2030d014e0..426630261614 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1991,9 +1991,15 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
  * Check and return whether first level is used by default for
  * DMA translation.
  */
-static bool first_level_by_default(void)
+static bool first_level_by_default(unsigned int type)
 {
-	return scalable_mode_support() && intel_cap_flts_sanity();
+	if (!scalable_mode_support())
+		return false;
+
+	if (intel_cap_flts_sanity() ^ intel_cap_slts_sanity())
+		return intel_cap_flts_sanity();
+
+	return type != IOMMU_DOMAIN_UNMANAGED;
 }
 
 static struct dmar_domain *alloc_domain(unsigned int type)
@@ -2006,7 +2012,7 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 
 	memset(domain, 0, sizeof(*domain));
 	domain->nid = NUMA_NO_NODE;
-	if (first_level_by_default())
+	if (first_level_by_default(type))
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
