Return-Path: <SRS0=jcR/=E5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573C0C56202
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 23:28:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99AF8206B6
	for <iommu@archiver.kernel.org>; Mon, 23 Nov 2020 23:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="B2IBeB19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AF8206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D34B985FD5;
	Mon, 23 Nov 2020 23:28:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RCGr50H5LGpi; Mon, 23 Nov 2020 23:28:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CE1E085BDF;
	Mon, 23 Nov 2020 23:28:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B80A2C0891;
	Mon, 23 Nov 2020 23:28:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9137EC0052
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 23:20:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7467E85BCD
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 23:20:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V75TuQgdpoHG for <iommu@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 23:20:25 +0000 (UTC)
X-Greylist: delayed 00:33:59 by SQLgrey-1.7.6
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com
 [209.85.161.74])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C4C5684EDB
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 23:20:25 +0000 (UTC)
Received: by mail-oo1-f74.google.com with SMTP id w3so7599999oov.6
 for <iommu@lists.linux-foundation.org>; Mon, 23 Nov 2020 15:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=YXylx3GCNHyHYBMQqsysdmzOVSsOtZin9cWyUbZGeSg=;
 b=B2IBeB19zTfs1xYaSNHLZDMsX3f0wvPupU1x6jQPo5zn0gD36JBXuYQIEFhSNZxQVc
 C+cutJyz7ixR0Zct99A8r8T+So46A9nmiDQAiQPQ5yQjyxNdxDFUrysbVUSvhoni3QWw
 qUNVsxjAQfDFmPr/HsEzGJYkQnVTRasJjwEaq22nHHkqnYRTLt+shTBNv1s7AsybXR/Q
 824VelCSQrO4ugrRqHUlEk05gL3618qDH7DQJgTrPp+XFCkLDAXfPJGZuCyUvB/ENZaN
 2sVT81n9zsSeivwzCcBMIGwGmXPrm13GhQHUsNjzlDceRfzYvC0buQx2dzAsdSmshJuR
 IjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=YXylx3GCNHyHYBMQqsysdmzOVSsOtZin9cWyUbZGeSg=;
 b=I/Nqk+gpN0UDRXutZmqb903MbBvG/vchKSFVmHFIeMg5YeIUJxXdRrmzhn2KcRHAiK
 JolWqlfl5vYqdOLqqk3oq5NDlgmJKWD3wDp+ai/sg02nw8Thk5uW2aNgBc3XOFfB1qO0
 GeirLn3rjiK1mbo/V1Ah2IN0EwZz8D2+UCtOKThEn/TDGAxkCN8nktiXlJxHsPz2F2xD
 Y4Rni0+eSQyIq/6aAagtKkSgNX2zPTqd13zjA2uUdFY18cxrI2L1w2kftr67VYeBHkx2
 RiwzcvJXLe4dSo8i6vjl3+rdqZo8A9SpbQObAIzEPb8qhDISXCh/Ua8HJq4zQxhEz6LY
 5RqQ==
X-Gm-Message-State: AOAM532731JSuTmNCmXmpIRwFfG/03C0rZy77RXIwcr7xAnQ9W71YB2F
 f0SooS6aJORQRmJ9KdET7lHuu2Hvtg==
X-Google-Smtp-Source: ABdhPJwaHIC5Agde+mPQGxwaVJCi4Ya+RC1h3w/HtrSv/HBYs4qc50kEx9QHD7poWbsARQ0erwEZDcV4cA==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:3e52:82ff:fe62:cb61])
 (user=jxgao job=sendgmr) by 2002:a17:90a:5b07:: with SMTP id
 o7mr1213160pji.58.1606169891131; Mon, 23 Nov 2020 14:18:11 -0800 (PST)
Date: Mon, 23 Nov 2020 14:18:07 -0800
Message-Id: <20201123221807.3344263-1-jxgao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] [PATCH] Adding offset keeping option when mapping data via
 SWIOTLB.
To: kbusch@kernel.org
X-Mailman-Approved-At: Mon, 23 Nov 2020 23:28:10 +0000
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

NVMe driver and other applications may depend on the data offset
to operate correctly. Currently when unaligned data is mapped via
SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When
booting with --swiotlb=force option and using NVMe as interface,
running mkfs.xfs on Rhel fails because of the unalignment issue.
This patch adds an option to make sure the mapped data preserves
its offset of the orginal addrss. Tested on latest kernel that
this patch fixes the issue.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 drivers/nvme/host/pci.c     |  3 ++-
 include/linux/dma-mapping.h |  8 ++++++++
 kernel/dma/swiotlb.c        | 13 +++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0578ff253c47..a366fb8a1ff0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -833,7 +833,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
 	else
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
-					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
+				rq_dma_dir(req),
+			       	DMA_ATTR_NO_WARN|DMA_ATTR_SWIOTLB_KEEP_OFFSET);
 	if (!nr_mapped)
 		goto out;
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 956151052d45..e46d23d9fa20 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -61,6 +61,14 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_SWIOTLB_KEEP_OFFSET: used to indicate that the buffer has to keep
+ * its offset when mapped via SWIOTLB. Some application functionality depends
+ * on the address offset, thus when buffers are mapped via SWIOTLB, the offset
+ * needs to be preserved.
+ */
+#define DMA_ATTR_SWIOTLB_KEEP_OFFSET	(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 781b9dca197c..f43d7be1342d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -483,6 +483,13 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	max_slots = mask + 1
 		    ? ALIGN(mask + 1, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT
 		    : 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
+ 
+	/*
+	 * If we need to keep the offset when mapping, we need to add the offset
+	 * to the total set we need to allocate in SWIOTLB
+	 */
+	if (attrs & DMA_ATTR_SWIOTLB_KEEP_OFFSET)
+		alloc_size += offset_in_page(orig_addr);
 
 	/*
 	 * For mappings greater than or equal to a page, we limit the stride
@@ -567,6 +574,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	 */
 	for (i = 0; i < nslots; i++)
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
+	/*
+	 * When keeping the offset of the original data, we need to advance
+	 * the tlb_addr by the offset of orig_addr.
+	 */
+	if (attrs & DMA_ATTR_SWIOTLB_KEEP_OFFSET)
+		tlb_addr += orig_addr & (PAGE_SIZE - 1);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
 		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
-- 
2.27.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
