Return-Path: <SRS0=NWqd=2B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25032C43603
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 01:41:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CC0205ED
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 01:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CC0205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A83ED88538;
	Wed, 11 Dec 2019 01:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sl5CPF7T9f5A; Wed, 11 Dec 2019 01:41:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 047BA88527;
	Wed, 11 Dec 2019 01:41:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2C12C1797;
	Wed, 11 Dec 2019 01:41:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CDD1C0881
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 01:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EAF8F88527
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 01:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JYPF+gWyiiE8 for <iommu@lists.linux-foundation.org>;
 Wed, 11 Dec 2019 01:41:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 49FF488524
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 01:41:17 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Dec 2019 17:41:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; d="scan'208";a="238371606"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 10 Dec 2019 17:41:14 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 1/1] iommu/vt-d: Fix dmar pte read access not set error
Date: Wed, 11 Dec 2019 09:40:15 +0800
Message-Id: <20191211014015.7898-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com
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

If the default DMA domain of a group doesn't fit a device, it
will still sit in the group but use a private identity domain.
When map/unmap/iova_to_phys come through iommu API, the driver
should still serve them, otherwise, other devices in the same
group will be impacted. Since identity domain has been mapped
with the whole available memory space and RMRRs, we don't need
to worry about the impact on it.

Link: https://www.spinics.net/lists/iommu/msg40416.html
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: 942067f1b6b97 ("iommu/vt-d: Identify default domains replaced with private")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f56a30..b73bebea9148 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5478,9 +5478,6 @@ static int intel_iommu_map(struct iommu_domain *domain,
 	int prot = 0;
 	int ret;
 
-	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
-		return -EINVAL;
-
 	if (iommu_prot & IOMMU_READ)
 		prot |= DMA_PTE_READ;
 	if (iommu_prot & IOMMU_WRITE)
@@ -5523,8 +5520,6 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	/* Cope with horrid API which requires us to unmap more than the
 	   size argument if it happens to be a large-page mapping. */
 	BUG_ON(!pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level));
-	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
-		return 0;
 
 	if (size < VTD_PAGE_SIZE << level_to_offset_bits(level))
 		size = VTD_PAGE_SIZE << level_to_offset_bits(level);
@@ -5556,9 +5551,6 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	int level = 0;
 	u64 phys = 0;
 
-	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
-		return 0;
-
 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
 	if (pte)
 		phys = dma_pte_addr(pte);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
