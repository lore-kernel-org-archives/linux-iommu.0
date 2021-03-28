Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935F3C433E5
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B14D6193E
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B14D6193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A09C40336;
	Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id In3-zcewYwJX; Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B717F40339;
	Mon, 29 Mar 2021 00:10:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0862C0022;
	Mon, 29 Mar 2021 00:10:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 306C6C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11CBC605BE
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AbQ94sE75af7 for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:56:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73BFC605A7
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:23 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id y18so10893827qky.11
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z1jriUq1sL9lb0mtxN9KbapTjAFOd4HdFdy/Egjy5og=;
 b=rGFcWETJr6kx1FhK2VwuyFhj5mEQ2a9w1BMQGwfNSg69VWO2NHz6DRFrgg4SGJ3Z+8
 +nckc0b33f7uTjbCD27I2Gl2Jdn2HT3qvcYJdS4WPW1YXJNFE46lhkK9BighwwVM7M6Z
 sbmrrRJH2t3VrRNWQZyiWfEew9FMNFhk6Zl5kKcli7J7b4abKENXJWSILGRJkqUTX2+t
 WHSb9X1FAt5JDH4q/BeU5ocKsg/w33VbP7p3+NQRcRhAMcotq7sULiWyjAlOYf/mHOqB
 H9GvMPiPug0qb8cAXChS8dbpZy4uTWPDejj82uflrDF2gz/fTxAhbelewAFroVWE3qew
 2RaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z1jriUq1sL9lb0mtxN9KbapTjAFOd4HdFdy/Egjy5og=;
 b=W7xWlchFk9RSX5dauwL7qAKgsEbxb6jrhtPPc/Mm2tXrY8h+C+flcl3LBm8y2JQRf9
 usEwB3Git+MuPLEbjw0us/WXMifaC+yhRw4e94veHyPfYXWEX+yFszlZqZNyZ8QiqE94
 OoGXR73RADgCzu77te3kd+beL9xsXf2GVqRAMTeBYGplT8gNpxcviypcDnjnGyTuVRFP
 7UklNNDnBS+wu62R4LlpPCTWdvzaw6pIOV6ZZTZI1aIpeV2gMRNbg8QkC+r1W4EbnGN8
 Cz2rXeuksFSDj5mPs5D5UoGKA3JnduJXtmUctUKHkrAxZaCFOPRWiGJXKUFFRiiuTYgF
 vZvA==
X-Gm-Message-State: AOAM531Egy7DQN9wCJfGdqkaFXzvLVRVq3DQzd6L1cuUAdDiRN1zbQ/D
 b51bGbyLoPADq0oKRTLTOKk=
X-Google-Smtp-Source: ABdhPJyKy/81JUq/KZUC1NO8pklpNrg2DlDqj4i3GsKGyS2IOzo8E/4XiQGvp7DS8QS7skiReIXQZA==
X-Received: by 2002:a37:584:: with SMTP id 126mr22223976qkf.274.1616975782447; 
 Sun, 28 Mar 2021 16:56:22 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:21 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 05/30] bcm2835-dma.c: Fix a typo
Date: Mon, 29 Mar 2021 05:23:01 +0530
Message-Id: <77d89989f1cb7362f0a3a5a279d7846a93ae3968.1616971780.git.unixbhaskar@gmail.com>
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

s/missmatch/mismatch/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/bcm2835-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 630dfbb01a40..e6baf17b0434 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -369,7 +369,7 @@ static struct bcm2835_desc *bcm2835_dma_create_cb_chain(
 	/* the last frame requires extra flags */
 	d->cb_list[d->frames - 1].cb->info |= finalextrainfo;

-	/* detect a size missmatch */
+	/* detect a size mismatch */
 	if (buf_len && (d->size != buf_len))
 		goto error_cb;

--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
