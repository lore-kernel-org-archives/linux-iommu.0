Return-Path: <SRS0=GTcZ=FL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7044EC433FE
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 21:48:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD4E235F9
	for <iommu@archiver.kernel.org>; Mon,  7 Dec 2020 21:48:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD4E235F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 48D9820411;
	Mon,  7 Dec 2020 21:48:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xjM2NQHbzOYt; Mon,  7 Dec 2020 21:48:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E39E72E162;
	Mon,  7 Dec 2020 21:48:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4F4BC0893;
	Mon,  7 Dec 2020 21:48:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B5E5C013B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 21:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1A16186FC1
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 21:48:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JpZaxndvt8kS for <iommu@lists.linux-foundation.org>;
 Mon,  7 Dec 2020 21:48:45 +0000 (UTC)
X-Greylist: delayed 00:06:08 by SQLgrey-1.7.6
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com
 [209.85.210.202])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8FB7786FB2
 for <iommu@lists.linux-foundation.org>; Mon,  7 Dec 2020 21:48:45 +0000 (UTC)
Received: by mail-pf1-f202.google.com with SMTP id x26so10795353pfo.23
 for <iommu@lists.linux-foundation.org>; Mon, 07 Dec 2020 13:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=pDfU68hJbVrMhlby67/fptgGuh7zYii/tAwKwJs5ABQ=;
 b=XdTC5hS/AEdpujA2auDl0oiHQKAaDQNA+nqMfmnrCYYh60Dkvw/1dR+Uqim2ZTfKsp
 txd6ggR8/zez7Zopxjyt7hFhg16FOh9vUa/pXxIDhK+3h4EDtFXrjhqL5cntIgghjp78
 ulJUbMrWsBU+5TEyIgHX8fexxcALt9nHZBo3XCOJPIqefrFS0wzdLA7WXahxLjvxiGkl
 v0n+2BtTMPhtMBsVBEKn3ddkOgQDAN6kf3O1t4yOqCsAkjcSdX1RYDrxh56ZF07FMCyl
 cdYnuWXwrQg9M7pCQyE28aW30Zxaev8zo58FYDpaSSNWOoUB952tGlfLyFT5aFK2dMyW
 hpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=pDfU68hJbVrMhlby67/fptgGuh7zYii/tAwKwJs5ABQ=;
 b=avEr9vQph6+gugR9QWdmucHknEOaJPyF3lxo99TDLN1CpiIZhpSPEJPlU93qwQ8vLX
 xBbBgPH2lYOXzdAH9nLor9RUX4b0O4FMPummy2uEdmzBq21uAK3xbTR22MYX4VTpcVxo
 c75J4qALrFobffP45Jfd9mg0JGYdB6Q+/amLvnvKeIDmjws0n7dUQyDNXJz3sjrHL+Ru
 QARK+QUpOrghLDYcmyXFUDKqls3t7EWdMegvkTylXG4YSyuQ/IMGpvxwD+RA4+PNPIxd
 t0jdD69dHeYt/syPmBdiXn28eGwktne2j6QHf9RXCuFqEnDeSy5mHjwKOzcYUVGNuYM9
 ye8w==
X-Gm-Message-State: AOAM532zfFPM5DW3l912K64IInlGD+pTFbFGpcFDcErxQrICo2YDg1IW
 5tn0t5e6Du0qhVTJEvQwJMWuX58o1w==
X-Google-Smtp-Source: ABdhPJw1DKVB1ysvlps113dHRHd8Gdmd9wuw9y2HR7LIJxoQyNpy8ztEFdTjgj9WPEQ8k+rl387OW7IIVw==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:3e52:82ff:fe62:cb61])
 (user=jxgao job=sendgmr) by 2002:a17:902:b70d:b029:da:5196:1181 with SMTP id
 d13-20020a170902b70db02900da51961181mr18297299pls.81.1607377356798; Mon, 07
 Dec 2020 13:42:36 -0800 (PST)
Date: Mon,  7 Dec 2020 13:42:04 -0800
Message-Id: <20201207214204.1839028-1-jxgao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] [PATCH] Keep offset when mapping data via SWIOTLB.
To: kbusch@kernel.org
Cc: sagi@grimberg.me, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, iommu@lists.linux-foundation.org,
 David Rientjes <rientjes@google.com>, Jianxiong Gao <jxgao@google.com>,
 robin.murphy@arm.com, hch@lst.de
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
From: Jianxiong Gao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

NVMe driver and other applications depend on the data offset
to operate correctly. Currently when unaligned data is mapped via
SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When
booting with --swiotlb=force option and using NVMe as interface,
running mkfs.xfs on Rhel fails because of the unalignment issue.
This patch makes sure the mapped data preserves
its offset of the orginal address. Tested on latest kernel that
this patch fixes the issue.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/swiotlb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 781b9dca197c..56a35e71b3fd 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -483,6 +483,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	max_slots = mask + 1
 		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
+ 
+	/*
+	 * We need to keep the offset when mapping, so adding the offset
+	 * to the total set we need to allocate in SWIOTLB
+	 */
+	alloc_size += offset_in_page(orig_addr);
 
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
@@ -567,6 +573,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	 */
 	for (i = 0; i < nslots; i++)
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+	/*
+	 * When keeping the offset of the original data, we need to advance
+	 * the tlb_addr by the offset of orig_addr.
+	 */
+	tlb_addr += orig_addr & (PAGE_SIZE - 1);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
-- 
2.27.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
