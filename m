Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB06CC433F5
	for <iommu@archiver.kernel.org>; Fri,  1 Apr 2022 02:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73C4E84049;
	Fri,  1 Apr 2022 02:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8uwFIUU1UGej; Fri,  1 Apr 2022 02:24:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2D4C884046;
	Fri,  1 Apr 2022 02:24:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F099AC001D;
	Fri,  1 Apr 2022 02:24:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4E61C0012
 for <iommu@lists.linux-foundation.org>; Fri,  1 Apr 2022 02:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D37441260
 for <iommu@lists.linux-foundation.org>; Fri,  1 Apr 2022 02:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sfVI7OoDVnEx for <iommu@lists.linux-foundation.org>;
 Fri,  1 Apr 2022 02:24:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D38640126
 for <iommu@lists.linux-foundation.org>; Fri,  1 Apr 2022 02:24:41 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id cm17so1170628pjb.2
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 19:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LooVy6HxBljYsBOT5BZDR0fJDc4Rp8fN59jEgY+o0DI=;
 b=PJAxfuVD6PmKHxbahwunHYBhTlcgqbr8BH03aEQ7YdBeYh0l8U1M+pgy+mr9SEeoJX
 spL22iG8LTYMgQoBYGlE7JsmG25ZPJjbYzqJgTUYalOgziSNfj4aEBd0+3qR4DQedjLu
 ZRZPZr/+0ck7AP7BQvcFp4UV2cft/iM9QSGzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LooVy6HxBljYsBOT5BZDR0fJDc4Rp8fN59jEgY+o0DI=;
 b=mMdtQTqOG+e2dR4HwYxBGmKzK6YkKOyjVOaBwygmUoR7g+HD59btf6T8hqSTyXcXPy
 WY0QcosLq2itIW3Kv53rY2Ew3V5pWZCzyUhay5XozFxAuPvRMMNEqtN2ex92B50rXjZj
 zi6TUPIg8SwRHWhC3t5ajW6pzRbtwPeBLcbO/5tXOcfz4RqbAqflmZFuyo3X7fFyyrM5
 EQxdcQbZD8tQF1hCdxEnoqrumbj23gN2LUsVs6dqhLVnAjrsqtonpwx0anX6iiCOEjLL
 bbENGWJ+aH+1/cLJ3TVuCjwMBlWU0xr16MIFAMNdB1McBRD8UiVUgC3lYmqgJpk+GX8Z
 KVZg==
X-Gm-Message-State: AOAM530WBwrS9nARV+meHg09GCe50KtJwovI0SPE1ADP1nhnexg3aKUo
 0heek6M9ey3QPUNNcFs84764LA==
X-Google-Smtp-Source: ABdhPJx3cds3IJYsBVyQKsdjyy6GrzZdmfUcleihi5PO6oQwuyC6RYYe7HrHRCWYE9lO/XrCkzT6Rw==
X-Received: by 2002:a17:903:110f:b0:154:c7a4:9371 with SMTP id
 n15-20020a170903110f00b00154c7a49371mr8265857plh.75.1648779880649; 
 Thu, 31 Mar 2022 19:24:40 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:2248:fc58:91aa:767])
 by smtp.gmail.com with UTF8SMTPSA id
 b7-20020a056a00114700b004f7be3231d6sm815989pfm.7.2022.03.31.19.24.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Mar 2022 19:24:40 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v3] iommu/vt-d: calculate mask for non-aligned flushes
Date: Fri,  1 Apr 2022 11:24:30 +0900
Message-Id: <20220401022430.1262215-1-stevensd@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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
---
The seeds of the bug were introduced by f76aec76ec7f6, which
simultaniously added the alignement requirement to the iommu driver and
made the iova allocator return aligned iovas. However, I don't think
there was any way to trigger the bug at that time. The tagged VFIO
change is one that actually introduced a code path that could trigger
the bug. There may also be other ways to trigger the bug that I am not
aware of.

v1 -> v2:
 - Calculate an appropriate mask for non-size-aligned iovas instead
   of falling back to domain selective flush.
v2 -> v3:
 - Add more detail to commit message.

 drivers/iommu/intel/iommu.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5b196cfe9ed2..ab2273300346 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1717,7 +1717,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 				  unsigned long pfn, unsigned int pages,
 				  int ih, int map)
 {
-	unsigned int mask = ilog2(__roundup_pow_of_two(pages));
+	unsigned int aligned_pages = __roundup_pow_of_two(pages);
+	unsigned int mask = ilog2(aligned_pages);
 	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
 	u16 did = domain->iommu_did[iommu->seq_id];
 
@@ -1729,10 +1730,30 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	if (domain_use_first_level(domain)) {
 		domain_flush_piotlb(iommu, domain, addr, pages, ih);
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
2.35.1.1094.g7c7d902a7c-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
