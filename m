Return-Path: <SRS0=kdGy=CM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92458C2D0A5
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 20:20:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C641206C0
	for <iommu@archiver.kernel.org>; Thu,  3 Sep 2020 20:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="f5+yqTBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C641206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 468EF86DB2;
	Thu,  3 Sep 2020 20:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aHRW2DPyxltz; Thu,  3 Sep 2020 20:20:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 401C886D38;
	Thu,  3 Sep 2020 20:20:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2391BC07FF;
	Thu,  3 Sep 2020 20:20:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFB7EC0051
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 20:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AE5E286566
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 20:19:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N3+gFAZD4zr6 for <iommu@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 20:19:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 717FA86BF8
 for <iommu@lists.linux-foundation.org>; Thu,  3 Sep 2020 20:19:57 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id d20so4357775qka.5
 for <iommu@lists.linux-foundation.org>; Thu, 03 Sep 2020 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I6sqmpjYQS1i8I2u5OlgYcgH9H7Q/fBtF5RLdQCIbUY=;
 b=f5+yqTBUf+Zh3CRFoO7j+ETaR7BoPwPjFFldKKUkS1MaF6C6Fhwpo/kFj9rjCy1WKz
 UvVrCewv98Q0u5xdiLRiQc2o21P1MUhEJpVVKYv4Oib5ziK5CvQHARu0Q+x5d183b+a6
 pF1Y9Ta/u7jrWC4e/BOGveysxuPjYG6SL8clEy2/9NFsjB7pcUzK5w/ajmD0QUJEmEJ7
 grlTnuwzZj90QQPTQfrRqu+3zrbInu79cugqbqdNdno5i9bSMHWFc6OH7UE+QbWnabjI
 j4ujlx1OtFcGDtL7MGk8lvaMK9Ru9VrxxbhDJZygAX8HxPJDXZGH/dbbp+8T2c57rjnq
 uR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I6sqmpjYQS1i8I2u5OlgYcgH9H7Q/fBtF5RLdQCIbUY=;
 b=NADR3HEYwLUZ5Ck1+36OtfCoDnF3XUR2wKdxmHU4tND7/rMwE63BcErz3QhYasANlH
 yU2Draop13HejDlRvrlt4qIsq5kYgAl0+xxBqei0g5LIhU9StWfEFFTcu0GhTwTrG6FL
 5dHkM0xSUr+gmy4yPuWxG6UCCDh7XQXGetljN7oWbX0YutLd7WcHMYUYNyPaAwqP5zk+
 M8YElKFtUEsSQ3m5NZkHI5Ee8RYVxRaXoA0aydqO56t3BGUjwPmOFZnwePxqfePBwEEh
 OC+fF15Vs7UyNPGNNd3NDvAx8tmxvTih0/T1ryhIaaPOzkhtEwifjwmFRdRLEGD/RQan
 6nxA==
X-Gm-Message-State: AOAM532C6uH0WE5AmT+kA5LSA8n0a1JvW1vBoNL/pxveqBSBR3QAT8eW
 t1NJ+fcdCX39DED20uAZXgOAgWGmSa3RTw==
X-Google-Smtp-Source: ABdhPJy41UyVnEf4Yul9EU5IS6jK0ALJvv/N9qDQ6Ke4Op2ACBvgPzzrHN3lrSAG5StjeziwV2NjPg==
X-Received: by 2002:a37:a00d:: with SMTP id j13mr4956214qke.349.1599164396368; 
 Thu, 03 Sep 2020 13:19:56 -0700 (PDT)
Received: from tom-ThinkPad-X1-Carbon-5th.hitronhub.home
 (CPEa84e3fce9b83-CMa84e3fce9b80.cpe.net.cable.rogers.com. [99.230.61.29])
 by smtp.googlemail.com with ESMTPSA id g37sm2863257qtk.76.2020.09.03.13.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 13:19:56 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in
 dma-iommu
Date: Thu,  3 Sep 2020 21:18:37 +0100
Message-Id: <20200903201839.7327-6-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903201839.7327-1-murphyt7@tcd.ie>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 Tom Murphy <murphyt7@tcd.ie>
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

Disable combining sg segments in the dma-iommu api.
Combining the sg segments exposes a bug in the intel i915 driver which
causes visual artifacts and the screen to freeze. This is most likely
because of how the i915 handles the returned list. It probably doesn't
respect the returned value specifying the number of elements in the list
and instead depends on the previous behaviour of the intel iommu driver
which would return the same number of elements in the output list as in
the input list.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 185cd504ca5a..6697b4ad0df6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -843,49 +843,23 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		dma_addr_t dma_addr)
 {
 	struct scatterlist *s, *cur = sg;
-	unsigned long seg_mask = dma_get_seg_boundary(dev);
-	unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
-	int i, count = 0;
+	int i;
 
 	for_each_sg(sg, s, nents, i) {
 		/* Restore this segment's original unaligned fields first */
 		unsigned int s_iova_off = sg_dma_address(s);
 		unsigned int s_length = sg_dma_len(s);
 		unsigned int s_iova_len = s->length;
+		if (i > 0)
+			cur = sg_next(cur);
 
 		s->offset += s_iova_off;
 		s->length = s_length;
-		sg_dma_address(s) = DMA_MAPPING_ERROR;
-		sg_dma_len(s) = 0;
-
-		/*
-		 * Now fill in the real DMA data. If...
-		 * - there is a valid output segment to append to
-		 * - and this segment starts on an IOVA page boundary
-		 * - but doesn't fall at a segment boundary
-		 * - and wouldn't make the resulting output segment too long
-		 */
-		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
-		    (max_len - cur_len >= s_length)) {
-			/* ...then concatenate it with the previous one */
-			cur_len += s_length;
-		} else {
-			/* Otherwise start the next output segment */
-			if (i > 0)
-				cur = sg_next(cur);
-			cur_len = s_length;
-			count++;
-
-			sg_dma_address(cur) = dma_addr + s_iova_off;
-		}
-
-		sg_dma_len(cur) = cur_len;
+		sg_dma_address(cur) = dma_addr + s_iova_off;
+		sg_dma_len(cur) = s_length;
 		dma_addr += s_iova_len;
-
-		if (s_length + s_iova_off < s_iova_len)
-			cur_len = 0;
 	}
-	return count;
+	return nents;
 }
 
 /*
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
