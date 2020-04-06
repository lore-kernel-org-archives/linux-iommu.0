Return-Path: <SRS0=BbwH=5W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC9AC2BA80
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 21:06:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF00206B8
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 21:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNG6cwoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF00206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3A75985E47;
	Mon,  6 Apr 2020 21:06:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SkdYUId-17aG; Mon,  6 Apr 2020 21:06:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CC38385F3D;
	Mon,  6 Apr 2020 21:06:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC122C089E;
	Mon,  6 Apr 2020 21:06:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A851DC0177
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 21:06:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9793885F3D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 21:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3xnkUo5mrwkK for <iommu@lists.linux-foundation.org>;
 Mon,  6 Apr 2020 21:06:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 868CF85E47
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 21:06:41 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id k18so345436pll.6
 for <iommu@lists.linux-foundation.org>; Mon, 06 Apr 2020 14:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=F7oyQrycdBGvwHlAg5l8DJr2cSrN+vxfu/5R7n9PHnM=;
 b=VNG6cwohDXNRbJGMuO22h1hA4687il974YFacYVjjW0YaZFR++a3HGfBJJ7qYyat6E
 Pqlj+VbHwHV5dgg4V3abZvK3Jx7HPojHNnppBCGjRmy5zttmIJEFyNmrgYnSlX32hMra
 3yXr+RSEkAemaAarNl/R7E2W+XqlWrwkrZ/jic14gRTFGVhiuH5wte6NfiUD7YqHiRRz
 nMsqJ/TPb0p0LRYuqFU6gnBkw7sHpqIXM6WIR13FaknYRtX1Vkxc7xonlfLQ2D/jHtDh
 Zks1+3n/eKOHAbsFpvOjiIML7IcRhrRuBzyGI2up5/9vtpyFnNp5mxH2BQ4a4JGo7Qt/
 Rtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=F7oyQrycdBGvwHlAg5l8DJr2cSrN+vxfu/5R7n9PHnM=;
 b=UTxjEJ5JrVUGFXTR/yV1rhG67PYBxlwwxhlI2IWYVLUkUFV8B3rSoWYrt0kMCybWYt
 kWDSI9dEXKHOW/teeeD6cmpnLsH+LYP2zbpKz1YRmtSCiOEbwWJPqeKoA+NPLEV4EO5K
 9XUMjZvfdT2J6Y5ck3CU6uZ3UKpK3hOR+2GRfjgmBYwQK8ejTZJaBYJDhGVctwQd2rzE
 ZlpM5dHznC0YbVlrN81cGgaOwlbA+rjebaGDnS44yKJw6AydzZVWrakwpmgCxEAMekle
 my75pvWDdRl3Des4ichn3pqqGYRkHcJeLBNDDkSex2j0kTUJbmtJBSzTq6xuIVBu52BX
 XN6g==
X-Gm-Message-State: AGi0PuaV2/vcbktVj8Z+oJ2wU7mWpXrOf+22pQ1nG1Cls+sUIGKMUwHu
 O+i0GWxL/bXOUMh3hOCjYE0=
X-Google-Smtp-Source: APiQypKJbIkLMaBwh90y6jKxYqWc9V67C01F47EfkGfkWEkFa7Vx6ItiZnoObiuN7fiA/whRFXG+Dg==
X-Received: by 2002:a17:902:bd02:: with SMTP id
 p2mr22035795pls.67.1586207201046; 
 Mon, 06 Apr 2020 14:06:41 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d71sm12427134pfd.46.2020.04.06.14.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 14:06:40 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: robin.murphy@arm.com,
	m.szyprowski@samsung.com,
	hch@lst.de
Subject: [RFC/RFT][PATCH v2] dma-mapping: set default segment_boundary_mask to
 ULONG_MAX
Date: Mon,  6 Apr 2020 14:06:43 -0700
Message-Id: <20200406210643.20665-1-nicoleotsuka@gmail.com>
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

So this patch sets default segment_boundary_mask to ULONG_MAX.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog:
v1->v2
 * Followed Robin's comments to revise the commit message by
   dropping one paragraph of not-entirely-true justification
   (no git-diff level change, so please ack if you tested v1)

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
