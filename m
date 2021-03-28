Return-Path: <SRS0=QSWf=I3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C340AC433ED
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83AD361954
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83AD361954
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 57AF1400CD;
	Mon, 29 Mar 2021 00:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qsGgpvcyAT5o; Mon, 29 Mar 2021 00:11:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49D0D402AB;
	Mon, 29 Mar 2021 00:11:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8758AC0017;
	Mon, 29 Mar 2021 00:10:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF2EDC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD5AA40314
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8lt29Bwn0X4u for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:58:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAC5D40312
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:58:02 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id f12so8253539qtq.4
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bpe0M5+HDAqDdeQIOejQbDfFbOvYGihGTywPqCQfPxk=;
 b=UBnTpPl9V62AUBrqC/YSqABPupQ76JLXTf9wdWJSwN8Y02M91Cv2rn4ZwjhokBjvOT
 caKPPonpNMbkYJsmubQ2Bumfsz0OvmkkTWS8FwgdpAJJ2UjLRJp7acfTyFudWVBAqVM4
 mAaT3aHaultxmZCgXXXV5OvJ6J1msraQIsZAdfJkw4uSiaZABZyAHr7r8flbrOwvpPZH
 zBFD5EMOq2xPgbxunhlKskRUqPhi8QLQoyZ1kqDj7sVSl05HXPEVHwZylycvJDJMix34
 BhEq84yLvrSkLfYTrEw/MPY6YGk4Ihk/VSSgfbjYkcNwFP0GEpF+EGDzHiMvb4HSukdQ
 PlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bpe0M5+HDAqDdeQIOejQbDfFbOvYGihGTywPqCQfPxk=;
 b=C+7mp3Qg+mvkYjDRIKa0imCupywwlPsrFgZ1wopzxGEFenAQXAWtKmNOX3+RKcdGzs
 Zn3lFxnkKwnmPoBSAdrjSAznkYyyBABh6pWxlNqigxikrtUQj9RMUqxjvmuCdqOfzdqB
 A2Z8F4uQCtWnWgSl38Dk8yV08EY7an0j7qCNY7SkAI5bWMgBSqBGPEmmy1JiM+IdlAqm
 4ZRL2LkcS5oVG/9tL1QCAXRQ/ITdxJHsERSqDuXkygmMcAPu82iTWMKkCagVvwXj9xex
 1mYZKbwyiJv2/nFLac8PbT9o106/sGpTmOKtY24DE4IzCzGjVgSBagtSBg24H4rBM7cS
 3+/w==
X-Gm-Message-State: AOAM533CbsiQCtEBsFnGjtwoXp3w/jV5vVk0VNRVBCdx9AZ57uwOclM8
 WqHItlnIixeAb6jfX/vozl8XfL4aXn8FxGjW
X-Google-Smtp-Source: ABdhPJz4aA7ldRQgsCMEBAdvXkEvBGcKpJz3Kr32GBN9DAQyr64A5Qqw5tpT7IRp1HeHqf9g6ttT3w==
X-Received: by 2002:ac8:698f:: with SMTP id o15mr21281625qtq.39.1616975881895; 
 Sun, 28 Mar 2021 16:58:01 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:58:01 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 25/30] ste_dma40.c: Few spello fixes
Date: Mon, 29 Mar 2021 05:23:21 +0530
Message-Id: <ef2c19d475895f8a627335e37560a18d28c062e9.1616971780.git.unixbhaskar@gmail.com>
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

s/ealier/earlier/
s/orignal/original/
s/manouver/maneuver/
s/transfer/transfer/
s/succees/success/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/ste_dma40.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 265d7c07b348..39fa2fb74057 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -155,7 +155,7 @@ static __maybe_unused u32 d40_backup_regs[] = {

 /*
  * since 9540 and 8540 has the same HW revision
- * use v4a for 9540 or ealier
+ * use v4a for 9540 or earlier
  * use v4b for 8540 or later
  * HW revision:
  * DB8500ed has revision 0
@@ -382,7 +382,7 @@ struct d40_desc {
  *
  * @base: The virtual address of LCLA. 18 bit aligned.
  * @dma_addr: DMA address, if mapped
- * @base_unaligned: The orignal kmalloc pointer, if kmalloc is used.
+ * @base_unaligned: The original kmalloc pointer, if kmalloc is used.
  * This pointer is only there for clean-up on error.
  * @pages: The number of pages needed for all physical channels.
  * Only used later for clean-up on error
@@ -1630,7 +1630,7 @@ static void dma_tasklet(struct tasklet_struct *t)

 	return;
  check_pending_tx:
-	/* Rescue manouver if receiving double interrupts */
+	/* Rescue maneuver if receiving double interrupts */
 	if (d40c->pending_tx > 0)
 		d40c->pending_tx--;
 	spin_unlock_irqrestore(&d40c->lock, flags);
@@ -1970,7 +1970,7 @@ static int d40_config_memcpy(struct d40_chan *d40c)
 		   dma_has_cap(DMA_SLAVE, cap)) {
 		d40c->dma_cfg = dma40_memcpy_conf_phy;

-		/* Generate interrrupt at end of transfer or relink. */
+		/* Generate interrupt at end of transfer or relink. */
 		d40c->dst_def_cfg |= BIT(D40_SREG_CFG_TIM_POS);

 		/* Generate interrupt on error. */
@@ -3415,7 +3415,7 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 		base->lcla_pool.base = (void *)page_list[i];
 	} else {
 		/*
-		 * After many attempts and no succees with finding the correct
+		 * After many attempts and no success with finding the correct
 		 * alignment, try with allocating a big buffer.
 		 */
 		dev_warn(base->dev,
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
