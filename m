Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276B8C433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 23:18:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D2220708
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 23:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D2220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C775A86DF1;
	Mon, 22 Jun 2020 23:18:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EglQy-5nPiEH; Mon, 22 Jun 2020 23:18:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id ABF3B86CAC;
	Mon, 22 Jun 2020 23:18:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B150C0891;
	Mon, 22 Jun 2020 23:18:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9652FC016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 707E38872B
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g2I9AzveFs4X for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 23:18:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C369D888D6
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:18:06 +0000 (UTC)
IronPort-SDR: c7uLpTxUd5INwMqlduNqf2wtQ2Y7678rgBzTfHNSsdCgR9Fu+iVB2tmtjaUUkMJHAelcJWS6d4
 dH/uOyLN715g==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="124176536"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="124176536"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 16:18:05 -0700
IronPort-SDR: liPi7WMSZYPTV+q07DuIsL8+6WPRWVHgDpXxUWndRmvzOkOpcr1B9HbSM/x9/oCsewwVBZ5m4F
 6jk8nemzZe+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="301006528"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2020 16:18:01 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/6] iommu/vt-d: Set U/S bit in first level page table by
 default
Date: Tue, 23 Jun 2020 07:13:41 +0800
Message-Id: <20200622231345.29722-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622231345.29722-1-baolu.lu@linux.intel.com>
References: <20200622231345.29722-1-baolu.lu@linux.intel.com>
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

When using first-level translation for IOVA, currently the U/S bit in the
page table is cleared which implies DMA requests with user privilege are
blocked. As the result, following error messages might be observed when
passing through a device to user level:

DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Read] Request device [41:00.0] PASID 1 fault addr 7ecdcd000
        [fault reason 129] SM: U/S set 0 for first-level translation
        with user privilege

This fixes it by setting U/S bit in the first level page table and makes
IOVA over first level compatible with previous second-level translation.

Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
Reported-by: Xin Zeng <xin.zeng@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 5 ++---
 include/linux/intel-iommu.h | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9129663a7406..0fa394f7bbf9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -921,7 +921,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 			domain_flush_cache(domain, tmp_page, VTD_PAGE_SIZE);
 			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
 			if (domain_use_first_level(domain))
-				pteval |= DMA_FL_PTE_XD;
+				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
 			if (cmpxchg64(&pte->val, 0ULL, pteval))
 				/* Someone else set it while we were thinking; use theirs. */
 				free_pgtable_page(tmp_page);
@@ -1951,7 +1951,6 @@ static inline void
 context_set_sm_rid2pasid(struct context_entry *context, unsigned long pasid)
 {
 	context->hi |= pasid & ((1 << 20) - 1);
-	context->hi |= (1 << 20);
 }
 
 /*
@@ -2243,7 +2242,7 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 
 	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
 	if (domain_use_first_level(domain))
-		attr |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_XD;
+		attr |= DMA_FL_PTE_PRESENT | DMA_FL_PTE_XD | DMA_FL_PTE_US;
 
 	if (!sg) {
 		sg_res = nr_pages;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4100bd224f5c..3e8fa1c7a1e6 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -41,6 +41,7 @@
 #define DMA_PTE_SNP		BIT_ULL(11)
 
 #define DMA_FL_PTE_PRESENT	BIT_ULL(0)
+#define DMA_FL_PTE_US		BIT_ULL(2)
 #define DMA_FL_PTE_XD		BIT_ULL(63)
 
 #define ADDR_WIDTH_5LEVEL	(57)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
