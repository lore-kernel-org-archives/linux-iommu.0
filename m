Return-Path: <SRS0=F28s=FB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BEFC63777
	for <iommu@archiver.kernel.org>; Fri, 27 Nov 2020 01:40:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D96422228
	for <iommu@archiver.kernel.org>; Fri, 27 Nov 2020 01:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D96422228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 092BB87982;
	Fri, 27 Nov 2020 01:40:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bCnJ6DM+ora7; Fri, 27 Nov 2020 01:40:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 623BB8797C;
	Fri, 27 Nov 2020 01:40:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 420A5C0891;
	Fri, 27 Nov 2020 01:40:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42CCFC0052
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 01:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 258F98797F
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 01:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IICSP68knR1k for <iommu@lists.linux-foundation.org>;
 Fri, 27 Nov 2020 01:40:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 809DB8797C
 for <iommu@lists.linux-foundation.org>; Fri, 27 Nov 2020 01:40:38 +0000 (UTC)
IronPort-SDR: xGupATE75cLPDIRUBuuM4gCQtnvIwIBLrtgqxBLLwpToNyfwvMhCT+931ZFLoGPSJv5cu+aS/2
 w7O34hmx+4eA==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="159386851"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; d="scan'208";a="159386851"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2020 17:40:37 -0800
IronPort-SDR: luTU8T4gGrJ+vN0Tv7JZLe7oT+Nn79S7H6CmHj0LDER5vank1jJsa/uHNMPirlRiAITy28qwGO
 rDr0n2OTakPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; d="scan'208";a="535902890"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by fmsmga006.fm.intel.com with ESMTP; 26 Nov 2020 17:40:35 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Remove set but not used variable
Date: Fri, 27 Nov 2020 09:33:08 +0800
Message-Id: <20201127013308.1833610-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: kernel test robot <lkp@intel.com>, iommu@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/iommu/intel/iommu.c:5643:27: warning: variable 'last_pfn' set but not used [-Wunused-but-set-variable]
5643 |  unsigned long start_pfn, last_pfn;
     |                           ^~~~~~~~

This variable is never used, so remove it.

Fixes: 2a2b8eaa5b256 ("iommu: Handle freelists when using deferred flushing in iommu drivers")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f9379b4a32fb..8c6c3c0812d2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4942,13 +4942,12 @@ static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	unsigned long iova_pfn = IOVA_PFN(gather->start);
 	size_t size = gather->end - gather->start;
-	unsigned long start_pfn, last_pfn;
+	unsigned long start_pfn;
 	unsigned long nrpages;
 	int iommu_id;
 
 	nrpages = aligned_nrpages(gather->start, size);
 	start_pfn = mm_to_dma_pfn(iova_pfn);
-	last_pfn = start_pfn + nrpages - 1;
 
 	for_each_domain_iommu(iommu_id, dmar_domain)
 		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
