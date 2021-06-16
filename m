Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E921C48BE8
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:43:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FFF461375
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFF461375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E79974051B;
	Wed, 16 Jun 2021 11:43:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZaV7nXjJ2zxt; Wed, 16 Jun 2021 11:43:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D6C06404F8;
	Wed, 16 Jun 2021 11:43:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99EF3C000D;
	Wed, 16 Jun 2021 11:43:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4637C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5037404E3
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:43:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZGlejzAF3z4u for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 11:43:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EFE564051E
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:43:10 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id x24so3794646lfr.10
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TRz4KFdLmerhp38zcm9b3IR/zrRQXeHz9t6YRT8nYG4=;
 b=BQ1EiQqyrVqVHYO1YJE1WkJqCisfV4zCqAT3TpOECMypGYpV2HVPzoVU78QyxUTGAf
 aAH1SaSFCB7L2Zwql0oaykhTd5SIZvsqRiyKGnR6Kxog148iIqumKXrnh0/VJ/veU9Ux
 wvSgoT6qHRxR8lAsqujwyx9M+PQupGHXXWZpxTPZG0r4b8vCndoHVlDaSmhzeTE2Manq
 3vxiQEtDa7fUD49JhUcZzcevSLWhTCg706FlcM3EuG69A56qczdMbi5WsoKwXdU2sXaJ
 ze1zdv4c9B+QJXP88ExqlT0wV7mh1mHgraR8vV7NhcZ77jHpxAgJjsi/6obs4dwP4k4B
 Da3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TRz4KFdLmerhp38zcm9b3IR/zrRQXeHz9t6YRT8nYG4=;
 b=Xy6eXnhlFdD5cz4ORbTIZ/2Fv7Ly2vC+G3RT2hPBGA4446wkLKt2HHnt4+3LRIj1C4
 h8tNb+Eba70hutB3hS05wbkT2Trf5hR0abVOdVNxo6siS/evzmBW1m3pswtzuG51qEH9
 c3jBUnLAJvZMqM5RH5voDbWB4y9IHgwKIuzkuMmwKYxzUm47lrZ8iIJVcN0qzrPY6Ygv
 sRv144M2tynuk5yKgBjRYXH8PjT9BPp/J4r3nCMNF4c6Qsb+TFJx/PfEVPW2Xbncp9+d
 UyRm8bZZNAx2DFE94b9WaLFTeO0TzntLIewPnOrri55N2vTSV5s0Ec4p1UWcRfZwQCAS
 22XA==
X-Gm-Message-State: AOAM5339BGXzVBNuu+TvPZQox+IAviKRQgTq9puFtbw6q//VoBXKEH7K
 NuVLBy0t+J48hvxMx8gnsxU=
X-Google-Smtp-Source: ABdhPJwAYLX/JWWa/WTgHFPNNwbAi3jjfzTIsIUGQh6s1o9tPoHMdzNk1Uqk89bpuFeRS3vRXZ3c8w==
X-Received: by 2002:ac2:58e3:: with SMTP id v3mr3388446lfo.339.1623843788885; 
 Wed, 16 Jun 2021 04:43:08 -0700 (PDT)
Received: from localhost ([178.151.124.169])
 by smtp.gmail.com with ESMTPSA id bp28sm222612lfb.188.2021.06.16.04.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jun 2021 04:43:08 -0700 (PDT)
From: Roman Skakun <rm.skakun@gmail.com>
X-Google-Original-From: Roman Skakun <roman_skakun@epam.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Revert "swiotlb-xen: remove xen_swiotlb_dma_mmap and
 xen_swiotlb_dma_get_sgtable"
Date: Wed, 16 Jun 2021 14:42:04 +0300
Message-Id: <20210616114205.38902-1-roman_skakun@epam.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
References: <855a58e2-1e03-4763-cb56-81367b73762c@oracle.com>
MIME-Version: 1.0
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Roman Skakun <roman_skakun@epam.com>, Roman Skakun <rm.skakun@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
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

This reverts commit 922659ea771b3fd728149262c5ea15608fab9719.

Signed-off-by: Roman Skakun <roman_skakun@epam.com>
---
 drivers/xen/swiotlb-xen.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2b385c1b4a99..90bc5fc321bc 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -563,6 +563,31 @@ xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return xen_virt_to_bus(hwdev, xen_io_tlb_end - 1) <= mask;
 }
 
+/*
+ * Create userspace mapping for the DMA-coherent memory.
+ * This function should be called with the pages from the current domain only,
+ * passing pages mapped from other domains would lead to memory corruption.
+ */
+static int
+xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
+		     void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		     unsigned long attrs)
+{
+	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
+}
+
+/*
+ * This function should be called with the pages from the current domain only,
+ * passing pages mapped from other domains would lead to memory corruption.
+ */
+static int
+xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
+			void *cpu_addr, dma_addr_t handle, size_t size,
+			unsigned long attrs)
+{
+	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
+}
+
 const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.alloc = xen_swiotlb_alloc_coherent,
 	.free = xen_swiotlb_free_coherent,
@@ -575,8 +600,8 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.map_page = xen_swiotlb_map_page,
 	.unmap_page = xen_swiotlb_unmap_page,
 	.dma_supported = xen_swiotlb_dma_supported,
-	.mmap = dma_common_mmap,
-	.get_sgtable = dma_common_get_sgtable,
+	.mmap = xen_swiotlb_dma_mmap,
+	.get_sgtable = xen_swiotlb_get_sgtable,
 	.alloc_pages = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
 };
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
