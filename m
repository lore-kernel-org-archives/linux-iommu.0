Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E28C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 06:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37E6F41687;
	Tue, 22 Mar 2022 06:36:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NJ_Eo8xtVzUD; Tue, 22 Mar 2022 06:36:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F005541680;
	Tue, 22 Mar 2022 06:36:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB2C9C001A;
	Tue, 22 Mar 2022 06:36:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58634C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 06:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28E0440386
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 06:36:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1jT0NQ-rGPqN for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:36:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F15B1400B8
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 06:36:34 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id i11so13963741plr.1
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 23:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G6vvJq5zoMKlH4LeyY++zNuuhHapBdcqnf3yKUaAlL4=;
 b=EFWlNhWZpicfIkIQP2h4g+pbFMtlmTLoWAm+LXiEA0O4kM1lViKFAHnYxbXcPrcx5E
 SprX6bMQEVYLdXjPKX3ZO/bPWgoY5ZaNNnqWJJKPHnSxzklPbBxQT3Ofcaqv1gWy7TAQ
 Sv0o60MHo6ih6uoTTCZvQKZveKBweJ6+VPj6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G6vvJq5zoMKlH4LeyY++zNuuhHapBdcqnf3yKUaAlL4=;
 b=XRFJXKhPGBKAmo01J0q0p5FauorF1Rmrlor+zFUd9FHiEAQkoOe4e/VyPALRBDubVf
 aKBQEbJ+orjhty7lnMEaZZUqosX2ZAQXNHvEy4WHBXtHF4vE/TPPct46sgN6mgY/EVnB
 ohTsjvUIbO5SnHj163Q/K0MD7TdQUyGL6nyff+1YdJyBBaOnEX5kL8X/awurPaM85e2d
 eKxXueFmC2iEA1rLfVDRwb2zUOOdP833mUZiNI/Hi3rKJcfAxLQl6t8hcBhRnpB7gtWo
 7u7XP8fiQcUKJeJgbXAemGgt6pQ40+DzjUwd957sOZxvLxJWXG3b8DEeZYXE8fcnGNsA
 wkYg==
X-Gm-Message-State: AOAM530HRBNg4cW2MbP/bRMYJRJ3tZFk4BX0wzJKRQKGYdtIsEs3/ge8
 MZakPym8k5fEc/k0HU/A60F2Dw==
X-Google-Smtp-Source: ABdhPJwYVDLjrioQC821Tnchg1fLRlY6qHPW4SoqkFywCCr1nD6wcEkSOGlMlHmEuN5luqRgjiFbtw==
X-Received: by 2002:a17:902:bcc2:b0:14f:23c6:c8c5 with SMTP id
 o2-20020a170902bcc200b0014f23c6c8c5mr16437126pls.131.1647930994318; 
 Mon, 21 Mar 2022 23:36:34 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:e974:e434:a940:4f9f])
 by smtp.gmail.com with UTF8SMTPSA id
 gb5-20020a17090b060500b001c6d46f7e75sm1491413pjb.30.2022.03.21.23.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Mar 2022 23:36:33 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v2] iommu/vt-d: calculate mask for non-aligned flushes
Date: Tue, 22 Mar 2022 15:35:55 +0900
Message-Id: <20220322063555.1422042-1-stevensd@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
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

From: David Stevens <stevensd@chromium.org>

Calculate the appropriate mask for non-size-aligned page selective
invalidation. Since psi uses the mask value to mask out the lower order
bits of the target address, properly flushing the iotlb requires using a
mask value such that [pfn, pfn+pages) all lie within the flushed
size-aligned region.  This is not normally an issue because iova.c
always allocates iovas that are aligned to their size. However, iovas
which come from other sources (e.g. userspace via VFIO) may not be
aligned.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
v1 -> v2:
 - Calculate an appropriate mask for non-size-aligned iovas instead
   of falling back to domain selective flush.

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
2.35.1.894.gb6a874cedc-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
