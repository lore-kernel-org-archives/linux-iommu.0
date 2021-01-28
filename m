Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91BDC433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 00:46:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2545F64DD1
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 00:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2545F64DD1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C279286DCC;
	Thu, 28 Jan 2021 00:46:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2sWqLZSeDzB5; Thu, 28 Jan 2021 00:46:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 51B7686DB3;
	Thu, 28 Jan 2021 00:46:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 307CCC08A1;
	Thu, 28 Jan 2021 00:46:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E1E3C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 00:46:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 70883862C9
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 00:46:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rq25e_gcuq-R for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 00:46:47 +0000 (UTC)
X-Greylist: delayed 00:07:59 by SQLgrey-1.7.6
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 814A786239
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 00:46:47 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id k7so4090607ybm.13
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 16:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to; bh=S76UV5kxidYXbgCR1VuCa1vuB9V23gC9gqu6RBvYKNI=;
 b=fz1zYJOGH62ztoJUartn4VEw2vyYszv5Q1bITcQeeg34HhxJNH56QOsyD61zYCGfxd
 O7A+iQPhET5O5Iva7LqnCizGtkPKW4pfNGMbubFOMH1RBYzMSGU6xD3q6/QrXA18Ff8/
 5G8BPmR7JcKzxA4ITYT/eKsnQTpPWpXcI/M9cTyZChpy28GxXqVXqWhRuu2H7is+0Nz1
 iIQrn6/kJilKpc9BmD7xkjcwDbgncjcB4rjOZKh56EcTNP8lVA/tlr0fWqnoMSCAJSqF
 yoceWAFFLD9BpXjDiLmsgFwfEl0Gu/npahweWe2ZfSjj7rurxZpp86jkHhmxZ3VXcOXU
 PX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to;
 bh=S76UV5kxidYXbgCR1VuCa1vuB9V23gC9gqu6RBvYKNI=;
 b=ajaYzjxvJu5ndCO5FcSR+K74ikO+xysj9g5umaAfZB++IeEgWhRSYApGcHdDTF8bSa
 sOa3UEhiwZxaF7yKfRkhCKkNyK9uwdMT23UWfIsGIIMQOP1e0FnY8pGNPjB5hvn5WlJe
 DuCaMuNHxdkpg7ctuACKwhUDddCpYfhuL7AdSH5v4rlV/tuNvPsTM1gX3QbCgVgAoijs
 J4Zgvd/WkL+DJQQc8AA0YC+KzBJ7CPSnMihmpW0qW2FDXFWYMOjJRWU3PrSvFYWpx8k7
 eCdIL3kmNaMT/4GwMeo4BCsup4Ugs8Czl/56qqYC8NVLoFzMKpEUTGyJ84nnFvUnldEN
 xhWw==
X-Gm-Message-State: AOAM5306YFx4qGgyzI4T3cUCIXN2KmkbDeet2afx/Bz9wc+r8dGc8/fW
 of6SrD7og9NkI43muFAC8n0fhCGshQ==
X-Google-Smtp-Source: ABdhPJxhW9bnAu6awThXrNNK9h8pR96zH9JI9NukbN8uc2eD0HCU4F2glSXLYN/SAof/oTTUS9ZxUoM4Wg==
X-Received: from jxgao.kir.corp.google.com
 ([2620:0:1008:11:4d90:620d:7a68:ffc5])
 (user=jxgao job=sendgmr) by 2002:a5b:30f:: with SMTP id
 j15mr19901700ybp.431.1611794326856; 
 Wed, 27 Jan 2021 16:38:46 -0800 (PST)
Date: Wed, 27 Jan 2021 16:38:29 -0800
In-Reply-To: <20210128003829.1892018-1-jxgao@google.com>
Message-Id: <20210128003829.1892018-4-jxgao@google.com>
Mime-Version: 1.0
References: <20210128003829.1892018-1-jxgao@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 3/3] Adding device_dma_parameters->offset_preserve_mask to
 NVMe driver.
To: jxgao@google.com, erdemaktas@google.com, marcorr@google.com, hch@lst.de, 
 m.szyprowski@samsung.com, robin.murphy@arm.com, gregkh@linuxfoundation.org,
 saravanak@google.com, heikki.krogerus@linux.intel.com, 
 rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
 dan.j.williams@intel.com, bgolaszewski@baylibre.com, jroedel@suse.de, 
 iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, kbusch@kernel.org, 
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
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
From: Jianxiong Gao via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jianxiong Gao <jxgao@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

NVMe driver relies on the address offset to function properly.
This patch adds the offset preserve mask to NVMe driver when mapping
via dma_map_sg_attrs and unmapping via nvme_unmap_sg. The mask
depends on the page size defined by CC.MPS register of NVMe
controller.

Signed-off-by: Jianxiong Gao <jxgao@google.com>
---
 drivers/nvme/host/pci.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 856aa31931c1..0b23f04068be 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -580,12 +580,15 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
 static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-
+	if (dma_set_page_offset_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
+		dev_warn(dev->dev, "dma_set_page_offset_mask failed to set offset\n");
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
 		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
 				    rq_dma_dir(req));
 	else
 		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
+	if (dma_set_page_offset_mask(dev->dev, 0))
+		dev_warn(dev->dev, "dma_set_page_offset_mask failed to reset offset\n");
 }
 
 static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
@@ -842,7 +845,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret = BLK_STS_RESOURCE;
-	int nr_mapped;
+	int nr_mapped, offset_ret;
 
 	if (blk_rq_nr_phys_segments(req) == 1) {
 		struct bio_vec bv = req_bvec(req);
@@ -868,12 +871,24 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	if (!iod->nents)
 		goto out_free_sg;
 
+	offset_ret = dma_set_page_offset_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
+	if (offset_ret) {
+		dev_warn(dev->dev, "dma_set_page_offset_mask failed to set offset\n");
+		goto out_free_sg;
+	}
+
 	if (is_pci_p2pdma_page(sg_page(iod->sg)))
 		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
 				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
 	else
 		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
 					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
+
+	offset_ret = dma_set_page_offset_mask(dev->dev, 0);
+	if (offset_ret) {
+		dev_warn(dev->dev, "dma_set_page_offset_mask failed to reset offset\n");
+		goto out_free_sg;
+	}
 	if (!nr_mapped)
 		goto out_free_sg;
 
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
