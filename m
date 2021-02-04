Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA477C433DB
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:31:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F1664F6B
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 19:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F1664F6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4BB9D868DE;
	Thu,  4 Feb 2021 19:31:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D9Bpf4dcn62L; Thu,  4 Feb 2021 19:31:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 57ABE868BC;
	Thu,  4 Feb 2021 19:31:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 532F1C07FD;
	Thu,  4 Feb 2021 19:31:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6495EC07FD
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5CFC686903
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:31:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XPdZR5AvrEzt for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 19:31:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BE617868CE
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 19:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=x8//hYqo7QA5J7KlPRIBWxIN1r3dqOW8pvcBjP4fgD4=; b=r+U9drErryzVNsxBhwiFC41lgS
 bFPlFHhFQgdb4jr/6PDIirPBkDjDUOMM9gFGsTolsd6iRt08CPyO2QWcXYlAZq/UwcbKoEfIsCQRS
 0OLDGd8cHz/VSGHSw6CMhi8/jDazIBFGnUczpv/XSuHrHxhbulyE51bja5unjR1Hnpu6m6KLtOjfI
 hOlJPKMAXqvA/5H43JF1glAY0iDhL79dKokYdu2FP0skudyOZ05fwC3EaKSr9YM90BDVrjT5zaPc+
 4R5yYyk0j0fkvNXwreM1IdeqR5qakaw4/OnNZ1nuP7iOy/pbp1uCCTjS2+xBP5tP8Xh5ocSPFLBZE
 bUOI2cVw==;
Received: from [2001:4bb8:184:7d04:e998:f47:b9fb:7611] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l7kLA-001Jjb-KK; Thu, 04 Feb 2021 19:30:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com,
	gregkh@linuxfoundation.org
Subject: [PATCH 8/8] nvme-pci: set min_align_mask
Date: Thu,  4 Feb 2021 20:30:35 +0100
Message-Id: <20210204193035.2606838-9-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204193035.2606838-1-hch@lst.de>
References: <20210204193035.2606838-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com
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

From: Jianxiong Gao <jxgao@google.com>

The PRP addressing scheme requires all PRP entries except for the
first one to have a zero offset into the NVMe controller pages (which
can be different from the Linux PAGE_SIZE).  Use the min_align_mask
device parameter to ensure that swiotlb does not change the address
of the buffer modulo the device page size to ensure that the PRPs
won't be malformed.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 81e6389b204205..5d194b4e814719 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2629,6 +2629,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * Don't limit the IOMMU merged segment size.
 	 */
 	dma_set_max_seg_size(dev->dev, 0xffffffff);
+	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
 
 	mutex_unlock(&dev->shutdown_lock);
 
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
