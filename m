Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84432C4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 02:44:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D05A60F55
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 02:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D05A60F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1556340125;
	Wed, 11 Aug 2021 02:44:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Amp52DnLYWIB; Wed, 11 Aug 2021 02:44:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ADF8940109;
	Wed, 11 Aug 2021 02:44:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C5E8C0010;
	Wed, 11 Aug 2021 02:44:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6586AC000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54EB840458
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ClcKpaJDy3fA for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 02:44:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54CF940332
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:25 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id j1so1110539pjv.3
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 19:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uK/FnVBscvb9gt2KwYk+sXYzXlkd3kRD4fZoCy8gV8Q=;
 b=aJGVB54LoTfBWgGyOTv3dYkkKKgSH4tjlVJIn/OLX7BXnPUh3Wfg1tGz0JfF/UYtcI
 sHLbpkAdYUQYAw0eikau+liKR+YJ5Vel6RFU2LzOQ88O9hUj9704YfliHs3MfbA/ZK4E
 Sn3vH4vVBuaR8UafmSt7qADKfIYfXS42s1prU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uK/FnVBscvb9gt2KwYk+sXYzXlkd3kRD4fZoCy8gV8Q=;
 b=NqvlADkfyzIHB/AY6DBlxBCtLTy8DccGsPxbm7Av1yB/MNVkTR0EsUApMFcfRY8qUn
 9RadgwZVt0Jv8oNYvRx61CE2yUX/xoXJrJkVtYMVXCddKbrVCrDcMB/qeWmHB4+b6/tY
 N6nJ5n1gpjTzdB52/lftvu9/HsguTUKro6KYb65R7YpXxLPjLP0o26E2gnsoluH+JpDr
 1vZ4OqsnKA/Dp+Uk8vZL9SMzGtMHN3JHGJG78oUWoOhvCivIN8N/0xNfHJonHb3242Eg
 lTAm5/csGIRl9kWAOVJom4m1LUrhlSG+Xh3LBCu2IBTAcmuZymVj0hdRb8BnOf9iYKUu
 pobg==
X-Gm-Message-State: AOAM533g8PKlKUFvAg/0asK3Axv8t+H2UXY7MUvBi6KrkoBLXa+ohuIX
 ZvUA+0bVmEX+Fe7sz4jW2TWaPw==
X-Google-Smtp-Source: ABdhPJzbsUY7hLr+SsX/ZABjK8m2acBbgxoapc9e0rEkZpzz39aRPvDlpqvnBDgk2iJsisu2YxepeQ==
X-Received: by 2002:a63:1e4b:: with SMTP id p11mr335123pgm.295.1628649864834; 
 Tue, 10 Aug 2021 19:44:24 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1e5c:70cb:3289:1b5b])
 by smtp.gmail.com with UTF8SMTPSA id 21sm25298942pfh.103.2021.08.10.19.44.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 19:44:24 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 5/5] dma-iommu: account for min_align_mask
Date: Wed, 11 Aug 2021 11:42:47 +0900
Message-Id: <20210811024247.1144246-6-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210811024247.1144246-1-stevensd@google.com>
References: <20210811024247.1144246-1-stevensd@google.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>
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

For devices which set min_align_mask, swiotlb preserves the offset of
the original physical address within that mask. Since __iommu_dma_map
accounts for non-aligned addresses, passing a non-aligned swiotlb
address with the swiotlb aligned size results in the offset being
accounted for twice in the size passed to iommu_map_atomic. The extra
page exposed to DMA is also not cleaned up by __iommu_dma_unmap, since
tht at function unmaps with the correct size. This causes mapping failures
if the iova gets reused, due to collisions in the iommu page tables.

To fix this, pass the original size to __iommu_dma_map, since that
function already handles alignment.

Additionally, when swiotlb returns non-aligned addresses, there is
padding at the start of the bounce buffer that needs to be cleared.

Fixes: 1f221a0d0dbf ("swiotlb: respect min_align_mask")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 89b689bf801f..ffa7e8ef5db4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -549,9 +549,8 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	size_t aligned_size = org_size;
-	void *padding_start;
-	size_t padding_size;
+	void *tlb_start;
+	size_t aligned_size, iova_off, mapping_end_off;
 	dma_addr_t iova;
 
 	/*
@@ -566,24 +565,26 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 		if (phys == DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
 
-		/* Cleanup the padding area. */
-		padding_start = phys_to_virt(phys);
-		padding_size = aligned_size;
+		iova_off = iova_offset(iovad, phys);
+		tlb_start = phys_to_virt(phys - iova_off);
 
+		/* Cleanup the padding area. */
 		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 		    (dir == DMA_TO_DEVICE ||
 		     dir == DMA_BIDIRECTIONAL)) {
-			padding_start += org_size;
-			padding_size -= org_size;
+			mapping_end_off = iova_off + org_size;
+			memset(tlb_start, 0, iova_off);
+			memset(tlb_start + mapping_end_off, 0,
+			       aligned_size - mapping_end_off);
+		} else {
+			memset(tlb_start, 0, aligned_size);
 		}
-
-		memset(padding_start, 0, padding_size);
 	}
 
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		arch_sync_dma_for_device(phys, org_size, dir);
 
-	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
+	iova = __iommu_dma_map(dev, phys, org_size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
 		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
 	return iova;
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
