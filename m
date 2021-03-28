Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635F2C433E5
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E08D6193D
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E08D6193D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FEAA40333;
	Mon, 29 Mar 2021 00:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eWHzMfHmgAY6; Mon, 29 Mar 2021 00:11:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93AEE40341;
	Mon, 29 Mar 2021 00:11:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BABF1C002D;
	Mon, 29 Mar 2021 00:10:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4EF5C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 83B90605BE
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:58:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Is6zJMwRH8D for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:58:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF165605A7
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:58:07 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id s2so8204932qtx.10
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NJwGboF3RRjxp++ZERmPQjReWWVKr/czZXPuA+ZJx80=;
 b=YL9DmbE2fe0BApSWAt2uHCdURo+Rz+Rr5GPOuD10WlMJxvjxgDIyyDM3ifIcvvFf0U
 gcHFBmE54d+3KH4GKg8iBAbwJWZlANd7lr6vJAYD4G9J3iSs9fFEc0DzrVMnX38/kG6P
 RJbrTE5VSk49lSyEs8UvPXBlWiDPiTcK4eOBOcIgR1St56TAKdCSryZn0q84c3m+KGM7
 s8XD83myVeBcsZjrO6SlOUShzdK8/g4TPaF96Oa/YASCcUSk06hFuZSxlBgiMcaJpQKm
 i06egdkTzyqoTyu9lUskiJSdlxdgPxtUPgPXwD0kgeJVE3IOcizvkW/yV7TLUyM+fCMH
 j1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NJwGboF3RRjxp++ZERmPQjReWWVKr/czZXPuA+ZJx80=;
 b=eCUM68jlzafS6o+9jKjTiq1wxfrztJs639Ved+eVA/oHrUci9oXk/oZ+X9Tmcd+l5q
 kB+jn5gFjBKjVqJ+FMpDCVUeeLBb1Z3519iy3wkE73qOPrfRdoJsGvWkxZ+S/U3v2pIv
 pbYpSPvcFKMsdg4EkHlGQOK1TRhgXIun8JYPJa5yXFyVoG0t6FlfiCNiutREM6FIrEGo
 ng/lc12RUFPhnraiinYLI+Nqb8hkC+PQq4TLgrmtIdukEr1X+gSQIC7BIn87Sv4QPkjz
 VTTsje0ZQfktzqShhjhXTccKOu7PmpPALunvIEQvLO6LJhsztaqTti+ufJGX9k50Vwmf
 +8yw==
X-Gm-Message-State: AOAM531tCdaHoMY6rjEUhwFRiRpC1bTA6MbKkpyGisyBEY+cERaCcvmU
 Op0wSkpdQRAI8vwhvxuAvUA=
X-Google-Smtp-Source: ABdhPJx9IaqtHu2JrNlJIS8s9C3nSt+b7/qaYIDs+xEjbuoo0gr+h5DM6WDJ9l2kCetRDAOn+2QZpA==
X-Received: by 2002:ac8:46cc:: with SMTP id h12mr21317176qto.105.1616975886810; 
 Sun, 28 Mar 2021 16:58:06 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:58:06 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 26/30] dw-axi-dmac-platform.c: Few typos fixed
Date: Mon, 29 Mar 2021 05:23:22 +0530
Message-Id: <01f2fed34eca736091a46dfee38381882e5dc5e9.1616971780.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1616971780.git.unixbhaskar@gmail.com>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Mar 2021 00:10:51 +0000
Cc: rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

s/configurarion/configuration/
s/inerrupts/interrupts/
s/chanels/channels/  ....two different places.
s/Synopsys/Synopsis/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index d9e4ac3edb4e..ef4da10361a7 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -35,7 +35,7 @@
 /*
  * The set of bus widths supported by the DMA controller. DW AXI DMAC supports
  * master data bus width up to 512 bits (for both AXI master interfaces), but
- * it depends on IP block configurarion.
+ * it depends on IP block configuration.
  */
 #define AXI_DMA_BUSWIDTHS		  \
 	(DMA_SLAVE_BUSWIDTH_1_BYTE	| \
@@ -1056,10 +1056,10 @@ static irqreturn_t dw_axi_dma_interrupt(int irq, void *dev_id)

 	u32 status, i;

-	/* Disable DMAC inerrupts. We'll enable them after processing chanels */
+	/* Disable DMAC interrupts. We'll enable them after processing channels */
 	axi_dma_irq_disable(chip);

-	/* Poll, clear and process every chanel interrupt status */
+	/* Poll, clear and process every channel interrupt status */
 	for (i = 0; i < dw->hdata->nr_channels; i++) {
 		chan = &dw->chan[i];
 		status = axi_chan_irq_read(chan);
@@ -1511,5 +1511,5 @@ static struct platform_driver dw_driver = {
 module_platform_driver(dw_driver);

 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Synopsys DesignWare AXI DMA Controller platform driver");
+MODULE_DESCRIPTION("Synopsis DesignWare AXI DMA Controller platform driver");
 MODULE_AUTHOR("Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>");
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
