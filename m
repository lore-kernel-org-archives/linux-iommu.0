Return-Path: <SRS0=+HXC=BZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913A4C433DF
	for <iommu@archiver.kernel.org>; Sat, 15 Aug 2020 06:48:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E95821744
	for <iommu@archiver.kernel.org>; Sat, 15 Aug 2020 06:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+20G6uG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E95821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 04529885CF;
	Sat, 15 Aug 2020 06:48:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R6rwfFD0PvIE; Sat, 15 Aug 2020 06:48:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 65C84885BB;
	Sat, 15 Aug 2020 06:48:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 590BBC07FF;
	Sat, 15 Aug 2020 06:48:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F1B0C004D
 for <iommu@lists.linux-foundation.org>; Sat, 15 Aug 2020 06:48:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 95082886B0
 for <iommu@lists.linux-foundation.org>; Sat, 15 Aug 2020 06:48:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zQnkM8PYeLLJ for <iommu@lists.linux-foundation.org>;
 Sat, 15 Aug 2020 06:48:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1B02F886A9
 for <iommu@lists.linux-foundation.org>; Sat, 15 Aug 2020 06:48:18 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id 128so5571220pgd.5
 for <iommu@lists.linux-foundation.org>; Fri, 14 Aug 2020 23:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=1UEjNo8FBjY3zOHNcMSpQLZ9ulspEjH4BS4O+4ISF0c=;
 b=l+20G6uGynVVHrnnRdzNF3Fh3VpleLP+EkvjlzL6Ihoj8BrtDflhsxuQap/puPx9vx
 Y5DS9R5phbsGF046MkBSx2YiepDjw9cXOF41ylVI1jUOP9Gg6wtjkxmap+dGxLtSTXoW
 bmEG6PPHN43EPUmbdBQpw5+Ohgy0M2mJW1cuVjfS3MXYBWgczFmUGHkSiB9txA2jSAzB
 jfA8oIuwNkIvDNCKP8Etl56gvVk3ERPw4fNbiKCLdnwYGJ/x6Iq00/oKsT7H3LXD9ZHi
 xiHU5Dl3yqFQS6B+FTPHDWbGVcW8sNv6mt12xCXJzgC/oqKVvF1ImcBV5jj22cgf39hg
 7+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1UEjNo8FBjY3zOHNcMSpQLZ9ulspEjH4BS4O+4ISF0c=;
 b=PTmXoezzA1gjCzfoPamp+fw5Wi9tfY2ykPioLCWR4GLRoWp5C0CEVNEYGS/byMHWAx
 CExXd5IKsPp1Vl1O1q1167/PsJ7KKYLS+J6CVaHNwy4d2PilYzwbODkT2S5od/ZQXnGt
 kMfSbMbjfQstTFtnWj62Ej/Pl/UPvcZketDxn/7kiAd6pd2ekQaHvjfv2K24dEbdzUAN
 OClYx/E1nU30HoapLyN6m3GqE9cMtCT3EklTaYR8fznNGNiDH2Ju1O5zfI4i5nS/uOI/
 tnDF6srnRJ413nEyt7KfGH/Yy7qzdXO2/FpLsWkzvwrNmJZ3puBZkSf+1ltgACS617bJ
 aJMA==
X-Gm-Message-State: AOAM530l3qG5sA8ayGw6IgzX24m8PGPm/5psb54Jl3XGApbqT+tNF1Pv
 msrCmf3OVMNmvS/P4VJSJao=
X-Google-Smtp-Source: ABdhPJyDokbcNBNU6ZlOnvAx0b5d1g3l+PGfHIBTohbm9Oy6CbFfNDh9Ubt5zFfMlMd6VZd9Nc8BVw==
X-Received: by 2002:a63:5515:: with SMTP id j21mr3870740pgb.31.1597474097506; 
 Fri, 14 Aug 2020 23:48:17 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (searspoint.nvidia.com.
 [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id f63sm10162940pjk.53.2020.08.14.23.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 23:48:17 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: hch@lst.de,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com
Subject: [PATCH v3] dma-mapping: set default segment_boundary_mask to ULONG_MAX
Date: Fri, 14 Aug 2020 23:47:26 -0700
Message-Id: <20200815064726.20459-1-nicoleotsuka@gmail.com>
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
v2->v3
 * Resent -- no change
   v2 was sent 4 months ago https://lkml.org/lkml/2020/4/6/881
   but it has not got replied yet
v1->v2
 * Followed Robin's comments to revise the commit message by
   dropping one paragraph of not-entirely-true justification
   (no git-diff level change, so please ack if you tested v1)

 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 016b96b384bd..27df499aa041 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -628,7 +628,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
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
