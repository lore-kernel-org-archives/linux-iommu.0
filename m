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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8ACC433C1
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD146192F
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD146192F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0447B40360;
	Mon, 29 Mar 2021 00:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h6DFFuCyo3bN; Mon, 29 Mar 2021 00:11:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B8E24032D;
	Mon, 29 Mar 2021 00:10:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBFF7C002A;
	Mon, 29 Mar 2021 00:10:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 463A9C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 27C69400C1
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YiMMwZbvMvLC for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:57:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C128400B9
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:57:47 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id g15so10930563qkl.4
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I1EIk4YVKhOnAZImQsN2ZKDY/BZ5VFtnbICpb2ytuZw=;
 b=dYzr6KWh4SK2C8ze1rrsjBDcu+hcBxWGkb1HkW+qd+/dV31vd3A3Ee2Vxu4ZavXqnU
 o8NDQ+MysLv2Em5XbQ1laoO0P8vfDo77vfaElmp1/5MVQKkCU4xkYBZR1Y8MPoqMfo6V
 0ko2b1t/YU/AM1SxeZ+mvKZbA/x6XJ6/kteEuByX/qo+qxxZ6LTZgy9ICZUMbPMGWoNd
 UclUSFoR61rQ9kcGDjvMWAIuCwmuY+iSBQs/83RVR6BF2KMyUhMQ4juCkRyTGV1Haspm
 asUV/RoPmdZFZFpoRySHsNo2MW5LLW2WQLM3f1CKrl3Ao9QZR9avs1tE9a+FJ+MwI3Vx
 lRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I1EIk4YVKhOnAZImQsN2ZKDY/BZ5VFtnbICpb2ytuZw=;
 b=E2opWsizfaafGhG+fpuMW7oZuFDj1b1r0sp8QTD69/0B40/2WvKELQVgioT4QhKtSv
 i42tFMu2NVus2SzEYwIoLckbmH6GLyuZDo+NoZUby6XmXy8JtdJ0gZ9v7RuWx+9lpjp2
 DEg4ilk2oISdecPDh5KF00BMLG0O9eHtj7u16bmcXX0uZc0EaUl2EYWYUPeQjfcDD+Rv
 kruMM2tRhRiI7T4Xm5h6a/pog0X/ZI0AtdH84uId3mPXs7YBiRdtIuPunqNZNpCPt/A9
 XdAxkQt+mcwQhPBX0Rc92INqQDA0CDoTAzWGpv1/r1cdHew2u55++XFrCV0/Y5htaQfJ
 J7Fw==
X-Gm-Message-State: AOAM530shjby11UwgRKv4wlspsozA+3lWcXm/+jOv/XZMLm3FaGI+HCs
 OtJRfPqL2dy43wVJQQr8+L0=
X-Google-Smtp-Source: ABdhPJw/RMK7vmZ45zLUGVxo30c6mvRq7joodocZ04PQOyJJPRklWL/yJc/aDwzeJa2I3aVqupZvhQ==
X-Received: by 2002:a05:620a:2116:: with SMTP id
 l22mr22838891qkl.377.1616975866552; 
 Sun, 28 Mar 2021 16:57:46 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:57:46 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 22/30] at_hdmac_regs.h: Couple of typo fixes
Date: Mon, 29 Mar 2021 05:23:18 +0530
Message-Id: <a588f9e9c32c5af24570ea04c4cd460fb3958147.1616971780.git.unixbhaskar@gmail.com>
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

s/availlable/available/
s/signle/single/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/at_hdmac_regs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index 4d1ebc040031..46ecc40edaa8 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -338,7 +338,7 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
  * @ch_regs: memory mapped register base
  * @clk: dma controller clock
  * @save_imr: interrupt mask register that is saved on suspend/resume cycle
- * @all_chan_mask: all channels availlable in a mask
+ * @all_chan_mask: all channels available in a mask
  * @dma_desc_pool: base of DMA descriptor region (DMA address)
  * @chan: channels table to store at_dma_chan structures
  */
@@ -462,7 +462,7 @@ static inline int atc_chan_is_cyclic(struct at_dma_chan *atchan)

 /**
  * set_desc_eol - set end-of-link to descriptor so it will end transfer
- * @desc: descriptor, signle or at the end of a chain, to end chain on
+ * @desc: descriptor, single or at the end of a chain, to end chain on
  */
 static void set_desc_eol(struct at_desc *desc)
 {
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
