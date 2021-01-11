Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B0BC433E6
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 18:39:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69680225AB
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 18:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69680225AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0764A86631;
	Mon, 11 Jan 2021 18:39:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gMZ+ofw4bpyk; Mon, 11 Jan 2021 18:39:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6C36F87096;
	Mon, 11 Jan 2021 18:39:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ABA8C1DA7;
	Mon, 11 Jan 2021 18:39:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 813DEC013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 18:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 64ADF870E9
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 18:34:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uis7gdzWcmYl for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 18:33:59 +0000 (UTC)
X-Greylist: delayed 02:49:51 by SQLgrey-1.7.6
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CA0B2870E8
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 18:33:59 +0000 (UTC)
Received: by mail-pf1-f201.google.com with SMTP id l17so439657pff.17
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 10:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=FfPhYcgmpWfwmSV36aZsn2I7a8UwoF5mD7MCCfCIqsM=;
 b=hzZWrMpCqJJDhEcCP2t/Pa1Lp/Mjs7S51gLMqdSGernAmS6D1MVKbdz8bc3aUH6JsV
 YwxEi0Wo5x6CpbhjAiZYIRCQx1IjF1ebjNsbiiq8KU5sfGnJHhSwfmwD2ceKh6aEAw30
 04G7l1e6RT+UWbUfrUr7ABpI/vAUo02eYnSCREkCVMiqxVhaZdkwCGZZCvoXWWI+23Kk
 FtcC60BODKq43VdlxVuUGYUMH+qPvAsJ17RFnX5oHSVmWhlVyaVbvBR8ltTQoI+yMBOM
 zjHP+j1uNC28b6zicrOmjH1B16kiJWLFecCe1oigeKVm7YZddi1L3UxN4OgoLaxzkaXC
 pplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=FfPhYcgmpWfwmSV36aZsn2I7a8UwoF5mD7MCCfCIqsM=;
 b=N5QB2LzHnF5PFWfEewwcu/sf8RJd+yAZhcFCwTx7MxuGtmz87jKZemD3CFU+ahW7Ge
 Grm5QZfy3gZ4zvRSn4P9uJWBaaqkrUV9IEz+F9O0uYFMACQPEODxfV2sUmNGa1nabYFJ
 tNuydtXYLWGV/fMaotErp+gl5YYa4X3HJ5OzFmlYEoQ2WQLNm/2ZZZhnenDhthHOHaYx
 3zoU7No/rzbEDAXKe7ARxM3KN5RQG5Kcyce/lweBEJLTwUDfsFiKumTCK+XwDVlxlWWg
 AlVmF15h5hE6EamFL6s8u/wxxtiyGyCAv/a/eqchaRKtm8F8ZmT+NWu2DYLpXtgkXnRr
 bjmw==
X-Gm-Message-State: AOAM531NVRN+i2/JtYYwqNXtkCIfoj+4XhWyNR8d6uzuj09Z3P6G1GZX
 c5Hh1TbPoA0ex+3MJ3YoXjkLxzIjEv5j
X-Google-Smtp-Source: ABdhPJyLqwzeL4t2eytHl1iY8HQ1baI3DclZDFWZdkBLNL7yQv+KBJSfikwzJGitgqEBvIQ9yMlu+w/nBd/j
X-Received: from marcorr.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1d18])
 (user=marcorr job=sendgmr) by 2002:a17:902:d90c:b029:da:9930:9da7
 with SMTP
 id c12-20020a170902d90cb02900da99309da7mr17350870plz.85.1610379848075; Mon,
 11 Jan 2021 07:44:08 -0800 (PST)
Date: Mon, 11 Jan 2021 07:43:35 -0800
Message-Id: <20210111154335.23388-1-marcorr@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] dma: mark unmapped DMA scatter/gather invalid
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
 jxgao@google.com, iommu@lists.linux-foundation.org, 
 linux-kernel@vger.kernel.org
X-Mailman-Approved-At: Mon, 11 Jan 2021 18:39:13 +0000
Cc: Marc Orr <marcorr@google.com>, stable@vger.kernel.org
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
From: Marc Orr via iommu <iommu@lists.linux-foundation.org>
Reply-To: Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This patch updates dma_direct_unmap_sg() to mark each scatter/gather
entry invalid, after it's unmapped. This fixes two issues:

1. It makes the unmapping code able to tolerate a double unmap.
2. It prevents the NVMe driver from erroneously treating an unmapped DMA
address as mapped.

The bug that motivated this patch was the following sequence, which
occurred within the NVMe driver, with the kernel flag `swiotlb=force`.

* NVMe driver calls dma_direct_map_sg()
* dma_direct_map_sg() fails part way through the scatter gather/list
* dma_direct_map_sg() calls dma_direct_unmap_sg() to unmap any entries
  succeeded.
* NVMe driver calls dma_direct_unmap_sg(), redundantly, leading to a
  double unmap, which is a bug.

With this patch, a hadoop workload running on a cluster of three AMD
SEV VMs, is able to succeed. Without the patch, the hadoop workload
suffers application-level and even VM-level failures.

Tested-by: Jianxiong Gao <jxgao@google.com>
Tested-by: Marc Orr <marcorr@google.com>
Reviewed-by: Jianxiong Gao <jxgao@google.com>
Signed-off-by: Marc Orr <marcorr@google.com>
---
 kernel/dma/direct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 0a4881e59aa7..3d9b17fe5771 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -374,9 +374,11 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 	struct scatterlist *sg;
 	int i;
 
-	for_each_sg(sgl, sg, nents, i)
+	for_each_sg(sgl, sg, nents, i) {
 		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
 			     attrs);
+		sg->dma_address = DMA_MAPPING_ERROR;
+	}
 }
 EXPORT_SYMBOL(dma_direct_unmap_sg);
 #endif
-- 
2.30.0.284.gd98b1dd5eaa7-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
