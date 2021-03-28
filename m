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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F1AC433E3
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3536194B
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3536194B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 99337400DC;
	Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8J7E7LjSuDHv; Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8CC8A400E5;
	Mon, 29 Mar 2021 00:10:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85B24C0022;
	Mon, 29 Mar 2021 00:10:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2DDFC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2649605BE
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wP45N4VPP5JN for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:56:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A9AF605A7
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:56:58 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id s2so8203797qtx.10
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V731M1ZjoMObeUPxmfQu760ZEmOVyQS5nvVKDsMpRYg=;
 b=lnZVGx88/Q4RgjL+3hIrxaeLUCknaQO529y1KHYklW+L+nkdj8gpcbnqm8dMc1/+l7
 f6zSHAW3lnPCPRE6I8Y7+qD6NhajFTxCnWDjvRqS+5YTVtxG9RfzFR2gppG6pd2KUONg
 x2Ypd6MdyYMDQxXuVr9h1defti29sytWbU8Ue/Li0RmO+WBaY8GzifXSi3Uzw8ctplXy
 6TXDeusuFr4d4znZtig85zoIyEx6i/oXnzfPQNVFdJWRikFvX9A33V/ZVXPGGkcr9CJy
 RJnXtSxeb6weKiUSJ+4jqKEIqqXxCR3aOs9fIwYirSfoCpnld2ZyldI5xWdSpa4LevUr
 PhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V731M1ZjoMObeUPxmfQu760ZEmOVyQS5nvVKDsMpRYg=;
 b=TVzGgCk+d++NTy4B7pkZsdPvKcWUg66+9LcSkj/PRYycDIvT7jAMDO+fiFz8zzgKZh
 ajPz5L7Ko2AuDelJ2e2QON8ZHvXddxYxDZmNATP1EUwraM7pDZNb/BGAU3q5whPGy1G8
 +okv7Cdj6Wf3lcItRrNfN4Sxv0LuOiksiMNjQW7Cqbof9J0r0MyWkMvJW9czUmbHnAKA
 R/QCI/C8rS16FuUwa950eobFo9hdXnz9EPKjAvQJykvN2LqIjsocp+YEiIBEdEm/bNBa
 K14IeGX/3pPqiK4AKAjbnIQ/J0INX42SzzJe+Wcxicitzk3K7JAunEWwQ1r8VCsJTaup
 Ncvg==
X-Gm-Message-State: AOAM531zQq/ClFsXstv8nba2G/3Q9KCcR4SxcHW5Gub4iLl9Ngcob5qQ
 +mLJQ2QBJMLZRfFVeTEi+Tw=
X-Google-Smtp-Source: ABdhPJwfkmcNQYJxn4S9wN8jOvwQsIXVBRg1ipQrCtKoJ4PNJU1NU5IafcNZI5PpJzjZHpA0d8+z4w==
X-Received: by 2002:ac8:1098:: with SMTP id a24mr20071293qtj.291.1616975817116; 
 Sun, 28 Mar 2021 16:56:57 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:56:56 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 12/30] of-dma.c: Fixed a typo
Date: Mon, 29 Mar 2021 05:23:08 +0530
Message-Id: <0c3e1bd83c63203a0aad27006fbd369090a69dce.1616971780.git.unixbhaskar@gmail.com>
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

s/propety/properly/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/of-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index ec00b20ae8e4..e028acff7fe8 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -337,7 +337,7 @@ EXPORT_SYMBOL_GPL(of_dma_simple_xlate);
  *
  * This function can be used as the of xlate callback for DMA driver which wants
  * to match the channel based on the channel id. When using this xlate function
- * the #dma-cells propety of the DMA controller dt node needs to be set to 1.
+ * the #dma-cells properly of the DMA controller dt node needs to be set to 1.
  * The data parameter of of_dma_controller_register must be a pointer to the
  * dma_device struct the function should match upon.
  *
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
