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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CA2C433E9
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DDD61938
	for <iommu@archiver.kernel.org>; Mon, 29 Mar 2021 00:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DDD61938
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7820983A5A;
	Mon, 29 Mar 2021 00:11:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vNedmH8NDJYJ; Mon, 29 Mar 2021 00:11:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0E6183A61;
	Mon, 29 Mar 2021 00:11:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D8CDC000A;
	Mon, 29 Mar 2021 00:10:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 967C3C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 78B70838F0
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:58:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ExhnB1vxaQ0f for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:58:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D175A838E6
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:58:27 +0000 (UTC)
Received: by mail-qt1-x830.google.com with SMTP id u8so8198819qtq.12
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pZY3iifrv8ClFucjg75wWqbWgmlD1U3QmF4uzbWxtyk=;
 b=PIw7C1Bk/eGWQKsGvWCr0S8TPn8QvRWOhl6hvWK4VjoMFupeY5/g8s7kzwhMScA5Yu
 3e7Rj/bjvS2b85U9+k88WGtsKgUTPvzzvdFJYC0k/RqLPZFS/3GhHjMqD5kK+e7jKM/6
 53Fvs6gxrbJFiC1u/dgFp8bxTyuVzLD/Tpou7SHHqSFadmyNPt3U4CU58tt95gASNQQ7
 xYX4ULcW05MCOpvlLfFnzFEUNX3Yp7+RhdNBet8s+BvsIMTWUkgy4Nq5pTpS8LNP/fAV
 /fA+htsmtHzgRatr0oZ5k5rLTOnxU0BoqA8YYmMtTbokFKvFZL0GLX13Zdgx+VbiqJTc
 ioTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pZY3iifrv8ClFucjg75wWqbWgmlD1U3QmF4uzbWxtyk=;
 b=Ci14qBYIyxAQ/BNbYE7qkSZqgCPjsFo0y/UTkdEJ+fkPdlOkHQGPLZOx7Rd0Stu4OD
 7AEYbJaaXupFifLgMVw6op/dIJR8Fa07AwXPcbe1cuxSBeh5Ak8N9kK6lshT+8wkUqZW
 auDLdIiNUTHm6polaoMGUspR4nE5T5aQbKw5ty/npVjsN8NHf5XLj27DoltQgdKbKOqh
 pv5o2AL50gHAnFqwldUKkSB1+q9mMptOf637cyMEsy1UuAuzJaswY46p5wRNuh4PwCot
 6LzC0ttKj/c+6tT+0kxKDcAFVuGZQu78vYeeGMwymCnVZZA+IZdNZnOFYpTA9GtD62vz
 Z6ow==
X-Gm-Message-State: AOAM530cVtAwratdYrUhPS4WcOBV1DZgRLQlXy+QdY630YeKYI2i49hv
 OpmbyDPCAxFb/NsvlaVhMX8=
X-Google-Smtp-Source: ABdhPJzrXaJ3NFEfLw/ORFLnH6cpcNnBby0kvFM8FYj18PlBci3BiuYNuENXsp4hnCZmTj7qcXXSOw==
X-Received: by 2002:ac8:dcc:: with SMTP id t12mr13998503qti.219.1616975906780; 
 Sun, 28 Mar 2021 16:58:26 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.24])
 by smtp.gmail.com with ESMTPSA id y19sm12153061qky.111.2021.03.28.16.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:58:26 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com
Subject: [PATCH 30/30] xilinx_dma.c: Fix a typo
Date: Mon, 29 Mar 2021 05:23:26 +0530
Message-Id: <4613951fd51572e8c152d07c402d30a13f19a917.1616971780.git.unixbhaskar@gmail.com>
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

s/interace/interface/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 3aded7861fef..63d2f447ad79 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -483,7 +483,7 @@ struct xilinx_dma_config {
  * @ext_addr: Indicates 64 bit addressing is supported by dma device
  * @pdev: Platform device structure pointer
  * @dma_config: DMA config structure
- * @axi_clk: DMA Axi4-lite interace clock
+ * @axi_clk: DMA Axi4-lite interface clock
  * @tx_clk: DMA mm2s clock
  * @txs_clk: DMA mm2s stream clock
  * @rx_clk: DMA s2mm clock
--
2.26.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
