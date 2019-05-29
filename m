Return-Path: <SRS0=Uk+I=T5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C62C28CC0
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 14:00:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CE32339F
	for <iommu@archiver.kernel.org>; Wed, 29 May 2019 14:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCUeomwu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CE32339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 453392679;
	Wed, 29 May 2019 14:00:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 677DB243F
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 08:16:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3FA1A89D
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 08:16:03 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id g13so2377754edu.5
	for <iommu@lists.linux-foundation.org>;
	Wed, 29 May 2019 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7YPMPnQHiZSTC9SMTzMeKs5svVKQA9+Mqdsa3E0VpUY=;
	b=FCUeomwuDfmxN1h0D6lV5jxZ/wMPiVvSLh+6vD04triShbrg3N711tx0v+ndzNVEut
	2qCPkBPgtAw9eb+yFx75vkwC6YOZW12ysDv0DmzpxYe3GlWLvMHwTwBbXbXcXXrCiOAg
	jmEA6ghVGNubW01UhbwRBlGDePYEPq3Sngg6MkkbWzwmwzyjk+oeg5KHQEmsSQ+ZDDNY
	wPehJjrTlpk+2DpeU0cq1Cthqz2lQIjBEF8L7C5av2+8fQx4JshBLGvtIDyM7otQGz9k
	r8VWyntEcUUna8khcjBtK1Dst2OuhpzG0hg6YoSouQ3CZfrn3jcG0ZNtJ9i6O+pip3vy
	G+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=7YPMPnQHiZSTC9SMTzMeKs5svVKQA9+Mqdsa3E0VpUY=;
	b=grr/ORwBxIX5YLEoVOvD3s7Bt+Xhr8TXPjDLkvC5Oi8S0LEcE/MttSZjqP4pfG0+FT
	joDrPKeaIFGUFFvo89SiYd6c5UG5WBJaYH7TbHE8nF+37k8LwVQ6wPqJIuCMp6HdXYXN
	iGxaiTLnB+rh9LsUxX23/2udXrv/cswCvzgIzLIuuOzifCSwD1mkR05yij1UckbdMnQc
	4uFK8yv2INv8TFdoixWB1zS/pCM2UJbvMBRaBozCqxv6VPKa6fnCLIrs0ZgYClV7aSE0
	MHZ4/kEiY+3qyXODGyJ8j7amaq9MIOY33rXGahPTStafHyTmTfD1RDts4JysR3SlO/Kj
	VkKQ==
X-Gm-Message-State: APjAAAXl46xBy9xvr0bOEYVbjHgEyJLjWYoYbdC/xC4c/xdE5GFSQRUO
	257jlY2aGgp/m8shwKhTTVc=
X-Google-Smtp-Source: APXvYqyKhTr9oxvChieY3z2xPala89CEJgfs4hhkYLjCMkL87W1gCcKCNRuP3pQL6cv2kPCr346y7A==
X-Received: by 2002:a50:8e81:: with SMTP id w1mr134921402edw.271.1559117761693;
	Wed, 29 May 2019 01:16:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
	by smtp.gmail.com with ESMTPSA id
	a17sm4835118edt.63.2019.05.29.01.16.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 01:16:00 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] iommu/dma: Fix condition check in iommu_dma_unmap_sg
Date: Wed, 29 May 2019 01:15:32 -0700
Message-Id: <20190529081532.73585-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-Mailman-Approved-At: Wed, 29 May 2019 13:57:30 +0000
Cc: Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
	clang-built-linux@googlegroups.com, iommu@lists.linux-foundation.org,
	Nathan Chancellor <natechancellor@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Clang warns:

drivers/iommu/dma-iommu.c:897:6: warning: logical not is only applied to
the left hand side of this comparison [-Wlogical-not-parentheses]
        if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
            ^                                 ~~
drivers/iommu/dma-iommu.c:897:6: note: add parentheses after the '!' to
evaluate the comparison first
        if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
            ^
             (                                    )
drivers/iommu/dma-iommu.c:897:6: note: add parentheses around left hand
side expression to silence this warning
        if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
            ^
            (                                )
1 warning generated.

Judging from the rest of the commit and the conditional in
iommu_dma_map_sg, either

    if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))

or
    if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)

was intended, not a combination of the two.

I personally think that the former is easier to understand so use that.

Fixes: 06d60728ff5c ("iommu/dma: move the arm64 wrappers to common code")
Link: https://github.com/ClangBuiltLinux/linux/issues/497
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0cd49c2d3770..0dee374fc64a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -894,7 +894,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
 
 	/*
-- 
2.22.0.rc1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
