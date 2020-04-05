Return-Path: <SRS0=HSJZ=5V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A241DC2BA18
	for <iommu@archiver.kernel.org>; Sun,  5 Apr 2020 00:52:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694162071C
	for <iommu@archiver.kernel.org>; Sun,  5 Apr 2020 00:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ1kps7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694162071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 32A8187886;
	Sun,  5 Apr 2020 00:52:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h-ubHk6uqnG5; Sun,  5 Apr 2020 00:52:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8E17F87852;
	Sun,  5 Apr 2020 00:52:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 752F0C1D7C;
	Sun,  5 Apr 2020 00:52:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 357A4C07FF
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 00:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1F35E880E0
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 00:52:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NU3Faj0T8jvR for <iommu@lists.linux-foundation.org>;
 Sun,  5 Apr 2020 00:51:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1D23D880B3
 for <iommu@lists.linux-foundation.org>; Sun,  5 Apr 2020 00:51:57 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id l36so4859158pjb.3
 for <iommu@lists.linux-foundation.org>; Sat, 04 Apr 2020 17:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=jxbeYfDO2Dzs1Qxjg6uhV0oWTScSLyrhcb9XrgOOWV0=;
 b=QJ1kps7fuwQPwxDWTmKliqra/mE4ScvXBKpwN0B00JcwQE4WKtOALnCSWssnLfBdpd
 +qHHtZK8qXOutKY5g/q+Lg/QZjPbBy9UsYU5qWJBEdOR64yGsAfN21GFCRdp0hGvjPQQ
 hEcK7tpV7+0J9RRQLFE2mOd/FgfQO/NEEj7hPwbvsj4yqwrnserPnfJFPOSl3+7sCvmz
 1QzauZt5cbSRh37miX9DxVj/kvGnQS3qa0oB5wa+CU0MEQYtiMULiZWYRliY529/pigJ
 pJnFd9MxeZlRYP6rrAcz4/S7MXwCmJDy9psyyZHFJebktIrAbzaGf892hssXjw0B5XwL
 ExIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=jxbeYfDO2Dzs1Qxjg6uhV0oWTScSLyrhcb9XrgOOWV0=;
 b=EjKikht9vlQUOLRXhyE8ccnxOrVHGYpwN9VKFsjpjRGpe8GN062k91O5xVyoZ3GzKe
 xNSAVU09iaZ8Vmxx9iAilMog1o+BLH7ulzBgAw2vIaUtQ+TNELU8TnG5Xmx6XhLBU3d1
 vCHMCbHQby+YkuKbCvtk4jLaV3CJ4KFvEWInkqDELnXh0hncs63d31Rcnv6pIL59GHmX
 CuaUJw6Ly/y+VD4iwXkoPKxuw558YGqSKKeGZvGY78FxHNCLYI2+8pc2CgJ3uk6rmeRG
 sDW1wIin+N+1Au6dC9YrlzPnVJtByVwZAVuC/llk4EY/hP8I7q4QaNvsW6BBqiUjqvh+
 8mCg==
X-Gm-Message-State: AGi0PuYdgiYcAP+FJguLm3yRvvm7K4fjzM12HzbJ8yRYF22k72DTKXnN
 oWNN68M9mKIqd9z+qXd7sgA=
X-Google-Smtp-Source: APiQypLB+X3qujTRRAtf81QwHvLmDeFWiaoG2f+FG4jSKLujTRniCz57ihn3csNG3jtUKJ0+DbLTGA==
X-Received: by 2002:a17:902:aa08:: with SMTP id
 be8mr13360515plb.299.1586047916448; 
 Sat, 04 Apr 2020 17:51:56 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id j17sm8528122pfd.175.2020.04.04.17.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2020 17:51:55 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com,
	hch@lst.de
Subject: [RFC/RFT][PATCH] dma-mapping: set default segment_boundary_mask to
 ULONG_MAX
Date: Sat,  4 Apr 2020 17:51:57 -0700
Message-Id: <20200405005157.1318-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The default segment_boundary_mask was set to DMA_BIT_MAKS(32)
a decade ago by referencing SCSI/block subsystem, as a 32-bit
mask was good enough for most of the devices.

Now more and more drivers set dma_masks above DMA_BIT_MAKS(32)
while only a handful of them call dma_set_seg_boundary(). This
means that most drivers have a 4GB segmention boundary because
DMA API returns a 32-bit default value, though they might not
really have such a limit.

The default segment_boundary_mask should mean "no limit" since
the device doesn't explicitly set the mask. But a 32-bit mask
certainly limits those devices capable of 32+ bits addressing.

And this 32-bit boundary mask might result in a situation that
when dma-iommu maps a DMA buffer (size > 4GB), iommu_map_sg()
cuts the IOVA region into discontiguous pieces, and creates a
faulty IOVA mapping that overlaps some physical memory outside
the scatter list, which might lead to some random kernel panic
after DMA overwrites that faulty IOVA space.

So this patch sets default segment_boundary_mask to ULONG_MAX.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 330ad58fbf4d..ff8cefe85f30 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
 {
 	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
 		return dev->dma_parms->segment_boundary_mask;
-	return DMA_BIT_MASK(32);
+	return ULONG_MAX;
 }
 
 static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
