Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79507C433FE
	for <iommu@archiver.kernel.org>; Sun, 10 Apr 2022 01:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DB9282B24;
	Sun, 10 Apr 2022 01:38:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5jdbygKFVNZd; Sun, 10 Apr 2022 01:38:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EBE6682BBC;
	Sun, 10 Apr 2022 01:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 763F2C002C;
	Sun, 10 Apr 2022 01:38:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B139C002C
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 01:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C01C8291A
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 01:38:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dq4gAIJAY0PT for <iommu@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 01:38:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 39CF58291D
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 01:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649554719; x=1681090719;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=In+/QOrPU5IpcGY/W0qgls0wxYTkECZ2NYOwXQKNj5c=;
 b=U65QdPQ/Bx02qbKfG3N7XwW70vUpaDzzxWn4GFfFv54oXR7k12JZHU1B
 pzQVNPTaHiE/qzro37QvsjTFtdyAbjX+8nmKmtY69AtAQJsroxIkVxDbE
 mEJF90ZDX8UkHeFy+QZLQo3jehHFdWqbIqVBMQGlKsp7sv7l5NUq+fbP4
 WXJjcHOpiQkQU2xr+h/aHFYXDcg/wk4y+ZhqFJnrstewf67xknfMpjL7e
 /rL+mpl6V3794/mj9kMi8vnDrCa5V11c9EOwGOOZy4xZURyq3C21wuCc6
 fYkLoRDo9jkr/yxVEWNhwXSrxDcrp5XC0Z+iOr1vGT7X2pMPUQjfeHGM7 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="259524673"
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; d="scan'208";a="259524673"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2022 18:38:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,248,1643702400"; d="scan'208";a="610529709"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga008.fm.intel.com with ESMTP; 09 Apr 2022 18:38:28 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Calculate mask for non-aligned flushes
Date: Sun, 10 Apr 2022 09:35:33 +0800
Message-Id: <20220410013533.3959168-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410013533.3959168-1-baolu.lu@linux.intel.com>
References: <20220410013533.3959168-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: stable@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
 David Stevens <stevensd@chromium.org>, iommu@lists.linux-foundation.org
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

From: David Stevens <stevensd@chromium.org>

Calculate the appropriate mask for non-size-aligned page selective
invalidation. Since psi uses the mask value to mask out the lower order
bits of the target address, properly flushing the iotlb requires using a
mask value such that [pfn, pfn+pages) all lie within the flushed
size-aligned region.  This is not normally an issue because iova.c
always allocates iovas that are aligned to their size. However, iovas
which come from other sources (e.g. userspace via VFIO) may not be
aligned.

To properly flush the IOTLB, both the start and end pfns need to be
equal after applying the mask. That means that the most efficient mask
to use is the index of the lowest bit that is equal where all higher
bits are also equal. For example, if pfn=0x17f and pages=3, then
end_pfn=0x181, so the smallest mask we can use is 8. Any differences
above the highest bit of pages are due to carrying, so by xnor'ing pfn
and end_pfn and then masking out the lower order bits based on pages, we
get 0xffffff00, where the first set bit is the mask we want to use.

Fixes: 6fe1010d6d9c ("vfio/type1: DMA unmap chunking")
Cc: stable@vger.kernel.org
Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220401022430.1262215-1-stevensd@google.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index df5c62ecf942..0ea47e17b379 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1588,7 +1588,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 				  unsigned long pfn, unsigned int pages,
 				  int ih, int map)
 {
-	unsigned int mask = ilog2(__roundup_pow_of_two(pages));
+	unsigned int aligned_pages = __roundup_pow_of_two(pages);
+	unsigned int mask = ilog2(aligned_pages);
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain->iommu_did[iommu->seq_id];
 
@@ -1600,10 +1601,30 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	if (domain_use_first_level(domain)) {
 		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, pages, ih);
 	} else {
+		unsigned long bitmask = aligned_pages - 1;
+
+		/*
+		 * PSI masks the low order bits of the base address. If the
+		 * address isn't aligned to the mask, then compute a mask value
+		 * needed to ensure the target range is flushed.
+		 */
+		if (unlikely(bitmask & pfn)) {
+			unsigned long end_pfn = pfn + pages - 1, shared_bits;
+
+			/*
+			 * Since end_pfn <= pfn + bitmask, the only way bits
+			 * higher than bitmask can differ in pfn and end_pfn is
+			 * by carrying. This means after masking out bitmask,
+			 * high bits starting with the first set bit in
+			 * shared_bits are all equal in both pfn and end_pfn.
+			 */
+			shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
+			mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
+		}
+
 		/*
 		 * Fallback to domain selective flush if no PSI support or
-		 * the size is too big. PSI requires page size to be 2 ^ x,
-		 * and the base address is naturally aligned to the size.
+		 * the size is too big.
 		 */
 		if (!cap_pgsel_inv(iommu->cap) ||
 		    mask > cap_max_amask_val(iommu->cap))
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
